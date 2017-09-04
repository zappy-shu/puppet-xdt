require_relative '../../../lib/puppet_x/transforms/xdt_transform_remove_all'
require 'nokogiri'

describe XdtTransformRemoveAll do
    describe '#transform' do
        it 'when source node parent has 1 child same as transform node' do
            source_doc = Nokogiri::XML('<root><a/></root>')
            transform_doc = Nokogiri::XML('<a/>')
            source_node = source_doc.xpath('/root/a')[0]
            transform_node = transform_doc.root

            XdtTransformRemoveAll.new([]).transform(source_node, transform_node)
            expect(source_doc.root.elements.length).to eql(0)
        end
        it 'when source node parent has multiple children same as transform node' do
            source_doc = Nokogiri::XML('<root><a/><a/></root>')
            transform_doc = Nokogiri::XML('<a/>')
            source_node = source_doc.xpath('/root/a')[0]
            transform_node = transform_doc.root

            XdtTransformRemoveAll.new([]).transform(source_node, transform_node)
            expect(source_doc.root.elements.length).to eql(0)
        end
        it 'when source node parent has 1 child same as transform node and 1 node different' do
            source_doc = Nokogiri::XML('<root><a/><b/></root>')
            transform_doc = Nokogiri::XML('<a/>')
            source_node = source_doc.xpath('/root/a')[0]
            transform_node = transform_doc.root

            XdtTransformRemoveAll.new([]).transform(source_node, transform_node)
            expect(source_doc.root.elements.length).to eql(1)
            expect(source_doc.root.elements[0].to_s).to eql('<b/>')
        end
    end
end
