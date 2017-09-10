require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/transforms/xdt_transform_insert'
require 'nokogiri'

describe XdtTransformInsert do
    describe '#transform' do
        context 'when source node has parent with 1 child' do
            it 'transform node is inserted after source node on parent' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.xpath('/root')[0]
                transform_node = transform_doc.root

                XdtTransformInsert.new([]).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(2)
                expect(source_doc.root.elements[0].to_s).to eql('<a/>')
                expect(source_doc.root.elements[1].to_s).to eql('<b/>')
            end
        end
        context 'when source node is first of 2 children of parent' do
            it 'insert transform node after all children' do
                source_doc = Nokogiri::XML('<root><a/><b/></root>')
                transform_doc = Nokogiri::XML('<c/>')
                source_node = source_doc.xpath('/root')[0]
                transform_node = transform_doc.root
                XdtTransformInsert.new([]).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(3)
                expect(source_doc.root.elements[0].to_s).to eql('<a/>')
                expect(source_doc.root.elements[1].to_s).to eql('<b/>')
                expect(source_doc.root.elements[2].to_s).to eql('<c/>')
            end
        end
    end
end
