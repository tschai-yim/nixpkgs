{ lib, stdenv, fetchFromGitHub, postgresql }:

stdenv.mkDerivation rec {
  pname = "pgvector";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "pgvector";
    repo = "pgvector";
    rev = "v${version}";
    hash = "sha256-NS9iNgrVnoqmAIXd4sJFnPISQvYYl8YQ84bnLjpChx4=";
  };

  buildInputs = [ postgresql ];

  installPhase = ''
    install -D -t $out/lib vector${postgresql.dlSuffix}
    install -D -t $out/share/postgresql/extension sql/vector-*.sql
    install -D -t $out/share/postgresql/extension vector.control
  '';

  meta = with lib; {
    description = "Open-source vector similarity search for PostgreSQL";
    homepage = "https://github.com/pgvector/pgvector";
    changelog = "https://github.com/pgvector/pgvector/raw/v${version}/CHANGELOG.md";
    license = licenses.postgresql;
    platforms = postgresql.meta.platforms;
    maintainers = [ maintainers.marsam ];
  };
}
