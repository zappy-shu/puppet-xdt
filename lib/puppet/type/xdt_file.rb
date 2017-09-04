Puppet::Type.newtype(:xdt_file) do
    @doc = "Creates an XML file transformed from a source file by a transform file using the XDT standard"

    newparam(:destination_path, :namevar => true) do
        desc "Specifies the fully qualified destination file path of the transformed file"
        
    end
end