require 'puppet_x/xdt_transformer'
require 'nokogiri'

Puppet::Type.type(:xdt_file).provide(:xdt) do
    desc "XDT provider"

    def exists?
        file_exists = File.exists?(@resource[:destination_file])
        Puppet.debug("destination_file exists = #{file_exists}")
        return File.exists?(@resource[:destination_file]) && File.read(@resource[:destination_file]) == transform.to_xml
    end

    def create
        Puppet.debug("create")
        doc = transform
        Puppet.debug(@resource[:destination_file])
        File.open(@resource[:destination_file], 'w') {|f| doc.write_xml_to f}
    end

    def destroy
        Puppet.debug("destroy")
        File.delete(@resource[:destination_file])
    end

    def update
        Puppet.debug("update")
        doc = transform
        File.open(@resource[:destination_file], 'w') {|f| doc.write_xml_to f}
    end

    def transform
        transformer = XdtTransformer.new(
            Nokogiri::XML(File.read(@resource[:source_file])),
            Nokogiri::XML(File.read(@resource[:transform_file])))
        return transformer.transform
    end
end