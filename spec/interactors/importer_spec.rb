require 'rails_helper'

describe Importer do
  let(:csv_path) { "#{Rails.root.join}/spec/support/importer/csv_files" }
  let(:importer) { described_class.new(csv_path) }

  context "self.import_all" do
    subject { lambda{ described_class.import_all(csv_path) } }

    context "with an invalid file path" do
      let(:csv_path) { '/this/is/a/bad/path' }

      it { should raise_error ArgumentError }
    end
  end

  { "agency" => 1,
    "calendar_dates" => 6,
    "calendar" => 6,
    "routes" =>5,
    "shapes" => 5,
    "stop_times" => 25,
    "stops" => 22,
    "trips" => 10 }.each do |method, count|
      describe "when ##{method}" do
        subject { importer.public_send(method)}

        context "when the source has #{method.humanize.pluralize}" do
          it "should insert them into the database" do
            expect { subject }
              .to change { method.classify.constantize.count }
              .from(0).to(count)
          end
        end
      end
    end

end
