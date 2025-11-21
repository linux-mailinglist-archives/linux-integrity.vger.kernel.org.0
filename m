Return-Path: <linux-integrity+bounces-7653-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2ABC7A8F4
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 16:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C78A74EF62F
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87312D94A1;
	Fri, 21 Nov 2025 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zsP+yX3q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4/NdiQNe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FfDHjEsu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMPRnis0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F728B4E2
	for <linux-integrity@vger.kernel.org>; Fri, 21 Nov 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738478; cv=none; b=ukZJSSPu1RbtQ/PBVs5MKg42X8ylaFQq6PJZtQlYd0YwArW8jgrau5CObtkldG988/l2TZWwuDT6cpsu+Td9k7uc4Y+WBGfEx7TFGdu5lqcjVZZq1Ytma8Y3g91di82GyA6L4MbmlRE4JDukLAafSC7cvhTEWxULXJVN1oYp6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738478; c=relaxed/simple;
	bh=poSgNSusiYmChnm2DgfmAVOyeyMMfQ/BFZrrFgtH1MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpEGR/PwC/TDJRrlwqMBJ6WV3R5tW4OIG2SEPYrLe0F370NkMl00uTPvGfVKaWUOvsd3PDlw/0c35jpc2iz7PW4ycjkiH8xaraFWTZJgnPw7gT/J9uHia8ygcsyOEmNI6IxqrnKQZTx7RINJ8ESopdOcM97Wh/34Hm0JBYTzTmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zsP+yX3q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4/NdiQNe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FfDHjEsu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMPRnis0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4D6021954;
	Fri, 21 Nov 2025 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763738475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWhagkJmZt4hC55bT3smd1pK/KtDYkFqTvc8uSpwJns=;
	b=zsP+yX3qQRgmKnBVPxjGefHn/16BaMXchy8sXn8WisMkUEPK5JxveMdxv724lATeSnq6bo
	pzIOq4ItZbnqckUz8AcBH7LAccDT+Q0Tl6dgCt/cZkI4zSXslP4barzfB2EzgnRHnyWrOp
	V2+Q7UiR38rqPAgfKxj+BEjmDfqsRFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763738475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWhagkJmZt4hC55bT3smd1pK/KtDYkFqTvc8uSpwJns=;
	b=4/NdiQNeNPhgSwzKFPZj46Qfqugp9atSMhilr1O1gDY1JPk+cKN+Q0vkAkNLvEnwaZWcJA
	1icBtzzrAK1asdCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FfDHjEsu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZMPRnis0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763738474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWhagkJmZt4hC55bT3smd1pK/KtDYkFqTvc8uSpwJns=;
	b=FfDHjEsuYDMopS/uaUlXJnIcPZ7Cc2S+HHmosRuy/PSpCehMSruu+i5cdI6bwfi1ZS/nuP
	I3SGp4KtvAs0tfGvV9B2Ih6o1ef6MnBG+TH8UxX/5pxRXb+jBYvVSSbCkl5MuzbsZ5zdm4
	YPuY+pKx3UlqxCwhUJ39Ylm4XjhsOIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763738474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWhagkJmZt4hC55bT3smd1pK/KtDYkFqTvc8uSpwJns=;
	b=ZMPRnis0ncZ67TSxCUP/TpHHfwQVuZ4YJsYlaXYqY/Hvt2yooMsZrQna4KSgraDJ+tlwrF
	JPVmvhP2HGfjXZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 780C53EA62;
	Fri, 21 Nov 2025 15:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aEUTHGqDIGndSQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 21 Nov 2025 15:21:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v2 1/4] shell: Add tst_sudo.c helper
Date: Fri, 21 Nov 2025 16:21:08 +0100
Message-ID: <20251121152111.10419-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121152111.10419-1-pvorel@suse.cz>
References: <20251121152111.10419-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4D6021954
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:mid,suse.cz:dkim];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

It will be used in LTP IMA tests. Not only it removes external
dependency, but also fixes problem when 'nobody' user is not possible to
use due using /usr/sbin/nologin shell.

Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2, suggested by Jan Stancek.
https://lore.kernel.org/ltp/CAASaF6yjdrLLVnehESx1TjsrB_z48nmN_2i585GPfkG3Vvg15Q@mail.gmail.com/

 doc/users/setup_tests.rst |  4 ++++
 testcases/lib/.gitignore  |  1 +
 testcases/lib/Makefile    |  2 +-
 testcases/lib/tst_sudo.c  | 50 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_sudo.c

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 38976f3b0a..9c49852830 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -71,6 +71,10 @@ users.
    * - LTP_IMA_LOAD_POLICY
      - Load IMA example policy, see :master:`testcases/kernel/security/integrity/ima/README.md`.
 
+   * - LTP_USR_UID, LTP_USR_GID
+     - Set UID and GID of ``nobody`` user for :doc:`../developers/api_shell_tests`,
+       see :master:`testcases/lib/tst_sudo.c`.
+
    * - LTP_VIRT_OVERRIDE
      - Overrides virtual machine detection in the test library. Setting it to
        empty string, tells the library that system is not a virtual machine.
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 385f3c3ca6..602abdee1f 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -25,3 +25,4 @@
 /tst_timeout_kill
 /tst_res_
 /tst_run_shell
+/tst_sudo
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index b3a9181c11..9973090cfc 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -17,6 +17,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
 			   tst_check_kconfigs tst_cgctl tst_fsfreeze tst_ns_create tst_ns_exec\
 			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_\
-			   tst_run_shell
+			   tst_run_shell tst_sudo
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/lib/tst_sudo.c b/testcases/lib/tst_sudo.c
new file mode 100644
index 0000000000..e8d5d8dd9d
--- /dev/null
+++ b/testcases/lib/tst_sudo.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
+ */
+
+#define LTP_USR_UID 65534
+#define LTP_USR_GID 65534
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+static void print_help(void)
+{
+	fprintf(stderr, "Usage: %s cmd [args] ...\n", __FILE__);
+	fprintf(stderr, "Usage: %s cmd [-h] print help\n\n", __FILE__);
+
+	fprintf(stderr, "Environment Variables\n");
+	fprintf(stderr, "LTP_USR_UID: UID of 'nobody' user, defaults %d\n",
+			LTP_USR_UID);
+	fprintf(stderr, "LTP_USR_GID: GID of 'nobody' user, defaults %d\n",
+			LTP_USR_GID);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc < 2 || !strcmp(argv[1], "-h")) {
+		print_help();
+		return 1;
+	}
+
+	unsigned uid = LTP_USR_UID, gid = LTP_USR_GID;
+
+	char *uid_env = getenv(TST_TO_STR_(LTP_USR_UID));
+	char *gid_env = getenv(TST_TO_STR_(LTP_USR_GID));
+
+	if (uid_env)
+		uid = SAFE_STRTOL(uid_env, 1, INT_MAX);
+
+	if (gid_env)
+		gid = SAFE_STRTOL(gid_env, 1, INT_MAX);
+
+	tst_res(TINFO, "UID: %d, GID: %d", uid, gid);
+	SAFE_SETGROUPS(0, NULL);
+	SAFE_SETRESGID(gid, gid, gid);
+	SAFE_SETRESUID(uid, uid, uid);
+
+	SAFE_CMD((const char * const *)&argv[1], NULL, NULL);
+
+	return 0;
+}
-- 
2.51.0


