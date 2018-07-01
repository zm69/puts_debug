require "puts_debug/version"

module Kernel

  ##
  # For easier puts debugging (pd). Defined in Kernel module which is included into Object class so this method
  # is accessible from everywhere. Output is sent to standard error stream (stderr) so it could be further separated
  # from standard output like this:
  #
  #   rails s 2>> error
  #
  #   then you can
  #
  #   tail -f error
  #
  #   to watch error stream output.
  #
  #   Examples:
  #
  #     pd('something') =>
  #     something
  #
  #     pd(name: 'Yogurt') =>
  #     name: Yogurt
  #
  #     pd(1, '-', :both, 1) =>
  #
  #     ------------------------------------------------------------
  #     1
  #     ------------------------------------------------------------
  #
  #     pd({a: 1, b: 3}, '*', :both, 2) =>
  #
  #
  #     ************************************************************
  #     a: 1
  #     b: 3
  #     ************************************************************
  #
  #
  def pd(h = {}, line_symbol = nil, show_lines = :both, empty_lines_margin = nil)

    return unless Rails.env.development?

    $stderr.puts "\n" * empty_lines_margin if empty_lines_margin.present? && show_lines.in?([:both, :top])
    $stderr.puts (line_symbol * 60) if line_symbol.present? && show_lines.in?([:both, :top])

    if h.is_a? Hash
      h.each do |k, v|
        $stderr.puts "#{k}: #{v}"
      end
    else
      $stderr.puts h
    end

    $stderr.puts line_symbol * 60 if line_symbol.present? && show_lines.in?([:both, :bottom])
    $stderr.puts "\n" * empty_lines_margin if empty_lines_margin.present? && show_lines.in?([:both, :bottom])

  end

end
