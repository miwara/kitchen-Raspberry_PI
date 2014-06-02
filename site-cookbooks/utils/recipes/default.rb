#
# Cookbook Name:: utils
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{zsh emacs git tmux}.each do |pkg|
  package pkg do
    action :install
  end
end

#.zshrc
template '/home/pi/.zshrc' do
  source "zshrc.erb"
  owner "pi"
  group "pi"
  mode "0644"
end

# init.el
directory '/home/pi/.emacs.d' do
  owner "pi"
  group "pi"
  mode "0755"
  action :create
end

template '/home/pi/.emacs.d/init.el' do
  source "init.el.erb"
  owner "pi"
  group "pi"
  mode "0644"
end

directory '/home/pi/.emacs.d/elisp' do
  owner "pi"
  group "pi"
  mode "0755"
  action :create
end

directory '/home/pi/.emacs.d/snippet' do
  owner "pi"
  group "pi"
  mode "0755"
  action :create
end

directory '/home/pi/.emacs.d/elisp/yasnippet' do
  owner "pi"
  group "pi"
  mode "0755"
  action :create
end

# yasnippet setting
git "/home/pi/.emacs.d/elisp/yasnippet" do
  repository "https://github.com/capitaomorte/yasnippet.git"
  reference "master"
  action :checkout
  user "pi"
  group "pi"
end
