package de.menzel.hadoop.sum;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.Mapper;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reporter;

import java.io.IOException;

/**
 * Created by Max on 12.06.2017.
 */
public class SumMapper extends MapReduceBase implements Mapper<Object, Text, Text, LongWritable> {

	private static final String DELIMITERS = "[,; \t\n]";
	private Text word = new Text();

	public void map(Object o, Text text, OutputCollector<Text, LongWritable> outputCollector, Reporter reporter) throws IOException {

	}

}
