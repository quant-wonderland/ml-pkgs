{ lib, buildPythonPackage, fetchFromGitHub, setuptools }:

buildPythonPackage rec {
  pname = "gepa";
  version = "0.0.27";

  src = fetchFromGitHub {
    owner = "gepa-ai";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-5IXXE76Nb2Lc+6wQmLIw4zmsWMhVOCvRLXLXZjMFhec=";
  };

  pyproject = true;
  build-system = [ setuptools ];

  postPatch = ''
    substituteInPlace pyproject.toml --replace-fail 'version="0.0.26"' 'version="${version}"'
  '';

  pythonImportsCheck = [ "gepa" ];

  meta = with lib; {
    homepage = "https://github.com/gepa-ai/gepa";
    description = "Framework for optimizing textual system components with LLM-based reflection and evolutionary search";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
