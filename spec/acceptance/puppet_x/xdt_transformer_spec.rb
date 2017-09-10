require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/xdt_transformer'
require 'nokogiri'

def compare_attributes(expected, actual)
    expected_attrs = expected.attribute_nodes
    actual_attrs = actual.attribute_nodes
    expect(expected_attrs.length).to eql(actual_attrs.length)
    expected_attrs.each_with_index do |expected_attr, i|
        expect(expected_attr.name).to eql(actual_attrs[i].name)
        expect(expected_attr.value).to eql(actual_attrs[i].value)
        expect(expected_attr.namespace).to eql(actual_attrs[i].namespace)
    end
end

def compare_elements(expected, actual)
    expect(expected.name).to eql(actual.name)
    expect(expected.namespace).to eql(actual.namespace)
    expect(expected.elements.length).to eql(actual.elements.length)

    compare_attributes(expected, actual)
    expected.elements.each_with_index do |expected_child, i|
        actual_child = actual.elements[i]
        compare_elements(expected_child, actual_child)
    end
end

describe XdtTransformer do
    describe "#transform" do
        context "when transforming spec/resources/source.xml with spec/resources/transform.xml" do
            it "transformed file same as spec/resources/expected.xml" do
                source_doc = Nokogiri::XML(File.read("#{Dir.pwd}/spec/resources/source.xml"))
                transform_doc = Nokogiri::XML(File.read("#{Dir.pwd}/spec/resources/transform.xml"))
                expected_doc = Nokogiri::XML(File.read("#{Dir.pwd}/spec/resources/expected.xml"))
                transformed_doc = XdtTransformer.new(source_doc, transform_doc).transform
                File.write("#{Dir.pwd}/spec/resources/actual.xml", transformed_doc.to_s)
                compare_elements(expected_doc.root, transformed_doc.root)
            end
        end
    end
end