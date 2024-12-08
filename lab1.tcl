set ns [new Simulator]
set nf [open lab1.nam w]
$ns namtrace-all $nf
set tf [open lab1.tr w]
$ns trace-all $tf
proc finish {} {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam lab1.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
$ns duplex-link $n0 $n1 10mb 300ms DropTail
$ns duplex-link $n1 $n2 1mb 300ms DropTail
$ns queue-limit $n0 $n1 10
$ns queue-limit $n1 $n2 5
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set null2 [new Agent/Null]
$ns attach-agent $n2 $null2
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.0005$ns connect $udp0 $null2
$ns at 0.1 "$cbr0 start"
$ns at 4.9 "$cbr0 stop"
$ns at 5.0 "finish"
$ns run

