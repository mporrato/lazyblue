ARG FEDORA_MAJOR_VERSION=42

FROM quay.io/fedora/fedora-silverblue:${FEDORA_MAJOR_VERSION}

COPY rootfs/ /
COPY cosign.pub /etc/pki/containers/cosign-mporrato.pub

RUN <<-'EOT' sh
    set -eu

    rpm-ostree install \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
    ostree remote add tailscale https://pkgs.tailscale.com/stable/fedora/tailscale.repo

	if [ "$(rpm -E %fedora)" -lt "40" ] ; then
        rpm-ostree override remove \
            gnome-classic-session \
            gnome-classic-session-xsession
    else
        rpm-ostree override remove \
            gnome-classic-session
	fi

    rpm-ostree override remove mesa-va-drivers fdk-aac-free libavcodec-free libavdevice-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free ffmpeg-free \
        --install mesa-va-drivers-freeworld --install ffmpeg

    rpm-ostree install gcc gnome-tweaks buildah skopeo podman-compose distrobox tmux vim ripgrep htop tailscale \
        stow screen micro intel-media-driver mesa-vdpau-drivers-freeworld gstreamer1-plugin-libav \
        gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly \
        gstreamer1-vaapi --allow-inactive

    rpm-ostree cleanup -m && ostree container commit

	systemctl enable dconf-update.service
	systemctl enable flatpak-add-flathub-repo.service
	systemctl enable flatpak-replace-fedora-apps.service
	systemctl enable flatpak-cleanup.timer
	systemctl enable rpm-ostreed-automatic.timer
	systemctl enable tailscaled.service
EOT
