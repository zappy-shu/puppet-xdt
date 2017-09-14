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
        context 'when inserting to parent with namespace while node has no namespace' do
            it 'inserted node has no namespace' do
                source_doc = Nokogiri::XML('<n:root xmlns:n="ns"><a/><b/></n:root>')
                transform_doc = Nokogiri::XML('<c/>')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformInsert.new(['/n:root']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(3)
                expect(source_doc.root.elements[0].to_s).to eql('<a/>')
                expect(source_doc.root.elements[1].to_s).to eql('<b/>')
                expect(source_doc.root.elements[2].to_s).to eql('<c/>')
            end
        end
        context 'when inserting to parent with namespace while node has different namespace' do
            it 'inserted node has own namespace' do
                source_doc = Nokogiri::XML('<n1:root xmlns:n1="ns1"><a/><b/></n:root>')
                transform_doc = Nokogiri::XML('<n2:c xmlns:n2="ns2"/>')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformInsert.new(['/n1:root']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(3)
                expect(source_doc.root.elements[0].to_s).to eql('<a/>')
                expect(source_doc.root.elements[1].to_s).to eql('<b/>')
                expect(source_doc.root.elements[2].to_s).to eql('<n2:c xmlns:n2="ns2"/>')
                expect(source_doc.root.elements[2].namespace.href).to eql("ns2")
            end
        end
    end
end
