Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795B12FEBF7
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 14:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbhAUNcv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 08:32:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55172 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbhAUNcH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 08:32:07 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2ZvJ-0005g7-5f; Thu, 21 Jan 2021 13:22:53 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v6 36/40] tests: add mount_setattr() selftests
Date:   Thu, 21 Jan 2021 14:19:55 +0100
Message-Id: <20210121131959.646623-37-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=LBuIblkAhmSYhmbpfnjqwRafbbM2vrHdlAWh3mc5iqw=; m=2maKW/zZlPAVJrdM6kNzR0fhaHJ93Kb3ianb8IKjhYk=; p=kEzWUlk/ns9SW3I22aH5sqMGLwGUW+rLr4cV1Kllg/E=; g=eefe9b38721555eb68cc95dd3b4350ef2b5380cd
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pwAKCRCRxhvAZXjcomKyAP4qDDr zR5rPhAuZdLjFoL6lQ3LBnMxIjTIlkBNzc9V9lQEAzmeDe38g2tiHEpkxD2JxDwjpPCdk6CqeyutN tKZ8uA4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a range of selftests for the new mount_setattr() syscall to verify
that it works as expected. This tests that:
- no invalid flags can be specified
- changing properties of a single mount works and leaves other mounts in
  the mount tree unchanged
- changing a mount tre to read-only when one of the mounts has writers
  fails and leaves the whole mount tree unchanged
- changing mount properties from multiple threads works
- changing atime settings works
- changing mount propagation works
- changing the mount options of a mount tree where the individual mounts
  in the tree have different mount options only changes the flags that
  were requested to change
- changing mount options from another mount namespace fails
- changing mount options from another user namespace fails
- idmapped mounts

Note, the main test-suite for idmapped mounts is part of xfstests and is
pretty huge. These tests here just make sure that the syscalls bits work
correctly.

 TAP version 13
 1..20
 # Starting 20 tests from 3 test cases.
 #  RUN           mount_setattr.invalid_attributes ...
 #            OK  mount_setattr.invalid_attributes
 ok 1 mount_setattr.invalid_attributes
 #  RUN           mount_setattr.extensibility ...
 #            OK  mount_setattr.extensibility
 ok 2 mount_setattr.extensibility
 #  RUN           mount_setattr.basic ...
 #            OK  mount_setattr.basic
 ok 3 mount_setattr.basic
 #  RUN           mount_setattr.basic_recursive ...
 #            OK  mount_setattr.basic_recursive
 ok 4 mount_setattr.basic_recursive
 #  RUN           mount_setattr.mount_has_writers ...
 #            OK  mount_setattr.mount_has_writers
 ok 5 mount_setattr.mount_has_writers
 #  RUN           mount_setattr.mixed_mount_options ...
 #            OK  mount_setattr.mixed_mount_options
 ok 6 mount_setattr.mixed_mount_options
 #  RUN           mount_setattr.time_changes ...
 #            OK  mount_setattr.time_changes
 ok 7 mount_setattr.time_changes
 #  RUN           mount_setattr.multi_threaded ...
 #            OK  mount_setattr.multi_threaded
 ok 8 mount_setattr.multi_threaded
 #  RUN           mount_setattr.wrong_user_namespace ...
 #            OK  mount_setattr.wrong_user_namespace
 ok 9 mount_setattr.wrong_user_namespace
 #  RUN           mount_setattr.wrong_mount_namespace ...
 #            OK  mount_setattr.wrong_mount_namespace
 ok 10 mount_setattr.wrong_mount_namespace
 #  RUN           mount_setattr_idmapped.invalid_fd_negative ...
 #            OK  mount_setattr_idmapped.invalid_fd_negative
 ok 11 mount_setattr_idmapped.invalid_fd_negative
 #  RUN           mount_setattr_idmapped.invalid_fd_large ...
 #            OK  mount_setattr_idmapped.invalid_fd_large
 ok 12 mount_setattr_idmapped.invalid_fd_large
 #  RUN           mount_setattr_idmapped.invalid_fd_closed ...
 #            OK  mount_setattr_idmapped.invalid_fd_closed
 ok 13 mount_setattr_idmapped.invalid_fd_closed
 #  RUN           mount_setattr_idmapped.invalid_fd_initial_userns ...
 #            OK  mount_setattr_idmapped.invalid_fd_initial_userns
 ok 14 mount_setattr_idmapped.invalid_fd_initial_userns
 #  RUN           mount_setattr_idmapped.attached_mount_inside_current_mount_namespace ...
 #            OK  mount_setattr_idmapped.attached_mount_inside_current_mount_namespace
 ok 15 mount_setattr_idmapped.attached_mount_inside_current_mount_namespace
 #  RUN           mount_setattr_idmapped.attached_mount_outside_current_mount_namespace ...
 #            OK  mount_setattr_idmapped.attached_mount_outside_current_mount_namespace
 ok 16 mount_setattr_idmapped.attached_mount_outside_current_mount_namespace
 #  RUN           mount_setattr_idmapped.detached_mount_inside_current_mount_namespace ...
 #            OK  mount_setattr_idmapped.detached_mount_inside_current_mount_namespace
 ok 17 mount_setattr_idmapped.detached_mount_inside_current_mount_namespace
 #  RUN           mount_setattr_idmapped.detached_mount_outside_current_mount_namespace ...
 #            OK  mount_setattr_idmapped.detached_mount_outside_current_mount_namespace
 ok 18 mount_setattr_idmapped.detached_mount_outside_current_mount_namespace
 #  RUN           mount_setattr_idmapped.change_idmapping ...
 #            OK  mount_setattr_idmapped.change_idmapping
 ok 19 mount_setattr_idmapped.change_idmapping
 #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
 #            OK  mount_setattr_idmapped.idmap_mount_tree_invalid
 ok 20 mount_setattr_idmapped.idmap_mount_tree_invalid
 # PASSED: 20 / 20 tests passed.
 # Totals: pass:20 fail:0 xfail:0 xpass:0 skip:0 error:0

