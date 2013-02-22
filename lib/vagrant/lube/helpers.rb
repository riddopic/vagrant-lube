
require 'timeout'
require 'socket'

module Vagrant
  module Lube
    module Helpers  
      def local_ip
        @local_ip ||= begin
          # turn off reverse DNS resolution temporarily
          orig, Socket.do_not_reverse_lookup =
            Socket.do_not_reverse_lookup, true

          UDPSocket.open do |s|
            s.connect '64.233.187.99', 1
            s.addr.last
          end
        ensure
          Socket.do_not_reverse_lookup = orig
        end
      end
  
      def port_open? host, port
        Timeout.timeout(0.25) do
          s = TCPSocket.new(host, port)
          s.close rescue nil
          return true
        end
      rescue Timeout::Error, Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        return false
      end

      def next_free_ip start
        all, network, start_ip = /(.*\.)([0-9]+)/.match(start).to_a
        (start_ip.to_i..255).each do |ip|
          host = "#{network}#{ip}"
          if port_open?(host, 22)
            next
          else
            return host
          end
        end
      end

      def next_random_free_ip start
        all, network, start_ip = /(.*\.)([0-9]+)/.match(start).to_a
        ((rand(start_ip.to_i..255))..255).each do |ip|
          host = "#{network}#{ip}"
          if port_open?(host, 22)
            next
          else
            return host
          end
        end
      end

      def next_free_chef_ip start
        all, network, start_net = /(.*\.)([0-9]+)/.match(start).to_a
        (start_net.to_i..255).each do |subnet|
          host = "#{network}#{subnet}.2"
          if port_open?(host, 22)
            next
          else
            return host
          end
        end
      end
    end # module Helpers
  end # module Lube
end # module Vagrant
