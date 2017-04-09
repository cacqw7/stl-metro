namespace :feeds do
  desc "Fetch most recent copy of GTFS feed"
  task fetch: :environment do
    require 'net/ftp'
    require 'zip'

    pastel = Pastel.new

    gtfs_zip_path = "#{Rails.root}/tmp/stl_metro.zip"
    data_path = "#{Rails.root}/tmp/gtfs"

    Dir.glob("#{data_path}/**").each { |file| File.delete(file) }
    Dir.delete(data_path)

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

end
