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
    devShells.x86_64-linux = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          permittedInsecurePackages = [
            "segger-jlink-qt4-874"
          ];
          allowUnfree = true;
          segger-jlink.acceptLicense = true;
        };
      };
    in {
    default = pkgs.mkShell {
      buildInputs = with pkgs; [
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
          click
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
        SDL2
        pahole
        hidrd
        gitlint
        mcuboot-imgtool
        nrfutil
        nrf-command-line-tools
        rustc
        cargo
        protobuf
        
        gcc_multi

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
  };
}
