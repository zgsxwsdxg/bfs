#! /bin/sh

ns_num=1
if [ "$1x" == "raftx" ]; then
    ns_num=3;
fi

for((i=0;i<$ns_num;i++))
do
    cd nameserver$i;
    port=$((i+8827))
    ./bin/nameserver --raft_node_index=$i --nameserver_port=$port 1>nlog 2>&1 &
    echo $! > pid
    cd -
done;

for i in `seq 0 3`;
do
    cd chunkserver$i;
    ./bin/chunkserver --chunkserver_port=802$i 1>clog1 2>&1 &
    echo $! > pid
    cd -
done
