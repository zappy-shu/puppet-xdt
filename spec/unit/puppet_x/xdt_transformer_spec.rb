require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/xdt_transformer'
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
        context 'when transform child is a replace on match' do
            it 'replace matched source child' do
                source_doc = Nokogiri::XML('<root><child a="1"/><child a="2"/></root>')
                transform_doc = Nokogiri::XML('<root '+ ns_attr +'><child a="2" b="3" xdt:Transform="Replace" xdt:Locator="Match(a)"/></root>')
                expected_xml = Nokogiri::XML('<root><child a="1"/><child a="2" b="3"/></root>').to_s
                expect(XdtTransformer.new(source_doc, transform_doc).transform.to_s).to eql(expected_xml)
            end
        end
        context 'when locator and transform at separate levels' do
            it 'transform at correct level' do
                source_doc = Nokogiri::XML('
                    <root>
                        <child a="1"><child1/></child>
                        <child a="2"><child2/></child>
                    </root>')
                transform_doc = Nokogiri::XML('
                    <root '+ ns_attr +'>
                        <child a="1" xdt:Locator="Match(a)">
                            <child1 b="1" xdt:Transform="Replace"/>
                        </child>
                    </root>')
                expected_xml = Nokogiri::XML('
                    <root>
                        <child a="1"><child1 b="1"/></child>
                        <child a="2"><child2/></child>
                    </root>').to_s
                expect(XdtTransformer.new(source_doc, transform_doc).transform.to_s).to eql(expected_xml)
            end
        end
    end
end
