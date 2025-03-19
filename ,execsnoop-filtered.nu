#!/usr/bin/env nu

let swaybar_pid = ps | where name == swaybar | get 0 | get pid
let sh_pid = ps | where name == sh and ppid == $swaybar_pid | get 0 | get pid

doas bpftrace $"($env.FILE_PWD)/execsnoop-filtered.bt" $sh_pid
