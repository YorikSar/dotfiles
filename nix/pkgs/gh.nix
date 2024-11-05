{
  lib,
  fetchFromGitHub,
  fetchpatch,
  buildGoModule,
  installShellFiles,
  stdenv,
  testers,
  gh,
}:
buildGoModule rec {
  pname = "gh";
  version = "2.60.0";

  src = fetchFromGitHub {
    owner = "cli";
    repo = "cli";
    rev = "refs/tags/v${version}";
    hash = "sha256-Tvyf58f/9bOUiUAG6R9nhOerZh5Yt3LyKx88oF3s0jI=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/yoriksar/cli/commit/bae5c444689f97c2c7f110b62ec5ef8b96885b87.patch";
      sha256 = "sha256-ryH+9jY4dmX+hsdcfqL6OT2jUno56rUDRlhVZQMy8bM=";
    })
  ];

  vendorHash = "sha256-/owHEvB+RHkfjNrAz6RrQgmIJpPcFrWmy+h0gOFT+Ws=";

  nativeBuildInputs = [installShellFiles];

  buildPhase = ''
    runHook preBuild
    make GO_LDFLAGS="-s -w" GH_VERSION=${version} bin/gh ${lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) "manpages"}
    runHook postBuild
  '';

  installPhase =
    ''
      runHook preInstall
      install -Dm755 bin/gh -t $out/bin
    ''
    + lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
      installManPage share/man/*/*.[1-9]

      installShellCompletion --cmd gh \
        --bash <($out/bin/gh completion -s bash) \
        --fish <($out/bin/gh completion -s fish) \
        --zsh <($out/bin/gh completion -s zsh)
    ''
    + ''
      runHook postInstall
    '';

  # most tests require network access
  doCheck = false;

  passthru.tests.version = testers.testVersion {
    package = gh;
  };

  meta = with lib; {
    description = "GitHub CLI tool";
    homepage = "https://cli.github.com/";
    changelog = "https://github.com/cli/cli/releases/tag/v${version}";
    license = licenses.mit;
    mainProgram = "gh";
    maintainers = with maintainers; [zowoq];
  };
}
