class SlimI18n < Slim::Filter
  def on_slim_interpolate str
    # $1: leave \\ as is for Slim's interpolation
    # $2: treat \$ as $
    # $3: $a.b.c form
    # $4: ${…} form
    stuffed = str.gsub(/(\\\\)|\\(\$)|\$([\.\-\w]+)|\${([^}]+)}/){ $1 || $2 || "\#{t('#{$3||$4}')}" }
    [:slim, :interpolate, stuffed]
  end
  
  Slim::Engine.before(Slim::Interpolation, self)
end
