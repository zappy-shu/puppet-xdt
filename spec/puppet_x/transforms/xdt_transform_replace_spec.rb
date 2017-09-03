require_relative '../../../lib/puppet_x/transforms/xdt_transform_replace'
require 'nokogiri'

describe XdtTransformReplace do
    describe '#transform' do
        context 'when transform node exists' do
            it 'source nodes replaced by transform node' do
                source_doc = Nokogiri::XML('<root><a><b1/><b2/></a></root>')
                transform_doc = Nokogiri::XML('<root><a><c1/><c2/></a></root>')
                source_node = source_doc.xpath('/root/a')[0]
                transform_node = transform_doc.xpath('/root/a')[0]

                XdtTransformReplace.new.transform(source_node, transform_node, [])
                expect(source_doc.root.elements[0].elements[0].to_s).to eql('<c1/>')
                expect(source_doc.root.elements[0].elements[1].to_s).to eql('<c2/>')
            end
        end
    end
end
