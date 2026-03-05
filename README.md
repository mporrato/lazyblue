# LazyBlue

Vanilla [Fedora Silverblue](https://fedoraproject.org/silverblue/) with quality-of-life improvements, built with [BlueBuild](https://blue-build.org/).

## What's included

- **Multimedia**: RPMFusion nonfree codecs, FFmpeg, VA-API/VAAPI drivers, PipeWire aptX codec
- **Virtualization**: QEMU/KVM, libvirt, virt-manager
- **Containers**: Podman, podman-compose, podman-docker, buildah, skopeo
- **VPN**: Tailscale + GNOME status extension
- **CLI tools**: git, vim, tmux, ripgrep, jq, yq, htop, distrobox, syncthing, and more
- **Fonts**: Cascadia, Fira Code, Hack, IBM Plex, Inconsolata, Source Code Pro, and more
- **Flatpaks**: Firefox, GNOME Boxes, Loupe, Flatseal, Foliate, Bazaar
- **GNOME extensions**: AppIndicator, Dash to Dock, PaperWM, Syncthing Indicator
- **GNOME defaults**: dark theme, tap-to-click, automount disabled

## Rebase

```
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/mporrato/lazyblue:stable
```

Then reboot. On subsequent updates, the image is rebuilt daily and delivered via `rpm-ostree upgrade`.

## Customize

Tweaks are organized as individual modules under `recipes/tweaks/`. To add or remove packages, extensions, or flatpaks, edit the relevant file and push — GitHub Actions will build and publish a new image automatically.

## Build locally

```
bluebuild build recipes/recipe.yml
```

Requires [BlueBuild CLI](https://blue-build.org/learn/getting-started/).
