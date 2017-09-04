require 'puppet_x/transforms/xdt_transform_insert_before'
require 'nokogiri'

describe XdtTransformInsertBefore do
    describe '#transform' do
        context 'when no arguments given' do
            it 'log warning and do no transforms' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.xpath('/root/a')[0]
                transform_node = transform_doc.root

                XdtTransformInsertBefore.new([]).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(1)
            end
        end
        context 'when more than 1 argument given' do
            it 'log warning and do no transforms' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.xpath('/root/a')[0]
                transform_node = transform_doc.root

                XdtTransformInsertBefore.new(['1','2']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(1)
            end
        end
        context 'when given xpath not found' do
            it 'log warning and do no transforms' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.xpath('/root/a')[0]
                transform_node = transform_doc.root

                XdtTransformInsertBefore.new(['/root/nope']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(1)
            end
        end
        context 'when given xpath is root' do
            it 'log warning and do no transforms' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformInsertBefore.new(['/root']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(1)
            end
        end
        context 'when given xpath found' do
            it 'transform node inserted before source node at parent' do
                source_doc = Nokogiri::XML('<root><a/><c/></root>')
                transform_doc = Nokogiri::XML('<b/>')
                source_node = source_doc.xpath('/root/c')[0]
                transform_node = transform_doc.root

                XdtTransformInsertBefore.new(['/root/c']).transform(source_node, transform_node)
                expect(source_doc.root.elements.length).to eql(3)
                expect(source_doc.root.elements[0].to_s).to eql('<a/>')
                expect(source_doc.root.elements[1].to_s).to eql('<b/>')
                expect(source_doc.root.elements[2].to_s).to eql('<c/>')
            end
        end
    end
end
