class LogParser
  attr_reader :entries

  def initialize(path=nil)
    @entries = []

    if path
      content = File.read(path)
      content.split("\n").each do |entry|
        (path, address) = entry.split("\s")
        @entries << { path: path, address: address}
      end
    end
  end

  def entries
    @entries
  end

  def retrieve_top_views
    paths.collect do |e|
      [e, count_path_for_view(e)]
    end.sort{|a,b| b[1] <=> a[1] }
  end

  def retrieve_top_uniq_views
    paths.collect do |e|
      [e, count_path_for_uniq_view(e)]
    end.sort{|a,b| b[1] <=> a[1] }
  end

  def output
    outputs = []
    retrieve_top_views.each do |top_view|
      outputs << top_view[0] + "\t" + top_view[1].to_s + " views"
    end

    outputs << ""

    retrieve_top_uniq_views.each do |top_uniq_view|
      outputs << top_uniq_view[0] + "\t" + top_uniq_view[1].to_s + " uniq views"
    end

    outputs.join("\n")
  end

  private
  def count_path_for_view(path)
    @entries.collect{|e| e[:path]}.count(path)
  end

  def count_path_for_uniq_view(path)
    @entries.uniq.collect{|e| e[:path]}.count(path)
  end

  def paths
    @entries.collect{|e| e[:path]}.uniq
  end

end
