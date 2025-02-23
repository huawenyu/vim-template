#!/usr/bin/env bash
# vim: setlocal autoindent cindent et ts=4 sw=4 sts=4:
#
# Get the script's directory, resolving symlinks
var_ScriptDir="$( cd "$( dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" &> /dev/null && pwd )"
var_ScriptName=$(basename "$0")
var_ScriptName="${var_ScriptName%.*}"
var_WorkDir=$(pwd)
SECONDS=0

# echo -e "${colorRed}This is red${colorReset}"
colorRed='\e[31m'
colorGreen='\e[32m'
colorYellow='\e[33m'
colorReset='\e[0m'


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
      bash -x script        # Run the script with debug mode enabled.
      bash -n script        # Check for syntax errors without execution.

      script afile

END
)

parse_define() {
  setup   REST help:usage -- "Usage: $var_ScriptName [options] ..." ''

  msg -- 'Options:'
  flag  var_VERBOSE    -v --verbose  counter:true init:=0    -- "e.g. -vvv is verbose level 3"
  flag  var_DRYRUN     -n --dryrun                           -- "Dryrun mode"
  flag  var_DEBUG      -d --debug                            -- "Debug mode and list all local variable"
  param var_Action     -a --action   init:="switch"  pattern:"switch | new | pull | push | delete"     -- "Action: *switch|new|pull|push|delete"

  disp  VERSION        --version
  disp  :usage         -h --help   -- "$_Usage"
}


# Option 2: Parse manually if no getoptions
# Define options
    OPTIONS="hf:o:"
    LONGOPTIONS="help,file:,output:"

    # Parse options
    PARSED=$(getopt -o "$OPTIONS" --long "$LONGOPTIONS" -- "$@")
    if [[ $? -ne 0 ]]; then
        die "Invalid option"
    fi

    # Evaluate parsed options
    eval set -- "$PARSED"

    # Default values
    file=""
    output=""

# Process options
parse_args () {
    case "$#" in
        2)
            var_Action="$1"
            var_SubAct="$2"
            ;;
        1)
            var_Action="$1"
            ;;
        0)
            ;;
        *)
            echo "$_Usage"
            die "Incorrect arguments"
            ;;
    esac

    while true; do
        case "$1" in
            -h|--help)
                echo "$_Usage"
                exit 0
                ;;
            -f|--file)
                file="$2"
                shift 2
                ;;
            -o|--output)
                output="$2"
                shift 2
                ;;
            --)
                shift
                break
                ;;
            *)
                die "Invalid option"
                exit 1
                ;;
        esac
    done
}


# Usage: varNum1=$( int var1 )
int ()
{
    printf '%d' $(expr ${1:-} : '[^0-9]*\([0-9]*\)' 2>/dev/null) || :
}


do_args () {
    if [[ -n "$var_DRYRUN" ]]; then
        ( set -o posix ; set ) | grep -e '^var_'
        exit 1
    fi

    if [[ "$var_VERBOSE" -ge 3 ]]; then
        set -x                              ### Print each command before eval
    fi

    if [[ "$var_VERBOSE" -ge 4 ]]; then
        set -v                              ### Print each line of the script before eval
    fi
}


main () {
    do_args

    ### Normalize the args
    # set --                                ### Clears positional parameters
    # input="arg1 arg2 'arg with spaces'"   ### If arg have space
    # eval set -- $input

    #set -- $(ls *.txt)                      ### Assigns all .txt filename to $1, $2, etc.
    do_task "$@"

    cleanup
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
    [ "$#" -gt 0 ] && echo -e "${colorRed}  $0: $@  ${colorReset}" >&2
    cleanup
    exit 1
}


maketemp () {
    TEMPFILE=
    if [ -z "$TEMPFILE" ]; then
        TEMPFILE="$(mktemp /tmp/git-info.XXXXXX)" || die
    fi

    if [ -z "$TEMPFILE2" ]; then
        TEMPFILE2="$(mktemp /tmp/git-info.XXXXXX)" || die
    fi
}


cleanup() {
    trap - EXIT

    duration=$SECONDS
    echo "trap-cleanup(action=$var_Action time=$(($duration / 60))m:$(($duration % 60))s)"

    if [ -n "$TEMPFILE" ]; then
        rm -f "$TEMPFILE" 2> /dev/null
    fi

    if [ -n "$TEMPFILE2" ]; then
        rm -f "$TEMPFILE2" 2> /dev/null
    fi

    # Backto the original current dir
    cd "$var_WorkDir"
}


# wget -O $HOME/bin/getoptions https://github.com/ko1nksm/getoptions/releases/latest/download/getoptions
trap "cleanup; exit 130" 1 2 3 15
if command -v getoptions &>/dev/null; then
    eval "$(getoptions parse_define) exit 1"
else
    parse_args "$@"
fi

main "$@"

