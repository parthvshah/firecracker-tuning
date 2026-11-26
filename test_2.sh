MOUNT_DIR="/tmp/mem_test"
mkdir -p "$MOUNT_DIR"
mount -t tmpfs -o size=1200M tmpfs "$MOUNT_DIR"

time {
  dd if=/dev/zero of="$MOUNT_DIR/blob" bs=4M count=256 conv=fsync 2>/dev/null
}

umount "$MOUNT_DIR"
rmdir "$MOUNT_DIR"
