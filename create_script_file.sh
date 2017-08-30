#!/bin/bash


script_name=$1

if [[ ! $script_name ]]; then
    echo "You need do state a new. I can't guess, sadly..."
    exit 0
fi

if [[ -f $script_name ]]; then
    echo "The name already exists, exiting..."
    exit 0
fi

script_ending=$(echo $script_name | awk -F'.' '{print $2}')


touch $script_name

chmod +x $script_name

if [[ $script_ending == "py" ]]; then
    echo "#!/usr/bin/env python" > $script_name

elif  [[ $script_ending == "pl" ]]; then
    echo "#!/usr/bin/env perl" > $script_name

elif  [[ $script_ending == "sh" ]]; then
    echo "#!/bin/bash" > $script_name
fi

echo -e "#\n# \$Id\$\n# \$HeadURL\$\n#" >> $script_name

vim $script_name
