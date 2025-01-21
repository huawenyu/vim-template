#! /bin/bash
# vim: setlocal autoindent cindent et ts=4 sw=4 sts=4:
#
_Usage=$(cat <<-END
    Usage: handle a files
      script [options] [file ...]

    Options:
      -v, -vvv, --verbose   Print all cmds if v<count> >= 3,
      -n, --dryrun          Dump variables if prefix-as 'var_'
      -d, --debug
      -h, --help            Usage
      --version             Version

    Sample:
      bash -x script        ### Run the script with debug mode enabled.
      bash -n script        ### Check for syntax errors without execution.

      script afile

END
)

type getoptions 2>&1 > /dev/null || \
    (echo "Require 'getoptions': <===???"; \
    echo "Install getoptions (https://github.com/ko1nksm/getoptions)"; \
    echo "wget https://github.com/ko1nksm/getoptions/releases/latest/download/getoptions -O $HOME/bin/getoptions"; \
    echo ""; echo "$_Usage"; \
    exit 2;)

# Handle option {{{1}}}
function parser_definition() {
  setup   REST help:usage -- "Usage: git worktree2 [options] [branch-name] [dest-work-dir] ..." ''

  msg -- 'Options:'
  flag  var_VERBOSE    -v --verbose  counter:true init:=0    -- "e.g. -vvv is verbose level 3"
  flag  var_DRYRUN     -n --dryrun                           -- "Dryrun mode"
  flag  var_DEBUG      -d --debug                            -- "Debug mode and list all local variable"
  param var_ACTION     -a --action   init:="switch"  pattern:"switch | new | pull | push | delete"     -- "Action: *switch|new|pull|push|delete"

  disp  VERSION        --version
  disp  :usage         -h --help   -- "$_Usage"
}

eval "$(getoptions parser_definition) exit 1"
var_RestArg="$@" # rest arguments


DoIt () {
    >&2 echo "    DO: $*"
    eval "$@"
}

main () {
    case "$#" in
        2)
            ;;
        1)
            if [ -z "$var_branchName" ]; then
                var_branchName="$1"
            fi
            ;;
        0)
            if [ -n "$GIT_DIR" ]; then
                set -- "$GIT_DIR"
            else
                set -- .
            fi
            ;;
        *)
            if [[ -z "$var_DEBUG" ]]; then
                die "Too many arguments"
            fi
            ;;
    esac


    if [[ -n "$var_DRYRUN" ]]; then
        ( set -o posix ; set ) | grep -e '^var_'
        exit 1
    fi

    if [[ "$var_VERBOSE" >= 3 ]]; then
        set -x                              ### Print each command before eval
    fi

    if [[ "$var_VERBOSE" >= 4 ]]; then
        set -v                              ### Print each line of the script before eval
    fi

    ### Normalize the args
    # set --                                ### Clears positional parameters
    # input="arg1 arg2 'arg with spaces'"   ### If arg have space
    # eval set -- $input
    set -- $(ls *.txt)                      ### Assigns all .txt filename to $1, $2, etc.
    do_task "$@"
}


do_task () {
    echo "First file: $1"
    echo "Second file: $2"

    maketemp

    # Dummy-Loop-once
    for i in $(seq 1); do
        if [[ ! -z "$var_file" ]]; then
            # Done and exit-loop
            break
        fi

        # Sanity loop once
        break
    done
}

die () {
    [ "$#" -gt 0 ] && echo "$0: $@" >&2
    cleanup
    exit 1
}

TEMPFILE=

maketemp () {
    if [ -z "$TEMPFILE" ]; then
        TEMPFILE="$(mktemp /tmp/git-info.XXXXXX)" || die
        trap "cleanup; exit 130" 1 2 3 15
    fi

    if [ -z "$TEMPFILE2" ]; then
        TEMPFILE2="$(mktemp /tmp/git-info.XXXXXX)" || die
        trap "cleanup; exit 130" 1 2 3 15
    fi
}

trap cleanup EXIT INT TERM
function cleanup() {
    trap - EXIT

    duration=$SECONDS
    echo "trap-cleanup(action=$action time=$(($duration / 60))m:$(($duration % 60))s)"

    if [ -n "$TEMPFILE" ]; then
        rm -f "$TEMPFILE" 2> /dev/null
    fi

    if [ -n "$TEMPFILE2" ]; then
        rm -f "$TEMPFILE2" 2> /dev/null
    fi

    # Backto the original current dir
    cd "$currDir"
}

main "$@"

