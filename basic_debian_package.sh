#!/bin/bash

# create dir structure for debian packages.

package_name=$(pwd | awk -F'/' '{print $NF}'|sed -e s/sua-//)

debian_path=trunk/debian
file_path=trunk/files/local/${package_name}

svn mkdir --parents ${debian_path}
svn mkdir --parents ${file_path}
svn mkdir --parents branches/sua/stable


for name in conf scripts; do
    svn mkdir ${file_path}/$name
done

# post-install.conf
post_conf=${file_path}/conf/post-install.conf
touch ${post_conf}
svn add ${post_conf}
echo "#
# \$Id\$
# \$HeadURL\$
#" > ${post_conf}
svn propset svn:keywords 'Id HeadURL' ${post_conf}


# post-install.sh
post_script=${file_path}/scripts/post-install.sh
touch ${post_script}
svn add ${post_script}
echo "#
# \$Id\$
# \$HeadURL\$
#" > ${post_script}
svn propset svn:keywords 'Id HeadURL' ${post_script}

for debian_stuff in rules control install cron.d conffiles; do
    touch ${debian_path}/$debian_stuff

    svn add ${debian_path}/$debian_stuff
echo "#
# \$Id\$
# \$HeadURL\$
#" > ${debian_path}/$debian_stuff

svn propset svn:keywords 'Id HeadURL' ${debian_path}/$debian_stuff

done

sed -i "1s/^/\#\!\/usr\/bin\/make -f\\n/" ${debian_path}/rules
echo "include /usr/share/cdbs/1/rules/debhelper.mk" >> ${debian_path}/rules
chmod +x ${debian_path}/rules

echo "files/* /
#" >> ${debian_path}/install


echo "Source: sua-${package_name}
Maintainer: IT <linux-sua@it.su.se>
Section: misc
Build-Depends: cdbs

Package: sua-${package_name}
Architecture: all
Depends:
Description: This is Stockholm University ${package_name} package." >> ${debian_path}/control

## SVN ##
echo "Run this if this are correct."
echo "svn commit -m 'Initial commit, just the basic structure.'"
