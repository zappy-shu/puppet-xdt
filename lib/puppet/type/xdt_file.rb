require 'pathname'

Puppet::Type.newtype(:xdt_file) do
    @doc = "Creates an XML file transformed from a source file by a transform file using the XDT standard"

    ensurable do
        defaultvalues
        defaultto :present
    end

    validate do
        fail "source_file is not set" if self[:source_file].to_s.empty?
        fail "transform_file is not set" if self[:transform_file].to_s.empty?
    end

    newparam(:destination_file, :namevar => true) do
        desc "Specifies the absolute path to the destination file for the transformed file"
        validate do |value|
            pathname = Pathname.new(value)
            fail "destination_file '#{value}' is not absolute" unless pathname.absolute?
            fail "destination_file '#{value}' is a a directory" if pathname.directory?
            fail "destination_file '#{value}' parent directory doesn't exist" unless Dir.exists?(pathname.dirname)
        end
    end
    
    newparam(:source_file) do
        desc "Specifies the absolute path of the source file"
        validate do |value|
            fail "source_file is empty" if value.nil? || value.empty?
            fail "source_file '#{value}' is not absolute" unless Pathname.new(value).absolute?
            fail "source_file '#{value}' does not exist" unless File.exists?(value)
        end
    end
    
    newparam(:transform_file) do
        desc "Specifies the absolute path of the transform file"
        validate do |value|
            fail "transform_file is empty" if value.to_s.empty?
            fail "transform_file '#{value}' is not absolute" unless Pathname.new(value).absolute?
            fail "transform_file '#{value}' does not exist" unless File.exists?(value)
        end
    end
end
