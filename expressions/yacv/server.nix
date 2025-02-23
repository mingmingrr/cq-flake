{
  buildPythonPackage,
  fetchFromGitHub,
  # Buildtime dependencies
  poetry-core,
  # Runtime dependencies
  build123d,
  pygltflib,
  pillow,
}: let
  pname = "yacv-server";
  version = "0.9.4";
  src = fetchFromGitHub {
    owner = "yeicor-3d";
    repo = "yet-another-cad-viewer";
    rev = "v${version}";
    hash = "sha256-85beVyVxsrLhLq1hNf//tkotau39VvBULEZk64/XXNI=";
  };
in
  buildPythonPackage {
    inherit src pname version;
    pyproject = true;

    SKIP_BUILD_FRONTEND = "1";

    build-system = [
      poetry-core
    ];

    dependencies = [
      build123d
      pygltflib
      pillow
    ];
  }
