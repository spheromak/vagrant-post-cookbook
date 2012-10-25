
include_recipe "vagrant-post"
execute "cp-validate" do 
  command "cp /etc/chef/validation.pem /vagrant/chef/"
  only_if "test -f /etc/chef/validation.pem"
  not_if "test -f /vagrant/chef/validation.pem"
end

execute "create-knife" do
  command "knife configure --defaults -u vagrant -c /vagrant/chef/provisioned-knife.rb  -y -r /vagrant/chef -s http://localhost:4000 -i "
  not_if "test -f /vagrant/chef/vagrant.pem"
end
