Begin keanee.lua By #keanee
local function getindex(t,id) 
	for i,v in pairs(t) do 
		if v == id then 
			return i 
		end 
	end 
	return nil 
end 

local function reload_plugins( ) 
	plugins = {} 
	load_plugins() 
end

--By @KE_NAE
local function already_sudo(user_id)
	for k,v in pairs(_config.sudo_users) do
		if user_id == v then
			return k
		end
	end
	-- If not found
	return false
end

--By @KE_NAE
local function sudolist(msg)
	local sudo_users = _config.sudo_users
	local text = "Sudo Users :\n"
	for i=1,#sudo_users do
		text = text..i.." - "..sudo_users[i].."\n"
	end
	return text
end

local function options(msg, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
     if not lang then
	 text = '_Welcome To_ *Group Option*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> Settings", callback_data="/settings:"..GP_id},
			{text = "> MuteList", callback_data="/mutelist:"..GP_id}
		},
		{
			{text = '> More ', callback_data = '/more:'..GP_id}
		},
		{
			{text = '> About Us ', callback_data = '/beyond:'..GP_id}
		},
		{
			{text= '> Back' ,callback_data = '/lang:'..GP_id}
		}				
	}
  elseif lang then
	 text = '_اهلا بيك في قائمه الاوامر_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> الاوامر", callback_data="/settings:"..GP_id},
			{text = "> قائمه الكتم", callback_data="/mutelist:"..GP_id}
		},
		{
			{text = '>الخاصيات ', callback_data = '/more:'..GP_id}
		},
		{
			{text = '> معلومات ', callback_data = '/beyond:'..GP_id}
		},
		{
			{text= '> رجوع' ,callback_data = '/lang:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

function moresetting(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
local settings = data[tostring(GP_id)]["settings"]
   if not lang then
 text = '_Welcome To_ *More Settings*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '> Flood Sensitivity ', callback_data = 'keanee'}
		},
		{
			{text = "➕", callback_data='/floodup:'..GP_id}, 
			{text = tostring(settings.num_msg_max), callback_data="keanee"},
			{text = "➖", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = '> Character Sensitivity ', callback_data = 'keanee'}
		},
		{
			{text = "➕", callback_data='/charup:'..GP_id}, 
			{text = tostring(settings.set_char), callback_data="keanee"},
			{text = "➖", callback_data='/chardown:'..GP_id}
		},
		{
			{text = '> Flood Check Time ', callback_data = 'keanee'}
		},
		{
			{text = "➕", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(settings.time_check), callback_data="keanee"},
			{text = "➖", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = '> Back ', callback_data = '/settings:'..GP_id}
		}				
	}
   elseif lang then
 text = '_مرحبًا بك في المزيد من الإعدادات_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		
			{text = '> الحد الأقصى للرسائل المتكررة ', callback_data = 'keanee'}
		},
		{
			{text = "➕", callback_data='/floodup:'..GP_id}, 
			{text = tostring(settings.num_msg_max), callback_data="keanee"},
			{text = "➖", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = '> الحد الأقصى المسموح به من الحروف ', callback_data = 'keanee'}
		},
		{
			{text = "➕", callback_data='/charup:'..GP_id}, 
			{text = tostring(settings.set_char), callback_data="keanee"},
			{text = "➖", callback_data='/chardown:'..GP_id}
		},
		{
			{text = '> التحقق من الوقت المتكرر للرسائل', callback_data = 'keanee'}
		},
		{
			{text = "➕", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(settings.time_check), callback_data="keanee"},
			{text = "➖", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = '> Back ', callback_data = '/settings:'..GP_id}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

function setting(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
	if data[tostring(GP_id)] and data[tostring(GP_id)]['settings'] then
		settings = data[tostring(GP_id)]['settings']
	else
		return
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = 'no'
	end
	if settings.lock_join then
		lock_join = settings.lock_join
	else
		lock_join = 'no'
	end
	if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = 'no'
	end
	if settings.lock_pin then
		lock_pin = settings.lock_pin
	else
		lock_pin = 'no'
	end
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = 'no'
	end
	if settings.lock_mention then
		lock_mention = settings.lock_mention
	else
		lock_mention = 'no'
	end
		if settings.lock_edit then
		lock_edit = settings.lock_edit
	else
		lock_edit = 'no'
	end
		if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = 'no'
	end
	if settings.flood then
		lock_flood = settings.flood
	else
		lock_flood = 'no'
	end
	if settings.lock_markdown then
		lock_markdown = settings.lock_markdown
	else
		lock_markdown = 'no'
	end
	if settings.lock_webpage then
		lock_webpage = settings.lock_webpage
	else
		lock_webpage = 'no'
	end
	if settings.lock_bots then
		lock_bots = settings.lock_bots
	else
		lock_bots = 'no'
	end
	if settings.welcome then
		group_welcone = settings.welcome
	else
		group_welcone = 'no'
	end
    if not lang then
 text = '_Welcome To_ *Group Settings*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> Lock Edit", callback_data='keanee'}, 
			{text = lock_edit, callback_data="/lockedit:"..GP_id}
		},
		{
			{text = "> Lock Link", callback_data='keanee'}, 
			{text = lock_link, callback_data="/locklink:"..GP_id}
		},
		{
			{text = "> Lock Tags", callback_data='keanee'}, 
			{text = lock_tag, callback_data="/locktags:"..GP_id}
		},
		{
			{text = "> Lock Join", callback_data='keanee'}, 
			{text = lock_join, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = "> Lock Flood", callback_data='keanee'}, 
			{text = lock_flood, callback_data="/lockflood:"..GP_id}
		},
		{
			{text = "> Lock Spam", callback_data='keanee'}, 
			{text = lock_spam, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = "> Lock Mention", callback_data='keanee'}, 
			{text = lock_mention, callback_data="/lockmention:"..GP_id}
		},
		{
			{text = "> Lock Arabic", callback_data='keanee'}, 
			{text = lock_arabic, callback_data="/lockarabic:"..GP_id}
		},
		{
			{text = "> Lock Webpage", callback_data='keanee'}, 
			{text = lock_webpage, callback_data="/lockwebpage:"..GP_id}
		},
		{
			{text = "> Lock Markdown", callback_data='keanee'}, 
			{text = lock_markdown, callback_data="/lockmarkdown:"..GP_id}
		},
		{
			{text = "> Lock Pin", callback_data='keanee'}, 
			{text = lock_pin, callback_data="/lockpin:"..GP_id}
		},
		{
			{text = "> Lock Bots", callback_data='keanee'}, 
			{text = lock_bots, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = "> Group Welcome", callback_data='keanee'}, 
			{text = group_welcone, callback_data="/welcome:"..GP_id}
		},
		{
			{text = '> More Settings ', callback_data = '/moresettings:'..GP_id}
		},
		{
			{text = '> Back ', callback_data = '/option:'..GP_id}
		}				
	}
     elseif lang then
 text = '_مرحبًا بك في إعدادات المجموعة_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> قفل التعديل", callback_data='keanee'}, 
			{text = lock_edit, callback_data="/lockedit:"..GP_id}
		},
		{
			{text = "> قفل الروابط", callback_data='keanee'}, 
			{text = lock_link, callback_data="/locklink:"..GP_id}
		},
		{
			{text = "> قفل التاك", callback_data='keanee'}, 
			{text = lock_tag, callback_data="/locktags:"..GP_id}
		},
		{
			{text = "> قفل الاشعارات", callback_data='keanee'}, 
			{text = lock_join, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = "> قفل التكرار", callback_data='keanee'}, 
			{text = lock_flood, callback_data="/lockflood:"..GP_id}
		},
		{
			{text = "> قفل المواقع", callback_data='keanee'}, 
			{text = lock_spam, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = "> قفل الشبكات", callback_data='keanee'}, 
			{text = lock_mention, callback_data="/lockmention:"..GP_id}
		},
		{
			{text = "> قفل العربيه", callback_data='keanee'}, 
			{text = lock_arabic, callback_data="/lockarabic:"..GP_id}
		},
		{
			{text = "> قفل صفحات الوب", callback_data='keanee'}, 
			{text = lock_webpage, callback_data="/lockwebpage:"..GP_id}
		},
		{
			{text = "> قفل الزخرفه", callback_data='keanee'}, 
			{text = lock_markdown, callback_data="/lockmarkdown:"..GP_id}
		},
		{
			{text = "> قفل التثبيت", callback_data='keanee'}, 
			{text = lock_pin, callback_data="/lockpin:"..GP_id}
		},
		{
			{text = "> قفل البوتات", callback_data='keanee'}, 
			{text = lock_bots, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = ">  قفل الترحيب", callback_data='keanee'}, 
			{text = group_welcone, callback_data="/welcome:"..GP_id}
		},
		{
			{text = '> اعدادات اكثر ', callback_data = '/moresettings:'..GP_id}
		},
		{
			{text = '> رجوع ', callback_data = '/option:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

function mutelists(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
    if data[tostring(GP_id)] and data[tostring(GP_id)]['mutes'] then
		mutes = data[tostring(GP_id)]['mutes']
	else
		return
	end
	if mutes.mute_all then
		mute_all = mutes.mute_all
	else
		mute_all = 'no'
	end
	if mutes.mute_gif then
		mute_gif = mutes.mute_gif
	else
		mute_gif = 'no'
	end
   if mutes.mute_photo then
		mute_photo = mutes.mute_photo
	else
		mute_photo = 'no'
	end
	if mutes.mute_sticker then
		mute_sticker = mutes.mute_sticker
	else
		mute_sticker = 'no'
	end
	if mutes.mute_contact then
		mute_contact = mutes.mute_contact
	else
		mute_contact = 'no'
	end
	if mutes.mute_inline then
		mute_inline = mutes.mute_inline
	else
		mute_inline = 'no'
	end
	if mutes.mute_game then
		mute_game = mutes.mute_game
	else
		mute_game = 'no'
	end
	if mutes.mute_text then
		mute_text = mutes.mute_text
	else
		mute_text = 'no'
	end
	if mutes.mute_keyboard then
		mute_keyboard = mutes.mute_keyboard
	else
		mute_keyboard = 'no'
	end
	if mutes.mute_forward then
		mute_forward = mutes.mute_forward
	else
		mute_forward = 'no'
	end
	if mutes.mute_location then
		mute_location = mutes.mute_location
	else
		mute_location = 'no'
	end
   if mutes.mute_document then
		mute_document = mutes.mute_document
	else
		mute_document = 'no'
	end
	if mutes.mute_voice then
		mute_voice = mutes.mute_voice
	else
		mute_voice = 'no'
	end
	if mutes.mute_audio then
		mute_audio = mutes.mute_audio
	else
		mute_audio = 'no'
	end
	if mutes.mute_video then
		mute_video = mutes.mute_video
	else
		mute_video = 'no'
	end
	if mutes.mute_tgservice then
		mute_tgservice = mutes.mute_tgservice
	else
		mute_tgservice = 'no'
	end
   if not lang then
	 text = '_Welcome To_ *Group Mutelist*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> Mute All", callback_data='keanee'}, 
			{text = mute_all, callback_data="/muteall:"..GP_id}
		},
		{
			{text = "> Mute Gifs", callback_data='keanee'}, 
			{text = mute_gif, callback_data="/mutegif:"..GP_id}
		},
		{
			{text = "> Mute Text", callback_data='keanee'}, 
			{text = mute_text, callback_data="/mutetext:"..GP_id}
		},
		{
			{text = "> Mute Inline", callback_data='keanee'}, 
			{text = mute_inline, callback_data="/muteinline:"..GP_id}
		},
		{
			{text = "> Mute Game", callback_data='keanee'}, 
			{text = mute_game, callback_data="/mutegame:"..GP_id}
		},
		{
			{text = "> Mute Photo", callback_data='keanee'}, 
			{text = mute_photo, callback_data="/mutephoto:"..GP_id}
		},
		{
			{text = "> Mute Video", callback_data='keanee'}, 
			{text = mute_video, callback_data="/mutevideo:"..GP_id}
		},
		{
			{text = "> Mute Audio", callback_data='keanee'}, 
			{text = mute_audio, callback_data="/muteaudio:"..GP_id}
		},
		{
			{text = "> Mute Voice", callback_data='keanee'}, 
			{text = mute_voice, callback_data="/mutevoice:"..GP_id}
		},
		{
			{text = "> Mute Sticker", callback_data='keanee'}, 
			{text = mute_sticker, callback_data="/mutesticker:"..GP_id}
		},
		{
			{text = "> Mute Contact", callback_data='keanee'}, 
			{text = mute_contact, callback_data="/mutecontact:"..GP_id}
		},
		{
			{text = "> Mute Forward", callback_data='keanee'}, 
			{text = mute_forward, callback_data="/muteforward:"..GP_id}
		},
		{
			{text = "> Mute Location", callback_data='keanee'}, 
			{text = mute_location, callback_data="/mutelocation:"..GP_id}
		},
		{
			{text = "> Mute Document", callback_data='keanee'}, 
			{text = mute_document, callback_data="/mutedocument:"..GP_id}
		},
		{
			{text = "> Mute TgService", callback_data='keanee'}, 
			{text = mute_tgservice, callback_data="/mutetgservice:"..GP_id}
		},
		{
			{text = "> Mute Keyboard", callback_data='keanee'}, 
			{text = mute_keyboard, callback_data="/mutekeyboard:"..GP_id}
		},
		{
			{text = '> Back ', callback_data = '/option:'..GP_id}
		}				
	}
   elseif lang then
	 text = '_اهلا بيك في قائمه المكتومين_'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> قفل الكل", callback_data='keanee'}, 
			{text = mute_all, callback_data="/muteall:"..GP_id}
		},
		{
			{text = "> قفل المتحركه", callback_data='keanee'}, 
			{text = mute_gif, callback_data="/mutegif:"..GP_id}
		},
		{
			{text = "> قفل الدردشه", callback_data='keanee'}, 
			{text = mute_text, callback_data="/mutetext:"..GP_id}
		},
		{
			{text = "> قفل الانلاين", callback_data='keanee'}, 
			{text = mute_inline, callback_data="/muteinline:"..GP_id}
		},
		{
			{text = "> قفل الاالعاب", callback_data='keanee'}, 
			{text = mute_game, callback_data="/mutegame:"..GP_id}
		},
		{
			{text = "> قفل الصور", callback_data='keanee'}, 
			{text = mute_photo, callback_data="/mutephoto:"..GP_id}
		},
		{
			{text = "> قفل الفيديو", callback_data='keanee'}, 
			{text = mute_video, callback_data="/mutevideo:"..GP_id}
		},
		{
			{text = "> قفل الموسيقب", callback_data='keanee'}, 
			{text = mute_audio, callback_data="/muteaudio:"..GP_id}
		},
		{
			{text = "> قفل الصوت", callback_data='keanee'}, 
			{text = mute_voice, callback_data="/mutevoice:"..GP_id}
		},
		{
			{text = "> قفل الملصقات", callback_data='keanee'}, 
			{text = mute_sticker, callback_data="/mutesticker:"..GP_id}
		},
		{
			{text = "> قفل الجهات", callback_data='keanee'}, 
			{text = mute_contact, callback_data="/mutecontact:"..GP_id}
		},
		{
			{text = "> قفل الحركات", callback_data='keanee'}, 
			{text = mutes.mute_forward, callback_data="/muteforward:"..GP_id}
		},
		{
			{text = "> قفل المكان", callback_data='keanee'}, 
			{text = mute_location, callback_data="/mutelocation:"..GP_id}
		},
		{
			{text = "> قفل الملفات", callback_data='keanee'}, 
			{text = mute_document, callback_data="/mutedocument:"..GP_id}
		},
		{
			{text = "> قفل الخدمات", callback_data='keanee'}, 
			{text = mute_tgservice, callback_data="/mutetgservice:"..GP_id}
		},
		{
			{text = "> قفل الكيبورد", callback_data='keanee'}, 
			{text = mute_keyboard, callback_data="/mutekeyboard:"..GP_id}
		},
		{
			{text = '> رجوع ', callback_data = '/option:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
--------------Begin Msg Matches---------------
	if matches[1] == "sudolist" and is_sudo(msg) then
		return sudolist(msg)
	end
	if tonumber(msg.from.id) == sudo_id then
		if matches[1]:lower() == "setsudo" then
			if matches[2] and not msg.reply_to_message then
				local user_id = matches[2]
				if already_sudo(tonumber(user_id)) then
					return 'User '..user_id..' is already sudo users'
				else
					table.insert(_config.sudo_users, tonumber(user_id)) 
					print(user_id..' added to sudo users') 
					save_config() 
					reload_plugins(true) 
					return "User "..user_id.." added to sudo users" 
				end
		elseif not matches[2] and msg.reply_to_message then
			local user_id = msg.reply_to_message.from.id
			if already_sudo(tonumber(user_id)) then
				return 'User '..user_id..' is already sudo users'
			else
				table.insert(_config.sudo_users, tonumber(user_id)) 
				print(user_id..' added to sudo users') 
				save_config() 
				reload_plugins(true) 
				return "User "..user_id.." added to sudo users" 
			end
		end
	end
	if matches[1]:lower() == "remsudo" then
	if matches[2] and not msg.reply_to_message then
		local user_id = tonumber(matches[2]) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	elseif not matches[2] and msg.reply_to_message then
		local user_id = tonumber(msg.reply_to_message.from.id) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	end
	end
	end
--------------End Msg Matches---------------

--------------Begin Inline Query---------------
if msg.query and msg.query:match("-%d+") and is_sudo(msg) then
	local chatid = "-"..msg.query:match("%d+")
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = ' Go To Group Option ', callback_data = '/lang:'..chatid}
		},
		{
			{text= 'Exit' ,callback_data = '/exit:'..chatid}
		}					
	}
	send_inline(msg.id,'settings','Group Option','Tap Here','Please select an option.!',keyboard)
