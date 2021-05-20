module FactoryBurgers
  module Cheating
    module_function

    def discover_sequences(factory)
      cheater = SequenceCheater.new
      attributes = factory.definition.attributes
      attributes.map do |attr|
        block = attr.instance_variable_get(:@block)
        cheater.instance_eval(&block)
      end
      return cheater.sequence_names
    end

    def advance_sequence(name, klass, column, sql: nil, regex: nil)
      sequence = FactoryBot::Internal.sequences.find(name)
      sql ||= sql_condition(sequence, column)
      regex ||= regex_pattern(sequence)

      matches = klass.where(sql).pluck(column).select { |val| val =~ regex }
      highest = matches.map { |value| value =~ regex && Regexp.last_match(1) }.map(&:to_i).max
      highest&.times { FactoryBot.generate name }
      return FactoryBot.generate(name)
    end

    def sql_condition(sequence, column)
      proc = sequence.instance_variable_get(:@proc)
      injector = SequenceInjector.new("%")
      sql_value = proc.call(injector)
      return "#{column} like '#{sql_value}'"
    end

    def regex_pattern(sequence)
      proc = sequence.instance_variable_get(:@proc)
      injector = SequenceInjector.new("(\\d+)")
      return Regexp.new(proc.call(injector))
    end
  end
end
