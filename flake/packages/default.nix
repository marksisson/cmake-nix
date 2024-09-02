{
  imports = [
    ./cmake
  ];

  perSystem = { self', ... }: {
    packages.default = self'.packages.cmake;
  };
}
