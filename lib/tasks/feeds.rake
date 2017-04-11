class Import
  DATA_FOLDER = "#{Rails.root.join('tmp', 'gtfs')}"
  class << self
    def agency
      SmarterCSV::process(File.open("#{DATA_FOLDER}/agency.txt")) do |chunk|
        now = Time.now.to_datetime
        chunk.each do |h|
          h[:created_at] = now
          h[:updated_at] = now
        end

        Agency.insert_many chunk
      end
    end

    def calendar_dates
      SmarterCSV::process(File.open("#{DATA_FOLDER}/calendar_dates.txt")) do |chunk|
        now = Time.now.to_datetime
        chunk.each do |h|
          h[:created_at] = now
          h[:updated_at] = now
          h[:date] = DateTime.strptime(h[:date].to_s, "%Y%m%d")
        end

        CalendarDate.insert_many chunk
      end
    end
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
    files_to_import = Dir.glob("#{Rails.root}/tmp/gtfs/**")

    if files_to_import.empty?
      puts <<~STRING
      🚨  No data to import! 🚨
      Please run 'rake feeds:fetch' to get most recent transit data.
      STRING
      exit 1
    end

    # data_to_load = SmarterCSV::process(File.open("#{Rails.root.join('tmp', 'gtfs', 'agency.txt')}"))
    #
    # files_to_import.each do |file|
    #   data_type = File.basename(file, File.extname(file))
    #   klass = data_type.singularize.camelize.constantize
    #   puts pastel.blue("Importing: #{klass}")
    #   data_to_load = SmarterCSV::process(File.open(file))
    #   now = Time.now.to_datetime
    #   timestamp = { created_at: now, updated_at: now }
    #
    #   data_to_load.map! { |hsh| hsh.merge(timestamp) }
    #   klass.insert_many data_to_load
    # end
    Import.agency
    Import.calendar_dates
  end

  desc "TODO"
  task erase: :environment do
  end


end
