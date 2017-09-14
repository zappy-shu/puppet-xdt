require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/transforms/xdt_transform_insert_after'
require 'nokogiri'

describe XdtTransformInsertAfter do
    describe '#transform' do
        context 'when no arguments given' do
            it 'log warning and do no transforms' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.xpath('/root/a')[0]
                transform_node = transform_doc.root

                XdtTransformInsertAfter.new([]).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(1)
            end
        end
        context 'when more than 1 argument given' do
            it 'log warning and do no transforms' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.xpath('/root/a')[0]
                transform_node = transform_doc.root

                XdtTransformInsertAfter.new(['1','2']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(1)
            end
        end
        context 'when given xpath not found' do
            it 'log warning and do no transforms' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.xpath('/root/a')[0]
                transform_node = transform_doc.root

                XdtTransformInsertAfter.new(['/root/nope']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(1)
            end
        end
        context 'when given xpath is root' do
            it 'log warning and do no transforms' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.xpath('/root/a')[0]
                transform_node = transform_doc.root

                XdtTransformInsertAfter.new(['/root']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(1)
            end
        end
        context 'when given xpath found' do
            it 'transform node inserted after source node at parent' do
                source_doc = Nokogiri::XML('<root><a/><c/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformInsertAfter.new(['/root/a']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(3)
                expect(source_doc.root.elements[0].to_s).to eql('<a/>')
                expect(source_doc.root.elements[1].to_s).to eql('<b/>')
                expect(source_doc.root.elements[2].to_s).to eql('<c/>')
            end
        end
        context 'when inserting to parent with namespace while node has no namespace' do
            it 'inserted node has no namespace' do
                source_doc = Nokogiri::XML('<n:root xmlns:n="ns"><a/><c/></n:root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformInsertAfter.new(['/n:root/a']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(3)
                expect(source_doc.root.elements[0].to_s).to eql('<a/>')
                expect(source_doc.root.elements[1].to_s).to eql('<b/>')
                expect(source_doc.root.elements[2].to_s).to eql('<c/>')
            end
        end
        context 'when inserting to parent with namespace while node has different namespace' do
            it 'inserted node has own namespace' do
                source_doc = Nokogiri::XML('<n1:root xmlns:n1="ns1"><a/><c/></n:root>')
                transform_doc = Nokogiri::XML('<n2:b xmlns:n2="ns2"/>')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformInsertAfter.new(['/n1:root/a']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(3)
                expect(source_doc.root.elements[0].to_s).to eql('<a/>')
                expect(source_doc.root.elements[1].to_s).to eql('<n2:b xmlns:n2="ns2"/>')
                expect(source_doc.root.elements[2].to_s).to eql('<c/>')
                expect(source_doc.root.elements[1].namespace.href).to eql("ns2")
            end
        end
    end
end
