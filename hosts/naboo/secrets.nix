{...}: {
  age.secrets = {
    cabero-15582531.file = ../../secrets/cabero-15582531.age; # keychain
    cabero-15582547.file = ../../secrets/cabero-15582547.age; # loose
  };

  security.pam.yubico = {
    enable = true;
    debug = false;
    mode = "challenge-response";
    id = [
      "15582547"
      "15582531"
    ];
    challengeResponsePath = "/run/agenix";
  };
}
