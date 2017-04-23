class Importer
  def initialize(dir)
    @dir = dir
    raise ArgumentError if Dir.glob("#{dir}/**").empty?
  end

  def self.import_all(dir)
    importer = new(dir)

    Parallel.each([
      :agencies,
      :calendar,
      :calendar_dates,
      :routes,
      :shapes,
      :stop_times,
      :stops,
      :trips
    ]) { |import_type| importer.send(import_type) }
  end

  def agencies
    clean_csv(:agency) { |imported_data| Agency.insert_many imported_data }
    puts "Imported Agencies"
  end

  def calendar_dates
    progress_bar(:calendar_dates) do |pbar|
      clean_csv(:calendar_dates) do |imported_data|
        imported_data.each do |obj|
          format_dates! obj, 'date'
          pbar.increment
        end

        CalendarDate.insert_many imported_data
      end
    end
  end

  def calendar
    progress_bar(:calendar) do |pbar|
      clean_csv(:calendar) do |imported_data|
        imported_data.each do |obj|
          format_dates! obj, 'start_date', 'end_date'
          pbar.increment
        end

        Calendar.insert_many imported_data
      end
    end
  end

  def routes
    clean_csv(:routes) { |imported_data| Route.insert_many imported_data }
    puts "Imported Routes"
  end

  def shapes
    progress_bar(:shapes) do |pbar|
      clean_csv(:shapes) do |imported_data|
        imported_data.each do |obj|
          gis_point! obj, 'shape_pt_lat', 'shape_pt_lon', to: 'shape_pt_latlon'
          pbar.increment
        end

        Shape.insert_many imported_data
      end
    end
  end

  def stop_times
    progress_bar(:stop_times) do |pbar|
      clean_csv(:stop_times) do |imported_data|
        imported_data.each do |h|
          format_times! h, 'arrival_time', 'departure_time'
          pbar.increment
        end

        StopTime.insert_many imported_data
      end
    end
  end

  def stops
    progress_bar(:stops) do |pbar|
      clean_csv(:stops) do |imported_data|
        imported_data.each do |obj|
          gis_point! obj, 'stop_lat', 'stop_lon', to: 'stop_latlon'
          pbar.increment
        end

        Stop.insert_many imported_data
      end
    end
  end

  def trips
    clean_csv(:trips) { |imported_data| Trip.insert_many imported_data }
    puts "Imported Trips"
  end

  private

  def gis_point!(obj, lat, lon, to:)
    string_to_convert = "POINT(#{obj.delete(lat)} #{obj.delete(lon)})"
    result = Stop.connection.execute <<-SQL
      SELECT ST_GeomFromText('#{string_to_convert}');
    SQL

    obj[to] = result[0]['st_geomfromtext']
  end

  def format_dates!(obj, *properties)
    properties.each do |property|
      next unless obj[property]
      obj[property] = DateTime.strptime(obj[property].to_s, '%Y%m%d')
    end
  end

  def format_times!(obj, *properties)
    properties.each do |property|
      next unless obj[property]

      prefix = property.gsub(/_time\z/, '')
      hour, minute, second = obj[property].split(':')
      obj["#{prefix}_hour"] = hour
      obj["#{prefix}_minute"] = minute
      obj["#{prefix}_second"] = second

      obj.delete(property)
    end
  end

  def clean_csv(filename)
    options = { chunk_size: 1600, strings_as_keys: true, remove_empty_values: false }
    SmarterCSV.process(dir(filename), options) { |chunk| yield chunk }
  end

  def dir(filename)
    "#{@dir}/#{filename}.txt"
  end

  def progress_bar(description)
    record_count = `wc -l #{dir(description)}`.strip.split(' ').first.to_i - 1
    pbar = ProgressBar.create(title: description, total: record_count)
    yield pbar
  end
end
