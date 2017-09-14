require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/xdt_transformer'
require 'nokogiri'

def compare_namespaces(expected, actual)
    if expected.nil?
        expect(actual).to eql(nil)
    else
        expect(actual.href).to eql(expected.href)
        expect(actual.prefix).to eql(expected.prefix)
    end
end

def compare_attributes(expected, actual)
    expected_attrs = expected.attribute_nodes
    actual_attrs = actual.attribute_nodes
    expect(actual_attrs.length).to eql(expected_attrs.length)
    expected_attrs.each_with_index do |expected_attr, i|
        expect(actual_attrs[i].name).to eql(expected_attr.name)
        expect(actual_attrs[i].value).to eql(expected_attr.value)
        compare_namespaces(expected_attr.namespace, actual_attrs[i].namespace)
    end
end

def compare_elements(expected, actual)
    expect(actual.name).to eql(expected.name)
    compare_namespaces(expected.namespace, actual.namespace)
    compare_attributes(expected, actual)
    expect(actual.elements.length).to eql(expected.elements.length)
    expected.elements.each_with_index do |expected_child, i|
        compare_elements(expected_child, actual.elements[i])
    end
end

describe XdtTransformer do
    describe "#transform" do
        context "when transforming spec/resources/transform_only/source.xml with spec/resources/transform_only/transform.xml" do
            it "transformed file same as spec/resources/transform_only/expected.xml" do
                source_doc = Nokogiri::XML(File.read("#{Dir.pwd}/spec/resources/transform_only/source.xml"))
                transform_doc = Nokogiri::XML(File.read("#{Dir.pwd}/spec/resources/transform_only/transform.xml"))
                expected_doc = Nokogiri::XML(File.read("#{Dir.pwd}/spec/resources/transform_only/expected.xml"))
                transformed_doc = XdtTransformer.new(source_doc, transform_doc).transform
                
                File.write("#{Dir.pwd}/spec/resources/transform_only/.temp.actual.xml", transformed_doc.to_s)
                compare_elements(expected_doc.root, transformed_doc.root)
            end
        end
        context "when transforming spec/resources/transform_with_namespaces/source.xml with spec/resources/transform_with_namespaces/transform.xml" do
            it "transformed file same as spec/resources/transform_with_namespaces/expected.xml" do
                source_doc = Nokogiri::XML(File.read("#{Dir.pwd}/spec/resources/transform_with_namespaces/source.xml"))
                transform_doc = Nokogiri::XML(File.read("#{Dir.pwd}/spec/resources/transform_with_namespaces/transform.xml"))
                expected_doc = Nokogiri::XML(File.read("#{Dir.pwd}/spec/resources/transform_with_namespaces/expected.xml"))
                transformed_doc = XdtTransformer.new(source_doc, transform_doc).transform
                File.write("#{Dir.pwd}/spec/resources/transform_with_namespaces/.temp.actual.xml", transformed_doc.to_s)
                compare_elements(expected_doc.root, transformed_doc.root)
            end
        end
    end
end