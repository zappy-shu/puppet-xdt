require 'puppet_x/xdt_transformer'
require 'nokogiri'

describe XdtTransform do
    describe "#transform" do
        context "when transforming spec/resources/source.xml with spec/resources/transform.xml" do
            it "transformed file same as spec/resources/expected.xml" do
                source_xml = Nokogiri::XML(File.read("#{Dir.pwd}/../resources/source.xml"))
                transform_xml = Nokogiri::XML(File.read("#{Dir.pwd}/../resources/transform.xml"))
                expected_xml = Nokogiri::XML(File.read("#{Dir.pwd}/../resources/expected.xml"))

                transformed_xml = XdtTransformer.new(source_doc, transform_doc).transform
            end
        end
    end
end