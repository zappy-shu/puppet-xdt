require_relative '../../../lib/puppet_x/locators/xdt_locator_xpath'
require 'nokogiri'

describe XdtLocatorXpath do
    describe '#locate' do
        context 'when no locator attributes given' do
            it 'warns and returns empty array' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                locator_doc = Nokogiri::XML('<root/>')
                source_node = source_doc.xpath('/root/a')[0]
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorXpath.new.locate(source_node, locator_node, [])
                expect(matching_nodes.length).to eql(0)
            end
        end
        context 'when more than 1 locator attributes given' do
            it 'warns and returns empty array' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                locator_doc = Nokogiri::XML('<root/>')
                source_node = source_doc.xpath('/root/a')[0]
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorXpath.new.locate(source_node, locator_node, ['1', '2'])
                expect(matching_nodes.length).to eql(0)
            end
        end
        context 'when no node matches xpath' do
            it 'returns empty array' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                locator_doc = Nokogiri::XML('<root/>')
                source_node = source_doc.xpath('/root/a')[0]
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorXpath.new.locate(source_node, locator_node, ['//root/b'])
                expect(matching_nodes.length).to eql(0)
            end
        end
        context 'when 1 node matches xpath' do
            it 'return matching node' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                locator_doc = Nokogiri::XML('<root/>')
                source_node = source_doc.xpath('/root/a')[0]
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorXpath.new.locate(source_node, locator_node, ['//root/a'])
                expect(matching_nodes.length).to eql(1)
                expect(matching_nodes[0]).to eql(source_node)
            end
        end
        context 'when 2 nodes matches xpath' do
            it 'return both matching node' do
                source_doc = Nokogiri::XML('<root><a/><a/></root>')
                locator_doc = Nokogiri::XML('<root/>')
                source_nodes = source_doc.xpath('/root/a')
                locator_node = locator_doc.root

                matching_nodes = XdtLocatorXpath.new.locate(source_nodes[0], locator_node, ['//root/a'])
                expect(matching_nodes.length).to eql(2)
                expect(matching_nodes[0]).to eql(source_nodes[0])
                expect(matching_nodes[1]).to eql(source_nodes[1])
            end
        end
    end
end
