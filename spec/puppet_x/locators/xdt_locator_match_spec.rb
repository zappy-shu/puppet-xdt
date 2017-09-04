require_relative '../../../lib/puppet_x/locators/xdt_locator_match'
require 'nokogiri'

describe XdtLocatorMatch do
    describe '#locate' do
        context 'when no locator arguments given' do
            it 'selects all child nodes with same name' do
                source_doc = Nokogiri::XML('<root><a/><b/><a/></root>')
                locator_doc = Nokogiri::XML('<a/>')
                source_node = source_doc.root
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorMatch.new([]).locate(source_node, locator_node)
                expect(matching_nodes.length).to eql(2)
                expect(matching_nodes[0].path).to eql('/root/a[1]')
                expect(matching_nodes[1].path).to eql('/root/a[2]')
            end
        end
        context 'when locator argument doesnt match locator attribute' do
            it 'warns and returns empty array' do
                source_doc = Nokogiri::XML('<root/>')
                locator_doc = Nokogiri::XML('<a/>')
                source_node = source_doc.root
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorMatch.new(['nope']).locate(source_node, locator_node)
                expect(matching_nodes.length).to eql(0)
            end
        end
        context 'when selected locator attributes match child node' do
            it 'returns array of matching child node' do
                source_doc = Nokogiri::XML('<root><a a="aaa"/><b/><a a="bbb"/></root>')
                locator_doc = Nokogiri::XML('<a a="aaa"/>')
                source_node = source_doc.root
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorMatch.new(["a"]).locate(source_node, locator_node)
                expect(matching_nodes.length).to eql(1)
                expect(matching_nodes[0].path).to eql('/root/a[1]')
            end
        end
    end
end
