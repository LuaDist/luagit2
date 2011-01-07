-- Copyright (c) 2010 by Robert G. Jakabosky <bobby@sharedrealm.com>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

c_source [[
typedef git_tree_entry TreeEntry;
]]

object "TreeEntry" {
	method "name" {
		c_call "const char *" "git_tree_entry_name" {}
	},
	method "set_name" {
		c_call "void" "git_tree_entry_set_name" {"const char *", "name"}
	},
	method "attributes" {
		c_call "unsigned int" "git_tree_entry_attributes" {}
	},
	method "set_attributes" {
		c_call "void" "git_tree_entry_set_attributes" {"int", "attr"}
	},
	method "id" {
		var_out{"OID", "id"},
		c_source "${id} = *(git_tree_entry_id(${this}));"
	},
	method "set_id" {
		var_in{"OID", "id"},
		c_source "git_tree_entry_set_id(${this}, &(${id}));"
	},
	method "object" {
		var_out{"Object *", "obj"},
		var_out{"GitError", "err"},
		c_source [[
	${err} = git_tree_entry_2object(&(${obj}), ${this});
]]
	},
}

