Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB88260CE3
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgIHIBy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 04:01:54 -0400
Received: from smtp-190e.mail.infomaniak.ch ([185.125.25.14]:55521 "EHLO
        smtp-190e.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729547AbgIHIAr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 04:00:47 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BlyHc0zrszlh9lB;
        Tue,  8 Sep 2020 10:00:12 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4BlyHX2cVXzlh8Tc;
        Tue,  8 Sep 2020 10:00:08 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Subject: [RFC PATCH v8 3/3] selftest/interpreter: Add tests for AT_INTERPRETED enforcing
Date:   Tue,  8 Sep 2020 09:59:56 +0200
Message-Id: <20200908075956.1069018-4-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075956.1069018-1-mic@digikod.net>
References: <20200908075956.1069018-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Test that checks performed by faccessat2(2) with AT_INTERPRETED on file
path and file descriptors are consistent with noexec mount points and
file execute permissions, according to the policy configured with the
fs.interpreted_access sysctl.

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
---

Changes since v7:
* Update tests with faccessat2/AT_INTERPRETED, including new ones to
  check that setting R_OK or W_OK returns EINVAL.
* Add tests for memfd, pipefs and nsfs.
* Rename and move back tests to a standalone directory.

Changes since v6:
* Add full combination tests for all file types, including block
  devices, character devices, fifos, sockets and symlinks.
* Properly save and restore initial sysctl value for all tests.

Changes since v5:
* Refactor with FIXTURE_VARIANT, which make the tests much more easy to
  read and maintain.
* Save and restore initial sysctl value (suggested by Kees Cook).
* Test with a sysctl value of 0.
* Check errno in sysctl_access_write test.
* Update tests for the CAP_SYS_ADMIN switch.
* Update tests to check -EISDIR (replacing -EACCES).
* Replace FIXTURE_DATA() with FIXTURE() (spotted by Kees Cook).
* Use global const strings.

Changes since v3:
* Replace RESOLVE_MAYEXEC with O_MAYEXEC.
* Add tests to check that O_MAYEXEC is ignored by open(2) and openat(2).

Changes since v2:
* Move tests from exec/ to openat2/ .
* Replace O_MAYEXEC with RESOLVE_MAYEXEC from openat2(2).
* Cleanup tests.

Changes since v1:
* Move tests from yama/ to exec/ .
* Fix _GNU_SOURCE in kselftest_harness.h .
* Add a new test sysctl_access_write to check if CAP_MAC_ADMIN is taken
  into account.
* Test directory execution which is always forbidden since commit
  73601ea5b7b1 ("fs/open.c: allow opening only regular files during
  execve()"), and also check that even the root user can not bypass file
  execution checks.
* Make sure delete_workspace() always as enough right to succeed.
* Cosmetic cleanup.
---
 .../testing/selftests/interpreter/.gitignore  |   2 +
 tools/testing/selftests/interpreter/Makefile  |  18 +
 tools/testing/selftests/interpreter/config    |   1 +
 .../interpreter/interpreted_access_test.c     | 384 ++++++++++++++++++
 4 files changed, 405 insertions(+)
 create mode 100644 tools/testing/selftests/interpreter/.gitignore
 create mode 100644 tools/testing/selftests/interpreter/Makefile
 create mode 100644 tools/testing/selftests/interpreter/config
 create mode 100644 tools/testing/selftests/interpreter/interpreted_access_test.c

diff --git a/tools/testing/selftests/interpreter/.gitignore b/tools/testing/selftests/interpreter/.gitignore
new file mode 100644
index 000000000000..82a4846cbc4b
--- /dev/null
+++ b/tools/testing/selftests/interpreter/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/*_test
diff --git a/tools/testing/selftests/interpreter/Makefile b/tools/testing/selftests/interpreter/Makefile
new file mode 100644
index 000000000000..6b3e8c3e533b
--- /dev/null
+++ b/tools/testing/selftests/interpreter/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2
+LDLIBS += -lcap
+
+src_test := $(wildcard *_test.c)
+TEST_GEN_PROGS := $(src_test:.c=)
+
+KSFT_KHDR_INSTALL := 1
+include ../lib.mk
+
+khdr_dir = $(top_srcdir)/usr/include
+
+$(khdr_dir)/asm-generic/unistd.h: khdr
+	@:
+
+$(OUTPUT)/%_test: %_test.c $(khdr_dir)/asm-generic/unistd.h ../kselftest_harness.h
+	$(LINK.c) $< $(LDLIBS) -o $@ -I$(khdr_dir)
diff --git a/tools/testing/selftests/interpreter/config b/tools/testing/selftests/interpreter/config
new file mode 100644
index 000000000000..dd53c266bf52
--- /dev/null
+++ b/tools/testing/selftests/interpreter/config
@@ -0,0 +1 @@
+CONFIG_SYSCTL=y
diff --git a/tools/testing/selftests/interpreter/interpreted_access_test.c b/tools/testing/selftests/interpreter/interpreted_access_test.c
new file mode 100644
index 000000000000..6458dccabe51
--- /dev/null
+++ b/tools/testing/selftests/interpreter/interpreted_access_test.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test AT_INTERPRETED
+ *
+ * Copyright © 2018-2020 ANSSI
+ *
+ * Author: Mickaël Salaün <mic@digikod.net>
+ */
+
+#define _GNU_SOURCE
+#include <asm-generic/unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/capability.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/sysmacros.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef AT_INTERPRETED
+#define AT_INTERPRETED		0x400
+#endif
+
+#ifndef faccessat2
+static int faccessat2(int dirfd, const char *pathname, int mode, int flags)
+{
+	errno = 0;
+	return syscall(__NR_faccessat2, dirfd, pathname, mode, flags);
+}
+#endif
+
+static const char sysctl_path[] = "/proc/sys/fs/interpreted_access";
+
+static const char workdir_path[] = "./test-mount";
+static const char reg_file_path[] = "./test-mount/regular_file";
+static const char dir_path[] = "./test-mount/directory";
+static const char symlink_path[] = "./test-mount/symlink";
+static const char block_dev_path[] = "./test-mount/block_device";
+static const char char_dev_path[] = "./test-mount/character_device";
+static const char fifo_path[] = "./test-mount/fifo";
+static const char sock_path[] = "./test-mount/socket";
+
+static void ignore_dac(struct __test_metadata *_metadata, int override)
+{
+	cap_t caps;
+	const cap_value_t cap_val[2] = {
+		CAP_DAC_OVERRIDE,
+		CAP_DAC_READ_SEARCH,
+	};
+
+	caps = cap_get_proc();
+	ASSERT_NE(NULL, caps);
+	ASSERT_EQ(0, cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_val,
+				override ? CAP_SET : CAP_CLEAR));
+	ASSERT_EQ(0, cap_set_proc(caps));
+	EXPECT_EQ(0, cap_free(caps));
+}
+
+static void ignore_sys_admin(struct __test_metadata *_metadata, int override)
+{
+	cap_t caps;
+	const cap_value_t cap_val[1] = {
+		CAP_SYS_ADMIN,
+	};
+
+	caps = cap_get_proc();
+	ASSERT_NE(NULL, caps);
+	ASSERT_EQ(0, cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_val,
+				override ? CAP_SET : CAP_CLEAR));
+	ASSERT_EQ(0, cap_set_proc(caps));
+	EXPECT_EQ(0, cap_free(caps));
+}
+
+static void test_omx(struct __test_metadata *_metadata,
+		const char *const path, const int err_open,
+		const int err_access)
+{
+	int flags = O_RDONLY | O_NOFOLLOW | O_CLOEXEC;
+	int fd, access_ret, access_errno;
+
+	/* Do not block on pipes. */
+	if (path == fifo_path)
+		flags |= O_NONBLOCK;
+
+	fd = open(path, flags);
+	if (err_open) {
+		ASSERT_EQ(err_open, errno) {
+			TH_LOG("Wrong error for open %s: %s", path, strerror(errno));
+		}
+		ASSERT_EQ(-1, fd);
+	} else {
+		ASSERT_LE(0, fd) {
+			TH_LOG("Failed to open %s: %s", path, strerror(errno));
+		}
+		access_ret = faccessat2(fd, "", X_OK, AT_EMPTY_PATH | AT_INTERPRETED);
+		access_errno = errno;
+		EXPECT_EQ(0, close(fd));
+		if (err_access) {
+			ASSERT_EQ(err_access, access_errno) {
+				TH_LOG("Wrong error for faccessat2 w/o path %s: %s",
+						path, strerror(access_errno));
+			}
+			ASSERT_EQ(-1, access_ret);
+		} else {
+			ASSERT_EQ(0, access_ret) {
+				TH_LOG("Access denied for %s: %s", path, strerror(access_errno));
+			}
+		}
+	}
+
+	access_ret = faccessat2(AT_FDCWD, path, X_OK, AT_SYMLINK_NOFOLLOW | AT_INTERPRETED);
+	if (err_access) {
+		ASSERT_EQ(err_access, errno) {
+			TH_LOG("Wrong error for faccessat2 w/ path %s: %s", path, strerror(errno));
+		}
+		ASSERT_EQ(-1, access_ret);
+	} else {
+		ASSERT_EQ(0, access_ret) {
+			TH_LOG("Access denied for %s: %s", path, strerror(errno));
+		}
+	}
+
+	/* Tests read access. */
+	access_ret = faccessat2(AT_FDCWD, path, R_OK, AT_SYMLINK_NOFOLLOW | AT_INTERPRETED);
+	ASSERT_EQ(-1, access_ret);
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Tests write access. */
+	access_ret = faccessat2(AT_FDCWD, path, W_OK, AT_SYMLINK_NOFOLLOW | AT_INTERPRETED);
+	ASSERT_EQ(-1, access_ret);
+	ASSERT_EQ(EINVAL, errno);
+}
+
+static void test_policy_fd(struct __test_metadata *_metadata, const int fd,
+		const bool has_policy)
+{
+	const int ret = faccessat2(fd, "", X_OK, AT_EMPTY_PATH | AT_INTERPRETED);
+
+	if (has_policy) {
+		ASSERT_EQ(-1, ret);
+		ASSERT_EQ(EACCES, errno) {
+			TH_LOG("Wrong error for faccessat2 with an FD: %s", strerror(errno));
+		}
+	} else {
+		ASSERT_EQ(0, ret) {
+			TH_LOG("Access denied for an FD: %s", strerror(errno));
+		}
+	}
+}
+
+FIXTURE(access) {
+	char initial_sysctl_value;
+	int memfd, pipefd;
+	int pipe_fds[2];
+};
+
+static void test_file_types(struct __test_metadata *_metadata, FIXTURE_DATA(access) *self,
+		const int err_code, const bool has_policy)
+{
+	/* Tests are performed on a tmpfs mount point. */
+	test_omx(_metadata, reg_file_path, 0, err_code);
+	test_omx(_metadata, dir_path, 0, has_policy ? EACCES : 0);
+	test_omx(_metadata, symlink_path, ELOOP, has_policy ? EACCES : 0);
+	test_omx(_metadata, block_dev_path, 0, has_policy ? EACCES : 0);
+	test_omx(_metadata, char_dev_path, 0, has_policy ? EACCES : 0);
+	test_omx(_metadata, fifo_path, 0, has_policy ? EACCES : 0);
+	test_omx(_metadata, sock_path, ENXIO, has_policy ? EACCES : 0);
+
+	test_omx(_metadata, "/proc/self/ns/mnt", ELOOP, has_policy ? EACCES : 0);
+
+	/* Checks that exec is denied for any memfd. */
+	test_policy_fd(_metadata, self->memfd, has_policy);
+
+	/* Checks that exec is denied for any pipefs fd. */
+	test_policy_fd(_metadata, self->pipefd, has_policy);
+}
+
+static void test_files(struct __test_metadata *_metadata, FIXTURE_DATA(access) *self,
+		const int err_code, const bool has_policy)
+{
+	/* Tests as root. */
+	ignore_dac(_metadata, 1);
+	test_file_types(_metadata, self, err_code, has_policy);
+
+	/* Tests without bypass. */
+	ignore_dac(_metadata, 0);
+	test_file_types(_metadata, self, err_code, has_policy);
+}
+
+static void sysctl_write_char(struct __test_metadata *_metadata, const char value)
+{
+	int fd;
+
+	fd = open(sysctl_path, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	ASSERT_EQ(1, write(fd, &value, 1));
+	EXPECT_EQ(0, close(fd));
+}
+
+static char sysctl_read_char(struct __test_metadata *_metadata)
+{
+	int fd;
+	char sysctl_value;
+
+	fd = open(sysctl_path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	ASSERT_EQ(1, read(fd, &sysctl_value, 1));
+	EXPECT_EQ(0, close(fd));
+	return sysctl_value;
+}
+
+FIXTURE_VARIANT(access) {
+	const bool mount_exec;
+	const bool file_exec;
+	const int sysctl_err_code[3];
+};
+
+FIXTURE_VARIANT_ADD(access, mount_exec_file_exec) {
+	.mount_exec = true,
+	.file_exec = true,
+	.sysctl_err_code = {0, 0, 0},
+};
+
+FIXTURE_VARIANT_ADD(access, mount_exec_file_noexec)
+{
+	.mount_exec = true,
+	.file_exec = false,
+	.sysctl_err_code = {0, EACCES, EACCES},
+};
+
+FIXTURE_VARIANT_ADD(access, mount_noexec_file_exec)
+{
+	.mount_exec = false,
+	.file_exec = true,
+	.sysctl_err_code = {EACCES, 0, EACCES},
+};
+
+FIXTURE_VARIANT_ADD(access, mount_noexec_file_noexec)
+{
+	.mount_exec = false,
+	.file_exec = false,
+	.sysctl_err_code = {EACCES, EACCES, EACCES},
+};
+
+FIXTURE_SETUP(access)
+{
+	int procfd_path_size;
+	static const char path_template[] = "/proc/self/fd/%d";
+	char procfd_path[sizeof(path_template) + 10];
+
+	/*
+	 * Cleans previous workspace if any error previously happened (don't
+	 * check errors).
+	 */
+	umount(workdir_path);
+	rmdir(workdir_path);
+
+	/* Creates a clean mount point. */
+	ASSERT_EQ(0, mkdir(workdir_path, 00700));
+	ASSERT_EQ(0, mount("test", workdir_path, "tmpfs", MS_MGC_VAL |
+				(variant->mount_exec ? 0 : MS_NOEXEC),
+				"mode=0700,size=4k"));
+
+	/* Creates a regular file. */
+	ASSERT_EQ(0, mknod(reg_file_path, S_IFREG | (variant->file_exec ? 0500 : 0400), 0));
+	/* Creates a directory. */
+	ASSERT_EQ(0, mkdir(dir_path, variant->file_exec ? 0500 : 0400));
+	/* Creates a symlink pointing to the regular file. */
+	ASSERT_EQ(0, symlink("regular_file", symlink_path));
+	/* Creates a character device: /dev/null. */
+	ASSERT_EQ(0, mknod(char_dev_path, S_IFCHR | 0400, makedev(1, 3)));
+	/* Creates a block device: /dev/loop0 */
+	ASSERT_EQ(0, mknod(block_dev_path, S_IFBLK | 0400, makedev(7, 0)));
+	/* Creates a fifo. */
+	ASSERT_EQ(0, mknod(fifo_path, S_IFIFO | 0400, 0));
+	/* Creates a socket. */
+	ASSERT_EQ(0, mknod(sock_path, S_IFSOCK | 0400, 0));
+
+	/* Creates a regular file without user mount point. */
+	self->memfd = memfd_create("test-interpreted", MFD_CLOEXEC);
+	ASSERT_LE(0, self->memfd);
+	/* Sets mode, which must be ignored by the exec check. */
+	ASSERT_EQ(0, fchmod(self->memfd, variant->file_exec ? 0500 : 0400));
+
+	/* Creates a pipefs file descriptor. */
+	ASSERT_EQ(0, pipe(self->pipe_fds));
+	procfd_path_size = snprintf(procfd_path, sizeof(procfd_path),
+			path_template, self->pipe_fds[0]);
+	ASSERT_LT(procfd_path_size, sizeof(procfd_path));
+	self->pipefd = open(procfd_path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, self->pipefd);
+	ASSERT_EQ(0, fchmod(self->pipefd, variant->file_exec ? 0500 : 0400));
+
+	/* Saves initial sysctl value. */
+	self->initial_sysctl_value = sysctl_read_char(_metadata);
+
+	/* Prepares for sysctl writes. */
+	ignore_sys_admin(_metadata, 1);
+}
+
+FIXTURE_TEARDOWN(access)
+{
+	EXPECT_EQ(0, close(self->memfd));
+	EXPECT_EQ(0, close(self->pipefd));
+	EXPECT_EQ(0, close(self->pipe_fds[0]));
+	EXPECT_EQ(0, close(self->pipe_fds[1]));
+
+	/* Restores initial sysctl value. */
+	sysctl_write_char(_metadata, self->initial_sysctl_value);
+
+	/* There is no need to unlink the test files. */
+	ASSERT_EQ(0, umount(workdir_path));
+	ASSERT_EQ(0, rmdir(workdir_path));
+}
+
+TEST_F(access, sysctl_0)
+{
+	/* Do not enforce anything. */
+	sysctl_write_char(_metadata, '0');
+	test_files(_metadata, self, 0, false);
+}
+
+TEST_F(access, sysctl_1)
+{
+	/* Enforces mount exec check. */
+	sysctl_write_char(_metadata, '1');
+	test_files(_metadata, self, variant->sysctl_err_code[0], true);
+}
+
+TEST_F(access, sysctl_2)
+{
+	/* Enforces file exec check. */
+	sysctl_write_char(_metadata, '2');
+	test_files(_metadata, self, variant->sysctl_err_code[1], true);
+}
+
+TEST_F(access, sysctl_3)
+{
+	/* Enforces mount and file exec check. */
+	sysctl_write_char(_metadata, '3');
+	test_files(_metadata, self, variant->sysctl_err_code[2], true);
+}
+
+FIXTURE(cleanup) {
+	char initial_sysctl_value;
+};
+
+FIXTURE_SETUP(cleanup)
+{
+	/* Saves initial sysctl value. */
+	self->initial_sysctl_value = sysctl_read_char(_metadata);
+}
+
+FIXTURE_TEARDOWN(cleanup)
+{
+	/* Restores initial sysctl value. */
+	ignore_sys_admin(_metadata, 1);
+	sysctl_write_char(_metadata, self->initial_sysctl_value);
+}
+
+TEST_F(cleanup, sysctl_access_write)
+{
+	int fd;
+	ssize_t ret;
+
+	ignore_sys_admin(_metadata, 1);
+	sysctl_write_char(_metadata, '0');
+
+	ignore_sys_admin(_metadata, 0);
+	fd = open(sysctl_path, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	ret = write(fd, "0", 1);
+	ASSERT_EQ(-1, ret);
+	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(0, close(fd));
+}
+
+TEST_HARNESS_MAIN
-- 
2.28.0

