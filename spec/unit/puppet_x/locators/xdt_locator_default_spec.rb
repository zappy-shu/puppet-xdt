require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/locators/xdt_locator_default'
require 'nokogiri'

describe XdtLocatorDefault do
    describe '#locate' do
        context 'when parent has 1 child matching locator node' do
            it 'returns child node' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                locator_doc = Nokogiri::XML('<root><a/></root>')
                source_node = source_doc.root
                locator_node = locator_doc.xpath('/root/a')[0]

                matching_nodes = XdtLocatorDefault.new([]).locate(source_node, locator_node)
                expect(matching_nodes.length).to eql(1)
                expect(matching_nodes[0].path).to eql('/root/a')
            end
        end
        context 'when parent has 2 children matching locator node and 1 not' do
            it 'returns the 2 matching children' do
                source_doc = Nokogiri::XML('<root><a/><a/><b/></root>')
                locator_doc = Nokogiri::XML('<root><a/></root>')
                source_node = source_doc.root
                locator_node = locator_doc.xpath('/root/a')[0]

                matching_nodes = XdtLocatorDefault.new([]).locate(source_node, locator_node)
                expect(matching_nodes.length).to eql(2)
                expect(matching_nodes[0].path).to eql('/root/a[1]')
                expect(matching_nodes[1].path).to eql('/root/a[2]')
            end
        end
    end
end
