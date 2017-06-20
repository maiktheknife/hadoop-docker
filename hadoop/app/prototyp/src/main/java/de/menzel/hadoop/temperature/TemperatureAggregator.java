package de.menzel.hadoop.temperature;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by Max on 20.06.2017.
 */
public class TemperatureAggregator {

	private static Logger LOG = LoggerFactory.getLogger(TemperatureAggregator.class);

	public static void main(String[] args) throws Exception {
		LOG.info("Start main");

		Configuration conf = new Configuration();
		Job job = Job.getInstance(conf, "temperature aggregator");
		job.setJarByClass(TemperatureAggregator.class);
		job.setMapperClass(TempMapper.class);
		job.setReducerClass(TempReducer.class);

		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);

		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(DoubleWritable.class);

		String inputPath = args[0];
		String outputPath = args[1];

		FileInputFormat.addInputPath(job, new Path(inputPath));
		FileOutputFormat.setOutputPath(job, new Path(outputPath));

		boolean completion = job.waitForCompletion(true);
		LOG.info("end main with code: '{}'", completion);
		System.exit(completion ? 0 : 1);
	}

}
