class SimpleNetTool
  def initialize(ip, port, interface, count, timeout)
    @ip = ip
    @port = port
    @interface = interface
    @count = count
    @timeout = timeout
  end

  def local_brief
    local_brief = `ip address show dev #{@interface}`
  end

  def datalink_layer_reachable?
    # Output sample:
    # 2 packets transmitted, 0 received, +2 errors, 100% packet loss, time 14ms
    ping_raw = `ping -I #{@interface} -n #{@ip} -c #{@count} -t 1 -q |tail -n2 |head -n1`
    ping_errors = ping_raw.scan(/\d+/).map(&:to_i)[2]
    return false if ping_errors == @count
    true
  end

  def network_layer_reachable?
    ping_raw = `ping -I #{@interface} -n #{@ip} -c #{@count} -t 64 -q |tail -n2 |head -n1`
    ping_errors = ping_raw.scan(/\d+/).map(&:to_i)[2]
    return true if ping_errors < @count
    
    puts "ICMP failed, try TCP"
    tcp_raw = `nmap #{@ip} -p #{@port} -e #{@interface} --host-timeout #{@timeout} -Pn`
    return true if tcp_raw.include?("open") # Need a confirmed open port

    false
  end

end