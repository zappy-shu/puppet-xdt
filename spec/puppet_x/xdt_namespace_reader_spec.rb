require_relative '../../lib/puppet_x/xdt_namespace_reader'
require_relative '../../lib/puppet_x/xdt_attribute'

require 'nokogiri'

describe XdtNamespaceReader do
    xdt_namespace_reader = XdtNamespaceReader.new

    describe '#has_xdt_namespace?' do
        context 'given xml without namespace' do
            it 'returns false' do
                xml = '<root><child/></root>'
                doc = Nokogiri::XML(xml)
                expect(xdt_namespace_reader.has_xdt_namespace?(doc)).to eql(false)
            end
        end
        context 'given xml without xdt namespace' do
            it 'returns false' do
                xml = '<root xmlns:xdt="not-xdt-namespace"><child/></root>'
                doc = Nokogiri::XML(xml)
                expect(xdt_namespace_reader.has_xdt_namespace?(doc)).to eql(false)
            end
        end
        context 'given xml with xdt namespace' do
            it 'returns false' do
                xml = '<root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform"><child/></root>'
                doc = Nokogiri::XML(xml)
                expect(xdt_namespace_reader.has_xdt_namespace?(doc)).to eql(true)
            end
        end
    end
    describe '#get_xdt_attributes' do
        context 'given node with no attributes' do
            it 'return empty array' do
                xml = '<root><child/></root>'
                doc = Nokogiri::XML(xml)
                child = doc.xpath('/root/child')[0]
                expect(xdt_namespace_reader.get_xdt_attributes(doc, child)).to eql([])
            end
        end
        context 'given node with attributes with no namespace' do
            it 'return empty array' do
                xml = '<root><child a="aaa"/></root>'
                doc = Nokogiri::XML(xml)
                child = doc.xpath('/root/child')[0]
                expect(xdt_namespace_reader.get_xdt_attributes(doc, child)).to eql([])
            end
        end
        context 'given node with attributes with non xdt namespace' do
            it 'return empty array' do
                xml = '<root xmlns:ns="not-xdt"><child ns:a="aaa"/></root>'
                doc = Nokogiri::XML(xml)
                child = doc.xpath('/root/child')[0]
                expect(xdt_namespace_reader.get_xdt_attributes(doc, child)).to eql([])
            end
        end
        context 'given node with attribute with xdt namespace' do
            it 'return array with xdt attribute' do
                xml = '
                    <root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
                        <child xdt:a="aaa"/>
                    </root>'
                doc = Nokogiri::XML(xml)
                child = doc.xpath('/root/child')[0]
                attrs = xdt_namespace_reader.get_xdt_attributes(doc, child)
                expect(attrs.count).to eql(1)
                expect(attrs[0].name).to eql('a')
                expect(attrs[0].value).to eql('aaa')
            end
        end
        context 'given node with 2 attributes, 1 with xdt namespace' do
            it 'return array with xdt attribute' do
                xml = '
                    <root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
                        <child xdt:a="aaa" b="bbb"/>
                    </root>'
                doc = Nokogiri::XML(xml)
                child = doc.xpath('/root/child')[0]
                attrs = xdt_namespace_reader.get_xdt_attributes(doc, child)
                expect(attrs.count).to eql(1)
                expect(attrs[0].name).to eql('a')
                expect(attrs[0].value).to eql('aaa')
            end
        end
        context 'given node with 2 xdt attributes' do
            it 'return array with both xdt attributes' do
                xml = '
                    <root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
                        <child xdt:a="aaa" xdt:b="bbb"/>
                    </root>'
                doc = Nokogiri::XML(xml)
                child = doc.xpath('/root/child')[0]
                attrs = xdt_namespace_reader.get_xdt_attributes(doc, child)
                expect(attrs.count).to eql(2)
                expect(attrs[0].name).to eql('a')
                expect(attrs[0].value).to eql('aaa')
                expect(attrs[1].name).to eql('b')
                expect(attrs[1].value).to eql('bbb')
            end
        end
    end
end
