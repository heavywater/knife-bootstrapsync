require 'chef/knife/bootstrap'

module Bootstrapsync
  def sync_bootstrap_run
    sync_directory
    non_sync_bootstrap_run
  end

  def sync_directory
    require 'net/sftp'
    host = name_args.first
    user = config[:ssh_user]
    args = {}
    args[:password] = config[:ssh_password] if config[:ssh_password]
    args[:keys] = [config[:identity_file]] if config[:identity_file]
    begin
      Net::SFTP.start(host, user, args) do |sftp|
        begin
          sftp.mkdir!(File.dirname(Chef::Config[:knife][:directory_sync][:remote]))
        rescue
          puts 'Cookbook dir already exists'
        end
        sftp.upload!(
          Chef::Config[:knife][:directory_sync][:local],
          Chef::Config[:knife][:directory_sync][:remote],
          :mkdir => true
        )
      end
    rescue
      puts 'Upload Failed'
    end
  end
  
  class << self
    def included(klass)
      klass.class_eval do
        alias_method :non_sync_bootstrap_run, :run
        alias_method :run, :sync_bootstrap_run

        option(:sync_directory,
          :long => '--sync-directory LOCAL_PATH:REMOTE_PATH',
          :description => 'Sync local directory to remote server',
          :proc => Proc.new{ |k|
            dirs = k.split(':')
            Chef::Config[:knife][:directory_sync] = {:local => dirs.first, :remote => dirs.last}
          }
        )
      end
    end
  end
end

Chef::Knife::Bootstrap.send(:include, Bootstrapsync)


begin
  require 'chef/knife/rackspace_server_create'

  class Chef
    class Knife
      class RackspaceServerCreate
        option(:sync_directory,
          :long => '--sync-directory LOCAL_PATH:REMOTE_PATH',
          :description => 'Sync local directory to remote server',
          :proc => Proc.new{ |k|
            dirs = k.split(':')
            Chef::Config[:knife][:directory_sync] = {:local => dirs.first, :remote => dirs.last}
          }
        )
      end
    end
  end
  
rescue
end
