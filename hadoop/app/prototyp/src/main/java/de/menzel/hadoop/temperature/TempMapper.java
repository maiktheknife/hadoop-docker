package de.menzel.hadoop.temperature;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * Created by Max on 20.06.2017.
 */
public class TempMapper extends Mapper<Object, Text, Text, IntWritable> {

	private static Logger LOG = LoggerFactory.getLogger(TempMapper.class);

	private IntWritable writable = new IntWritable(1);

	@Override
	protected void map(Object key, Text value, Context context) throws IOException, InterruptedException {
		LOG.info("map {}", key);
		String[] line = value.toString().split(";");
		System.out.println(line.length);
		context.write(value, writable);
	}
}
