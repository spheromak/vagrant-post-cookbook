knife_dir = node[:vagrant][:knife_dir] 

include_recipe "vagrant-post"
execute "cp-validate" do 
  command "cp /etc/chef/validation.pem #{knife_dir}"
  only_if "test -f /etc/chef/validation.pem"
  not_if "test -f #{knife_dir}/validation.pem"
end

execute "create-knife" do
  command "knife configure --defaults -u vagrant -c #{knife_dir}/provisioned-knife.rb  -y -r #{knife_dir} -s http://localhost:4000 -i "
  not_if "test -f #{knife_dir}/vagrant.pem"
end
