require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/xdt_xpath_reader'
require 'nokogiri'

describe XdtXpathReader do
    describe '.read' do
        context 'when node has no namesapce' do
            it 'xpath is just name' do
                node = Nokogiri::XML('<root><a/></root>').xpath('/root/a')[0]
                expect(XdtXpathReader.read(node)).to eql('/root/a')
            end
        end
        context 'when node has namesapce' do
            it 'xpath is prefixed' do
                node = Nokogiri::XML('<root xmlns:ns="space"><ns:a/></root>').xpath('/root/ns:a')[0]
                expect(XdtXpathReader.read(node)).to eql('/root/ns:a')
            end
        end
        context 'when parent has duplicate children' do
            it 'xpath does not have child number' do
                node = Nokogiri::XML('<root xmlns:ns="space"><ns:a/><ns:a/></root>').xpath('/root/ns:a')[0]
                expect(XdtXpathReader.read(node)).to eql('/root/ns:a')
            end
        end
    end
    describe '.read_local' do
        context 'when node has no namespace' do
            it 'return name' do
                node = Nokogiri::XML('<root><a/></root>').xpath('/root/a')[0]
                expect(XdtXpathReader.read_local(node)).to eql('a')
            end
        end
        context 'when node has namespace' do
            it 'return with local name and namespace uri' do
                node = Nokogiri::XML('<root xmlns:ns="space"><ns:a/><ns:a/></root>').xpath('/root/ns:a')[0]
                expect(XdtXpathReader.read_local(node)).to eql("*[local-name()='a' and namespace-uri()='space']")
            end
        end
    end
    describe '.read_attribute' do
        context 'when attribute has no namespace' do
            it 'return name' do
                node = Nokogiri::XML('<root><a a="aaa"/></root>').xpath('/root/a')[0]
                attr = node.attribute_nodes[0]
                expect(XdtXpathReader.read_attribute(attr)).to eql('a')
            end
        end
        context 'when attribue has namespace' do
            it 'return prefix:name' do
                node = Nokogiri::XML('<root xmlns:ns="space"><a ns:a="aaa"/></root>').xpath('/root/a')[0]
                attr = node.attribute_nodes[0]
                expect(XdtXpathReader.read_attribute(attr)).to eql('ns:a')
            end
        end
    end
end
