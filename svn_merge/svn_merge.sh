#!/bin/bash


. $variable_file

merge () {
    paketnamn=$1
    svn up /home/masv3971/repon/svn/$paketnamn
    svn merge svn+ssh://svn.it.su.se/svn/$paketnamn/branches/sua/stable svn+ssh://svn.it.su.se/svn/$paketnamn/trunk $paketnamn/branches/sua/stable
}

set_paket_name () {
    echo "Set paket name plase."
    read variable_input
    echo "enheter package name, "
    echo "pk_name="${variable_input}"" > $variable_file
    merge $variable_input
}

if [[ $pk_name ]]; then
    echo "Are you sure you want to merge $pk_name to stable? (yes|no)"
    read response
    if [[ $response == "yes" ]]; then
        merge $pk_name
    else
        response=""
        echo "Would you like to change package name?"
        read response
        if [[ $response == "yes" ]]; then
            set_paket_name
        else
            echo "Exiting.."
            exit 0
        fi
    fi
else
    set_paket_name
fi
