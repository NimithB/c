set ns [new Simulator]
set nf [open lab3.nam w]
$ns namtrace-all $nf
set tf [open lab3.tr w]
$ns trace-all $tf

proc finish { } {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam lab3.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
$ns make-lan "$n0 $n1 $n2 $n3" 100mb 100ms LL Queue/DropTail Mac/802_3
# Source <--> Destination: n0 <--> n2, n1 <--> n3
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns connect $tcp0 $sink2
$ns connect $tcp1 $sink3
set file1 [open file1.tr w]
set file2 [open file2.tr w]
$tcp0 attach $file1
$tcp1 attach $file2
$tcp0 trace cwnd_
$tcp1 trace cwnd_
$ns at 0.1 "$ftp0 start"
$ns at 5.0 "$ftp0 stop"
$ns at 6.0 "$ftp0 start"
$ns at 11.0 "$ftp0 stop"
$ns at 1.0 "$ftp1 start"
$ns at 6.0 "$ftp1 stop"
$ns at 7.0 "$ftp1 start"
$ns at 12.0 "$ftp1 stop"
$ns at 13.0 "finish"
$ns run

