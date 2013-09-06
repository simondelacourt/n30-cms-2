module Admin::EmbeddablesHelper
  def embedify (url, maxwidth)
    begin
      o = OhEmbedr::OhEmbedr.new(:url => url, :maxwidth => maxwidth)
    rescue => e
      return {}
    else
      begin
        return  o.gets
      rescue => e
        return {}
      end
    end
  end
end