end
if msg.cb then
local hash = "gp_lang:"..matches[2]
local lang = redis:get(hash) 
	if matches[1] == '/lang' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
    elseif not data[tostring(matches[2])] then
     if not lang then
		edit_inline(msg.message_id, "`Group Is Not Added`")
   elseif lang then
		edit_inline(msg.message_id, "_تم اضافه الكروب لقائمه كروبات البوت_")
   end
	else
	local text = '_Please Select An_ *Language*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> English", callback_data="/english:"..matches[2]},
			{text = '> فارسی ', callback_data = '/persian:'..matches[2]}
		},
		{
			{text= '> Exit' ,callback_data = '/exit:'..matches[2]}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
	end
end
	if matches[1] == '/english' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
    redis:del(hash)
   sleep(1)
	options(msg, matches[2])
	end
end
	if matches[1] == '/persian' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
    redis:set(hash, true)
   sleep(1)
	options(msg, matches[2])
	end
end
	if matches[1] == '/option' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
	options(msg, matches[2])
	end
end
if matches[1] == '/settings' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutelist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/moresettings' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		moresetting(msg, data, matches[2])
	end
end

          -- ####################### Settings ####################### --
if matches[1] == '/locklink' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local locklink = data[tostring(matches[2])]["settings"]["lock_link"]
		if locklink == "no" then
   if not lang then
			text = 'Link Has Been Locked'
   elseif lang then
			text = 'تم قفل الروابط'
    end
			data[tostring(matches[2])]["settings"]["lock_link"] = "yes"
			save_data(_config.moderation.data, data)
		elseif locklink == "yes" then
   if not lang then
			text = 'Link Has Been Unlocked'
   elseif lang then
			text = 'تم فتح الروابط'
    end
			data[tostring(matches[2])]["settings"]["lock_link"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockedit' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local lockedit = data[tostring(matches[2])]["settings"]["lock_edit"]
		if lockedit == "no" then
   if not lang then
			text = 'Edit Has Been Locked'
   elseif lang then
			text = 'تم قفل التعديل'
    end
			data[tostring(matches[2])]["settings"]["lock_edit"] = "yes"
			save_data(_config.moderation.data, data)
		elseif lockedit == "yes" then
   if not lang then
			text = 'Edit Has Been Unlocked'
   elseif lang then
			text = 'تم فتح التعديل'
    end
			data[tostring(matches[2])]["settings"]["lock_edit"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locktags' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_tag"]
		if chklock == "no" then
   if not lang then
			text = 'Tags Has Been Locked'
   elseif lang then
			text = 'انت ليس ادمن في البوت'
    end
            data[tostring(matches[2])]["settings"]["lock_tag"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Tags Has Been Unlocked'
   elseif lang then
			text = 'تم فتح التاك'
    end
			data[tostring(matches[2])]["settings"]["lock_tag"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockjoin' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_join"]
		if chklock == "no" then
   if not lang then
			text = 'Join Has Been Locked'
   elseif lang then
			text = 'تم قفل الاشعاات'
    end
            data[tostring(matches[2])]["settings"]["lock_join"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Join Has Been Unlocked'
   elseif lang then
			text = 'تم فتح الاشعارات'
    end
			data[tostring(matches[2])]["settings"]["lock_join"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockflood' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["flood"]
		if chklock == "no" then
   if not lang then
			text = 'Flood Has Been Locked'
   elseif lang then
			text = 'تم قفل التكرار'
    end
            data[tostring(matches[2])]["settings"]["flood"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Flood Has Been Unlocked'
   elseif lang then
			text = 'تم فتح التكرار'
    end
			data[tostring(matches[2])]["settings"]["flood"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockspam' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_spam"]
		if chklock == "no" then
   if not lang then
			text = 'Spam Has Been Locked'
   elseif lang then
			text = 'تم قفل المواقع'
    end
            data[tostring(matches[2])]["settings"]["lock_spam"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Spam Has Been Unlocked'
   elseif lang then
			text = 'تم فتح المواقع'
    end
			data[tostring(matches[2])]["settings"]["lock_spam"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmention' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_mention"]
		if chklock == "no" then
   if not lang then
			text = 'Mention Has Been Locked'
   elseif lang then
			text = 'تم قفل الشبكات'
    end
            data[tostring(matches[2])]["settings"]["lock_mention"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Mention Has Been Unlocked'
   elseif lang then
			text = 'تم فتح الشبكات'
    end
			data[tostring(matches[2])]["settings"]["lock_mention"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockarabic' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_arabic"]
		if chklock == "no" then
   if not lang then
			text = 'Arabic Has Been Locked'
   elseif lang then
			text = 'تم قفل العربيه'
    end
            data[tostring(matches[2])]["settings"]["lock_arabic"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Arabic Has Been Unlocked'
   elseif lang then
			text = 'تم فتح العربيه'
    end
			data[tostring(matches[2])]["settings"]["lock_arabic"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockwebpage' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_webpage"]
		if chklock == "no" then
   if not lang then
			text = 'Webpage Has Been Locked'
   elseif lang then
			text = 'تم قفل صفحات الوب'
    end
            data[tostring(matches[2])]["settings"]["lock_webpage"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Webpage Has Been Unlocked'
   elseif lang then
			text = 'تم فتح صفحات الوب'
    end
			data[tostring(matches[2])]["settings"]["lock_webpage"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmarkdown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_markdown"]
		if chklock == "no" then
   if not lang then
			text = 'Markdown Has Been Locked'
   elseif lang then
			text = 'تم قفل الزخرفه'
    end
            data[tostring(matches[2])]["settings"]["lock_markdown"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Markdown Has Been Unlocked'
   elseif lang then
			text = 'تم فتح الزخرفه'
    end
			data[tostring(matches[2])]["settings"]["lock_markdown"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockpin' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_pin"]
		if chklock == "no" then
   if not lang then
			text = 'Pin Has Been Locked'
   elseif lang then
			text = 'تم قفل التثبيت'
    end
            data[tostring(matches[2])]["settings"]["lock_pin"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Pin Has Been Unlocked'
   elseif lang then
			text = 'تم فتح التثبيت'
    end
			data[tostring(matches[2])]["settings"]["lock_pin"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockbots' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_bots"]
		if chklock == "no" then
   if not lang then
			text = 'Bots Has Been Locked'
   elseif lang then
			text = 'تم قفل البوتات'
    end
            data[tostring(matches[2])]["settings"]["lock_bots"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Bots Has Been Unlocked'
   elseif lang then
			text = 'تم فتح البوتات'
    end
			data[tostring(matches[2])]["settings"]["lock_bots"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/welcome' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["welcome"]
		if chklock == "no" then
   if not lang then
			text = 'Welcome Has Been Enabled'
   elseif lang then
			text = 'تم تفعيل الترحيب'
    end
            data[tostring(matches[2])]["settings"]["welcome"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = 'Welcome Has Been Disabled'
   elseif lang then
			text = 'تم تعطيل الترحيب'
    end
			data[tostring(matches[2])]["settings"]["welcome"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/floodup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) < 30 then
			flood_max = tonumber(flood_max) + 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Sensitivity Has Been Set To : "..flood_max
   elseif lang then
			text = "تم تفعيل حساسيت التكرار : "..flood_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/flooddown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) > 2 then
			flood_max = tonumber(flood_max) - 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Sensitivity Has Been Set To : "..flood_max
   elseif lang then
			text = "تم تفعيل حساسيت التكرار : "..flood_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/charup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) < 1000 then
			char_max = tonumber(char_max) + 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Character Sensitivity Has Been Set To : "..char_max
   elseif lang then
			text = "تم تفعيل حساسيت الكلمات الممنوعه : "..char_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/chardown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) > 2 then
			char_max = tonumber(char_max) - 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Character Sensitivity Has Been Set To : "..char_max
   elseif lang then
			text = "تم تفعيل حساسيت الكلمات الممنوعه : "..char_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimeup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) < 10 then
			check_time = tonumber(check_time) + 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Check Time Has Been Set To : "..check_time
   elseif lang then
			text = "تم تفعيل حساسيت الرسايل المكرره : "..check_time
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimedown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) > 2 then
			check_time = tonumber(check_time) - 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
   if not lang then
			text = "Flood Check Time Has Been Set To : "..check_time
   elseif lang then
			text = "تم تفعيل حساسيت الرسايل المكرره : "..check_time
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end

			-- ###################### Mute ###################### --
			
if matches[1] == '/muteall' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_all"]
		if chkmute == "no" then
    if not lang then
			text = 'All Has Been Muted'
    elseif lang then
        text = 'تم قفل الدردشه'
    end
            data[tostring(matches[2])]["mutes"]["mute_all"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'All Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الدردشه'
    end
			data[tostring(matches[2])]["mutes"]["mute_all"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutegif' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_gif"]
		if chkmute == "no" then
    if not lang then
			text = 'Gifs Has Been Muted'
    elseif lang then
        text = 'تم قفل الصور'
    end
            data[tostring(matches[2])]["mutes"]["mute_gif"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Gifs Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الصور'
    end
			data[tostring(matches[2])]["mutes"]["mute_gif"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetext' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_text"]
		if chkmute == "no" then
    if not lang then
			text = 'Text Has Been Muted'
    elseif lang then
        text = 'تم قفل الدردشه'
    end
            data[tostring(matches[2])]["mutes"]["mute_text"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Text Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الدردشه'
    end
			data[tostring(matches[2])]["mutes"]["mute_text"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteinline' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_inline"]
		if chkmute == "no" then
    if not lang then
			text = 'Inline Has Been Muted'
    elseif lang then
        text = 'ﭨم قفل الانلاين'
    end
            data[tostring(matches[2])]["mutes"]["mute_inline"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Inline Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الانلاين'
    end
			data[tostring(matches[2])]["mutes"]["mute_inline"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutegame' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_game"]
		if chkmute == "no" then
    if not lang then
			text = 'Game Has Been Muted'
    elseif lang then
        text = 'تم قفل الاالعاب'
    end
            data[tostring(matches[2])]["mutes"]["mute_game"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Game Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الاالعاب'
    end
			data[tostring(matches[2])]["mutes"]["mute_game"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutephoto' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_photo"]
		if chkmute == "no" then
    if not lang then
			text = 'Photo Has Been Muted'
    elseif lang then
        text = 'تم قفل الصور'
    end
            data[tostring(matches[2])]["mutes"]["mute_photo"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Photo Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الصور'
    end
			data[tostring(matches[2])]["mutes"]["mute_photo"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideo' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_video"]
		if chkmute == "no" then
    if not lang then
			text = 'Video Has Been Muted'
    elseif lang then
        text = 'تم قفل الفيديو'
    end
            data[tostring(matches[2])]["mutes"]["mute_video"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Video Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الفيديو'
    end
			data[tostring(matches[2])]["mutes"]["mute_video"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteaudio' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_audio"]
		if chkmute == "no" then
    if not lang then
			text = 'Audio Has Been Muted'
    elseif lang then
        text = 'تم قفل الموسيقي'
    end
            data[tostring(matches[2])]["mutes"]["mute_audio"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Audio Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الموسيقى'
    end
			data[tostring(matches[2])]["mutes"]["mute_audio"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevoice' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_voice"]
		if chkmute == "no" then
    if not lang then
			text = 'Voice Has Been Muted'
    elseif lang then
        text = 'تم قفل الصوت'
    end
            data[tostring(matches[2])]["mutes"]["mute_voice"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Voice Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الصوت'
    end
			data[tostring(matches[2])]["mutes"]["mute_voice"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutesticker' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_sticker"]
		if chkmute == "no" then
    if not lang then
			text = 'Sticker Has Been Muted'
    elseif lang then
        text = 'تم قفل الملصقات'
    end
            data[tostring(matches[2])]["mutes"]["mute_sticker"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Sticker Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الملصقات'
    end
			data[tostring(matches[2])]["mutes"]["mute_sticker"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutecontact' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_contact"]
		if chkmute == "no" then
    if not lang then
			text = 'Contact Has Been Muted'
    elseif lang then
        text = 'تم قفل الجهات'
    end
            data[tostring(matches[2])]["mutes"]["mute_contact"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Contact Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الجهات'
    end
			data[tostring(matches[2])]["mutes"]["mute_contact"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteforward' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_forward"]
		if chkmute == "no" then
    if not lang then
			text = 'Forward Has Been Muted'
    elseif lang then
        text = 'تم قفل الحركات'
    end
            data[tostring(matches[2])]["mutes"]["mute_forward"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Forward Has Been Unmuted'
    elseif lang then
        text = 'تم قفل الحركات'
    end
			data[tostring(matches[2])]["mutes"]["mute_forward"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutelocation' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_location"]
		if chkmute == "no" then
    if not lang then
			text = 'Location Has Been Muted'
    elseif lang then
        text = 'تم قفل المكان'
    end
            data[tostring(matches[2])]["mutes"]["mute_location"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Location Has Been Unmuted'
    elseif lang then
        text = 'تم فتح المكان'
    end
			data[tostring(matches[2])]["mutes"]["mute_location"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutedocument' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_document"]
		if chkmute == "no" then
    if not lang then
			text = 'Document Has Been Muted'
    elseif lang then
        text = 'قفل الملصقات'
    end
            data[tostring(matches[2])]["mutes"]["mute_document"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Document Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الملصقات'
    end
			data[tostring(matches[2])]["mutes"]["mute_document"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetgservice' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_tgservice"]
		if chkmute == "no" then
    if not lang then
			text = 'TgService Has Been Muted'
    elseif lang then
        text = 'تم قفل الخدمات'
    end
            data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'TgService Has Been Unmuted'
    elseif lang then
        text = 'تم فتح الخدمات'
    end
			data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutekeyboard' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_keyboard"]
		if chkmute == "no" then
    if not lang then
			text = 'Keyboard Has Been Muted'
    elseif lang then
        text = 'تم قفل كيبورد الشفاف'
    end
            data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = 'Keyboard Has Been uted'
    elseif lang then
        text = 'تم فتح يبورد الشفاف'
    end
			data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end

            -- ####################### More #######################--
			
if matches[1] == '/more' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
    if not lang then
		local text = 'Welcome To More Option'
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> OwnerList", callback_data="/ownerlist:"..matches[2]},
				{text = "> ModList", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = "> SillentList", callback_data="/silentlist:"..matches[2]},
				{text = "> FilterList", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "> BanList", callback_data="/bans:"..matches[2]},
				{text = "> WhiteList", callback_data="/whitelists:"..matches[2]}
        },
			{
				{text = "> Group Link", callback_data="/link:"..matches[2]},
				{text = "> Group Rules", callback_data="/rules:"..matches[2]}
			},
			{
				{text = "> Show Welcome", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = "> Back To Option", callback_data="/option:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> قائمه المنشئين", callback_data="/ownerlist:"..matches[2]},
				{text = "> قائمه المدراء", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = "> قائمه المكتومين", callback_data="/silentlist:"..matches[2]},
				{text = "> قائمه المنع", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "> قائمه المحظورين", callback_data="/bans:"..matches[2]},
				{text = "> قائمه المميزين", callback_data="/whitelists:"..matches[2]}
        },
			{
				{text = "> الرابط", callback_data="/link:"..matches[2]},
				{text = "> القوانين", callback_data="/rules:"..matches[2]}
			},
			{
				{text = "> رساله الترحيب", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = "> رجوع لل اوامر", callback_data="/option:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/ownerlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['owners']) == nil then --fix way
     if not lang then
			text = "_No_ *owner* _in this group_"
   elseif lang then
			text = "_المنشئ ليس موجود في قائمه المنشئين_"
   end
		else
     if not lang then
			text = "*List Of Group Owners :*\n"
   elseif lang then
			text = "_قائمه المنشئن :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
     if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Demote All Owners", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> مسح المنشئين", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanowners' then
	if not is_admin1(msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Bot Admin")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		if next(data[tostring(matches[2])]['owners']) == nil then
     if not lang then
			text = "_No_ *owner* _in this group_"
   elseif lang then
			text = "_المنشئ ليس موجود في قائمه المنشئين_"
   end
		else
     if not lang then
			text = "_All_ *Group Owners* _Has Been_ *Demoted*"
   elseif lang then
			text = "_تم مسح المنشئين_"
   end
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				data[tostring(matches[2])]['owners'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
    if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/ownerlist:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> رجوع", callback_data="/ownerlist:"..matches[2]}
			}
		}
   end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/filterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت لست ادمن في البوت")
   end
	else
		if next(data[tostring(matches[2])]['filterlist']) == nil then --fix way
   if not lang then
			text = "*Filter List* _Is Empty_"
     elseif lang then
			text = "_قائمه المنع فارقه_"
     end
		else 
			local i = 1
   if not lang then
			text = '*List Of Filtered Words List :*\n'
     elseif lang then
			text = '_قائمه كلمات الممنوعه :_\n'
    end
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				text = text..''..i..' - '..check_markdown(k)..'\n'
				i = i + 1
			end
		end
    if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Clean", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> تنظيف", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanfilterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت لست ادمن في البوت")
   end
	else
		if next(data[tostring(matches[2])]['filterlist']) == nil then
   if not lang then
			text = "*Filter List* _Is Empty_"
     elseif lang then
			text = "_قائمه المنع فارقه_"
     end
		else
   if not lang then
			text = "*Filter List* _Has Been_ *Cleaned*"
     elseif lang then
			text = "_لیست کلمات فیلتر پاک شد_"
     end
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				data[tostring(matches[2])]['filterlist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/filterlist:"..matches[2]}
			}
		}
     elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> رجوع", callback_data="/filterlist:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/modlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['mods']) == nil then --fix way
     if not lang then
			text = "_No_ *moderator* _in this group_"
   elseif lang then
			text = "_لا يوجد ادمن معين للكروب_"
   end
		else
     if not lang then
			text = "*List Of Moderators :*\n"
   elseif lang then
			text = "_قائمه المدرا :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
     if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Demote All Moderators", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> مسح المدرا۽", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanmods' then
	if not is_owner1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Group Owner")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس منشئ")
   end
	else
		if next(data[tostring(matches[2])]['mods']) == nil then
     if not lang then
			text = "_No_ *moderator* _in this group_"
   elseif lang then
			text = "_لا يوجد مدير معين للكروب_"
   end
		else
     if not lang then
			text = "_All_ *Moderators* _Has Been_ *Demoted*"
   elseif lang then
			text = "_تم مسح قائمه المدراء_"
   end
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				data[tostring(matches[2])]['mods'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/modlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/bans' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['banned']) == nil then --fix way
     if not lang then
			text = "_No_ *banned users* _in this group_"
   elseif lang then
			text = "_قائمه المحظورين فارقه_"
   end
		else
     if not lang then
			text = "*List Of Banned Users :*\n"
   elseif lang then
			text = "_قائمه المحظورين :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Unban All Banned Users", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> مسح المحظورين ", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/silentlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then --fix way
     if not lang then
			text = "_No_ *silent users* _in this group_"
   elseif lang then
			text = "_قائمه المكتومين فارقه_"
   end
		else
     if not lang then
			text = "*List Of Silent Users :*\n"
   elseif lang then
			text = "_لیست افراد سایلنت شده :_\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Unsilent All Silent Users", callback_data="/cleansilentlist:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> مسح المكتومين", callback_data="/cleansilentlist:"..matches[2]}
			},
			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleansilentlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then
     if not lang then
			text = "_No_ *silent users* _in this group_"
   elseif lang then
			text = "_لا يوجد مكتوم في الكروب"
   end
		else
     if not lang then
			text = "_All_ *Silent Users* _Has Been_ *Unsilent*"
   elseif lang then
			text = "_تم مسح قائمه الكتم_"
   end
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				data[tostring(matches[2])]['is_silent_users'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/silentlist:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> رجوع", callback_data="/silentlist:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanbans' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		if next(data[tostring(matches[2])]['banned']) == nil then
     if not lang then
			text = "_No_ *banned users* _in this group_"
   elseif lang then
			text = "_قائمه المحظورين فارقه"
   end
		else
     if not lang then
			text = "_All_ *Banned Users* _Has Been_ *Unbanned*"
   elseif lang then
			text = "_تم مسح قائمه الحظر_"
   end
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				data[tostring(matches[2])]['banned'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/bans:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> روجوع", callback_data="/bans:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/link' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local linkgp = data[tostring(matches[2])]['settings']['linkgp']
		if not linkgp then
   if not lang then
			text = "_First set a_ *link* _for group with using_ /setlink"
    elseif lang then
			text = "_حاول مع امر_ setlink/ _لا يوجد رابط_"
  end
		else
   if not lang then
			text = "[Group Link Is Here]("..linkgp..")"
    elseif lang then
			text = "[رابط الكروب]("..linkgp..")"
        end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/rules' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
   if not lang then
     text = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@keanee"
    elseif lang then
    text = "ℹ️ قوانين المحفوظه:\n1️⃣ التكرار ممنوع.\n2️⃣اسبام ممنوع.\n3️⃣ تبلیغ ممنوع.\n4⃣حاول الخروج من موضوع المزعج .\n5️⃣ الفشار ممنوع, خ الطائفيه ممنوع .\n➡️  اتبع قوانين المجموعه غير ذالك نقوم بحظرك من المجموعه قوانین  .\n@XXF1XX"
 end
		elseif rules then
     if not lang then
			text = '*Group Rules :*\n'..rules
   elseif lang then
			text = '_قوانین گروه :_\n'..rules
       end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Clean", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> مسح", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanrules' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
    if not lang then
			text = "`No Rules Available`"
   elseif lang then
			text = "_القوانين ليس مثبته_"
   end
		else
    if not lang then
			text = "*Group Rules* _Has Been_ *Cleaned*"
   elseif lang then
			text = "_تم مسح القوانين_"
  end
			data[tostring(matches[2])]['rules'] = nil
			save_data(_config.moderation.data, data)
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/rules:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> رجوع", callback_data="/rules:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
		if matches[1] == '/whitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
			if not lang then
				text = "_White List is Empty._"
			else
				text = "_قائمه المميزين فارقه._"
			end
		else 
			local i = 1
			if not lang then
				text = '_> White List:_ \n'
			else
				text = '_> المميزين:_ \n'
			end
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				text = text..''..i..' - '..check_markdown(v)..' ' ..k.. ' \n'
				i = i + 1
			end
		end
		local keyboard = {}
		if not lang then
		keyboard.inline_keyboard = {
			{
				{text = "> Clean White List", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
		else
		keyboard.inline_keyboard = {
			{
				{text = "> مسح المميزين", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end

if matches[1] == '/cleanwhitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
			if not lang then
				text = "_White List is Empty._"
			else
				text = "_قائمه المميزين فارقه._"
			end
		else
			if not lang then
				text = "_White List Was Cleared._"
			else
				text = "_تم مسح قائمه المميزين._"
			end
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				data[tostring(matches[2])]['whitelist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {

			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
		else
				keyboard.inline_keyboard = {

			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
		end
end
if matches[1] == '/showwlc' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
		local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
		if not lang then
				text = "_Welcome Message Not Set._\n*Default Message :* _Welcome Dude_"
			else
				text = "_الترحيب لا يوجد._"
			end
		else
		if not lang then
			text = '_Welcome Message:_\n'..wlc
		else
			text = '_الترحيب:_\n'..wlc
		end
		end
		local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {
			{ 
				{text = "> Clean Welcome Message", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
		else
		keyboard.inline_keyboard = {
			{ 
				{text = "> مسح الترحیب", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/cleanwlcmsg' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
		if not lang then
				text = "_Welcome Message Not Set._"
			else
				text = "_الترحيب لا يوجد._"
			end
		else
		if not lang then
			text = '_Welcome Message Was Cleaned._'
		else
			text = '_تم مسح الترحیب._'
		end
		data[tostring(matches[2])]['setwelcome'] = nil
		save_data(_config.moderation.data, data)
end
local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {

			{ 
				{text = "> Back", callback_data="/more:"..matches[2]}
			}
		}
		else
				keyboard.inline_keyboard = {

			{ 
				{text = "> رجوع", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end
         -- ####################### About Us ####################### --
if matches[1] == '/beyond' then
	local text = _config.info_text
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> KE_NAE", callback_data="/KE_NAE:"..matches[2]}, 
			{text = "> ToOfan", callback_data="/toofan:"..matches[2]}
		},
		{
			{text = '> Our GitHub ', url = 'https://www.github.com/keanee'}
		},
		{
			{text= '> Back' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "> سعید", callback_data="/KE_NAE:"..matches[2]}, 
			{text = "> طوفان", callback_data="/toofan:"..matches[2]}
		},
		{
			{text = '> گیت هاب تیم ', url = 'https://www.github.com/keanee'}
		},
		{
			{text= '> رجوع' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

if matches[1] == '/KE_NAE' then
local text = [[*》KE_NAE Information《*
_》Age :_ *26*
_》Name :_ *Saeid Rostami*
_》City :_ *Shahriar - Tehran*
*-------------------------*
*》GitHub :《*
》[KE_NAE](Github.Com/KE_NAE)
*-------------------------*
*》Bridges :《*
_》Pv : _[@KE_NAE](Telegram.Me/KE_NAE)
_》PvResan : _[@KE_NAE Pv](Telegram.Me/KE_NAEPv_Bot)
*-------------------------*
*》Expertise :《*
_》_*Lua*, *Cli* `and` *Api* _Bots_
*-------------------------*]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/beyond:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> رجوع", callback_data="/beyond:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/toofan' then
local text = [[*》ToOfan Information《*
_》Age :_ *35*
_》Name :_ *Ali AzizAbadi*
_》City :_ *Bam - Kerman*
*-------------------------*
*》GitHub :《*
》[To0fan](GitHub.Com/To0fan)
*-------------------------*
*》Bridges :《*
_》Pv :_ [@ToOfan](Telegram.Me/ToOfan)
_》PvResan :_ [@ToOfanRobot](Telegram.Me/ToOfanRobot)
*-------------------------*
*》Expertise :《*
*》C#, Lua, VB.Net, JAVA*

*-------------------------*]]
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> Back", callback_data="/beyond:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "> رجوع", callback_data="/beyond:"..matches[2]}
			}
		}
  end
    edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/exit' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "انت ليس ادمن في البوت")
   end
	else
    if not lang then
		 text = '*Group Option Closed*'
   elseif lang then
		 text = '_تم تعطيل الاعدادات_'
   end
		edit_inline(msg.message_id, text)
	end
end

end
--------------End Inline Query---------------
end

local function pre_process(msg)
-- print(serpent.block(msg), {comment=false})
--leave_group(msg.chat.id)
end

return {
	patterns ={
		"^-(%d+)$",
		"^###cb:(%d+)$",
		"^[/](sudolist)$",
		"^[/](setsudo)$",
		"^[/](remsudo)$",
		"^[/](setsudo) (%d+)$",
		"^[/](remsudo) (%d+)$",
		"^###cb:(/option):(.*)$",
		"^###cb:(/lang):(.*)$",
		"^###cb:(/persian):(.*)$",
		"^###cb:(/english):(.*)$",
		"^###cb:(/settings):(.*)$",
		"^###cb:(/mutelist):(.*)$",
		"^###cb:(/locklink):(.*)$",
		"^###cb:(/lockedit):(.*)$",
		"^###cb:(/locktags):(.*)$",
		"^###cb:(/lockjoin):(.*)$",
		"^###cb:(/lockpin):(.*)$",
		"^###cb:(/lockmarkdown):(.*)$",
		"^###cb:(/lockmention):(.*)$",
		"^###cb:(/lockarabic):(.*)$",
		"^###cb:(/lockwebpage):(.*)$",
		"^###cb:(/lockbots):(.*)$",
		"^###cb:(/lockspam):(.*)$",
		"^###cb:(/lockflood):(.*)$",
		"^###cb:(/welcome):(.*)$",
		"^###cb:(/muteall):(.*)$",
		"^###cb:(/mutegif):(.*)$",
		"^###cb:(/mutegame):(.*)$",
		"^###cb:(/mutevideo):(.*)$",
		"^###cb:(/mutevoice):(.*)$",
		"^###cb:(/muteinline):(.*)$",
		"^###cb:(/mutesticker):(.*)$",
		"^###cb:(/mutelocation):(.*)$",
		"^###cb:(/mutedocument):(.*)$",
		"^###cb:(/muteaudio):(.*)$",
		"^###cb:(/mutephoto):(.*)$",
		"^###cb:(/mutetext):(.*)$",
		"^###cb:(/mutetgservice):(.*)$",
		"^###cb:(/mutekeyboard):(.*)$",
		"^###cb:(/mutecontact):(.*)$",
		"^###cb:(/muteforward):(.*)$",
		"^###cb:(/toofan):(.*)$",
		"^###cb:(/setflood):(.*)$",
		"^###cb:(/floodup):(.*)$",
		"^###cb:(/flooddown):(.*)$",
		"^###cb:(/charup):(.*)$",
		"^###cb:(/chardown):(.*)$",
		"^###cb:(/floodtimeup):(.*)$",
		"^###cb:(/floodtimedown):(.*)$",
		"^###cb:(/moresettings):(.*)$",
		"^###cb:(/more):(.*)$",
		"^###cb:(/ownerlist):(.*)$",
		"^###cb:(/cleanowners):(.*)$",
		"^###cb:(/modlist):(.*)$",
		"^###cb:(/cleanmods):(.*)$",
		"^###cb:(/bans):(.*)$",
		"^###cb:(/beyond):(.*)$",
		"^###cb:(/cleanbans):(.*)$",
		"^###cb:(/filterlist):(.*)$",
		"^###cb:(/cleanfilterlist):(.*)$",
		"^###cb:(/whitelist):(.*)$",
		"^###cb:(/cleanwhitelist):(.*)$",
		"^###cb:(/silentlist):(.*)$",
		"^###cb:(/KE_NAE):(.*)$",
		"^###cb:(/cleansilentlist):(.*)$",
		"^###cb:(/link):(.*)$",
		"^###cb:(/rules):(.*)$",
		"^###cb:(/cleanrules):(.*)$",
		"^###cb:(/exit):(.*)$",
		"^###cb:(/whitelists):(.*)$",
		"^###cb:(/cleanwhitelists):(.*)$",
		"^###cb:(/showwlc):(.*)$",
		"^###cb:(/cleanwlcmsg):(.*)$",

	},
	run=run,
	pre_process=pre_process
