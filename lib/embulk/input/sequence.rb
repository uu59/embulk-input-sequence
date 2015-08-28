module Embulk
  module Input

    class Sequence < InputPlugin
      Plugin.register_input("sequence", self)

      def self.transaction(config, &control)
        # configuration code:
        task = {
          min: config.param(:min, :integer),
          max: config.param(:max, :integer),
          threads: config.param(:threads, :integer, default: 2),
          fail_random: config.param(:fail_random, :float, default: 0.2),
        }

        columns = [
          Column.new(nil, "number", :long),
        ]

        resume(task, columns, task[:threads], &control)
      end

      def self.resume(task, columns, count, &control)
        commit_reports = yield(task, columns, count)
        Embulk.logger.info "commit_reports: #{commit_reports}"

        next_config_diff = {}
        return next_config_diff
      end

      # TODO
      #def self.guess(config)
      #  sample_records = [
      #    {"example"=>"a", "column"=>1, "value"=>0.1},
      #    {"example"=>"a", "column"=>2, "value"=>0.2},
      #  ]
      #  columns = Guess::SchemaGuess.from_hash_records(sample_records)
      #  return {"columns" => columns}
      #end

      def init
        super
      end

      def run
        range = (task[:min]..task[:max]).to_a
        slices = task[:threads].times.map do |i|
          pivot = range.count / task[:threads]
          to = (i == range.count ? range.count : pivot * (i + 1))
          range[pivot * i, to]
        end
        slices.each_with_index do |numbers, i|
          next if index != i
          numbers.each do |number|
            raise "Random error!" if rand > task[:fail_random]
            Embulk.logger.info "add #{number}"
            page_builder.add([number])
          end
        end
        page_builder.finish

        commit_report = {}
        return commit_report
      end
    end

  end
end
