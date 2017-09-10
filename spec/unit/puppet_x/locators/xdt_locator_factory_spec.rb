require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/xdt_attribute'
require 'puppet_x/locators/xdt_locator_factory'

describe XdtLocatorFactory do
    describe '#create' do
        context 'when attribute not a locator' do
            it 'returns nil' do
                attr = XdtAttribute.new('a', 'b')
                expect(XdtLocatorFactory.new.create(attr)).to eql(nil)
            end
        end
        context 'when attribute is a Condition locator' do
            it 'returns XdtLocatorCondition object' do
                attr = XdtAttribute.new('Locator', 'Condition')
                expect(XdtLocatorFactory.new.create(attr).is_a?(XdtLocatorCondition)).to eql(true)
            end
        end
        context 'when attribute is an XPath locator' do
            it 'returns XdtLocatorXpath object' do
                attr = XdtAttribute.new('Locator', 'XPath')
                expect(XdtLocatorFactory.new.create(attr).is_a?(XdtLocatorXpath)).to eql(true)
            end
        end
        context 'when attribute is a Match locator' do
            it 'returns XdtLocatorMatch object' do
                attr = XdtAttribute.new('Locator', 'Match')
                expect(XdtLocatorFactory.new.create(attr).is_a?(XdtLocatorMatch)).to eql(true)
            end
        end
        context 'when attribute is locator but not of a known type' do
            it 'returns XdtLocatorDefault object' do
                attr = XdtAttribute.new('Locator', 'unknown')
                expect(XdtLocatorFactory.new.create(attr).is_a?(XdtLocatorDefault)).to eql(true)
            end
        end
    end
end
