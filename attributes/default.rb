default[:vagrant][:knife_dir] = "/vagrant/.chef"
default[:vagrant][:chef_server][:port] = 8000
default[:vagrant][:chef_server][:version] = 11

# chef 11 stuff
#default['chef-server'][:configuration][:nginx][:ssl_port] = 8443
#default['chef-server'][:configuration][:nginx][:non_ssl_port] = 8089
