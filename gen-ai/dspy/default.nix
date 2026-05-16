{ lib, buildPythonPackage, fetchFromGitHub, pythonRelaxDepsHook, setuptools
, openai, regex, orjson, tqdm, requests, pydantic, litellm, diskcache
, json-repair, tenacity, anyio, asyncer, cachetools, cloudpickle, numpy
, xxhash, gepa, typeguard }:

buildPythonPackage rec {
  pname = "dspy";
  version = "3.2.1";

  src = fetchFromGitHub {
    owner = "stanfordnlp";
    repo = pname;
    rev = version;
    hash = "sha256-xquV+FyDfejm1SCWYfuiezIkyutmm/1zOvd5X+oElrM=";
  };

  pyproject = true;
  nativeBuildInputs = [ pythonRelaxDepsHook ];
  build-system = [ setuptools ];

  dependencies = [
    openai
    regex
    orjson
    tqdm
    requests
    pydantic
    litellm
    diskcache
    json-repair
    tenacity
    anyio
    asyncer
    cachetools
    cloudpickle
    numpy
    xxhash
    gepa
    typeguard
  ];

  pythonRelaxDeps = [ "asyncer" "typeguard" ];

  # Work around checks that try to write into HOME.
  preHook = ''
    export HOME=$(mktemp -d)
  '';

  pythonImportsCheck = [ "dspy" ];

  meta = with lib; {
    homepage = "https://github.com/stanfordnlp/dspy";
    description = "DSPy: The framework for programming with foundation models";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
