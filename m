Return-Path: <linux-integrity+bounces-4569-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64B0A12675
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 15:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D284716240C
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2025 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB1A70801;
	Wed, 15 Jan 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0lzm/tWp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF824A7FF
	for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952540; cv=none; b=jLh9uHx5/6Xjd6FRvqIQjGV6xklnBzGUEVytosd4VB/7G6E+LiamHr2IS5OenP3S4UTjYst5JL6GXLwXjIpsmLPhP4BshtakMQ+IZapO1IEHbetBKW8UShDFPazYo/KAqi9+rauIILOa6oKg3orF0N0cD8QuEhls+2UaGtOzSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952540; c=relaxed/simple;
	bh=ALMsz0DhRhfXz7xJAaI48j24P/F3Gp3TuNNdMxy3GrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jGGIgP2mJeo2kn2xYoCf+Ha8Ip541uPYpqkGy3Q0TrmJMMIxaHipZYRDd8gAU/DILNpGNe+vHUDNLSybSqahAV6eKCFz3R3TlettXerLAW43G1dN3fZ2dMKwE0oPiALiJusxbrfrpMa3VdKC1qKhQqbIxUbx5K2Db9gsJIFRGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0lzm/tWp; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YY85C66ZRz8VP;
	Wed, 15 Jan 2025 15:48:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736952527;
	bh=ey9mu3jMu3EhGyYhzz0nIgSudnVLkTSzFKTIm8H5jJc=;
	h=From:To:Cc:Subject:Date:From;
	b=0lzm/tWp/L4NkEt0586kHRHd/H8dKNjB86yvOjsbv5WnmtIdNPwMamvcOyxm72pTo
	 9vVfXrz0JLBKloveNJ80HFkitEzpOuBNG8OUIlhBqSt/2ti2CjysdW6jMba9a/tK3Y
	 +3I0M6th8xlkk5mZeINU+bV9VdTkiigTOQv/HogE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YY8594xX5z4qt;
	Wed, 15 Jan 2025 15:48:45 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v1] selftests: Handle old glibc without execveat(2)
Date: Wed, 15 Jan 2025 15:47:50 +0100
Message-ID: <20250115144753.311152-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add an execveat(2) wrapper because glibc < 2.34 does not have one.  This
fixes the check-exec tests and samples.

Cc: Günther Noack <gnoack@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/r/20250114205645.GA2825031@ax162
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Based on Kees Cook's next/execve branch.
---
 samples/check-exec/inc.c                   | 11 +++++++++--
 tools/testing/selftests/exec/check-exec.c  | 11 +++++++++--
 tools/testing/selftests/landlock/fs_test.c | 10 ++++++++--
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/samples/check-exec/inc.c b/samples/check-exec/inc.c
index 94b87569d2a2..7f6ef06a2f06 100644
--- a/samples/check-exec/inc.c
+++ b/samples/check-exec/inc.c
@@ -21,8 +21,15 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/prctl.h>
+#include <sys/syscall.h>
 #include <unistd.h>
 
+static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
+			char *const envp[], int flags)
+{
+	return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
+}
+
 /* Returns 1 on error, 0 otherwise. */
 static int interpret_buffer(char *buffer, size_t buffer_size)
 {
@@ -78,8 +85,8 @@ static int interpret_stream(FILE *script, char *const script_name,
 	 * script execution.  We must use the script file descriptor instead of
 	 * the script path name to avoid race conditions.
 	 */
-	err = execveat(fileno(script), "", script_argv, envp,
-		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
+	err = sys_execveat(fileno(script), "", script_argv, envp,
+			   AT_EMPTY_PATH | AT_EXECVE_CHECK);
 	if (err && restrict_stream) {
 		perror("ERROR: Script execution check");
 		return 1;
diff --git a/tools/testing/selftests/exec/check-exec.c b/tools/testing/selftests/exec/check-exec.c
index 4d3f4525e1e1..55bce47e56b7 100644
--- a/tools/testing/selftests/exec/check-exec.c
+++ b/tools/testing/selftests/exec/check-exec.c
@@ -22,6 +22,7 @@
 #include <sys/prctl.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 #include <sys/sysmacros.h>
 #include <unistd.h>
 
@@ -31,6 +32,12 @@
 
 #include "../kselftest_harness.h"
 
+static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
+			char *const envp[], int flags)
+{
+	return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
+}
+
 static void drop_privileges(struct __test_metadata *const _metadata)
 {
 	const unsigned int noroot = SECBIT_NOROOT | SECBIT_NOROOT_LOCKED;
@@ -219,8 +226,8 @@ static void test_exec_fd(struct __test_metadata *_metadata, const int fd,
 	 * test framework as an error.  With AT_EXECVE_CHECK, we only check a
 	 * potential successful execution.
 	 */
-	access_ret =
-		execveat(fd, "", argv, NULL, AT_EMPTY_PATH | AT_EXECVE_CHECK);
+	access_ret = sys_execveat(fd, "", argv, NULL,
+				  AT_EMPTY_PATH | AT_EXECVE_CHECK);
 	access_errno = errno;
 	if (err_code) {
 		EXPECT_EQ(-1, access_ret);
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cd66901be612..ac9701c018e0 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -59,6 +59,12 @@ int open_tree(int dfd, const char *filename, unsigned int flags)
 }
 #endif
 
+static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
+			char *const envp[], int flags)
+{
+	return syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
+}
+
 #ifndef RENAME_EXCHANGE
 #define RENAME_EXCHANGE (1 << 1)
 #endif
@@ -2018,8 +2024,8 @@ static void test_check_exec(struct __test_metadata *const _metadata,
 	int ret;
 	char *const argv[] = { (char *)path, NULL };
 
-	ret = execveat(AT_FDCWD, path, argv, NULL,
-		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
+	ret = sys_execveat(AT_FDCWD, path, argv, NULL,
+			   AT_EMPTY_PATH | AT_EXECVE_CHECK);
 	if (err) {
 		EXPECT_EQ(-1, ret);
 		EXPECT_EQ(errno, err);

base-commit: 95b3cdafd7cb74414070893445a9b731793f7b55
-- 
2.48.1


