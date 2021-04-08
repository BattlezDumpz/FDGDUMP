const Sound = function (id, url, volume) {
	let self = this;

	self.id = id
	self.howl = null;
	self.url = url;
	self.volume = volume;

	self.play = function() {
		var howl = new Howl({
			src: self.url,
			html5: true,
			format: ['opus', 'ogg'],
			volume: self.volume,

			onend: function() {
				$.post("http://base_scripting/soundFinished", JSON.stringify(self.id));
			}
		});

		howl.once("load", function() {
			howl.play();

			if (self.howl) {self.howl.unload()}

			self.howl = howl;
		})		
	}

	self.stop = function() {
		if (self.howl) {
			self.howl.stop();
		}
	}

	self.setVolume = function(volume) {
		self.volume = volume
		self.howl.volume(self.volume)
	}

	self.playAudio = function(toggle) {
		if (toggle) {
			self.howl.volume(self.volume)
		} else {
			self.howl.volume(0.0)			
		}		
	}

	return self;
};

var sounds = {}

// Listen for NUI Messages.
window.addEventListener('message', function(event) {
	var item = event.data;

	if (item.soundUrl != null) {
		var volume = 0.5
		if (item.volume != null) { 
			var volume = item.volume
		}

			if (item.playAudio)	
			var soundObj = Sound(item.soundID, `sounds/${item.soundUrl}.ogg`, volume)

			soundObj.play()
			sounds[item.soundID] = soundObj

	} else if (item.playAudio != undefined) {
		sounds[item.soundID].playAudio(item.playAudio)

	}
});