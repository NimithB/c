BEGIN {
count = 0;
}
{
if($1 == "d"){
count++;
}
}
END {
printf("The no. of packets dropped is %d\n",count);
}
