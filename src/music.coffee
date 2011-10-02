###*
The Music object provides an easy API to play
songs from your sounds project directory. By
default, the track is looped.

<code><pre>
  Music.play('intro_theme')
</pre></code>

@name Music
@namespace
###

Music = (->
  track = $ "<audio />",
    loop: "loop"
  .appendTo('body').get(0)

  track.volume = 1

  play: (name) ->
    track.src = "#{BASE_URL}/sounds/#{name}.mp3"
    track.play()
)()

