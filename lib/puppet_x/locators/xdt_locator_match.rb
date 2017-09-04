require_relative 'xdt_locator_logger'
require_relative '../xdt_xpath_reader'
require 'nokogiri'

class XdtLocatorMatch
    def initialize(locator_arguments)
        @locator_arguments = locator_arguments
    end

    def locate(parent_source_node, locator_node)
        XdtLocatorLogger.log_action('Match', parent_source_node, locator_node, @locator_arguments)
        xpath = XdtXpathReader.read_local(locator_node)
        if @locator_arguments.empty?
            return parent_source_node.xpath(xpath)
        end

        first_match_added = false
        attr_match = '['
        @locator_arguments.each do |arg|
            attr = locator_node.attribute_nodes.first { |attr| XdtXpathReader.read_attribute(attr) == arg }
            if attr.nil?
                warn "Attempting to match attribute '#{arg}' which locator doesnt have"
            else
                attr_match += ' && ' if first_match_added
                first_match_added = true
                attr_match += "@#{arg}='#{attr.value}'"    
            end
        end
        
        attr_match = attr_match == '[' ? '' : "#{attr_match}]"
        xpath += attr_match
        return parent_source_node.xpath(xpath)
    end
end