Link: https://lore.kernel.org/r/20210112220124.837960-8-christian.brauner@ubuntu.com
Link: https://lore.kernel.org/r/20210112220124.837960-42-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
- Christoph Hellwig <hch@lst.de>, Darrick J. Wong <darrick.wong@oracle.com>:
  - Port main test-suite to xfstests.

/* v4 */
unchanged

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
unchanged
base-commit: 19c329f6808995b142b3966301f217c831e7cf31
---
 tools/testing/selftests/Makefile              |    1 +
 .../selftests/mount_setattr/.gitignore        |    1 +
 .../testing/selftests/mount_setattr/Makefile  |    7 +
 tools/testing/selftests/mount_setattr/config  |    1 +
 .../mount_setattr/mount_setattr_test.c        | 1424 +++++++++++++++++
 5 files changed, 1434 insertions(+)
 create mode 100644 tools/testing/selftests/mount_setattr/.gitignore
 create mode 100644 tools/testing/selftests/mount_setattr/Makefile
 create mode 100644 tools/testing/selftests/mount_setattr/config
 create mode 100644 tools/testing/selftests/mount_setattr/mount_setattr_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8a917cb4426a..157179afd5b7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -33,6 +33,7 @@ TARGETS += memfd
 TARGETS += memory-hotplug
 TARGETS += mincore
 TARGETS += mount
+TARGETS += mount_setattr
 TARGETS += mqueue
 TARGETS += net
 TARGETS += net/forwarding
