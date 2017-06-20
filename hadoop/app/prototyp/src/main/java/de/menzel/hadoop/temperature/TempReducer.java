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

	private DoubleWritable doubleWritable = new DoubleWritable();

	@Override
	protected void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
		LOG.info("reduce task started, key={}", key);
		Averager averageCollect = StreamSupport.stream(values.spliterator(), false)
				.map(IntWritable::get)
				.collect(Averager::new, Averager::accept, Averager::combine);

		doubleWritable.set(averageCollect.average());
		context.write(key, doubleWritable);
		LOG.info("reduce task done -> {}", doubleWritable.get());
	}

	private class Averager implements IntConsumer {
		private int total = 0;
		private int count = 0;

		double average() {
			return count > 0 ? ((double) total) / count : 0;
		}

		public void accept(int i) {
			total += i;
			count++;
		}

		void combine(Averager other) {
			total += other.total;
			count += other.count;
		}
	}

}
