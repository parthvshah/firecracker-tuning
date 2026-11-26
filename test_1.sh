mkdir -p /links_dir
time {
  seq 1 20000 | xargs -I {} -P 4 ln -s /usr/lib/os-release /links_dir/link_{}
  sync
}
rm -rf /links_dir
