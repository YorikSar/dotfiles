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
  version = "2.32.0";

  src = fetchFromGitHub {
    owner = "cli";
    repo = "cli";
    rev = "v${version}";
    hash = "sha256-YnIwrx/NEOH3yXkkCq30i9Jt2IXKX5IX8BuM6+u9tvs=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/yoriksar/cli/commit/43dfa0fdd4f8ecd72d36eb755b05e9b416efaee5.patch";
      sha256 = "sha256-ozGP50Z/B6FcUYNYZV8/znRCmDElNOicB+WPPXFmmm4=";
    })
  ];

  vendorHash = "sha256-G6fdROuwpFncO5FL7DRwRQAiHRgtc3IFsvx0HfmWqxU=";

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
    maintainers = with maintainers; [zowoq];
  };
}
