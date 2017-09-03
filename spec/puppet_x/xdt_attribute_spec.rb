require_relative '../../lib/puppet_x/xdt_attribute'

describe XdtAttribute do
    describe '#name' do
        context 'given name = hello' do
            it 'name return hello' do
                expect(XdtAttribute.new('hello', 'world').name).to eql('hello')
            end
        end
    end
    describe '#value' do
        context 'given value = world' do
            it 'name return world' do
                expect(XdtAttribute.new('hello', 'world').value).to eql('world')
            end
        end
    end
    describe '#is_transform?' do
        context 'name is Transform' do
            it 'is true' do
                expect(XdtAttribute.new('Transform', 'value').is_transform?).to eql(true)
            end
        end
        context 'name is not Transform' do
            it 'is false' do
                expect(XdtAttribute.new('nope', 'value').is_transform?).to eql(false)
            end
        end
    end
    describe '#is_locator?' do
        context 'name is Locator' do
            it 'is true' do
                expect(XdtAttribute.new('Locator', 'value').is_locator?).to eql(true)
            end
        end
        context 'name is not Locator' do
            it 'is false' do
                expect(XdtAttribute.new('nope', 'value').is_locator?).to eql(false)
            end
        end
    end
end