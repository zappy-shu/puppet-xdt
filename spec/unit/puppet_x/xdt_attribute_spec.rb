require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/xdt_attribute'

describe XdtAttribute do
    describe '#name' do
        context 'when given name = hello' do
            it 'name return hello' do
                expect(XdtAttribute.new('hello', 'world').name).to eql('hello')
            end
        end
    end
    describe '#value' do
        context 'when given value = world' do
            it 'name return world' do
                expect(XdtAttribute.new('hello', 'world').value).to eql('world')
            end
        end
    end
    describe '#is_transform?' do
        context 'when name is Transform' do
            it 'is true' do
                expect(XdtAttribute.new('Transform', 'value').is_transform?).to eql(true)
            end
        end
        context 'when name is not Transform' do
            it 'is false' do
                expect(XdtAttribute.new('nope', 'value').is_transform?).to eql(false)
            end
        end
    end
    describe '#is_locator?' do
        context 'when name is Locator' do
            it 'is true' do
                expect(XdtAttribute.new('Locator', 'value').is_locator?).to eql(true)
            end
        end
        context 'when name is not Locator' do
            it 'is false' do
                expect(XdtAttribute.new('nope', 'value').is_locator?).to eql(false)
            end
        end
    end
    describe '#locator_type' do
        context 'when not a locator attribute' do
            it 'returns nil' do
                expect(XdtAttribute.new('nope', 'value').locator_type).to eql(nil)
            end
        end
        context 'when attribute is locator' do
            it 'returns locator type' do
                expect(XdtAttribute.new('Locator', 'locator-type').locator_type).to eql('locator-type')
            end
        end
        context 'when locator has arguments' do
            it 'returns only locator type' do
                expect(XdtAttribute.new('Locator', 'locator-type(attr)').locator_type).to eql('locator-type')
            end
        end
    end
    describe '#transform_type' do
        context 'when not a transform attribute' do
            it 'returns nil' do
                expect(XdtAttribute.new('nope', 'value').transform_type).to eql(nil)
            end
        end
        context 'when attribute is transform' do
            it 'returns transform type' do
                expect(XdtAttribute.new('Transform', 'transform-type').transform_type).to eql('transform-type')
            end
        end
        context 'when transform has arguments' do
            it 'returns only transform type' do
                expect(XdtAttribute.new('Transform', 'transform-type(attr)').transform_type).to eql('transform-type')
            end
        end
    end
    describe '#arguments' do
        context 'when no brackets in value' do
            it 'returns empty array' do
                expect(XdtAttribute.new('name', 'value').arguments).to eql([])
            end
        end
        context 'when brackets but no arguments in value' do
            it 'returns empty array' do
                expect(XdtAttribute.new('name', 'value()').arguments).to eql([])
            end
        end
        context 'when 2 arguments in value' do
            it 'returns array with arguments' do
                expect(XdtAttribute.new('name', 'value(1,2)').arguments).to eql(['1','2'])
            end
        end
    end
end
