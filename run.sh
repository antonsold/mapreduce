#!/usr/bin/env bash

OUT_DIR="out"
NUM_REDUCERS=8

hadoop fs -rm -r -skipTrash ${OUT_DIR}.tmp > /dev/null

yarn jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-streaming.jar \
    -D mapreduce.job.name="word files count" \
    -D mapreduce.job.reduces=$NUM_REDUCERS \
    -files mapper.py,reducer.py \
    -mapper "python mapper.py" \
    -reducer "python reducer.py" \
    -input /data/wiki/en_articles \
    -output ${OUT_DIR}.tmp > /dev/null

hadoop fs -rm -r -skipTrash ${OUT_DIR} > /dev/null

yarn jar /opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/hadoop-streaming.jar \
	-D mapreduce.job.name="words files sort" \
	-D mapreduce.job.reduces=1 \
	-D mapreduce.partition.keycomparator.options=-k1,1n \
	-D mapreduce.job.output.key.comparator.class=org.apache.hadoop.mapreduce.lib.partition.KeyFieldBasedComparator \
	-files sortmapper.py,sortreducer.py \
	-mapper "python sortmapper.py" \
	-reducer "python sortreducer.py" \
	-input ${OUT_DIR}.tmp \
	-output ${OUT_DIR} > /dev/null

hadoop fs -cat ${OUT_DIR}/part-00000 | head

