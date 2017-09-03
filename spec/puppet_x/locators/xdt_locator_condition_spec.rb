require_relative '../../../lib/puppet_x/locators/xdt_locator_condition'
require 'nokogiri'

describe XdtLocatorCondition do
    describe '#locate' do
        context 'when no locator arguments given' do
            it 'warns and returns empty array' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                locator_doc = Nokogiri::XML('<root/>')
                source_node = source_doc.xpath('/root/a')[0]
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorCondition.new.locate(source_node, locator_node, [])
                expect(matching_nodes.length).to eql(0)
            end
        end
        context 'when more than 1 locator arguments given' do
            it 'warns and returns empty array' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                locator_doc = Nokogiri::XML('<root/>')
                source_node = source_doc.xpath('/root/a')[0]
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorCondition.new.locate(source_node, locator_node, ['1', '2'])
                expect(matching_nodes.length).to eql(0)
            end
        end
        context 'when condition argument empty and all child nodes matches locator node' do
            it 'returns all child nodes' do
                source_doc = Nokogiri::XML('<root><a/><a/></root>')
                locator_doc = Nokogiri::XML('<a/>')
                source_node = source_doc.root
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorCondition.new.locate(source_node, locator_node, [''])
                expect(matching_nodes.length).to eql(2)
                expect(matching_nodes[0].path).to eql('/root/a[1]')
                expect(matching_nodes[1].path).to eql('/root/a[2]')
            end
        end
        context 'when condition argument empty and 2 child nodes matches locator node' do
            it 'returns all child nodes' do
                source_doc = Nokogiri::XML('<root><a/><b/><a/></root>')
                locator_doc = Nokogiri::XML('<a/>')
                source_node = source_doc.root
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorCondition.new.locate(source_node, locator_node, [''])
                expect(matching_nodes.length).to eql(2)
                expect(matching_nodes[0].path).to eql('/root/a[1]')
                expect(matching_nodes[1].path).to eql('/root/a[2]')
            end
        end
        context 'when condition argument matches attribute' do
            it 'returns matching child node' do
                source_doc = Nokogiri::XML('<root><a a="aaa"/><a a="bbb"/></root>')
                locator_doc = Nokogiri::XML('<a/>')
                source_node = source_doc.root
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorCondition.new.locate(source_node, locator_node, ["@a = 'aaa'"])
                expect(matching_nodes.length).to eql(1)
                expect(matching_nodes[0].path).to eql('/root/a[1]')
            end
        end
    end
end
