require 'puppet_x/transforms/xdt_transform_remove_attributes'
require 'nokogiri'

describe XdtTransformRemoveAttributes do
    describe '#transform' do
        context 'when source node has attributes' do
            it 'source node has no attributes' do
                source_doc = Nokogiri::XML('<root><a a="aaa" b="bbb"/></root>')
                source_node = source_doc.xpath('/root/a')[0]
                XdtTransformRemoveAttributes.new([]).transform(source_node, nil)
                expect(source_node.attributes.count).to eql(0)
            end
        end
        context 'when child of source node has attributes' do
            it 'child node still has attributes' do
                source_doc = Nokogiri::XML('<root><a a="aaa"><b b="bbb"/></a></root>')
                source_node = source_doc.xpath('/root/a')[0]
                XdtTransformRemoveAttributes.new([]).transform(source_node, nil)
                expect(source_node.attributes.count).to eql(0)
                expect(source_node.xpath('b')[0].attributes.count).to eql(1)
            end
        end
        context 'when arguments set' do
            it 'only remove attributes in arguments' do
                source_doc = Nokogiri::XML('<root a="aaa" b="bbb" />')
                source_node = source_doc.root
                XdtTransformRemoveAttributes.new(['a']).transform(source_node, nil)
                expect(source_node.attributes.count).to eql(1)
                expect(source_node['b']).to eql('bbb')
            end
        end
        context 'when argument not an attribute in source node' do
            it 'dont throw error' do
                source_doc = Nokogiri::XML('<root a="aaa" b="bbb" />')
                source_node = source_doc.root
                XdtTransformRemoveAttributes.new(['a','c']).transform(source_node, nil)
                expect(source_node.attributes.count).to eql(1)
                expect(source_node['b']).to eql('bbb')
            end
        end
    end
end
