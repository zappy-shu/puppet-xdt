Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require_relative '../xdt_attribute'

class XdtTransformFactory
    def create(attr)
        return nil unless attr.name == 'Transform'
        case attr.value
        when 'InsertAfter'
            return XdtTransformInsertAfter.new(attr.arguments)
        when 'InsertBefore'
            return XdtTransformInsertBefore.new(attr.arguments)
        when 'Insert'
            return XdtTransformInsert.new(attr.arguments)
        when 'RemoveAll'
            return XdtTransformRemoveAll.new(attr.arguments)
        when 'RemoveAttributes'
            return XdtTransformRemoveAttributes.new(attr.arguments)
        when 'Replace'
            return XdtTransformReplace.new(attr.arguments)
        when 'SetAttributes'
            return XdtTransformSetAttributes.new(attr.arguments)
        else
            return nil
        end
    end
end
