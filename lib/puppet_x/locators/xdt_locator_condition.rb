require_relative 'xdt_locator_logger'
require 'nokogiri'

class XdtLocatorCondition
    def locate(parent_source_node, locator_node, locator_arguments)
        XdtLocatorLogger.log_action('Condition', parent_source_node, locator_node, locator_arguments)
        unless locator_arguments.length == 1
            warn "Condition locator requires 1 locator argument that is an xpath expression"
            return []
        end

        conditions = locator_arguments[0]
        xpath = "#{locator_node.name}"
        xpath += "[#{conditions}]" unless conditions.empty?
        return parent_source_node.xpath(xpath)
    end
end
