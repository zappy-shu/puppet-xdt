require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/transforms/xdt_transform_remove'
require 'nokogiri'

describe XdtTransformRemove do
    describe '#transform' do
        context 'when source node has parent with 1 child' do
            it 'matching source node is removed from parent' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                source_node = source_doc.xpath('/root/a')[0]

                XdtTransformRemove.new([]).transform(source_node, nil)
                expect(source_doc.root.elements.length).to eql(0)
            end
        end
        context 'when source node is first of 2 children of parent' do
            it 'remove first child' do
                source_doc = Nokogiri::XML('<root><a/><b/></root>')
                source_node = source_doc.xpath('/root/a')[0]
                XdtTransformRemove.new([]).transform(source_node, nil)
                expect(source_doc.root.elements.length).to eql(1)
                expect(source_doc.root.elements[0].to_s).to eql('<b/>')
            end
        end
    end
end
