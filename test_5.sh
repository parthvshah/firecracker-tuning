PIPE="/tmp/ipc_pipe"
rm -f "$PIPE"
mkfifo "$PIPE"

(
	read -r msg < "$PIPE"
	recv_time=$(date +%s%N)
	latency_ns=$((recv_time - msg))
	latency_us=$((latency_ns / 1000))
	echo "Received in: ${latency_us} us"
) &

sleep 0.05

send_time=$(date +%s%N)
echo "$send_time" > "$PIPE"

wait
rm -f "$PIPE"
