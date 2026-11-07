# Roblox Classic Safe Chat Script

Retro Roblox Revival is a Roblox script package that recreates a classic R6 experience with old-style movement animations, a Safe Chat phrase menu, server-validated safe chat messages, speech bubbles, optional Safe Chat decals, chat sounds, and a wave animation when the local player speaks.

## Install

1. Open your Roblox experience in Roblox Studio.
2. Set `StarterPlayer.CharacterRigType` to `R6`.
3. Create a normal `Script` in `ServerScriptService` named `SafeChatServer`.
4. Copy the contents of `ServerScriptService/SafeChatServer.lua` into that script.
5. Create a `LocalScript` in `StarterPlayer > StarterPlayerScripts` named `ClassicSafeChat`.
6. Copy the contents of `StarterPlayer/StarterPlayerScripts/ClassicSafeChat.client.lua` into that script.
7. Create a `LocalScript` in `StarterPlayer > StarterCharacterScripts` named `ClassicR6Animations`.
8. Copy the contents of `StarterPlayer/StarterCharacterScripts/ClassicR6Animations.client.lua` into that script.
9. Test the experience using Play mode.

The server script automatically creates the `ReplicatedStorage.ClassicSafeChatEvent` RemoteEvent. Do not create another RemoteEvent with the same name.

## Use

1. Start the experience with an R6 character.
2. Select the `Safe Chat` button in the lower-left corner.
3. Select a predefined phrase from the phrase panel.
4. The server validates the phrase and broadcasts it to all clients.
5. The speaker displays the phrase in a speech bubble for five seconds.
6. Configure optional assets in `ClassicSafeChat.client.lua`:
   - Replace `SAFE_CHAT_DECAL_ID` with an approved decal asset ID.
   - Replace `CHAT_SOUND_ID` with an approved sound asset ID.
   - Replace `CLASSIC_WAVE_ANIMATION_ID` with an approved R6 wave animation ID.
7. Leave an optional asset set to `rbxassetid://0` to disable that feature.
8. To add a phrase, add the exact same text to both `DEFAULT_PHRASES` in `SafeChatServer.lua` and `phrases` in `ClassicSafeChat.client.lua`.

The server only accepts phrases from its predefined whitelist and applies a cooldown between messages. This system uses predefined safe phrases and does not provide unrestricted player chat.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/91cf1435-0fa4-4fea-be73-fc5627dc1255?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=91cf1435-0fa4-4fea-be73-fc5627dc1255
