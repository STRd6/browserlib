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

root = exports ? this

Music = (->
  # TODO: Load this from local storage of user preferences
  globalMusicVolume = 1
  trackVolume = 1

  root.musicVolume = (newVolume) ->
    if newVolume?
      globalMusicVolume = newVolume.clamp(0, 1)

      updateTrackVolume

    return globalMusicVolume

  # TODO: Add format fallbacks
  track = $ "<audio />",
    loop: "loop"
  .appendTo('body').get(0)

  updateTrackVolume = ->
    track.volume = globalMusicVolume * trackVolume

  updateTrackVolume()

  play: (name) ->
    track.src = "#{BASE_URL}/sounds/#{name}.mp3"
    track.play()

  volume: (newVolume) ->
    if newVolume?
      trackVolume = newVolume.clamp(0, 1)
      updateTrackVolume()

      return this
    else
      return trackVolume
)()