diff --git a/tools/testing/selftests/mount_setattr/.gitignore b/tools/testing/selftests/mount_setattr/.gitignore
new file mode 100644
index 000000000000..5f74d8488472
--- /dev/null
+++ b/tools/testing/selftests/mount_setattr/.gitignore
@@ -0,0 +1 @@
+mount_setattr_test
diff --git a/tools/testing/selftests/mount_setattr/Makefile b/tools/testing/selftests/mount_setattr/Makefile
new file mode 100644
index 000000000000..2250f7dcb81e
--- /dev/null
+++ b/tools/testing/selftests/mount_setattr/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for mount selftests.
+CFLAGS = -g -I../../../../usr/include/ -Wall -O2 -pthread
+
+TEST_GEN_FILES += mount_setattr_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/mount_setattr/config b/tools/testing/selftests/mount_setattr/config
new file mode 100644
index 000000000000..416bd53ce982
--- /dev/null
+++ b/tools/testing/selftests/mount_setattr/config
@@ -0,0 +1 @@
+CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
new file mode 100644
index 000000000000..4e94e566e040
--- /dev/null
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -0,0 +1,1424 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdio.h>
+#include <errno.h>
+#include <pthread.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/wait.h>
+#include <sys/vfs.h>
+#include <sys/statvfs.h>
+#include <sys/sysinfo.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <grp.h>
+#include <stdbool.h>
+#include <stdarg.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef CLONE_NEWNS
+#define CLONE_NEWNS 0x00020000
+#endif
+
+#ifndef CLONE_NEWUSER
+#define CLONE_NEWUSER 0x10000000
+#endif
+
+#ifndef MS_REC
+#define MS_REC 16384
+#endif
+
+#ifndef MS_RELATIME
+#define MS_RELATIME (1 << 21)
+#endif
+
+#ifndef MS_STRICTATIME
+#define MS_STRICTATIME (1 << 24)
+#endif
+
+#ifndef MOUNT_ATTR_RDONLY
+#define MOUNT_ATTR_RDONLY 0x00000001
+#endif
+
+#ifndef MOUNT_ATTR_NOSUID
+#define MOUNT_ATTR_NOSUID 0x00000002
+#endif
+
+#ifndef MOUNT_ATTR_NOEXEC
+#define MOUNT_ATTR_NOEXEC 0x00000008
+#endif
+
+#ifndef MOUNT_ATTR_NODIRATIME
+#define MOUNT_ATTR_NODIRATIME 0x00000080
+#endif
+
+#ifndef MOUNT_ATTR__ATIME
+#define MOUNT_ATTR__ATIME 0x00000070
+#endif
+
+#ifndef MOUNT_ATTR_RELATIME
+#define MOUNT_ATTR_RELATIME 0x00000000
+#endif
+
+#ifndef MOUNT_ATTR_NOATIME
+#define MOUNT_ATTR_NOATIME 0x00000010
+#endif
+
+#ifndef MOUNT_ATTR_STRICTATIME
+#define MOUNT_ATTR_STRICTATIME 0x00000020
+#endif
+
+#ifndef AT_RECURSIVE
+#define AT_RECURSIVE 0x8000
+#endif
+
+#ifndef MS_SHARED
+#define MS_SHARED (1 << 20)
+#endif
+
+#define DEFAULT_THREADS 4
+#define ptr_to_int(p) ((int)((intptr_t)(p)))
+#define int_to_ptr(u) ((void *)((intptr_t)(u)))
+
+#ifndef __NR_mount_setattr
+	#if defined __alpha__
+		#define __NR_mount_setattr 552
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_mount_setattr (442 + 4000)
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_mount_setattr (442 + 6000)
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_mount_setattr (442 + 5000)
+		#endif
+	#elif defined __ia64__
+		#define __NR_mount_setattr (442 + 1024)
+	#else
+		#define __NR_mount_setattr 442
+	#endif
+
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+	__u64 userns_fd;
+};
+#endif
+
+#ifndef __NR_open_tree
+	#if defined __alpha__
+		#define __NR_open_tree 538
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_open_tree 4428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_open_tree 6428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_open_tree 5428
+		#endif
+	#elif defined __ia64__
+		#define __NR_open_tree (428 + 1024)
+	#else
+		#define __NR_open_tree 428
+	#endif
+#endif
+
+#ifndef MOUNT_ATTR_IDMAP
+#define MOUNT_ATTR_IDMAP 0x00100000
+#endif
+
+static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flags,
+				    struct mount_attr *attr, size_t size)
+{
+	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
+}
+
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE 1
+#endif
+
+#ifndef OPEN_TREE_CLOEXEC
+#define OPEN_TREE_CLOEXEC O_CLOEXEC
+#endif
+
+#ifndef AT_RECURSIVE
+#define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
+#endif
+
+static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
+{
+	return syscall(__NR_open_tree, dfd, filename, flags);
+}
+
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = write(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+static int write_file(const char *path, const void *buf, size_t count)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
+	if (fd < 0)
+		return -1;
+
+	ret = write_nointr(fd, buf, count);
+	close(fd);
+	if (ret < 0 || (size_t)ret != count)
+		return -1;
+
+	return 0;
+}
+
+static int create_and_enter_userns(void)
+{
+	uid_t uid;
+	gid_t gid;
+	char map[100];
+
+	uid = getuid();
+	gid = getgid();
+
+	if (unshare(CLONE_NEWUSER))
+		return -1;
+
+	if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1) &&
+	    errno != ENOENT)
+		return -1;
+
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map, strlen(map)))
+		return -1;
+
+
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map, strlen(map)))
+		return -1;
+
+	if (setgid(0))
+		return -1;
+
+	if (setuid(0))
+		return -1;
+
+	return 0;
+}
+
+static int prepare_unpriv_mountns(void)
+{
+	if (create_and_enter_userns())
+		return -1;
+
+	if (unshare(CLONE_NEWNS))
+		return -1;
+
+	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0))
+		return -1;
+
+	return 0;
+}
+
+static int read_mnt_flags(const char *path)
+{
+	int ret;
+	struct statvfs stat;
+	unsigned int mnt_flags;
+
+	ret = statvfs(path, &stat);
+	if (ret != 0)
+		return -EINVAL;
+
+	if (stat.f_flag &
+	    ~(ST_RDONLY | ST_NOSUID | ST_NODEV | ST_NOEXEC | ST_NOATIME |
+	      ST_NODIRATIME | ST_RELATIME | ST_SYNCHRONOUS | ST_MANDLOCK))
+		return -EINVAL;
+
+	mnt_flags = 0;
+	if (stat.f_flag & ST_RDONLY)
+		mnt_flags |= MS_RDONLY;
+	if (stat.f_flag & ST_NOSUID)
+		mnt_flags |= MS_NOSUID;
+	if (stat.f_flag & ST_NODEV)
+		mnt_flags |= MS_NODEV;
+	if (stat.f_flag & ST_NOEXEC)
+		mnt_flags |= MS_NOEXEC;
+	if (stat.f_flag & ST_NOATIME)
+		mnt_flags |= MS_NOATIME;
+	if (stat.f_flag & ST_NODIRATIME)
+		mnt_flags |= MS_NODIRATIME;
+	if (stat.f_flag & ST_RELATIME)
+		mnt_flags |= MS_RELATIME;
+	if (stat.f_flag & ST_SYNCHRONOUS)
+		mnt_flags |= MS_SYNCHRONOUS;
+	if (stat.f_flag & ST_MANDLOCK)
+		mnt_flags |= ST_MANDLOCK;
+
+	return mnt_flags;
+}
+
+static char *get_field(char *src, int nfields)
+{
+	int i;
+	char *p = src;
+
+	for (i = 0; i < nfields; i++) {
+		while (*p && *p != ' ' && *p != '\t')
+			p++;
+
+		if (!*p)
+			break;
+
+		p++;
+	}
+
+	return p;
+}
+
+static void null_endofword(char *word)
+{
+	while (*word && *word != ' ' && *word != '\t')
+		word++;
+	*word = '\0';
+}
+
+static bool is_shared_mount(const char *path)
+{
+	size_t len = 0;
+	char *line = NULL;
+	FILE *f = NULL;
+
+	f = fopen("/proc/self/mountinfo", "re");
+	if (!f)
+		return false;
+
+	while (getline(&line, &len, f) != -1) {
+		char *opts, *target;
+
+		target = get_field(line, 4);
+		if (!target)
+			continue;
+
+		opts = get_field(target, 2);
+		if (!opts)
+			continue;
+
+		null_endofword(target);
+
+		if (strcmp(target, path) != 0)
+			continue;
+
+		null_endofword(opts);
+		if (strstr(opts, "shared:"))
+			return true;
+	}
+
+	free(line);
+	fclose(f);
+
+	return false;
+}
+
+static void *mount_setattr_thread(void *data)
+{
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID,
+		.attr_clr	= 0,
+		.propagation	= MS_SHARED,
+	};
+
+	if (sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)))
+		pthread_exit(int_to_ptr(-1));
+
+	pthread_exit(int_to_ptr(0));
+}
+
+/* Attempt to de-conflict with the selftests tree. */
+#ifndef SKIP
+#define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
+#endif
+
+static bool mount_setattr_supported(void)
+{
+	int ret;
+
+	ret = sys_mount_setattr(-EBADF, "", AT_EMPTY_PATH, NULL, 0);
+	if (ret < 0 && errno == ENOSYS)
+		return false;
+
+	return true;
+}
+
+FIXTURE(mount_setattr) {
+};
+
+FIXTURE_SETUP(mount_setattr)
+{
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	ASSERT_EQ(prepare_unpriv_mountns(), 0);
+
+	(void)umount2("/mnt", MNT_DETACH);
+	(void)umount2("/tmp", MNT_DETACH);
+
+	ASSERT_EQ(mount("testing", "/tmp", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir("/tmp/B", 0777), 0);
+
+	ASSERT_EQ(mount("testing", "/tmp/B", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir("/tmp/B/BB", 0777), 0);
+
+	ASSERT_EQ(mount("testing", "/tmp/B/BB", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir("/mnt/A", 0777), 0);
+
+	ASSERT_EQ(mount("testing", "/mnt/A", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir("/mnt/A/AA", 0777), 0);
+
+	ASSERT_EQ(mount("/tmp", "/mnt/A/AA", NULL, MS_BIND | MS_REC, NULL), 0);
+
+	ASSERT_EQ(mkdir("/mnt/B", 0777), 0);
+
+	ASSERT_EQ(mount("testing", "/mnt/B", "ramfs",
+			MS_NOATIME | MS_NODEV | MS_NOSUID, 0), 0);
+
+	ASSERT_EQ(mkdir("/mnt/B/BB", 0777), 0);
+
+	ASSERT_EQ(mount("testing", "/tmp/B/BB", "devpts",
+			MS_RELATIME | MS_NOEXEC | MS_RDONLY, 0), 0);
+}
+
+FIXTURE_TEARDOWN(mount_setattr)
+{
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	(void)umount2("/mnt/A", MNT_DETACH);
+	(void)umount2("/tmp", MNT_DETACH);
+}
+
+TEST_F(mount_setattr, invalid_attributes)
+{
+	struct mount_attr invalid_attr = {
+		.attr_set = (1U << 31),
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &invalid_attr,
+				    sizeof(invalid_attr)), 0);
+
+	invalid_attr.attr_set	= 0;
+	invalid_attr.attr_clr	= (1U << 31);
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &invalid_attr,
+				    sizeof(invalid_attr)), 0);
+
+	invalid_attr.attr_clr		= 0;
+	invalid_attr.propagation	= (1U << 31);
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &invalid_attr,
+				    sizeof(invalid_attr)), 0);
+
+	invalid_attr.attr_set		= (1U << 31);
+	invalid_attr.attr_clr		= (1U << 31);
+	invalid_attr.propagation	= (1U << 31);
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &invalid_attr,
+				    sizeof(invalid_attr)), 0);
+
+	ASSERT_NE(sys_mount_setattr(-1, "mnt/A", AT_RECURSIVE, &invalid_attr,
+				    sizeof(invalid_attr)), 0);
+}
+
+TEST_F(mount_setattr, extensibility)
+{
+	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
+	char *s = "dummy";
+	struct mount_attr invalid_attr = {};
+	struct mount_attr_large {
+		struct mount_attr attr1;
+		struct mount_attr attr2;
+		struct mount_attr attr3;
+	} large_attr = {};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	old_flags = read_mnt_flags("/mnt/A");
+	ASSERT_GT(old_flags, 0);
+
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, NULL,
+				    sizeof(invalid_attr)), 0);
+	ASSERT_EQ(errno, EFAULT);
+
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, (void *)s,
+				    sizeof(invalid_attr)), 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &invalid_attr, 0), 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &invalid_attr,
+				    sizeof(invalid_attr) / 2), 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &invalid_attr,
+				    sizeof(invalid_attr) / 2), 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE,
+				    (void *)&large_attr, sizeof(large_attr)), 0);
+
+	large_attr.attr3.attr_set = MOUNT_ATTR_RDONLY;
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE,
+				    (void *)&large_attr, sizeof(large_attr)), 0);
+
+	large_attr.attr3.attr_set = 0;
+	large_attr.attr1.attr_set = MOUNT_ATTR_RDONLY;
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE,
+				    (void *)&large_attr, sizeof(large_attr)), 0);
+
+	expected_flags = old_flags;
+	expected_flags |= MS_RDONLY;
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+}
+
+TEST_F(mount_setattr, basic)
+{
+	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
+		.attr_clr	= MOUNT_ATTR__ATIME,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	old_flags = read_mnt_flags("/mnt/A");
+	ASSERT_GT(old_flags, 0);
+
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", 0, &attr, sizeof(attr)), 0);
+
+	expected_flags = old_flags;
+	expected_flags |= MS_RDONLY;
+	expected_flags |= MS_NOEXEC;
+	expected_flags &= ~MS_NOATIME;
+	expected_flags |= MS_RELATIME;
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, old_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, old_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, old_flags);
+}
+
+TEST_F(mount_setattr, basic_recursive)
+{
+	int fd;
+	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
+		.attr_clr	= MOUNT_ATTR__ATIME,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	old_flags = read_mnt_flags("/mnt/A");
+	ASSERT_GT(old_flags, 0);
+
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags = old_flags;
+	expected_flags |= MS_RDONLY;
+	expected_flags |= MS_NOEXEC;
+	expected_flags &= ~MS_NOATIME;
+	expected_flags |= MS_RELATIME;
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.attr_clr = MOUNT_ATTR_RDONLY;
+	attr.propagation = MS_SHARED;
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags &= ~MS_RDONLY;
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A"), true);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA"), true);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA/B"), true);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA/B/BB"), true);
+
+	fd = open("/mnt/A/AA/B/b", O_RDWR | O_CLOEXEC | O_CREAT | O_EXCL, 0777);
+	ASSERT_GE(fd, 0);
+
+	/*
+	 * We're holding a fd open for writing so this needs to fail somewhere
+	 * in the middle and the mount options need to be unchanged.
+	 */
+	attr.attr_set = MOUNT_ATTR_RDONLY;
+	ASSERT_LT(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A"), true);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA"), true);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA/B"), true);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA/B/BB"), true);
+
+	EXPECT_EQ(close(fd), 0);
+}
+
+TEST_F(mount_setattr, mount_has_writers)
+{
+	int fd, dfd;
+	unsigned int old_flags = 0, new_flags = 0;
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOEXEC | MOUNT_ATTR_RELATIME,
+		.attr_clr	= MOUNT_ATTR__ATIME,
+		.propagation	= MS_SHARED,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	old_flags = read_mnt_flags("/mnt/A");
+	ASSERT_GT(old_flags, 0);
+
+	fd = open("/mnt/A/AA/B/b", O_RDWR | O_CLOEXEC | O_CREAT | O_EXCL, 0777);
+	ASSERT_GE(fd, 0);
+
+	/*
+	 * We're holding a fd open to a mount somwhere in the middle so this
+	 * needs to fail somewhere in the middle. After this the mount options
+	 * need to be unchanged.
+	 */
+	ASSERT_LT(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, old_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A"), false);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, old_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA"), false);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, old_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA/B"), false);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, old_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA/B/BB"), false);
+
+	dfd = open("/mnt/A/AA/B", O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dfd, 0);
+	EXPECT_EQ(fsync(dfd), 0);
+	EXPECT_EQ(close(dfd), 0);
+
+	EXPECT_EQ(fsync(fd), 0);
+	EXPECT_EQ(close(fd), 0);
+
+	/* All writers are gone so this should succeed. */
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+}
+
+TEST_F(mount_setattr, mixed_mount_options)
+{
+	unsigned int old_flags1 = 0, old_flags2 = 0, new_flags = 0, expected_flags = 0;
+	struct mount_attr attr = {
+		.attr_clr = MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME,
+		.attr_set = MOUNT_ATTR_RELATIME,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	old_flags1 = read_mnt_flags("/mnt/B");
+	ASSERT_GT(old_flags1, 0);
+
+	old_flags2 = read_mnt_flags("/mnt/B/BB");
+	ASSERT_GT(old_flags2, 0);
+
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/B", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags = old_flags2;
+	expected_flags &= ~(MS_RDONLY | MS_NOEXEC | MS_NOATIME | MS_NOSUID);
+	expected_flags |= MS_RELATIME;
+
+	new_flags = read_mnt_flags("/mnt/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	expected_flags = old_flags2;
+	expected_flags &= ~(MS_RDONLY | MS_NOEXEC | MS_NOATIME | MS_NOSUID);
+	expected_flags |= MS_RELATIME;
+
+	new_flags = read_mnt_flags("/mnt/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+}
+
+TEST_F(mount_setattr, time_changes)
+{
+	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	attr.attr_set = MOUNT_ATTR_STRICTATIME;
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	attr.attr_set = MOUNT_ATTR_STRICTATIME | MOUNT_ATTR_NOATIME;
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	attr.attr_set = MOUNT_ATTR_STRICTATIME | MOUNT_ATTR_NOATIME;
+	attr.attr_clr = MOUNT_ATTR__ATIME;
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	attr.attr_set = 0;
+	attr.attr_clr = MOUNT_ATTR_STRICTATIME;
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	attr.attr_clr = MOUNT_ATTR_NOATIME;
+	ASSERT_NE(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	old_flags = read_mnt_flags("/mnt/A");
+	ASSERT_GT(old_flags, 0);
+
+	attr.attr_set = MOUNT_ATTR_NODIRATIME | MOUNT_ATTR_NOATIME;
+	attr.attr_clr = MOUNT_ATTR__ATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags = old_flags;
+	expected_flags |= MS_NOATIME;
+	expected_flags |= MS_NODIRATIME;
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.attr_set &= ~MOUNT_ATTR_NOATIME;
+	attr.attr_set |= MOUNT_ATTR_RELATIME;
+	attr.attr_clr |= MOUNT_ATTR__ATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags &= ~MS_NOATIME;
+	expected_flags |= MS_RELATIME;
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.attr_set &= ~MOUNT_ATTR_RELATIME;
+	attr.attr_set |= MOUNT_ATTR_STRICTATIME;
+	attr.attr_clr |= MOUNT_ATTR__ATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags &= ~MS_RELATIME;
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.attr_set &= ~MOUNT_ATTR_STRICTATIME;
+	attr.attr_set |= MOUNT_ATTR_NOATIME;
+	attr.attr_clr |= MOUNT_ATTR__ATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags |= MS_NOATIME;
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	memset(&attr, 0, sizeof(attr));
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.attr_clr = MOUNT_ATTR_NODIRATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr)), 0);
+
+	expected_flags &= ~MS_NODIRATIME;
+
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+}
+
+TEST_F(mount_setattr, multi_threaded)
+{
+	int i, j, nthreads, ret = 0;
+	unsigned int old_flags = 0, new_flags = 0, expected_flags = 0;
+	pthread_attr_t pattr;
+	pthread_t threads[DEFAULT_THREADS];
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	old_flags = read_mnt_flags("/mnt/A");
+	ASSERT_GT(old_flags, 0);
+
+	/* Try to change mount options from multiple threads. */
+	nthreads = get_nprocs_conf();
+	if (nthreads > DEFAULT_THREADS)
+		nthreads = DEFAULT_THREADS;
+
+	pthread_attr_init(&pattr);
+	for (i = 0; i < nthreads; i++)
+		ASSERT_EQ(pthread_create(&threads[i], &pattr, mount_setattr_thread, NULL), 0);
+
+	for (j = 0; j < i; j++) {
+		void *retptr = NULL;
+
+		EXPECT_EQ(pthread_join(threads[j], &retptr), 0);
+
+		ret += ptr_to_int(retptr);
+		EXPECT_EQ(ret, 0);
+	}
+	pthread_attr_destroy(&pattr);
+
+	ASSERT_EQ(ret, 0);
+
+	expected_flags = old_flags;
+	expected_flags |= MS_RDONLY;
+	expected_flags |= MS_NOSUID;
+	new_flags = read_mnt_flags("/mnt/A");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A"), true);
+
+	new_flags = read_mnt_flags("/mnt/A/AA");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA"), true);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA/B"), true);
+
+	new_flags = read_mnt_flags("/mnt/A/AA/B/BB");
+	ASSERT_EQ(new_flags, expected_flags);
+
+	ASSERT_EQ(is_shared_mount("/mnt/A/AA/B/BB"), true);
+}
+
+TEST_F(mount_setattr, wrong_user_namespace)
+{
+	int ret;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_RDONLY,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	EXPECT_EQ(create_and_enter_userns(), 0);
+	ret = sys_mount_setattr(-1, "/mnt/A", AT_RECURSIVE, &attr, sizeof(attr));
+	ASSERT_LT(ret, 0);
+	ASSERT_EQ(errno, EPERM);
+}
+
+TEST_F(mount_setattr, wrong_mount_namespace)
+{
+	int fd, ret;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_RDONLY,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	fd = open("/mnt/A", O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+
+	ret = sys_mount_setattr(fd, "", AT_EMPTY_PATH | AT_RECURSIVE, &attr, sizeof(attr));
+	ASSERT_LT(ret, 0);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+FIXTURE(mount_setattr_idmapped) {
+};
+
+FIXTURE_SETUP(mount_setattr_idmapped)
+{
+	int img_fd = -EBADF;
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0), 0);
+
+	(void)umount2("/mnt", MNT_DETACH);
+	(void)umount2("/tmp", MNT_DETACH);
+
+	ASSERT_EQ(mount("testing", "/tmp", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir("/tmp/B", 0777), 0);
+	ASSERT_EQ(mknodat(-EBADF, "/tmp/B/b", S_IFREG | 0644, 0), 0);
+	ASSERT_EQ(chown("/tmp/B/b", 0, 0), 0);
+
+	ASSERT_EQ(mount("testing", "/tmp/B", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir("/tmp/B/BB", 0777), 0);
+	ASSERT_EQ(mknodat(-EBADF, "/tmp/B/BB/b", S_IFREG | 0644, 0), 0);
+	ASSERT_EQ(chown("/tmp/B/BB/b", 0, 0), 0);
+
+	ASSERT_EQ(mount("testing", "/tmp/B/BB", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir("/mnt/A", 0777), 0);
+
+	ASSERT_EQ(mount("testing", "/mnt/A", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir("/mnt/A/AA", 0777), 0);
+
+	ASSERT_EQ(mount("/tmp", "/mnt/A/AA", NULL, MS_BIND | MS_REC, NULL), 0);
+
+	ASSERT_EQ(mkdir("/mnt/B", 0777), 0);
+
+	ASSERT_EQ(mount("testing", "/mnt/B", "ramfs",
+			MS_NOATIME | MS_NODEV | MS_NOSUID, 0), 0);
+
+	ASSERT_EQ(mkdir("/mnt/B/BB", 0777), 0);
+
+	ASSERT_EQ(mount("testing", "/tmp/B/BB", "devpts",
+			MS_RELATIME | MS_NOEXEC | MS_RDONLY, 0), 0);
+
+	ASSERT_EQ(mkdir("/mnt/C", 0777), 0);
+	ASSERT_EQ(mkdir("/mnt/D", 0777), 0);
+	img_fd = openat(-EBADF, "/mnt/C/ext4.img", O_CREAT | O_WRONLY, 0600);
+	ASSERT_GE(img_fd, 0);
+	ASSERT_EQ(ftruncate(img_fd, 1024 * 2048), 0);
+	ASSERT_EQ(system("mkfs.ext4 -q /mnt/C/ext4.img"), 0);
+	ASSERT_EQ(system("mount -o loop -t ext4 /mnt/C/ext4.img /mnt/D/"), 0);
+	ASSERT_EQ(close(img_fd), 0);
+}
+
+FIXTURE_TEARDOWN(mount_setattr_idmapped)
+{
+	(void)umount2("/mnt/A", MNT_DETACH);
+	(void)umount2("/tmp", MNT_DETACH);
+}
+
+/**
+ * Validate that negative fd values are rejected.
+ */
+TEST_F(mount_setattr_idmapped, invalid_fd_negative)
+{
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= -EBADF,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	ASSERT_NE(sys_mount_setattr(-1, "/", 0, &attr, sizeof(attr)), 0) {
+		TH_LOG("failure: created idmapped mount with negative fd");
+	}
+}
+
+/**
+ * Validate that excessively large fd values are rejected.
+ */
+TEST_F(mount_setattr_idmapped, invalid_fd_large)
+{
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= INT64_MAX,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	ASSERT_NE(sys_mount_setattr(-1, "/", 0, &attr, sizeof(attr)), 0) {
+		TH_LOG("failure: created idmapped mount with too large fd value");
+	}
+}
+
+/**
+ * Validate that closed fd values are rejected.
+ */
+TEST_F(mount_setattr_idmapped, invalid_fd_closed)
+{
+	int fd;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_GE(close(fd), 0);
+
+	attr.userns_fd = fd;
+	ASSERT_NE(sys_mount_setattr(-1, "/", 0, &attr, sizeof(attr)), 0) {
+		TH_LOG("failure: created idmapped mount with closed fd");
+	}
+}
+
+/**
+ * Validate that the initial user namespace is rejected.
+ */
+TEST_F(mount_setattr_idmapped, invalid_fd_initial_userns)
+{
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	open_tree_fd = sys_open_tree(-EBADF, "/mnt/D",
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	attr.userns_fd = open("/proc/1/ns/user", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_NE(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	ASSERT_EQ(errno, EPERM);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+	ASSERT_EQ(close(open_tree_fd), 0);
+}
+
+static int map_ids(pid_t pid, unsigned long nsid, unsigned long hostid,
+		   unsigned long range)
+{
+	char map[100], procfile[256];
+
+	snprintf(procfile, sizeof(procfile), "/proc/%d/uid_map", pid);
+	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
+	if (write_file(procfile, map, strlen(map)))
+		return -1;
+
+
+	snprintf(procfile, sizeof(procfile), "/proc/%d/gid_map", pid);
+	snprintf(map, sizeof(map), "%lu %lu %lu", nsid, hostid, range);
+	if (write_file(procfile, map, strlen(map)))
+		return -1;
+
+	return 0;
+}
+
+#define __STACK_SIZE (8 * 1024 * 1024)
+static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
+{
+	void *stack;
+
+	stack = malloc(__STACK_SIZE);
+	if (!stack)
+		return -ENOMEM;
+
+#ifdef __ia64__
+	return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#else
+	return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#endif
+}
+
+static int get_userns_fd_cb(void *data)
+{
+	return kill(getpid(), SIGSTOP);
+}
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+static int get_userns_fd(unsigned long nsid, unsigned long hostid, unsigned long range)
+{
+	int ret;
+	pid_t pid;
+	char path[256];
+
+	pid = do_clone(get_userns_fd_cb, NULL, CLONE_NEWUSER);
+	if (pid < 0)
+		return -errno;
+
+	ret = map_ids(pid, nsid, hostid, range);
+	if (ret < 0)
+		return ret;
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	ret = open(path, O_RDONLY | O_CLOEXEC);
+	kill(pid, SIGKILL);
+	wait_for_pid(pid);
+	return ret;
+}
+
+/**
+ * Validate that an attached mount in our mount namespace can be idmapped.
+ * (The kernel enforces that the mount's mount namespace and the caller's mount
+ *  namespace match.)
+ */
+TEST_F(mount_setattr_idmapped, attached_mount_inside_current_mount_namespace)
+{
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	open_tree_fd = sys_open_tree(-EBADF, "/mnt/D",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC);
+	ASSERT_GE(open_tree_fd, 0);
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+	ASSERT_EQ(close(open_tree_fd), 0);
+}
+
+/**
+ * Validate that idmapping a mount is rejected if the mount's mount namespace
+ * and our mount namespace don't match.
+ * (The kernel enforces that the mount's mount namespace and the caller's mount
+ *  namespace match.)
+ */
+TEST_F(mount_setattr_idmapped, attached_mount_outside_current_mount_namespace)
+{
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	open_tree_fd = sys_open_tree(-EBADF, "/mnt/D",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC);
+	ASSERT_GE(open_tree_fd, 0);
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_NE(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,
+				    sizeof(attr)), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+	ASSERT_EQ(close(open_tree_fd), 0);
+}
+
+/**
+ * Validate that an attached mount in our mount namespace can be idmapped.
+ */
+TEST_F(mount_setattr_idmapped, detached_mount_inside_current_mount_namespace)
+{
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	open_tree_fd = sys_open_tree(-EBADF, "/mnt/D",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+	ASSERT_EQ(close(open_tree_fd), 0);
+}
+
+/**
+ * Validate that a detached mount not in our mount namespace can be idmapped.
+ */
+TEST_F(mount_setattr_idmapped, detached_mount_outside_current_mount_namespace)
+{
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	open_tree_fd = sys_open_tree(-EBADF, "/mnt/D",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+	ASSERT_EQ(close(open_tree_fd), 0);
+}
+
+/**
+ * Validate that currently changing the idmapping of an idmapped mount fails.
+ */
+TEST_F(mount_setattr_idmapped, change_idmapping)
+{
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	open_tree_fd = sys_open_tree(-EBADF, "/mnt/D",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_EQ(sys_mount_setattr(open_tree_fd, "",
+				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+
+	/* Change idmapping on a detached mount that is already idmapped. */
+	attr.userns_fd	= get_userns_fd(0, 20000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_NE(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+	ASSERT_EQ(close(open_tree_fd), 0);
+}
+
+static bool expected_uid_gid(int dfd, const char *path, int flags,
+			     uid_t expected_uid, gid_t expected_gid)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	return st.st_uid == expected_uid && st.st_gid == expected_gid;
+}
+
+TEST_F(mount_setattr_idmapped, idmap_mount_tree_invalid)
+{
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/b", 0, 0, 0), 0);
+	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/BB/b", 0, 0, 0), 0);
+
+	open_tree_fd = sys_open_tree(-EBADF, "/mnt/A",
+				     AT_RECURSIVE |
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	ASSERT_GE(open_tree_fd, 0);
+
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	ASSERT_GE(attr.userns_fd, 0);
+	ASSERT_NE(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	ASSERT_EQ(close(attr.userns_fd), 0);
+	ASSERT_EQ(close(open_tree_fd), 0);
+
+	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/b", 0, 0, 0), 0);
+	ASSERT_EQ(expected_uid_gid(-EBADF, "/tmp/B/BB/b", 0, 0, 0), 0);
+	ASSERT_EQ(expected_uid_gid(open_tree_fd, "B/b", 0, 0, 0), 0);
+	ASSERT_EQ(expected_uid_gid(open_tree_fd, "B/BB/b", 0, 0, 0), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.30.0

