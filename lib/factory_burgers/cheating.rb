module FactoryBurgers
  # This module contrains utilities to manipulate sequences that might fail for
  # usage in development environments that do not roll back db transactions for
  # factory creations.
  module Cheating
    module_function

    # Given a factory, discover what sequences are used in its attributes.
    # Since factories' attributes are defined as blocks, there is no way to know
    # which blocks use sequences without executing the block. We do this with
    # SequenceCheater to take notes without actually using the seqence itself.
    def discover_sequences(factory)
      cheater = SequenceCheater.new
      attributes = factory.definition.attributes
      attributes.map do |attr|
        block = attr.instance_variable_get(:@block)
        cheater.instance_eval(&block)
      end
      return cheater.sequence_names
    end

    # Find the highest value of a sequence in the database and advance the
    # sequence past it to avoid uniqueness violations.
    # This is by no means foolproof nor performant; use it with care.
    # There isn't a good way to access the iterator state; instead, we measure
    # how far we must advance the sequence and call `generate` that many times.
    # This works well for sequential iterations, but more complex sequences
    # might break this.
    def advance_sequence(name, klass, column, sql: nil, regex: nil)
      sequence = FactoryBot::Internal.sequences.find(name)
      sql ||= sql_condition(sequence, column)
      regex ||= regex_pattern(sequence)

      highest = find_highest_index_value(klass, column, sql, regex) or return nil
      highest&.times { FactoryBot.generate name }
    end

    def find_highest_index_value(klass, column, sql, regex)
      matches = klass.where(sql).pluck(column).grep(regex)
      return matches.map { |value| value =~ regex && Regexp.last_match(1) }.map(&:to_i).max
    end

    # ---
    # TODO: Use this same principle, but without swallowing `method_missing`, to
    # probe sequences at specific numeric values. This will allow us to determine if
    # a sequence is doing unexpected things like descending, e.g.
    #   `sequence :negatives { |ii| -ii }`
    # ---

    # For a sequence defined with { |ii| "foo#{ii}" }, `sql_condition` returns
    # the SQL fragemnt "<name> like 'foo%'"
    # TODO: does this work in pg, sqlite?
    # TODO: support mongo as well
    def sql_condition(sequence, column)
      # This proc is defined by the block used in the sequence definition
      # This may be fragile, but may also be out only option
      proc = sequence.instance_variable_get(:@proc)
      injector = SequenceInjector.new("%")
      sql_value = proc.call(injector)
      return "#{column} like '#{sql_value}'"
    end

    # For a sequence defined with { |ii| "foo#{ii}" }, `sql_condition` returns
    # the regex /foo(\d+)/
    def regex_pattern(sequence, numeric: true)
      wildcard = numeric ? "\\d" : "."
      proc = sequence.instance_variable_get(:@proc)
      injector = SequenceInjector.new("(#{wildcard}+)")
      return Regexp.new(proc.call(injector))
    end
  end
end
