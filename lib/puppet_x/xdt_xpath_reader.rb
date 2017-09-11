require 'nokogiri'

class XdtXpathReader
    def self.read(node)
        xpath = node.path
        if xpath.include?('[') && xpath.include?(']')
            xpath = xpath[0..xpath.index('[') - 1]
        end

        return xpath
    end
    def self.read_local(node)
        return node.name if node.namespace.nil?
        return "*[local-name()='#{node.name}' and namespace-uri()='#{node.namespace.href}']"
    end
    def self.read_attribute(attr)
        xpath = ''
        xpath += "#{attr.namespace.prefix}:" unless attr.namespace.nil?
        return xpath + attr.name
    end
end
