require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet/type/xdt_file'

describe 'xdt_file' do
  subject do
    Puppet::Type.type(:xdt_file).new(params)
  end
  context '#destination_file' do
    context 'when destination path not absolute' do
      let(:params) do
        { 
          destination_file: 'not absolute',
          source_file: __FILE__,
          transform_file: __FILE__,
        }
      end

      it 'raises error' do
        expect{subject}.to raise_error(Puppet::Error, /destination_file/)
      end
    end
    context 'when destination path is a directory' do
      let(:params) do 
        {
          destination_file: Dir.pwd,
          source_file: __FILE__,
          transform_file: __FILE__,
        }
      end
      
      it 'raises error' do
        expect{subject}.to raise_error(Puppet::Error, /destination_file/)
      end
    end
    context "when destination path's parent directory doesn't exist" do
      let(:params) do 
        { 
          destination_file: "#{Dir.pwd}/not-a-real-dir/nope.txt",
          source_file: __FILE__,
          transform_file: __FILE__,
        }
      end
      
      it 'raises error' do
        expect{subject}.to raise_error(Puppet::Error, /destination_file/)
      end
    end
    context "when destination path is a valid file path" do
      let(:params) do 
        {
          destination_file: "#{Dir.pwd}/yep.txt",
          source_file: __FILE__,
          transform_file: __FILE__,
        }
      end
      
      it 'validates successfully' do
        expect{subject}.to_not raise_error
      end
    end
  end
  context '#source_file' do
    context 'when source path not absolute' do
      let(:params) do
        {
          destination_file: "#{Dir.pwd}/yep.txt",
          source_file: 'not absolute',
          transform_file: __FILE__,
        }
      end

      it 'raises error' do
        expect{subject}.to raise_error(Puppet::Error, /source_file/)
      end
    end
    context 'when source path does not exist' do
      let(:params) do 
        {
          destination_file: "#{Dir.pwd}/yep.txt",
          source_file: "#{Dir.pwd}/does-not-exist.txt",
          transform_file: __FILE__,
        }
      end
      
      it 'raises error' do
        expect{subject}.to raise_error(Puppet::Error, /source_file/)
      end
    end
    context 'when source path not set' do
      let(:params) do 
        {
          destination_file: "#{Dir.pwd}/yep.txt",
          transform_file: __FILE__,
        }
      end
      
      it 'raises error' do
        expect{subject}.to raise_error(Puppet::Error, /source_file/)
      end
    end
    context 'when source path exists' do
      let(:params) do 
        {
          destination_file: "#{Dir.pwd}/yep.txt",
          source_file: __FILE__,
          transform_file: __FILE__,
        }
      end
      
      it 'validates successfully' do
        expect{subject}.to_not raise_error
      end
    end
  end
  context '#transform_file' do
    context 'when source path not absolute' do
      let(:params) do
        {
          destination_file: "#{Dir.pwd}/yep.txt",
          source_file: __FILE__,
          transform_file: 'not absolute',
        }
      end

      it 'raises error' do
        expect{subject}.to raise_error(Puppet::Error, /transform_file/)
      end
    end
    context 'when transform path does not exist' do
      let(:params) do 
        {
          destination_file: "#{Dir.pwd}/yep.txt",
          source_file: __FILE__,
        }
      end
      
      it 'raises error' do
        expect{subject}.to raise_error(Puppet::Error, /transform_file/)
      end
    end
    context 'when transform path exists' do
      let(:params) do 
        {
          destination_file: "#{Dir.pwd}/yep.txt",
          source_file: __FILE__,
          transform_file: __FILE__,
        }
      end
      
      it 'validates successfully' do
        expect{subject}.to_not raise_error
      end
    end
  end
end
