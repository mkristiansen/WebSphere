# encoding: UTF-8
#
# Author: Stefano Harding <sharding@trace3.com>
# Cookbook Name:: websphere
# Attributes:: packagingUtility
#

# =========================== IBM Packaging Utility ============================
#
default[:websphere][:pkgutil] = {
  # Specify whether or not to install IBM Packaging Utility. When installing IIM
  # and specifying the `:install_type` attribte as `:with_pkgutil` the Packaging
  # Utility is then installed as a bundle with IIM (default).
  install: false,

  # The Uniq IBM product ID for IBM Installation Manager.
  id: 'com.ibm.cic.packagingUtility',

  # Specify the repositories that are used during the installation. Use a URL
  # or UNC path to specify the remote repositories. Or use directory paths to
  # specify the local repositories.
  repositories: ->{ node[:websphere][:repositories][:local] },

  # Use the install and uninstall commands to inform Installation Manager of the
  # installation packages to install or uninstall.
  #   false = Indicates not to modify an existing install by adding or removing
  #           features.
  #   true  = Indicates to modify an existing install by adding or removing
  #           features.
  modify: false,

  # The version attribute is optional. If a version number is provided, then the
  # offering will be installed or uninstalled at the version level specified as
  # long as it is available in the repositories. If the version attribute is not
  # provided, then the default behavior is to install or uninstall the latest
  # version available in the repositories. The version number can be found in
  # the repository.xml file in the repositories.
  #
  # NOTE: In some cases, a package might be rolled back to an earlier version.
  # This roll back can happen if the version specified is earlier than the
  # installed version or if a version is not specified. For example, you have
  # version 1.0.2 of a package that is installed and the latest version of the
  # package available in the repository is version 1.0.1. When you install the
  # package, the installed version of the package is rolled back to version
  # 1.0.1.
  version: '1.8.0.20140902_1631',

  # The profile attribute is required and typically is unique to the offering.
  # If modifying or updating an existing installation, the profile attribute
  # must match the profile ID of the targeted installation of WebSphere
  # Application Server.
  profile: 'IBM Packaging Utility',

  # The features attribute is optional. Offerings always have at least one
  # feature; a required core feature which is installed regardless of whether
  # it is explicitly specified. If other feature names are provided, then only
  # those features will be installed. Features must be comma delimited without
  # spaces.
  features: 'packaging_utility,jre',

  # The installFixes attribute indicates whether fixes available in repositories
  # are installed with the product. By default, all available fixes will be
  # installed with the offering.
  #
  # Valid values for installFixes:
  #   none        = Do not install available fixes.
  #   recommended = Installs all available recommended fixes.
  #   all         = Installs all available fixes.
  fixes: 'none',

  # The installation directory for IBM Packaging Utility.
  # NOTE: The installation will append `/PackagingUtility` to the
  # path. Default is `/opt/IBM/PackagingUtility`.
  install_location: '/opt/IBM',

  data: [
    # The eclipseLocation data key should use the same directory path to
    # WebSphere Application Server as the installationLocation attribute.
    { key:   'eclipseLocation',
      value: lambda { node[:websphere][:pkgutil][:install_location] } },
    # Include data keys for product specific profile properties.
    { key:   'user.import.profile',         value: false              },
    # Specifies the operating system.
    { key:   'cic.selector.os',             value: 'linux'            },
    # Specifies the type of window system.
    { key:   'cic.selector.ws',             value: 'gtk'              },
    # Specifies the architecture to install: 32-bit or 64-bit.
    { key:   'cic.selector.arch',           value: 'x86_64'           },
    # Specifies the language pack to be installed using ISO-639 language codes.
    { key:   'cic.selector.nl',             value: 'en'               }
  ],

  file: {
    # Zip file that contains the IBM Installation Manager package.
    name: 'pu.offering.disk.linux.gtk.x86_64_1.8.0.20140902_1631.zip',

    # Local or remote location where the IIM zip file is located. Default
    # is to download from IBM.
    source: 'http://ibm.co/11JHlgJ',

    # The SHA-256 checksum of the zip file. Checksum are calculated with:
    # shasum -a 256 /path/to/file | cut -c-12
    checksum: '69787054dd6a'
  }
}