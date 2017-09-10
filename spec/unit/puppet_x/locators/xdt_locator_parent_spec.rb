require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/locators/xdt_locator_parent'
require 'nokogiri'

describe XdtLocatorParent do
    describe '#locate' do
        context 'when node has parent' do
            it 'returns parent node' do
                source_doc = Nokogiri::XML('<root><a/></root>')
                locator_doc = Nokogiri::XML('<root><a/></root>')
                source_node = source_doc.root
                locator_node = locator_doc.xpath('/root/a')[0]

                matching_nodes = XdtLocatorParent.new([]).locate(source_node, locator_node)
                expect(matching_nodes.length).to eql(1)
                expect(matching_nodes[0].path).to eql('/root')
            end
        end
    end
end
