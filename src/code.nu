#!/usr/bin/env nu

def main [file?: string] {
  (codium 
    --password-store=gnome-libsecret $"($file)"
    --enable-features=UseOzonePlatform --ozone-platform=wayland)
}

