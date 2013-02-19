
include_recipe "vagrant-post"
# default chef10 values
# 
validator =  "/etc/chef/validation.pem" 
knife_args = "--defaults -s #{node[:vagrant][:chef_server][:url]}"

if 11 == node[:vagrant][:chef_server][:version] 
  validator =  "/etc/chef-server/chef-validator.pem"
  knife_args = " -s #{node[:vagrant][:chef_server][:url]} --admin-client-key /etc/chef-server/admin.pem --admin-client-name admin --validation-client-name chef-validator  --validation-key=/etc/chef-server/chef-validator.pem"
end


execute "cp-validate" do 
  command "cp #{validator} #{node[:vagrant][:knife_dir]}"
  only_if "test -f #{validator}"
  not_if "test -f #{node[:vagrant][:knife_dir]}/validation.pem"
end

create_cmd = "knife configure #{knife_args} -u vagrant -c #{node[:vagrant][:knife_dir]}/provisioned-knife.rb  -y -r #{node[:vagrant][:knife_dir]} -i"

if node[:chef_packages][:chef][:version].to_i >= 11
  # chef11 client wants you to set a user password
  create_cmd = "echo 'vagrant' | " <<  create_cmd
end

if node[:chef_packages][:chef][:version].to_i >= 11
  # chef11 client wants you to set a user password
  create_cmd = "echo 'vagrant' | #{create_cmd}" 
end

execute "create-knife" do
  command  create_cmd
  not_if "test -f #{node[:vagrant][:knife_dir]}/vagrant.pem"
end
