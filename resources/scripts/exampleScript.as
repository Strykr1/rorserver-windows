#include "chatManager.as"
#include "terrainEditor.as"
#include "gameScriptWrapper.as"


// Create a chatManager object instance
chatManager chatSystem();



// Create a gameScriptManager object instance.
gameScriptManager gsm();



// Add the autoModerator plugin.
// This plugin allows the following commands:
//     - !suspendchat   Suspend all chat traffic for a certain time
//     - !schat         Short for !suspendchat
//     - !chatban       Blocks all chat messages from a certain user for a
//                      certain time
//     - !cban          Short for !chatban
//     - !temporaryban  Not yet implemented
//     - !tempban       Short for !temporaryban
//     - !tban       Short for !temporaryban
// Furthermore, it adds the profanity filter and flood filter to the chat.
chatPlugin_autoModerator autoModerator(@chatSystem);

// This small plugin transform messages like:
//      Anonymous: OMG LOOK ATZ ME
// to:
//      Anonymous: Omg look atz me
chatPlugin_disallowAllUpperCase disallowAllUpperCase(@chatSystem);

// This plugin adds the following commands:
//     - !afk           Prints "<username> is now away from keyboard."
//     - !back          Prints "<username> is now back."
//     - !gtg           Prints "<username> has got to go."
//     - !brb           Prints "<username> will be right back."
chatPlugin_miscellaneousCommands miscellaneousCommands(@chatSystem);

// This command adds the !move command, which will move your avatar in the
// specified direction.
chatPlugin_moveCommand moveCommand(@chatSystem);

// This commands adds the !goto, !setgoto (!sgoto) and !delelegoto (!dgoto)
// command. It allows you to store the position of your avatar (!setgoto <name>)
// and later teleport to that position (!goto <name>).
// Note: The !setgoto command works only with RoR 0.39! (not with 0.38)
chatPlugin_gotoCommand gotoCommand(@chatSystem, @gsm);

// This keeps track of what terrains are being used on the server and gives a
// list when the !terrainlist (!tlist) command is used.
// Note: All clients with RoR 0.38 will be shown as 'unknown terrain'.
chatPlugin_terrainList terrainList(@chatSystem, @gsm);

// This checks the latency of all RoR 0.39 players every 20 seconds and responds
// to !ping commands.
chatPlugin_ping ping(@chatSystem, @gsm);



// This is just meant as example, to show how to add commands.
// (note: the customCommand class is just a wrapper for the
// chatManager::addCommand method.)
// This adds a command !spam
customCommand spamCommand(@chatSystem, "spam", customCommand_spam);
void customCommand_spam(chatMessage@ cmsg)
{
	// Output something
	for(uint i=0; i<20; ++i)
	{
		cmsg.privateGameCommand.message(
			"SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM",
			"emoticon_smile.png"
		);
	}
}

// Another example, to show how to add commands.
// This adds a command !boost that gives a temporary boost to the truck of
// the user.
customCommand boostCommand(@chatSystem, "boost", customCommand_boost);
void customCommand_boost(chatMessage@ cmsg)
{
	cmsg.privateGameCommand.boostCurrentTruck(5);
}



// Add the terrain editor (RoR 0.39 only!)
// Commented out, doesn't work correctly yet.
//terrainEditor ternnditor(@chatSystem, @gsm);



// Load the terrain edits
terrainFileLoader terrain(@gsm, server.getServerTerrain());



// Add some commands that allow you to reload the terrain file, without having to restart the server.
customCommand reloadTerrainCommand(@chatSystem, "reloadterrain", customCommand_reloadTerrain, null, true, AUTH_ADMIN);
void customCommand_reloadTerrain(chatMessage@) { terrain.reload(); }

customCommand unloadTerrainCommand(@chatSystem, "unloadterrain", customCommand_unloadTerrain, null, true, AUTH_ADMIN);
void customCommand_unloadTerrain(chatMessage@) { terrain.unload(); }

customCommand loadTerrainCommand(@chatSystem, "loadterrain", customCommand_loadTerrain, null, true, AUTH_ADMIN);
void customCommand_loadTerrain(chatMessage@)   { terrain.load();   }



// Our main function (never remove this, even when it does nothing useful!)
void main()
{
	server.log("The script file is working :D");
}
