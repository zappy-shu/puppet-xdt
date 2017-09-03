require_relative 'xdt_locator_logger'
require 'nokogiri'

class XdtLocatorXpath
    def locate(source_node, locator_node, locator_arguments)
        XdtLocatorLogger.log_action('Xpath', source_node, locator_node, locator_arguments)
        unless locator_arguments.length == 1
            warn "Xpath locator requires 1 locator argument that is the full xpath"
            return []
        end

        return source_node.document.xpath(locator_arguments[0])
    end
end
