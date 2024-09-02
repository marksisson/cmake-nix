{
  perSystem = { inputs', pkgs, ... }:
    let
      inherit (inputs'.xcode-nix.packages) stdenv;
    in
    {
      packages.cmake =
        let
          version = "3.30.3";
        in
        stdenv.mkDerivation {
          pname = "cmake";
          inherit version;
          src = pkgs.fetchFromGitHub {
            owner = "Kitware";
            repo = "CMake";
            rev = "v${version}";
            hash = "sha256-H6s+gJbPhOsCEJJs170RXETwt3fGTi/zp3TAhsvEVIU=";
          };
          phases = [ "unpackPhase" "configurePhase" "buildPhase" "installPhase" ];
          configurePhase = ''
            echo "bootstrapping cmake version: $version"
            ./bootstrap --prefix=$out --parallel=$NIX_BUILD_CORES
          '';
          buildPhase = ''
            make -j$NIX_BUILD_CORES
          '';
          installPhase = ''
            make install
          '';
        };
    };
}
