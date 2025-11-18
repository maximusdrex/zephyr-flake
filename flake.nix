{
  description = "Zephyr devenv for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zephyr.url = "github:zephyrproject-rtos/zephyr/v3.5.0";
    zephyr.flake = false;
    zephyr-nix.url = "github:nix-community/zephyr-nix";
    zephyr-nix.inputs.nixpkgs.follows = "nixpkgs";
    zephyr-nix.inputs.zephyr.follows = "zephyr";
  };

  outputs = { self, nixpkgs, zephyr, zephyr-nix }: {
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        (python3.withPackages (python-pkgs: with python-pkgs; [
          anytree
          canopen
          cbor
          colorama
          coverage
          gcovr
          graphviz
          grpcio-tools
          intelhex
          junit2html
          junitparser
          lpc-checksum
          lxml
          mock
          mypy
          natsort
          packaging
          pillow
          ply
          progress
          protobuf
          psutil
          pyelftools
          pygithub
          pykwalify
          pylink-square
          pylint
          pyocd
          pyserial
          pytest
          python-magic
          pyyaml
          requests
          tabulate
          west
          yamllint
          zcbor
          jsonschema
        ]))
        banner
        dpkg
        gperf
        ccache
        dfu-util
        dtc
        wget
        xz
        file
        pkg-config
        glib
        libpcap
        pahole
        hidrd
        gitlint
        mcuboot-imgtool

        (zephyr-nix.packages.x86_64-linux.sdk-0_17.override {
          targets = [
            "arm-zephyr-eabi"
          ];
        })
        # zephyr.hosttools
        
        # zephyr-sdk
      ];


      shellHook = ''
        banner "Zephyr SDK"
      '';
    };
  };
}
