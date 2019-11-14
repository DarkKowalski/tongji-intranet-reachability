require 'json'
require_relative './simple_net_tool'

def run
  # Config
  config_file = File.read('./config.json')
  config_hash = JSON.parse(config_file)

  local_geo = config_hash['local_geo_address']
  remote_geo = config_hash['remote_geo_address']

  ip = config_hash['remote_ip']
  port = config_hash['remote_port']
  interface = config_hash['local_interface']

  count = config_hash['ping_count']
  timeout = config_hash['nmap_timeout']

  tool = SimpleNetTool.new(ip, port, interface, count, timeout)

  # Get info
  puts "[Start]:   From #{local_geo}(#{interface}) to #{remote_geo}(#{ip})"
  geo_info = "Geo: from #{local_geo}(#{interface}) to #{remote_geo}(#{ip})"
  interface_info = "Interface:\n#{tool.local_brief}"

  puts "[Testing]: Datalink Layer Reachability"
  dl_reachability_info = "Datalink Layer Reachable: #{tool.datalink_layer_reachable?}"
  puts dl_reachability_info

  puts "[Testing]: Network Layer Reachability"
  nl_reachability_info = "Network Layer Reachable : #{tool.network_layer_reachable?}"
  puts nl_reachability_info

  # Save result
  split_line = "=" * 140
  File.open('result.txt', 'a') do |f|
    f.puts split_line
    f.puts geo_info
    f.puts interface_info
    f.puts dl_reachability_info
    f.puts nl_reachability_info
  end

  puts "[Done]"
end

run