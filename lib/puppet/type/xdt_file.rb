require 'pathname'

Puppet::Type.newtype(:xdt_file) do
    @doc = "Creates an XML file transformed from a source file by a transform file using the XDT standard"

    validate do
        fail "source_path is not set" if self[:source_path].to_s.empty?
        fail "transform_path is not set" if self[:transform_path].to_s.empty?
    end

    newparam(:destination_path, :namevar => true) do
        desc "Specifies the fully qualified destination file path for the transformed file"
        validate do |value|
            pathname = Pathname.new(value)
            fail "destination_path '#{value}' is not absolute" unless pathname.absolute?
            fail "destination_path '#{value}' is a a directory" if pathname.directory?
            fail "destination_path '#{value}' parent directory doesn't exist" unless Dir.exists?(pathname.dirname)
        end
    end
    
    newparam(:source_path) do
        desc "Specifies the fully qualified source file"
        validate do |value|
            fail "source_path is empty" if value.nil? || value.empty?
            fail "source_path '#{value}' is not absolute" unless Pathname.new(value).absolute?
            fail "source_path '#{value}' does not exist" unless File.exists?(value)
        end
    end
    
    newparam(:transform_path) do
        desc "Specifies the fully qualified transform file"
        validate do |value|
            fail "transform_path is empty" if value.to_s.empty?
            fail "transform_path '#{value}' is not absolute" unless Pathname.new(value).absolute?
            fail "transform_path '#{value}' does not exist" unless File.exists?(value)
        end
    end
end
