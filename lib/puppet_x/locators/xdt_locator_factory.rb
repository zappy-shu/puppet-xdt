Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require_relative '../xdt_attribute'

class XdtLocatorFactory
    def create(attr)
        return nil unless attr.is_locator?

        case attr.value
        when 'Condition'
            return XdtLocatorCondition.new(attr.arguments)
        when 'Match'
            return XdtLocatorMatch.new(attr.arguments)
        when 'XPath'
            return XdtLocatorXpath.new(attr.arguments)
        else
            return XdtLocatorDefault.new(attr.arguments)
        end
    end
end
