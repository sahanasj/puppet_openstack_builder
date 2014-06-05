# Supplemental script to set settings specific to the Cisco COI install
#

# These 5 are needed to use the Cisco COI repos
export vendor_repo=CiscoSystems
export vendor_branch=master
export FACTER_vendor=cisco
export FACTER_vendorrepo=coi
export FACTER_vendorpuppet=vendor

# Set this to deb to install puppet modules from packages, or to git
# to install puppet modules using librarian and git
export install_type=deb

REPO_LOC=${repo_location:-openstack-repo.cisco.com}
# Add Cisco repo and puppet repo
cat > /etc/apt/sources.list.d/cisco-openstack-mirror_icehouse.list<<EOF
# cisco-openstack-mirror_icehouse
deb http://$REPO_LOC/openstack/cisco icehouse-proposed main
deb-src http://$REPO_LOC/openstack/cisco icehouse-proposed main
EOF

cat > /etc/apt/sources.list.d/cisco-openstack-puppet_icehouse.list<<EOF
# cisco packaged puppet modules
deb http://$REPO_LOC/openstack/puppet icehouse-proposed main
deb-src http://$REPO_LOC/openstack/puppet icehouse-proposed main
EOF

# Add the signing key for the Cisco Puppet repo
echo "-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.11 (GNU/Linux)

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
ykz5a/8840rWqc7sLA7lKA==
=HVuX
-----END PGP PUBLIC KEY BLOCK-----" | apt-key add -

# add cisco puppet repo key

echo '-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.11 (GNU/Linux)

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
ykz5a/8840rWqc7sLA7lKA==
=HVuX
-----END PGP PUBLIC KEY BLOCK-----' | apt-key add -


apt-get update && apt-get install -y ipmitool

# Fix puppet, clobbering any existing puppet version to ensure
# PKI gets set up correctly.
apt-get remove --purge --yes puppet puppet-common
rm -rf /etc/puppet/puppet.conf /var/lib/puppet

# run dist-upgrade to ensure vendor repo packages which replace
# default repo packages get installed
apt-get dist-upgrade -y
