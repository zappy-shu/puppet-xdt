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
        xpath = ''
        xpath += "#{node.namespace.prefix}:" unless node.namespace.nil?
        return xpath + node.name
    end
    def self.read_attribute(attr)
        xpath = ''
        xpath += "#{attr.namespace.prefix}:" unless attr.namespace.nil?
        return xpath + attr.name
    end
end
