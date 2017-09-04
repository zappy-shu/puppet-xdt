require 'puppet_x/xdt_namespace'
require 'puppet_x/xdt_attribute'

require 'nokogiri'

describe XdtNamespace do
    xdt_namespace = XdtNamespace.new

    describe '#has_xdt_namespace?' do
        context 'given xml without namespace' do
            it 'returns false' do
                xml = '<root><child/></root>'
                doc = Nokogiri::XML(xml)
                expect(xdt_namespace.has_xdt_namespace?(doc)).to eql(false)
            end
        end
        context 'given xml without xdt namespace' do
            it 'returns false' do
                xml = '<root xmlns:xdt="not-xdt-namespace"><child/></root>'
                doc = Nokogiri::XML(xml)
                expect(xdt_namespace.has_xdt_namespace?(doc)).to eql(false)
            end
        end
        context 'given xml with xdt namespace' do
            it 'returns false' do
                xml = '<root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform"><child/></root>'
                doc = Nokogiri::XML(xml)
                expect(xdt_namespace.has_xdt_namespace?(doc)).to eql(true)
            end
        end
    end
    describe '#get_xdt_attributes' do
        context 'given node with no attributes' do
            it 'return empty array' do
                xml = '<root><child/></root>'
                doc = Nokogiri::XML(xml)
                child = doc.xpath('/root/child')[0]
                expect(xdt_namespace.get_xdt_attributes(doc, child)).to eql([])
            end
        end
        context 'given node with attributes with no namespace' do
            it 'return empty array' do
                xml = '<root><child a="aaa"/></root>'
                doc = Nokogiri::XML(xml)
                child = doc.xpath('/root/child')[0]
                expect(xdt_namespace.get_xdt_attributes(doc, child)).to eql([])
            end
        end
        context 'given node with attributes with non xdt namespace' do
            it 'return empty array' do
                xml = '<root xmlns:ns="not-xdt"><child ns:a="aaa"/></root>'
                doc = Nokogiri::XML(xml)
                child = doc.xpath('/root/child')[0]
                expect(xdt_namespace.get_xdt_attributes(doc, child)).to eql([])
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
                attrs = xdt_namespace.get_xdt_attributes(doc, child)
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
                attrs = xdt_namespace.get_xdt_attributes(doc, child)
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
                attrs = xdt_namespace.get_xdt_attributes(doc, child)
                expect(attrs.count).to eql(2)
                expect(attrs[0].name).to eql('a')
                expect(attrs[0].value).to eql('aaa')
                expect(attrs[1].name).to eql('b')
                expect(attrs[1].value).to eql('bbb')
            end
        end
    end
    describe '#remove_xdt_attributes' do
        context 'when node contains no attributes' do
            it 'node unchanged' do
                doc = Nokogiri::XML('<root/>')
                node = doc.root
                xdt_namespace.remove_xdt_attributes(doc, node)
                expect(node.to_s).to eql('<root/>')
            end
        end
        context 'when node has non xdt attribute' do
            it 'node unchanged' do
                doc = Nokogiri::XML('<root a="aaa"/>')
                node = doc.root
                xdt_namespace.remove_xdt_attributes(doc, node)
                expect(node.to_s).to eql('<root a="aaa"/>')
            end
        end 
        context 'when node has xdt attribute' do
            it 'xdt attribute removed' do
                doc = Nokogiri::XML('
                    <root xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
                        <node a="aaa" xdt:b="bbb" />
                    </root>')
                node = doc.xpath('/root/node')[0]
                xdt_namespace.remove_xdt_attributes(doc, node)
                expect(node.to_s).to eql('<node a="aaa"/>')
            end
        end 
    end
end
