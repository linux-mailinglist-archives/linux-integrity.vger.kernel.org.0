Return-Path: <linux-integrity+bounces-4299-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716049E5AE2
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6645F18859B6
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F63222575;
	Thu,  5 Dec 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0OIj3DCv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485E221462
	for <linux-integrity@vger.kernel.org>; Thu,  5 Dec 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414997; cv=none; b=aKGiJn5QgjWnbnqgGd9fPtXLBVRG9cRjk4Pft7g/Ri9dM9luC2xaQ7lF1f0FXA5Zrk0bFmg1GIgRTaVYZ6QN1yoeu/MtkF1XqJvYpfDUshrNzdx69FxuF03v7Kr7D3yTLhndi0xHF4NJya9JmWFA0ZH4Oc/B0Yjr6zAUNB1KJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414997; c=relaxed/simple;
	bh=u06fPcu2KzUfUNvHusm40bNCohvcZhJyB+Rw5eu9Jas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNhub3adz1TryL+XbVpcu0BxCZebyunvnXgwev7kPCWSS1eKj7Rw8RODUyFquZDAI+lS6XqpAiwHKx2XcPH2LTyj0Ha+wWwY2PoZZkzljP16TADd8twfs62Ps8RNXzNs7ru6HMqev/RuA8Ld/2paEIlu98MNUMT6xRbVdh6MNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0OIj3DCv; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y3zqj0dYLzrFW;
	Thu,  5 Dec 2024 17:09:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733414992;
	bh=MteacQTQ2NgQIQSrr2+MZvfn5OWNPqEQh+YqVH3sxDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0OIj3DCvPyiqDb3AXCp6eoi4ZwD+RNrKLpKhSJRR6FE20dEn2VqGUf6mXAilpEQA6
	 rwleeYI78VmQrONQuNKlc7kAbdJJhnO89dyEQtKOdPLPHjYMeN8nWoN/CNojQ4X+aC
	 hXlBQJqh/3rGW9HzDHhxIssdMrXriHWUKgjVpEZk=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y3zqg5nY9zgfR;
	Thu,  5 Dec 2024 17:09:51 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [PATCH v22 4/8] selftests/landlock: Add tests for execveat + AT_EXECVE_CHECK
Date: Thu,  5 Dec 2024 17:09:21 +0100
Message-ID: <20241205160925.230119-5-mic@digikod.net>
In-Reply-To: <20241205160925.230119-1-mic@digikod.net>
References: <20241205160925.230119-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Extend layout1.execute with the new AT_EXECVE_CHECK flag.  The semantic
with AT_EXECVE_CHECK is the same as with a simple execve(2),
LANDLOCK_ACCESS_FS_EXECUTE is enforced the same way.

Cc: Günther Noack <gnoack@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241205160925.230119-5-mic@digikod.net
---

Changes since v20:
* Rename AT_CHECK to AT_EXECVE_CHECK.
---
 tools/testing/selftests/landlock/fs_test.c | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6788762188fe..cd66901be612 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -37,6 +37,10 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 
+/* Defines AT_EXECVE_CHECK without type conflicts. */
+#define _ASM_GENERIC_FCNTL_H
+#include <linux/fcntl.h>
+
 #include "common.h"
 
 #ifndef renameat2
@@ -2008,6 +2012,22 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
 	};
 }
 
+static void test_check_exec(struct __test_metadata *const _metadata,
+			    const int err, const char *const path)
+{
+	int ret;
+	char *const argv[] = { (char *)path, NULL };
+
+	ret = execveat(AT_FDCWD, path, argv, NULL,
+		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
+	if (err) {
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(errno, err);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
+}
+
 TEST_F_FORK(layout1, execute)
 {
 	const struct rule rules[] = {
@@ -2025,20 +2045,27 @@ TEST_F_FORK(layout1, execute)
 	copy_binary(_metadata, file1_s1d2);
 	copy_binary(_metadata, file1_s1d3);
 
+	/* Checks before file1_s1d1 being denied. */
+	test_execute(_metadata, 0, file1_s1d1);
+	test_check_exec(_metadata, 0, file1_s1d1);
+
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
 	test_execute(_metadata, EACCES, file1_s1d1);
+	test_check_exec(_metadata, EACCES, file1_s1d1);
 
 	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d2);
+	test_check_exec(_metadata, 0, file1_s1d2);
 
 	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d3);
+	test_check_exec(_metadata, 0, file1_s1d3);
 }
 
 TEST_F_FORK(layout1, link)
-- 
2.47.1


