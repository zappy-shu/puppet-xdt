Dir[File.dirname(__FILE__) + '/../../lib/puppet_x/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../../lib/puppet_x/locators/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../../lib/puppet_x/transforms/*.rb'].each {|file| require file }
require 'nokogiri'

ns_attr = 'xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform"'

describe XdtTransformer do
    describe '#transform' do
        context 'when document doesnt have an xdt namespace' do
            it 'do not alter source document' do
                source_doc = Nokogiri::XML('<root><child/></root>')
                original_xml = source_doc.to_s
                transform_doc = Nokogiri::XML('<root><replace xdt:Transform="Replace"/>,/root>')
                expect(XdtTransformer.new(source_doc, transform_doc).transform.to_s).to eql(original_xml)
            end
        end
        context 'when transform child is a replace' do
            it 'replace source child' do
                source_doc = Nokogiri::XML('<root><child a="aaa"/></root>')
                transform_doc = Nokogiri::XML('<root '+ ns_attr +'><child b="bbb" xdt:Transform="Replace"/></root>')
                expected_xml = Nokogiri::XML('<root><child b="bbb"/></root>').to_s
                expect(XdtTransformer.new(source_doc, transform_doc).transform.to_s).to eql(expected_xml)
            end
        end
    end
end
