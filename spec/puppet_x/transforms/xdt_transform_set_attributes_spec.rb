require_relative '../../../lib/puppet_x/transforms/xdt_transform_set_attributes'
require 'nokogiri'

describe XdtTransformSetAttributes do
    describe '#transform' do
        context 'when no transform arguments given' do
            it 'removes existing attributes and adds new attributes' do
                source_doc = Nokogiri::XML('<root a="aaa" />')
                transform_doc = Nokogiri::XML('<root b="bbb" />')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformSetAttributes.new([]).transform(source_node, transform_node)
                expect(source_node.attributes.count).to eql(1)
                expect(source_node.attributes['b'].value).to eql('bbb')
                expect(source_node.attributes['a'].nil?).to eql(true)
            end
        end
        context 'when transform arguments given and no duplicate attributes between source and transform' do
            it 'adds transform attributes, leaves source attributes as is' do
                source_doc = Nokogiri::XML('<root a="aaa" />')
                transform_doc = Nokogiri::XML('<root b="bbb" />')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformSetAttributes.new(['b']).transform(source_node, transform_node)
                expect(source_node.attributes.count).to eql(2)
                expect(source_node.attributes['b'].value).to eql('bbb')
                expect(source_node.attributes['a'].value).to eql('aaa')
            end
        end
        context 'when transform arguments and attributes are same as source attributes' do
            it 'sets all source attributes' do
                source_doc = Nokogiri::XML('<root a="aaa" />')
                transform_doc = Nokogiri::XML('<root a="aaa1" />')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformSetAttributes.new(['a']).transform(source_node, transform_node)
                expect(source_node.attributes.count).to eql(1)
                expect(source_node.attributes['a'].value).to eql('aaa1')
            end
        end
        context 'when transform arguments and attributes overlaps with source attributes' do
            it 'sets transform attributes, leaves others alone' do
                source_doc = Nokogiri::XML('<root a="aaa" b="bbb" />')
                transform_doc = Nokogiri::XML('<root b="bbb1" c="ccc" />')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformSetAttributes.new(['b','c']).transform(source_node, transform_node)
                expect(source_node.attributes.count).to eql(3)
                expect(source_node.attributes['a'].value).to eql('aaa')
                expect(source_node.attributes['b'].value).to eql('bbb1')
                expect(source_node.attributes['c'].value).to eql('ccc')
            end
        end
        context 'when transform arguments not all transform attributes' do
            it 'only sets from transform arguments' do
                source_doc = Nokogiri::XML('<root a="aaa" />')
                transform_doc = Nokogiri::XML('<root b="bbb" c="ccc" />')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformSetAttributes.new(['b']).transform(source_node, transform_node)
                expect(source_node.attributes.count).to eql(2)
                expect(source_node.attributes['a'].value).to eql('aaa')
                expect(source_node.attributes['b'].value).to eql('bbb')
            end
        end
        context 'when transform attribute doesnt exist' do
            it 'only logs, doesnt throw error' do
                source_doc = Nokogiri::XML('<root a="aaa" />')
                transform_doc = Nokogiri::XML('<root a="aaa1" />')
                source_node = source_doc.root
                transform_node = transform_doc.root

                XdtTransformSetAttributes.new(['a','b']).transform(source_node, transform_node)
                expect(source_node.attributes.count).to eql(1)
                expect(source_node.attributes['a'].value).to eql('aaa1')
            end
        end
    end
end
