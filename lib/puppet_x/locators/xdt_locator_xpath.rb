require_relative 'xdt_locator_logger'
require 'nokogiri'

class XdtLocatorXpath
    def locate(parent_source_node, locator_node, locator_arguments)
        XdtLocatorLogger.log_action('Xpath', parent_source_node, locator_node, locator_arguments)
        unless locator_arguments.length == 1
            warn "Xpath locator requires 1 locator argument that is the full xpath"
            return []
        end

        return parent_source_node.document.xpath(locator_arguments[0])
    end
end
