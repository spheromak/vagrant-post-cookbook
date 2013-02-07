knife_dir = node[:vagrant][:knife_dir] 

include_recipe "vagrant-post"

# default chef10 values
# 
validator =  "/etc/chef/validation.pem" 
knife_args = "--defaults -s http://localhost:#{node[:vagrant][:chef_server][:port]}"

if 11 == node[:vagrant][:chef_server][:version] 
  validator =  "/etc/chef-server/chef-validator.pem"
  knife_args = " -s https://localhost:#{node[:vagrant][:chef_server][:port]} --admin-client-key /etc/chef-server/admin.pem --admin-client-name admin --validation-client-name chef-validator  --validation-key=/etc/chef-server/chef-validator.pem"
end


execute "cp-validate" do 
  command "cp #{validator} #{knife_dir}"
  only_if "test -f #{validator}"
  not_if "test -f #{knife_dir}/validation.pem"
end

execute "create-knife" do
  command "knife configure #{knife_args} -u vagrant -c #{knife_dir}/provisioned-knife.rb  -y -r #{knife_dir}  -i "
  not_if "test -f #{knife_dir}/vagrant.pem"
end
