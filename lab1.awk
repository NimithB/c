BEGIN{
c=0;

}
{
if($1==d){
c++;}
}
END{
printf("The no of packets dropped is %d\n",count);
}
