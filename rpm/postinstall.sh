if [[ ! -z "$RPM_INSTALL_PREFIX" ]] ; then
   FILES="spark-defaults.conf spark-env.sh hive-site.xml log4j.properties spark-thrift-sparkconf.conf" 
   for file in $FILES
	do
   		if [[ -f /etc/spark/conf/$file ]] ; then
			ln -fns /etc/spark/conf/$file $RPM_INSTALL_PREFIX/conf/$file
   		fi
	done
fi
