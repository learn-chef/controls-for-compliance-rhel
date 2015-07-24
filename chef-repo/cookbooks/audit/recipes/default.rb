#
# Cookbook Name:: audit
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
control_group 'Validate web services' do
  control 'Ensure no web files are owned by the root user' do
    Dir.glob('/var/www/html/**/*') {|web_file|
      it 'is not owned by the root user' do
        expect(file(web_file)).to_not be_owned_by('root')
      end
    }
  end
end