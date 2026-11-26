import os
import mmap
import time
import random

DEV = "/dev/vda"
BS = 4096
DURATION = 10

fd = os.open(DEV, os.O_RDONLY | os.O_DIRECT)
max_blocks = os.lseek(fd, 0, os.SEEK_END) // BS
buf = mmap.mmap(-1, BS)

ops = 0
end = time.perf_counter() + DURATION
while time.perf_counter() < end:
    os.preadv(fd, [buf], random.randrange(max_blocks) * BS)
    ops += 1

iops = ops / DURATION
print(f"{iops:,.0f} IOPS ({iops * BS / 1048576:.1f} MB/s)")
