module TracksHelper
  include ERB::Util

  def ugly_lyrics(lyrics)
    "<pre>#{formatted_lyrics(lyrics)}</pre>".html_safe
  end

  def formatted_lyrics(lyrics)
    lyrics.split("\n").map { |line| "&#9835; " + h(line) }.join("\n")
  end

end
