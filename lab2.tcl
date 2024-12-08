set ns [new Simulator]
set nf [open lab2.nam w]
$ns namtrace-all $nf
set tf [open lab2.tr w]
$ns trace-all $tf
proc finish {} {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam lab2.nam &
exit 0
}


Agent/Ping instproc recv {from rtt} {
$self instvar node_
puts "node [$node_ id] received ping from $from with round trip time :
$rtt ms"
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$ns duplex-link $n0 $n1 10mb 300ms DropTail
$ns duplex-link $n0 $n2 1kb 300ms DropTail
$ns duplex-link $n0 $n3 10mb 300ms DropTail
$ns duplex-link $n0 $n4 1kb 300ms DropTail
$ns duplex-link $n0 $n5 10mb 300ms DropTail
$ns duplex-link $n0 $n6 1kb 300ms DropTail

$ns queue-limit $n0 $n2 2
$ns queue-limit $n0 $n4 2
$ns queue-limit $n0 $n6 2
# Create 6 ping agents
set ping1 [new Agent/Ping]
set ping2 [new Agent/Ping]
set ping3 [new Agent/Ping]
set ping4 [new Agent/Ping]
set ping5 [new Agent/Ping]
set ping6 [new Agent/Ping]
# Set each node except router (n0) as ping agent to send pings
$ns attach-agent $n1 $ping1
$ns attach-agent $n2 $ping2
$ns attach-agent $n3 $ping3
$ns attach-agent $n4 $ping4
$ns attach-agent $n5 $ping5
$ns attach-agent $n6 $ping6
# Since, n1 <--> n2, n3 <--> n4, n5 <--> n6, therefore
$ns connect $ping1 $ping2
$ns connect $ping3 $ping4
$ns connect $ping5 $ping6
# Since n1, n3, n5 sends ping, ie, ping1, ping2, ping3 agents
$ns at 0.1 "$ping1 send"
$ns at 0.2 "$ping1 send"
$ns at 0.3 "$ping1 send"
$ns at 0.4 "$ping1 send"
$ns at 0.5 "$ping1 send"
$ns at 0.1 "$ping3 send"
$ns at 0.2 "$ping3 send"
$ns at 0.3 "$ping3 send"
$ns at 0.4 "$ping3 send"
$ns at 0.5 "$ping3 send"
$ns at 0.1 "$ping5 send"
$ns at 0.2 "$ping5 send"
$ns at 0.3 "$ping5 send"
$ns at 0.4 "$ping5 send"
$ns at 0.5 "$ping5 send"
$ns at 5 "finish"
$ns run
