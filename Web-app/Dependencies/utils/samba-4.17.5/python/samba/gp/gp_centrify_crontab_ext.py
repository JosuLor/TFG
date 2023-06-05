# gp_centrify_crontab_ext samba gpo policy
# Copyright (C) David Mulder <dmulder@suse.com> 2022
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import os, re
from subprocess import Popen, PIPE
from samba.gp.gpclass import gp_pol_ext, drop_privileges
from hashlib import blake2b
from tempfile import NamedTemporaryFile

intro = '''
### autogenerated by samba
#
# This file is generated by the gp_centrify_crontab_ext Group Policy
# Client Side Extension. To modify the contents of this file,
# modify the appropriate Group Policy objects which apply
# to this machine. DO NOT MODIFY THIS FILE DIRECTLY.
#

'''
end = '''
### autogenerated by samba ###
'''

class gp_centrify_crontab_ext(gp_pol_ext):
    def __str__(self):
        return 'Centrify/CrontabEntries'

    def process_group_policy(self, deleted_gpo_list, changed_gpo_list,
                             cdir=None):
        for guid, settings in deleted_gpo_list:
            self.gp_db.set_guid(guid)
            if str(self) in settings:
                for attribute, script in settings[str(self)].items():
                    if os.path.exists(script):
                        os.unlink(script)
                    self.gp_db.delete(str(self), attribute)
            self.gp_db.commit()

        for gpo in changed_gpo_list:
            if gpo.file_sys_path:
                section = \
                    'Software\\Policies\\Centrify\\UnixSettings\\CrontabEntries'
                self.gp_db.set_guid(gpo.name)
                pol_file = 'MACHINE/Registry.pol'
                path = os.path.join(gpo.file_sys_path, pol_file)
                pol_conf = self.parse(path)
                if not pol_conf:
                    continue
                for e in pol_conf.entries:
                    if e.keyname == section and e.data.strip():
                        cron_dir = '/etc/cron.d' if not cdir else cdir
                        attribute = blake2b(e.data.encode()).hexdigest()
                        old_val = self.gp_db.retrieve(str(self), attribute)
                        if not old_val:
                            with NamedTemporaryFile(prefix='gp_', mode="w+",
                                    delete=False, dir=cron_dir) as f:
                                contents = '%s\n%s\n%s' % (intro, e.data, end)
                                f.write(contents)
                                self.gp_db.store(str(self), attribute, f.name)
                        self.gp_db.commit()

    def rsop(self, gpo, target='MACHINE'):
        output = {}
        section = 'Software\\Policies\\Centrify\\UnixSettings\\CrontabEntries'
        pol_file = '%s/Registry.pol' % target
        if gpo.file_sys_path:
            path = os.path.join(gpo.file_sys_path, pol_file)
            pol_conf = self.parse(path)
            if not pol_conf:
                return output
            for e in pol_conf.entries:
                if e.keyname == section and e.data.strip():
                    if str(self) not in output.keys():
                        output[str(self)] = []
                    output[str(self)].append(e.data)
        return output

def fetch_crontab(username):
    p = Popen(['crontab', '-l', '-u', username], stdout=PIPE, stderr=PIPE)
    out, err = p.communicate()
    if p.returncode != 0:
        raise RuntimeError('Failed to read the crontab: %s' % err)
    m = re.findall('%s(.*)%s' % (intro, end), out.decode(), re.DOTALL)
    if len(m) == 1:
        entries = m[0].strip().split('\n')
    else:
        entries = []
    m = re.findall('(.*)%s.*%s(.*)' % (intro, end), out.decode(), re.DOTALL)
    if len(m) == 1:
        others = '\n'.join([l.strip() for l in m[0]])
    else:
        others = out.decode()
    return others, entries

def install_crontab(fname, username):
    p = Popen(['crontab', fname, '-u', username], stdout=PIPE, stderr=PIPE)
    _, err = p.communicate()
    if p.returncode != 0:
        raise RuntimeError('Failed to install crontab: %s' % err)

class gp_user_centrify_crontab_ext(gp_centrify_crontab_ext):
    def process_group_policy(self, deleted_gpo_list, changed_gpo_list):
        for guid, settings in deleted_gpo_list:
            self.gp_db.set_guid(guid)
            if str(self) in settings:
                others, entries = fetch_crontab(self.username)
                for attribute, entry in settings[str(self)].items():
                    if entry in entries:
                        entries.remove(entry)
                    self.gp_db.delete(str(self), attribute)
                with NamedTemporaryFile() as f:
                    if len(entries) > 0:
                        f.write('\n'.join([others, intro,
                                '\n'.join(entries), end]).encode())
                    else:
                        f.write(others.encode())
                    f.flush()
                    install_crontab(f.name, self.username)
            self.gp_db.commit()

        for gpo in changed_gpo_list:
            if gpo.file_sys_path:
                section = \
                    'Software\\Policies\\Centrify\\UnixSettings\\CrontabEntries'
                self.gp_db.set_guid(gpo.name)
                pol_file = 'USER/Registry.pol'
                path = os.path.join(gpo.file_sys_path, pol_file)
                pol_conf = drop_privileges('root', self.parse, path)
                if not pol_conf:
                    continue
                for e in pol_conf.entries:
                    if e.keyname == section and e.data.strip():
                        attribute = blake2b(e.data.encode()).hexdigest()
                        old_val = self.gp_db.retrieve(str(self), attribute)
                        others, entries = fetch_crontab(self.username)
                        if not old_val or e.data not in entries:
                            entries.append(e.data)
                            with NamedTemporaryFile() as f:
                                f.write('\n'.join([others, intro,
                                        '\n'.join(entries), end]).encode())
                                f.flush()
                                install_crontab(f.name, self.username)
                            self.gp_db.store(str(self), attribute, e.data)
                        self.gp_db.commit()

    def rsop(self, gpo):
        return super().rsop(gpo, target='USER')
