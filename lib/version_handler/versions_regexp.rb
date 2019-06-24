module ReleaseManager
  module VersionHandler
    VERSIONS_REGEXP = {
        'puppet-agent' => {
            regexp: //,
            path: ''
        },
        'pxp-agent' => {
            regexp: /project\(pxp-agent VERSION \d+\.\d+\.\d+\)/,
            path: 'CMakeLists.txt'
        },
        'cpp-pcp-client' => {
            regexp: /project\(cpp-pcp-client VERSION \d+\.\d+\.\d+\)/,
            path: 'CMakeLists.txt'
        },
        'leatherman' => {
            regexp: /project\(leatherman VERSION \d+\.\d+\.\d+\)/,
            path: 'CMakeLists.txt'
        },
        'puppet-resource_api' => {
            regexp: /VERSION = ['\"]\d+\.\d+\.\d+['\"]/,
            path: 'lib/puppet/resource_api/version.rb'
        },
        'libwhereami' => {
            regexp: /project\(libwhereami VERSION \d+\.\d+\.\d+\)/,
            path: 'CMakeLists.txt'
        },
        'facter' => {
            regexp: /project\(FACTER VERSION \d+\.\d+\.\d+\)/,
            path: 'CMakeLists.txt'
        },
        'hiera' => {
            regexp: /VERSION = ['\"]\d+\.\d+\.\d+['\"]/,
            path: 'lib/hiera/version.rb'
        },
        'puppet' => {
            regexp: /PUPPETVERSION = ['\"]\d+\.\d+\.\d+['\"]/,
            path: 'lib/puppet/version.rb'
        }
    }.freeze
  end
end
