{
  fetchzip,
  writeShellScriptBin,
  python3,
}:
let
  frontend = fetchzip {
    url = "https://github.com/yeicor-3d/yet-another-cad-viewer/releases/download/v0.9.4/frontend.zip";
    hash = "sha256-9x3XaPAmk+xitcXtVrkkiqTjWoSwp+zCN2einxeYZpM=";
  };
in
  writeShellScriptBin "yacv-frontend" "${python3}/bin/python -m http.server --directory ${frontend}"
