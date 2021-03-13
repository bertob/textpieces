namespace Textpieces {
    // Define type of tool function
    delegate string? ToolFunc(string input, string[] args = {}, ref string? err);

    struct Tool {
        public string name;
        public string icon;
        public ToolFunc func;
        public string[] args;
    }

    Tool[] get_tools () {
        return {
            Tool () {
                name = "Hash - SHA1",
                icon = "fingerprint2-symbolic",
                func = (s) => Checksum.compute_for_string (ChecksumType.SHA1, s)
            },
            Tool () {
                name = "Hash - SHA256",
                icon = "fingerprint2-symbolic",
                func = (s) => Checksum.compute_for_string (ChecksumType.SHA256, s)
            },
            Tool () {
                name = "Hash - SHA384",
                icon = "fingerprint2-symbolic",
                func = (s) => Checksum.compute_for_string (ChecksumType.SHA384, s)
            },
            Tool () {
                name = "Hash - SHA512",
                icon = "fingerprint2-symbolic",
                func = (s) => Checksum.compute_for_string (ChecksumType.SHA512, s)
            },
            Tool () {
                name = "Hash - MD5",
                icon = "fingerprint2-symbolic",
                func = (s) => Checksum.compute_for_string (ChecksumType.MD5, s)
            },
            Tool () {
                name = "Base64 - Encode",
                icon = "size-right-symbolic",
                func = (s) => Base64.encode (s.data)
            },
            Tool () {
                name = "Base64 - Decode",
                icon = "size-left-symbolic",
                func = (s) => (string) Base64.decode (s)
            },
            Tool () {
                name = "Replace - Substring",
                icon = "edit-find-replace-symbolic",
                func = (s, args) => {
                    return s.replace (args[0], args[1]);
                },
                args = {"Find", "Replace"}
            },
            Tool () {
                name = "Replace - Regular Expression",
                icon = "edit-find-replace-symbolic",
                func = (s, args, ref err) => {
                    try {
                        var regex = new Regex (args[0]);
                        return regex.replace (s, s.length, 0, args[1]);
                    } catch (RegexError e) {
                        err = "Incorrect regular expression";
                        return null;
                    }
                },
                args = {"Find", "Replace"}
            },
            Tool () {
                name = "Remove - Substring",
                icon = "edit-cut-symbolic",
                func = (s, args) => {
                    return s.replace (args[0], "");
                },
                args = {"Substring"}
            },
            Tool () {
                name = "Remove - Regular Expression",
                icon = "edit-cut-symbolic",
                func = (s, args, ref err) => {
                    try {
                        var regex = new Regex (args[0]);
                        return regex.replace (s, s.length, 0, "");
                    } catch (RegexError e) {
                        err = "Incorrect regular expression";
                        return null;
                    }
                },
                args = {"Regular expression"}
            },
            Tool () {
                name = "Remove - Trailing Whitespaces",
                icon = "edit-cut-symbolic",
                func = (s) => {
                    var lines = s.split ("\n");
                    for (var i = 0; i < lines.length; i++)
                        lines[i] = lines[i].strip ();

                    return string.joinv ("\n", lines);
                }
            },
            Tool () {
                name = "Count - Symbols",
                icon = "view-list-ordered-symbolic",
                func = (s) => s.char_count().to_string(),
                args = {}
            },
            Tool () {
                name = "Count - Count lines",
                icon = "view-list-ordered-symbolic",
                func = (s) => {
                    return s.split("\n").length.to_string();
                }
            },
        };
    }
}