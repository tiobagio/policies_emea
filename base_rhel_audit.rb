# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'base_rhel_audit'

# Where to find external cookbooks:
default_source :supermarket, "https://supermarket.chef.io" do |s|
    s.preferred_for "chef-client","cron","logrotate", "chef_handler", "compat_resource", "ohai", "windows"
end
default_source :chef_repo, "../"

default_source :chef_server, "https://aut-chef-server/organizations/automate-org" do |t|
    t.preferred_for "audit-wrapper", "audit"
end

# run_list: chef-client will run these recipes in the order specified.
run_list 'chef-client::default','audit-wrapper::default'

# Specify a custom source for a single cookbook:
# cookbook 'example_cookbook', path: '../cookbooks/example_cookbook'
cookbook "chef-client", "= 11.0.4"
cookbook "cron", "= 6.2.2"
cookbook "logrotate", "= 2.2.2"
cookbook "audit-wrapper", "= 0.1.9"

# Set attributes
default['chef_client']['interval'] = '120'
default['chef_client']['splay'] ='30'

default['audit']['fetcher'] = 'chef-server'
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['inspec_version'] = '4.18.39'
