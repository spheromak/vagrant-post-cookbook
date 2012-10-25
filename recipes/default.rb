#
# Cookbook Name:: vagrant-post
# Recipe:: default
#
# Copyright (C) 2012 Jesse Nelson
# 
#


# remove vagrant and roots ubuntu scripts
#
#
%w{ 
  /home/vagrant/.bashrc 
  /home/vagrant/.profile
  /root/.profile
  /root/.bashrc
}.each do |rc|
  file rc do 
    action :delete
  end
end
