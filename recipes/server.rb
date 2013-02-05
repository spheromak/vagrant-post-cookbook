knife_dir = node[:vagrant][:knife_dir] 

include_recipe "vagrant-post"

# detect chef-server 11
validator =  "/etc/chef/validation.pem" 
if File.exists? "/opt/chef-server" 
  validator =  "/etc/chef-server/chef-validator.pem"
end


execute "cp-validate" do 
  command "cp #{validator} #{knife_dir}"
  only_if "test -f #{validator}"
  not_if "test -f #{knife_dir}/validation.pem"
end

execute "create-knife" do
  command "knife configure --defaults -u vagrant -c #{knife_dir}/provisioned-knife.rb  -y -r #{knife_dir} -s http://localhost:4000 -i "
  not_if "test -f #{knife_dir}/vagrant.pem"
end
