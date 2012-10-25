
include_recipe "vagrant-post"
template "/etc/chef/client.rb" do
  owner "root"
  group "root"
  mode 0640
  variables( :chef_server => node[:chef_server] )
end
