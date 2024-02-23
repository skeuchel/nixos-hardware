{
  fetchFromGitHub,
  lib,
  opensbi,
  withPayload ? null,
  withFDT ? null,
}:
(opensbi.override {
  inherit withPayload withFDT;
})
.overrideAttrs (attrs: {
  version = "1.2-git-3745939";
  src = fetchFromGitHub {
    owner = "sophgo";
    repo = "opensbi";
    rev = "3745939ceb8ba71f45c4cfad205912cedbc76bd9";
    hash = "sha256-UXsAKXO0fBjHkkanZlB0led9CiVeqa01dTM4r7D9dzs=";
  };

  makeFlags =
    attrs.makeFlags
    ++ [
      "PLATFORM=generic"
      "FW_PIC=y"
      "BUILD_INFO=y"
      "DEBUG=1"
    ]
    ++ lib.optionals (withPayload != null) [
      "FW_PAYLOAD_PATH=${withPayload}"
    ]
    ++ lib.optionals (withFDT != null) [
      "FW_FDT_PATH=${withFDT}"
    ];
})
