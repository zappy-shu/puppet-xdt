class XdtAttribute
    def initialize(name, value)
        @name = name
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
end
