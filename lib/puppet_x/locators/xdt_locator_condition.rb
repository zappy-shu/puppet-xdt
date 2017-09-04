require_relative 'xdt_locator_logger'
require_relative '../xdt_xpath_reader'
require 'nokogiri'

class XdtLocatorCondition
    def initialize(locator_arguments)
        @locator_arguments = locator_arguments
    end

    def locate(parent_source_node, locator_node)
        XdtLocatorLogger.log_action('Condition', parent_source_node, locator_node, @locator_arguments)
        unless @locator_arguments.length == 1
            warn "Condition locator requires 1 locator argument that is an xpath expression"
            return []
        end

        conditions = @locator_arguments[0]
        xpath = XdtXpathReader.read_local(locator_node)
        xpath += "[#{conditions}]" unless conditions.empty?
        return parent_source_node.xpath(xpath)
    end
end
