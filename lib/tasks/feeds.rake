class MissingFilesException < Exception; end
class Importer
  attr_reader :now

  def initialize(dir)
    @dir = dir
    raise MissingFilesException if Dir.glob("#{dir}/**").empty?

    @now = Time.now.to_datetime
  end

  def self.import_all(dir)
    importer = new(dir)

    [
      :agency,
      :calendar,
      :calendar_dates,
      :routes,
      :shapes,
      :stop_times
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

  private

  def timestamps!(obj)
    obj['created_at'] = now
    obj['updated_at'] = now
  end

  def format_dates!(obj, *properties)
    properties.each do |property|
      obj[property] = DateTime.strptime(obj[property].to_s, "%Y%m%d") if obj[property]
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
    CSV.foreach(dir(filename), headers: true).each_with_object([]) do |row, chunk|
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


namespace :feeds do
  pastel = Pastel.new

  desc "Fetch most recent copy of GTFS feed"
  task fetch: :environment do
    require 'net/ftp'
    require 'zip'

    gtfs_zip_path = "#{Rails.root}/tmp/stl_metro.zip"
    data_path = "#{Rails.root}/tmp/gtfs"

    Dir.glob("#{data_path}/**").each { |file| File.delete(file) }
    Dir.delete(data_path) if Dir.exists? data_path

    File.delete(gtfs_zip_path) if File.file? gtfs_zip_path

    puts pastel.blue('Fetching transit data... 🚀')

    Net::FTP.open('metrostlouis.org') do |ftp|
     ftp.login
     ftp.getbinaryfile('Transit/google_transit.zip', gtfs_zip_path, 1024)
    end
    Dir.mkdir(Rails.root.join('tmp', "gtfs"), 0700)

    puts pastel.blue('Unzipping GTFS files...')
    Zip::File.open(gtfs_zip_path) do |zipfile|
      zipfile.each do |file|
        puts pastel.cyan(">> #{file.name}")
        file.extract "#{data_path}/#{file.name}"
      end
    end

    puts pastel.green('Fetch complete! 🚌')
  end

  desc "Import most recent download to the database"
  task import: :environment do
    begin
      importer = Importer.import_all(Rails.root.join('tmp', 'gtfs'))
    rescue MissingFilesException
      puts <<~STRING
      🚨  No data to import! 🚨
      Please run 'rake feeds:fetch' to get most recent transit data.
      STRING
      exit 1
    end
  end

  desc "TODO"
  task erase: :environment do
  end


end
