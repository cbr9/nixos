{ ... }:
{
  imports = [
    ./cabero
  ];
  users.mutableUsers = false;
  users.users.root.initialPassword = "1234";
}
