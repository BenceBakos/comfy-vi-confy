Terminal = require("utils.terminal")
Keyboard = require("utils.keyborad")
Table = require("utils.table")
Tui = require("utils.tui")

Abz = {}

Abz.init = function()

end

Abz.maps = {
	{
		mode = 'n',
		map = 'ű',
		to = function()
			Tui.table(function(path)
				if #path == 0 then return Abz.exampleTable end

				local value = Table.traversePath(Abz.exampleTable, path)

				if type(value) == 'string' then
					return nil
				end

				return value
			end)
		end,
		options = false
	}
}

Abz.autocmds = {

}

Abz.commands = {
}

Abz.exampleTable = {
	home = {
		user1 = {
			documents = {
				resume = "resume.pdf",
				cover_letter = "cover_letter.docx",
				notes = {
					meeting_notes = "meeting_notes.txt",
					project_notes = "project_notes.txt"
				}
			},
			downloads = {
				file1 = "file1.zip",
				file2 = "file2.iso"
			},
			pictures = {
				vacation = {
					photo1 = "beach.png",
					photo2 = "mountain.png"
				},
				profile_picture = "profile.jpg"
			}
		},
		user2 = {
			documents = {
				report = "report.docx",
				thesis = "thesis.pdf"
			},
			music = {
				song1 = "song1.mp3",
				song2 = "song2.mp3"
			}
		}
	},
	var = {
		log = {
			system_log = "syslog.log",
			error_log = "error.log"
		},
		tmp = {
			temp_file1 = "temp1.tmp",
			temp_file2 = "temp2.tmp"
		}
	},
	etc = {
		config = {
			nginx = "nginx.conf",
			php = "php.ini"
		},
		hosts = "hosts"
	}
}

return Abz
