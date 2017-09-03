Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require_relative '../xdt_attribute'

class XdtTransformFactory
    def create(attr)
        return nil unless attr.name == 'Transform'
        puts attr.value
        case attr.value
        when 'InsertAfter'
            return XdtTransformInsertAfter.new
        when 'InsertBefore'
            return XdtTransformInsertBefore.new
        when 'Insert'
            return XdtTransformInsert.new
        when 'RemoveAll'
            return XdtTransformRemoveAll.new
        when 'RemoveAttributes'
            return XdtTransformRemoveAttributes.new
        when 'Replace'
            return XdtTransformReplace.new
        when 'SetAttributes'
            return XdtTransformSetAttributes.new
        else
            return nil
        end
    end
end
