class Importer
  attr_reader :now

  def initialize(dir)
    @dir = dir
    raise ArgumentError if Dir.glob("#{dir}/**").empty?

    @now = Time.zone.now.to_datetime
  end

  def self.import_all(dir)
    importer = new(dir)

    [
      :agency,
      :calendar,
      :calendar_dates,
      :routes,
      :shapes,
      :stop_times,
      :stops,
      :trips
    ].each(&importer.method(:send))
  end

  def agency
    progress_bar(:agency) do |pbar|
      imported_data = clean_csv(:agency) do |obj|
        timestamps! obj
        pbar.increment
      end

      Agency.insert_many imported_data
    end
  end

  def calendar_dates
    progress_bar(:calendar_dates) do |pbar|
      imported_data = clean_csv(:calendar_dates) do |obj|
        timestamps! obj
        format_dates! obj, :date
        pbar.increment
      end

      CalendarDate.insert_many imported_data
    end
  end

  def calendar
    progress_bar(:calendar) do |pbar|
      imported_data = clean_csv(:calendar) do |obj|
        timestamps! obj
        format_dates! obj, 'start_date', 'end_date'
        pbar.increment
      end

      Calendar.insert_many imported_data
    end
  end

  def routes
    progress_bar(:routes) do |pbar|
      imported_data = clean_csv(:routes) do |obj|
        timestamps! obj
        pbar.increment
      end

      Route.insert_many imported_data
    end
  end

  def shapes
    progress_bar(:shapes) do |pbar|
      imported_data = clean_csv(:shapes) do |obj|
        timestamps! obj
        pbar.increment
      end

      Shape.insert_many imported_data
    end
  end

  def stop_times
    progress_bar(:stop_times) do |pbar|
      imported_data = clean_csv(:stop_times) do |obj|
        timestamps! obj
        format_times! obj, 'arrival_time', 'departure_time'
        pbar.increment
      end

      StopTime.insert_many imported_data
    end
  end

  def stops
    progress_bar(:stops) do |pbar|
      imported_data = clean_csv(:stops) do |obj|
        timestamps! obj
        pbar.increment
      end

      Stop.insert_many imported_data
    end
  end

  def trips
    progress_bar(:trips) do |pbar|
      imported_data = clean_csv(:trips) do |obj|
        timestamps! obj
        pbar.increment
      end

      Trip.insert_many imported_data
    end
  end

  private

  def timestamps!(obj)
    obj['created_at'] = now
    obj['updated_at'] = now
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
    CSV.foreach(dir(filename), headers: true)
       .each_with_object([]) do |row, chunk|
      chunk << row.to_h.tap do |imported_object|
        yield imported_object
      end
    end
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
