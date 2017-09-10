require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_x/xdt_argument_utility'

describe XdtArgumentUtility do
    describe '.split_arguments' do
        context 'given an empty string' do
            it 'returns empty array' do
                expect(XdtArgumentUtility.split_arguments('')).to eql([])
            end
        end
        context 'given 1 arg with no commas' do
            it 'returns 1 element array' do
                expect(XdtArgumentUtility.split_arguments('aaa')).to eql(['aaa'])
            end
        end
        context 'given 2 args' do
            it 'returns 2 element array' do
                expect(XdtArgumentUtility.split_arguments('aaa,bbb')).to eql(['aaa','bbb'])
            end
        end
        context 'given args prefixed/suffixed with spaces' do
            it 'returns args without prefixed/suffixed spaces' do
                expect(XdtArgumentUtility.split_arguments(' aa a,bb b ')).to eql(['aa a','bb b'])
            end
        end
        context 'given arg with command enclosed in parentheses' do
            it 'returns arg without spliting' do
                expect(XdtArgumentUtility.split_arguments('aaa,(bbb,ccc),ddd')).to eql(['aaa','(bbb,ccc)','ddd'])
            end
        end
    end
end
