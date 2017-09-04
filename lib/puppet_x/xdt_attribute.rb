require_relative 'xdt_argument_utility'

class XdtAttribute
    def initialize(name, value)
        @name = name

        if (value.include?('('))
            type = value[0...value.index('(')]
            args_string = value[value.index('(') + 1..-2]
            @arguments = XdtArgumentUtility.split_arguments(args_string)
            value = type
        else
            @arguments = []
        end

        @value = value
    end

    def name
        return @name
    end

    def value
        return @value
    end

    def is_transform?
        return @name == 'Transform'
    end

    def is_locator?
        return @name == 'Locator'
    end
    
    def transform_type
        return is_transform? ? value : nil
    end
    
    def locator_type
        return is_locator? ? value : nil
    end

    def arguments
        return @arguments
    end
end
