class XmlArgumentUtility
    def self.split_arguments(args_string)
        return [] if args_string.empty?
        return [args_string] unless args_string.include?(',')
        args = args_string.split(',')
        args = recombine_args(args)
        return trim_arguments(args)
    end

    private
    def self.recombine_args(args)
        combinded_args = Array.new
        combinded_arg = nil
        paren_count = 0

        args.each do |arg|
            combinded_arg = combinded_arg.nil? ? arg : "#{combinded_arg},#{arg}"
            paren_count += count_paren(arg)
            next if paren_count != 0
            combinded_args << combinded_arg
            combinded_arg = nil
        end

        combinded_args << combinded_arg unless combinded_arg.nil?
        args = combinded_args if args.length != combinded_args.length
        return args
    end

    def self.count_paren(str)
        count = 0
        str.chars.each do |c|
            case c
            when '('
                count += 1
            when ')'
                count -= 1
            end
        end

        return count
    end

    def self.trim_arguments(args)
        return args.map { |arg| arg.strip }
    end
end