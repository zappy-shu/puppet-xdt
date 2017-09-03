require_relative '../../../lib/puppet_x/xdt_attribute'
Dir[File.dirname(__FILE__) + '/../../../lib/puppet_x/transforms/*.rb'].each {|file| require file }

describe XdtTransformFactory do
    describe '#create' do
        context 'attribute not a transform' do
            it 'returns nil' do
                attr = XdtAttribute.new('a', 'b')
                expect(XdtTransformFactory.new.create(attr)).to eql(nil)
            end
        end
        context 'attribute is InsertAfter' do
            it 'returns XdtTransformInsertAfter object' do
                attr = XdtAttribute.new('Transform', 'InsertAfter')
                expect(XdtTransformFactory.new.create(attr).is_a?(XdtTransformInsertAfter)).to eql(true)
            end
        end
        context 'attribute is InsertBefore' do
            it 'returns XdtTransformInsertBefore object' do
                attr = XdtAttribute.new('Transform', 'InsertBefore')
                expect(XdtTransformFactory.new.create(attr).is_a?(XdtTransformInsertBefore)).to eql(true)
            end
        end
        context 'attribute is Insert' do
            it 'returns XdtTransformInsert object' do
                attr = XdtAttribute.new('Transform', 'Insert')
                expect(XdtTransformFactory.new.create(attr).is_a?(XdtTransformInsert)).to eql(true)
            end
        end
        context 'attribute is RemoveAll' do
            it 'returns XdtTransformRemoveAll object' do
                attr = XdtAttribute.new('Transform', 'RemoveAll')
                expect(XdtTransformFactory.new.create(attr).is_a?(XdtTransformRemoveAll)).to eql(true)
            end
        end
        context 'attribute is RemoveAttributes' do
            it 'returns XdtTransformRemoveAttributes object' do
                attr = XdtAttribute.new('Transform', 'RemoveAttributes')
                expect(XdtTransformFactory.new.create(attr).is_a?(XdtTransformRemoveAttributes)).to eql(true)
            end
        end
        context 'attribute is Replace' do
            it 'returns XdtTransformReplace object' do
                attr = XdtAttribute.new('Transform', 'Replace')
                expect(XdtTransformFactory.new.create(attr).is_a?(XdtTransformReplace)).to eql(true)
            end
        end
        context 'attribute is SetAttributes' do
            it 'returns XdtTransformSetAttributes object' do
                attr = XdtAttribute.new('Transform', 'SetAttributes')
                expect(XdtTransformFactory.new.create(attr).is_a?(XdtTransformSetAttributes)).to eql(true)
            end
        end
    end
end