Return-Path: <linux-integrity+bounces-4374-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20E99EF892
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 18:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F75F2963BB
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE8223C5E;
	Thu, 12 Dec 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yFNuSGxh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7C223E99
	for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025373; cv=none; b=PFhBUGSBa1QJrHFs2xf7+h8WxfoBvHmtbF+m8bXh5LZ4tSpX0abUH+4bV9W8WH95kq+ZOzMkkFff3Eo15BX+XVRJqJNW5fQSSx2N1FcHZ/HO8mIclzEG6bJmlhgZAmszts6IlDKrdM+K2Hdw/2bYO6BIsr2boDeWvUvEp4EGrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025373; c=relaxed/simple;
	bh=OWtu4/9cb5rBJ0sC28mmX6e1Q8lEqMMH3bhf2adb73g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjmBrygKvBeCIbiygh6rEfuG2/UJc8AHV4v3YEdHULK3uitIc0TEhs4GTMqdY3jInzgtTiBiTPIl8CU6T0HE1LB11K2IOj/JZsjaU/fHcKQw8LObUALE+84IFq+h2pYBiDFc0R4EgW2GPlykWNNCHxTo1oCyyknCXSxUBz3iXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yFNuSGxh; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y8KYb0pxRz48W;
	Thu, 12 Dec 2024 18:42:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734025363;
	bh=z4ssrersaEHFV1b2phErnW7WJMX3XDwnDSGfj0KVL4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yFNuSGxhAFe2wYH+mdHF7gsVGu7RQuLRcjV/ujFKm7soYHH2JOpjcuTcNqsPed0Ni
	 RZLtCtL4WoSEC56qp3S6MroVxKwyl5CWt9t0D0LMTnpjTyANP4ttKw7jfAzaoOV7Hk
	 IPx1g1j6QDuJJv514rfFzfKiU/dcE19Lh3mYe+fs=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y8KYY6rb9z4Hr;
	Thu, 12 Dec 2024 18:42:41 +0100 (CET)
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
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [PATCH v23 4/8] selftests/landlock: Add tests for execveat + AT_EXECVE_CHECK
Date: Thu, 12 Dec 2024 18:42:19 +0100
Message-ID: <20241212174223.389435-5-mic@digikod.net>
In-Reply-To: <20241212174223.389435-1-mic@digikod.net>
References: <20241212174223.389435-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20241212174223.389435-5-mic@digikod.net
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


