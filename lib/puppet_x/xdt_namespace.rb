require_relative 'xdt_attribute'
require 'nokogiri'

class XdtNamespace
    NAMESPACE = 'http://schemas.microsoft.com/XML-Document-Transform'
    
    def has_xdt_namespace?(doc)
        return doc.xpath('//namespace::*').any? { |ns| ns.href == NAMESPACE }
    end

    def get_xdt_attributes(doc, node)
        return node.attribute_nodes
            .select { |attr| !attr.namespace.nil? && !attr.namespace.nil? && attr.namespace.href == NAMESPACE }
            .map { |attr| XdtAttribute.new(attr.name, attr.value) }
    end

    def remove_xdt_attributes(doc, node)
        node.attribute_nodes
            .select { |attr| !attr.namespace.nil? && !attr.namespace.nil? && attr.namespace.href == NAMESPACE }
            .each { |attr| attr.remove }
    end
end
