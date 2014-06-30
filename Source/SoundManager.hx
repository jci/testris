import openfl.Assets;
import openfl.media.Sound;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;

class SoundManager
{
	public static var instance : SoundManager;

	private var volume:Float;
	private var channel:SoundChannel;
	private var backgroundmusic:Sound;
	private var balance:Float;

	private function new()
	{
		volume = 0.0;
		channel = null;
		backgroundmusic=null;
		balance = 0.0;
	}

	public static function getInstance()	
	{
		if (SoundManager.instance == null)
		{
			SoundManager.instance = new SoundManager();
		}
		return SoundManager.instance;

	}

	public function loadMusic(url:String)
	{
		backgroundmusic=Assets.getSound(url);

	}

	public function playMusic()
	{
		channel = backgroundmusic.play();
		channel.addEventListener(Event.SOUND_COMPLETE,channel_onSoundComplete);

	}

	public function stopMusic()
	{
		if (channel!=null)
		{
			channel.removeEventListener(Event.SOUND_COMPLETE,channel_onSoundComplete);
			channel.stop();
			channel = null;
		}
	}


	public function playSound(url:String)	
	{
		var soundFX = openfl.Assets.getSound(url);
		soundFX.play(0,0,new SoundTransform(volume,balance));
	}


	private function channel_onSoundComplete( event:Event)
	{
		playMusic();
	}


	public function setVolume(newvolume : Float)
	{
		volume = newvolume	> 1 ? 1 : newvolume;

		if (channel != null)
		{
			channel.soundTransform = new SoundTransform(volume,balance);
		}
	}

	public function volumeUp(delta:Float = 0.1)
	{
		setVolume(volume + delta);
	}

	public function volumeDown(delta : Float = 0.1)
	{
		setVolume(volume - delta);
	}

	public function mute()	
	{
		if (volume!= 0.0)
		{
			setVolume(0.0);
		}
		else
		{
			setVolume(1.0);
		}
		if (channel != null)
		{
			channel.removeEventListener(Event.SOUND_COMPLETE,channel_onSoundComplete);

		}
	}

	public function unmute()
	{
		setVolume(1.0);
		if (channel != null)
		{
			channel.addEventListener(Event.SOUND_COMPLETE,channel_onSoundComplete);
		}
	}

	public function isMuted()	
	{
		return volume == 0.0;
	}

	public function setBalance(newbalance:Float)
	{
		balance = newbalance;
		if (channel != null)
		{
			channel.soundTransform = new SoundTransform(volume,balance);
		}
	}

	public function getBalance()	
	{
		return balance;
	}

	public function increaseRight(delta : Float = 0.1)	
	{
		if (balance + delta <=1.0)
		{
			setBalance(balance+delta);
		}
	}

	public function increaseLeft(delta : Float = 0.1)
	{
		if (balance - delta > -1.0)
		{
			setBalance(balance-delta);
		}
	}


	public function getVolume()
	{
		return volume;
	}

}
