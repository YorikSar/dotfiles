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
  version = "2.49.2";

  src = fetchFromGitHub {
    owner = "cli";
    repo = "cli";
    rev = "v${version}";
    hash = "sha256-RevdHBF/7etEstUhsTO9KVK45KTiJnhAhAZAamuEUwk=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/yoriksar/cli/commit/7a55107ac23bb9e8a980f1a8724375f4c4ab032d.patch";
      sha256 = "sha256-CSTxxDN8ngEQIxwcbO3MfgKnYwGGGYwpz9UhPEn5yXI=";
    })
  ];

  vendorHash = "sha256-Hrp+thG+o/unwh5eEVQwc31/JoMYeu7UAhTbGY1BWYI=";

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
