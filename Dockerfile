FROM debian:sid
RUN apt-get update && apt-get install -y curl xz-utils adduser
RUN adduser --disabled-password --gecos '' user
RUN mkdir -m 0755 /nix && chown user /nix
COPY entrypoint.sh /entrypoint.sh
USER user
ENV USER user
WORKDIR /home/user
RUN mkdir -p ~/.config/nix && echo "sandbox = false" > ~/.config/nix/nix.conf
RUN curl -L https://nixos.org/nix/install | sh
VOLUME /nix
ENTRYPOINT ["/entrypoint.sh"]
