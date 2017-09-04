# xdt

#### Table of Contents

1. [Description](#description)
2. [Reference](#reference)
    * [xdt_file](#xdt_file)
3. [Notes](#notes)

## Description
Transforms XMLs files using the XDT standard: https://msdn.microsoft.com/en-us/library/dd465326(v=vs.110).aspx

## Reference

### xdt_file

Transforms a source file with a transform and saves to a destination file

```puppet
xdt_file { 'C:/transforms/transformed.xml':
    ensure => present,
    source_file => 'C:/transforms/source.xml',
    transform_file => 'C:/transforms/transform.xml',
}
```

#### Properties/Parameters

##### `ensure`
If 'present' is specified, will ensure the destination file exists with the transformed contents.
If 'absent' is specified, will ensure the destination file does not exist.

##### `destination_file`
The absolute path to the destination file containing the transformed XML. Defaults to the resource name.

##### `source_file`
The absolute path to the file containing the XML to transform.

##### `transform_file`
The absolute path to the file containing the transforms.

## Notes
Though this module has only been tested on Windows, it uses no Windows specific implementations and should therefore work on other operating systems. Use at your own risk.
