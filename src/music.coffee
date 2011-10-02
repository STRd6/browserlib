###*
The Music object provides an easy API to play
songs from your sounds project directory.

@name Music
@namespace

<code><pre>
if keydown.left
  moveLeft()

if keydown.a or keydown.space
  attack()

if keydown.return
  confirm()

if keydown.esc
  cancel()
</pre></code>

@name keydown
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

