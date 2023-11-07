set dotenv-load

# Display help information.
help:
  @ just --list

# Open project workspace in VS Code.
code:
  @ code .

# Install tooling for working with The Stack.
[linux]
install-tooling:
  bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
  @ just _install-tooling-all-platforms

# Install tooling for working with The Stack.
[macos]
install-tooling:
  brew install opam darcs hg
  @ just _install-tooling-all-platforms

_install-tooling-all-platforms:
  #!/usr/bin/env bash
  set -euxo pipefail
  # Initialize opam.
  opam init -y
  eval $(opam env)
  # Install platform tooling.
  opam install dune ocaml-lsp-server odoc ocamlformat utop

setup:
  @ just setup-graphql-server

setup-graphql-server:
  #!/usr/bin/env bash
  set -euxo pipefail
  cd graphql-server
  # Create a local switch.
  opam switch create .
  # Install dependencies.
  opam install dune graphql-lwt graphql-cohttp cohttp-lwt-unix
