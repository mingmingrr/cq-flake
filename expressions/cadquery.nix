{ lib
  , buildPythonPackage
  , setuptools_scm
  , isPy3k
  , pythonOlder
  , fetchFromGitHub
  , makeFontsConf
  , freefont_ttf
  , pytestCheckHook
  , pytest-xdist
  , ocp
  , casadi
  , ezdxf
  , ipython
  , src
  , nptyping
  , typish
  , vtk
  , nlopt
  , multimethod
  , docutils
  , path
  , fetchpatch
}:

buildPythonPackage rec {
  pname = "cadquery";
  version = if (builtins.hasAttr "rev" src) then (builtins.substring 0 7 src.rev) else "local-dev";
  inherit src;

  SETUPTOOLS_SCM_PRETEND_VERSION = "${version}";

  nativeBuildInputs = [ setuptools_scm ];

  patches = [
    # compatibility with occt 7.8.1
    (fetchpatch {
      url = "https://github.com/CadQuery/cadquery/commit/b8370dd17ca003ffa766fb1d78c4bf96a272d522.patch";
      sha256 = "sha256-t+7e8MDd6c7YARGMKNa0mdVFB3BG6V8XXm4nnk0VitA=";
    })
    (fetchpatch {
      url = "https://github.com/CadQuery/cadquery/commit/d1e4cb660d8d1012f41f2f8ec9ea2fd09c2b8533.patch";
      sha256 = "sha256-KL+ESx8USTYfCDtKrAwtq/J1mSzHaLw4PPfNMYwK5F4=";
    })
    (fetchpatch {
      url = "https://github.com/CadQuery/cadquery/commit/cafbf7c3af3d0b0c74ae029bb202fe03c25123b6.patch";
      sha256 = "sha256-NrNnck3rkqKMP3tjFn5CyZQzUvaqva+DF7powvEJrQ0=";
    })
  ];

  propagatedBuildInputs = [
    ocp
    ezdxf
    casadi
    ipython
    nptyping
    typish
    vtk
    nlopt
    multimethod
  ];

  # If the user wants extra fonts, probably have to add them here
  FONTCONFIG_FILE = makeFontsConf {
    fontDirectories = [ freefont_ttf ];
  };

  disabled = !isPy3k;

  checkInputs = [
    pytestCheckHook
    pytest-xdist
    docutils
    path
  ];

  pytestFlagsArray = [
    "-W ignore::FutureWarning"
    "-n $NIX_BUILD_CORES"
    "-k 'not example'"
    "-k 'not testTextAlignment'"
  ];

  meta = with lib; {
    description = "Parametric scripting language for creating and traversing CAD models";
    homepage = "https://github.com/CadQuery/cadquery";
    license = licenses.asl20;
    maintainers = with maintainers; [ costrouc marcus7070 ];
  };
}
