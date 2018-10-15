#!/bin/bash

SPARKSUBMITPATH=`find $RPM_BUILD_ROOT -name spark-submit -exec dirname {} \;`
SPARKSUBMIT=$SPARKSUBMITPATH/spark-submit

/bin/sed -i '/spark-class org.apache.spark.deploy.SparkSubmit/d' $SPARKSUBMIT

/bin/echo "HDPSELECT=\`/usr/bin/hdp-select | /usr/bin/grep spark-client | /usr/bin/hdp-select | /usr/bin/grep spark-client | /bin/cut -d \" \" -f 3\`" >> $SPARKSUBMIT
/bin/echo "export SPARK_SUBMIT_OPTS=\"-Dhdp.version=\$HDPSELECT\"\$SPARK_SUBMIT_OPTS" >> $SPARKSUBMIT
/bin/echo "ADDTLARGS=\"--conf spark.driver.extraJavaOptions=-Dhdp.version=\$HDPSELECT --conf spark.executor.extraJavaOptions=-Dhdp.version=\$HDPSELECT --conf spark.yarn.am.extraJavaOptions=-Dhdp.version=\$HDPSELECT --conf spark.hadoop.yarn.timeline-service.enabled=false --conf spark.yarn.archive=hdfs:///apps/spark221/spark221.zip\"" >> $SPARKSUBMIT 
/bin/echo "if [[ \"\$1\" == \"pyspark-shell-main\" || \"\$1\" == \"sparkr-shell-main\" ]] ; then" >> $SPARKSUBMIT
/bin/echo "        exec \"\${SPARK_HOME}\"/bin/spark-class org.apache.spark.deploy.SparkSubmit \"\$@\" \$ADDTLARGS" >> $SPARKSUBMIT
/bin/echo "else" >> $SPARKSUBMIT
/bin/echo "        exec \"\${SPARK_HOME}\"/bin/spark-class org.apache.spark.deploy.SparkSubmit \$ADDTLARGS \"\$@\"" >> $SPARKSUBMIT
/bin/echo "fi" >> $SPARKSUBMIT

