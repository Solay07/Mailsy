#! /bin/bash

Name=$(basename "$0")
Version="1.0"

OPTS=$(getopt -o bs: --long version,help,sql,build,start: -n 'prosody' -- "$@")

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

eval set -- "$OPTS"

_usage() {
    cat <<- EOF
Usage:   $Name [options]

Options:
         --help        Display this message
         --version     Display script version
     -b, --build       build container
     -s, --start       start container

EOF
}

prosody_build() {
  docker build \
          --tag prosody:alpine \
          --build-arg PREFIX=/opt/prosody-0.11.1 \
          .
}

prosody() {
  docker run -it --rm \
          --name test \
          --link db_prosody:postgres \
          -v "$PWD/certs:/opt/prosody-0.11.1/etc/prosody/certificados" \
          -p 5000:5000 \
          -p 5222:5222 \
          -p 5223:5223 \
          -p 5269:5269 \
          -p 5280:5280 \
          -p 5281:5281 \
          prosody:alpine \
          /bin/sh
}

postgres() {
  docker run \
          --name db_prosody \
          -e POSTGRES_PASSWORD=prosody \
          -v "$PWD/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d" \
          -p 5432:5432 \
          postgres:11.1-alpine
}

postgres_sql() {
  docker run -it --rm \
          --link db_prosody:postgres \
          postgres:11.1-alpine \
          psql -h postgres -U prosody -d prosody
}

#  Handle command line arguments
while true; do
    case $1 in
        --help )
            _usage
            exit 0
            ;;
        --version )
            echo -e "$Name -- Version $Version"
            exit 0
            ;;
        -b | --build )
            prosody_build
            shift 1
            ;;
          -s | --start )
            case "$2" in
                "")
                    echo -e "you must specify the container to start"
                    shift 2
                    exit 1
                ;;
                prosody )
                    prosody ; shift 2
                    ;;
                postgres )
                    postgres ; shift 2
                    ;;
            esac
            ;;
          --sql )
            postgres_sql
            shift 1
            ;;
        -- ) shift; break
            ;;
        * )
            echo -e "Option does not exist"
            _usage
            exit 1
            ;;
    esac
done