require "puts_debug/version"
require 'rainbow'

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
  #     ============================================================
  #     something
  #     ============================================================
  #
  #     pd(data: 'something', data_color: 'magenta', lines: :none) =>
  #     something
  #
  #     pd(name: 'Yogurt') =>
  #     ============================================================
  #     name: Yogurt
  #     ============================================================
  #
  #     pd(data: 1, symbol: '-', margin: 1) =>
  #
  #     ------------------------------------------------------------
  #     1
  #     ------------------------------------------------------------
  #
  #     pd(data: {a: 1, b: 3}, symbol: '*') =>
  #     ************************************************************
  #     a: 1
  #     b: 3
  #     ************************************************************
  def pd(args)
    params = nil

    if args.is_a? Hash
      if args[:data].nil?
        params = { data: args }
      else
        params = args
      end
    else
      params = { data: args }
    end

    # parameters
    data       = params[:data]
    symbol     = params[:symbol] || '='
    line_color = params[:color] || 'red'
    data_color = params[:data_color] || nil
    margin     = params[:margin] || 0
    lines      = params[:lines] || :both
    title      = params[:title]
    epilogue   = params[:epilogue]

    # locals
    line_str   = Rainbow(symbol * 60).try(line_color)
    margin_str = "\n" * margin

    $stderr.puts margin_str if margin > 0 && lines.in?([:both, :top])
    $stderr.puts line_str if lines.in?([:both, :top])

    if title.present?
      title_str = if title.ends_with? ':'
        "#{title}\n"
      else
        "#{title}:\n"
      end

      $stderr.puts Rainbow(title_str).try(line_color)
    end

    data_str = case data
    when Hash
      data.map { |k, v| "#{k}: #{v}" }.join("\n")
    when Array
      data.map { |v| "#{v}" }.join(",\n")
    else
      data.to_s
    end

    data_str = Rainbow(data_str).try(data_color) if data_color.present?

    $stderr.puts data_str

    if title.present?
      $stderr.puts ''
    end

    $stderr.puts Rainbow(epilogue).try(line_color) if epilogue.present?

    if lines.present?
      $stderr.puts line_str if lines.in?([:both, :bottom])
      $stderr.puts margin_str if margin > 0 && lines.in?([:both, :bottom])
    end
  end

end
