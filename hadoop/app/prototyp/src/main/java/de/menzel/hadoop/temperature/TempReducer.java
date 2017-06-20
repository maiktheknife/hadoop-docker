package de.menzel.hadoop.temperature;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.function.IntConsumer;
import java.util.stream.StreamSupport;

/**
 * Created by Max on 20.06.2017.
 */
public class TempReducer extends Reducer<Text, IntWritable, Text, DoubleWritable> {

	private static Logger LOG = LoggerFactory.getLogger(TempReducer.class);

	private static DoubleWritable doubleWritable = new DoubleWritable();

	@Override
	protected void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
		LOG.info("reduce task {}", key);
		Averager averageCollect = StreamSupport.stream(values.spliterator(), false)
				.map(IntWritable::get)
				.collect(Averager::new, Averager::accept, Averager::combine);

		doubleWritable.set(averageCollect.average());
		LOG.info("reduce task done {} -> {}", key, averageCollect.average());
		context.write(key, doubleWritable);
	}

	class Averager implements IntConsumer {
		private int total = 0;
		private int count = 0;

		public double average() {
			return count > 0 ? ((double) total) / count : 0;
		}

		public void accept(int i) {
			total += i;
			count++;
		}

		public void combine(Averager other) {
			total += other.total;
			count += other.count;
		}
	}
}
