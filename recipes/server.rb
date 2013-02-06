knife_dir = node[:vagrant][:knife_dir] 

include_recipe "vagrant-post"

# detect chef-server 11
validator =  "/etc/chef/validation.pem" 
knife_args = "--defaults  -s http://localhost:4000"
if File.exists? "/opt/chef-server" 
  validator =  "/etc/chef-server/chef-validator.pem"
  knife_args = " -s https://localhost:#{node[:vagrant][:chef_server][:port]} --admin-client-key /etc/chef-server/chef-webui.pem --admin-client-name webui --validation-client-name chef-validator  --validation-key=/etc/chef-server/chef-validator.pem"
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
