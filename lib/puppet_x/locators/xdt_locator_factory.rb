Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require_relative '../xdt_attribute'

class XdtTransformFactory
    def create(attr)
        case attr.value
        when 'Condition'
            return XdtLocatorCondition.new
        when 'Match'
            return XdtLocatorMatch.new
        when 'XPath'
            return XdtLocatorXpath.new
        else
            return XdtLocatorDefault.new
        end
    end
end
