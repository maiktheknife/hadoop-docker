package de.menzel.hadoop.temperature;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.StringTokenizer;

/**
 * Created by Max on 20.06.2017.
 */
public class TempMapper extends Mapper<Object, Text, Text, IntWritable> {

	private static final Logger LOG = LoggerFactory.getLogger(TempMapper.class);

	@Override
	protected void map(Object key, Text value, Context context) throws IOException, InterruptedException {
		LOG.info("map task started, key={}", key);
		String[] line = value.toString().split(":");

		String year = line[0];
		LOG.info("map year {}", year);

		Text writeableKey = new Text(year);
		IntWritable writableValue = new IntWritable();

		StringTokenizer itr = new StringTokenizer(line[1], ",");
		while (itr.hasMoreTokens()) {
			int t = Integer.valueOf(itr.nextToken());
			writableValue.set(t);
			context.write(writeableKey, writableValue);
		}
		LOG.info("map task done {}", year);
	}
}
