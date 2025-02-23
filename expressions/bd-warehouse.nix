{
  lib
  , python
  , buildPythonPackage
  , fetchFromGitHub
  , build123d
  , setuptools
  , setuptools-scm
}:
buildPythonPackage rec {
  pname = "bd-warehouse";
  rev = "b7e0dbe87e76244282651e903f6f55257a298219";
  version = "0.0+git-48c507b";
  src = fetchFromGitHub {
    owner = "gumyr";
    repo = "bd_warehouse";
    inherit rev;
    sha256 = "sha256-NidGRolMRsAVH397/KwP0E0NPpcxZVlb0jrO++Gi7e8=";
  };

  build-system = [ setuptools ];

  format = "pyproject";

  propagatedBuildInputs = [ build123d setuptools-scm ];

  checkPhase = ''
    ${python.interpreter} -m unittest tests
  '';
}
