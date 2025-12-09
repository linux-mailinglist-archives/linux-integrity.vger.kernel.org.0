Return-Path: <linux-integrity+bounces-7880-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AB6CB0E1F
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 19:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A481430B2EB5
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E5F303A1D;
	Tue,  9 Dec 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wL5pzFH4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WaKE0Auy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wL5pzFH4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WaKE0Auy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E21303C9E
	for <linux-integrity@vger.kernel.org>; Tue,  9 Dec 2025 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306567; cv=none; b=XWV0y7XUoJkTD5HfYoXyRsyf7qr0p8QHw1/WkgrxmoSo4Z0d0c0IbT2qEwMocXpiFQ14lyzjCAFbW7HjZClvehIDbo8Zc9KAWwqUcatKUOJYouLaypPZK/Y451AMUm84bhL0+xbwe4WdqGTpUq1jYbN8wfWBT8GIQT/DDBxr+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306567; c=relaxed/simple;
	bh=lq6ggw4Le65lFRNGXGApI7bChrlGk3PcHyUW3fPxHao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTXJp5RSF/oDq7jDS8nD4q8+yl8oQM0PMCRgqj8y0/DfTCo8UAHJCy3/eFshDejauDBl3VO3wZ1eHSwS9xkqKHE3SSt3mOVaTcgtXqT1ZhUa2eXIGFJv+oHfMPxAjPIuX1Ec8AiQIshEgW+9eaG3mUl3973+liKk2z456dwv6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wL5pzFH4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WaKE0Auy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wL5pzFH4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WaKE0Auy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C97625BDA2;
	Tue,  9 Dec 2025 18:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765306561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5MG9VFe118qKaUvT5UGjokTQ/VC3l9FEHACN2oZ2Pw=;
	b=wL5pzFH49VWLFtQAlY/dzwfapSzFUsqDMudFU7+te2Jl5cY9kSo+77YoVsCU4lqbqAm4Av
	S9DiGm3pnUTet6LB4ygA3XjNbmjmXS1EQWYOo4z/GSFRxydQK2PgcHFYcE/dN3/R5E3zyQ
	6HknF+EHWnAzNCYOyYWb1yde3Jv5Vro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765306561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5MG9VFe118qKaUvT5UGjokTQ/VC3l9FEHACN2oZ2Pw=;
	b=WaKE0AuydKo7PVuilL4vHFwW0W9kt0gGnC21/GPNd2rGYS5Df7WCR38ac2w4YrKatLshhF
	Kxgrb7lYulyqEqDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765306561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5MG9VFe118qKaUvT5UGjokTQ/VC3l9FEHACN2oZ2Pw=;
	b=wL5pzFH49VWLFtQAlY/dzwfapSzFUsqDMudFU7+te2Jl5cY9kSo+77YoVsCU4lqbqAm4Av
	S9DiGm3pnUTet6LB4ygA3XjNbmjmXS1EQWYOo4z/GSFRxydQK2PgcHFYcE/dN3/R5E3zyQ
	6HknF+EHWnAzNCYOyYWb1yde3Jv5Vro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765306561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5MG9VFe118qKaUvT5UGjokTQ/VC3l9FEHACN2oZ2Pw=;
	b=WaKE0AuydKo7PVuilL4vHFwW0W9kt0gGnC21/GPNd2rGYS5Df7WCR38ac2w4YrKatLshhF
	Kxgrb7lYulyqEqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B3083EA65;
	Tue,  9 Dec 2025 18:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGpxGMFwOGnSSAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 18:56:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v4 1/4] shell: Add tst_runas.c helper
Date: Tue,  9 Dec 2025 19:55:54 +0100
Message-ID: <20251209185557.20598-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209185557.20598-1-pvorel@suse.cz>
References: <20251209185557.20598-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]

It will be used in LTP IMA tests. Not only it removes external
dependency, but also fixes problem when 'nobody' user is not possible to
use due using /usr/sbin/nologin shell.

Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/users/setup_tests.rst |  4 ++++
 testcases/lib/.gitignore  |  1 +
 testcases/lib/Makefile    |  2 +-
 testcases/lib/tst_runas.c | 50 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_runas.c

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 38976f3b0a..e3608127e4 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -71,6 +71,10 @@ users.
    * - LTP_IMA_LOAD_POLICY
      - Load IMA example policy, see :master:`testcases/kernel/security/integrity/ima/README.md`.
 
+   * - LTP_USR_UID, LTP_USR_GID
+     - Set UID and GID of ``nobody`` user for :doc:`../developers/api_shell_tests`,
+       see :master:`testcases/lib/tst_runas.c`.
+
    * - LTP_VIRT_OVERRIDE
      - Overrides virtual machine detection in the test library. Setting it to
        empty string, tells the library that system is not a virtual machine.
diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 19d7c67bbe..c379cd5ac4 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -26,3 +26,4 @@
 /tst_res_
 /tst_run_shell
 /tst_remaining_runtime
+/tst_runas
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index 2309a42a3d..e2461924a7 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -17,6 +17,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
 			   tst_check_kconfigs tst_cgctl tst_fsfreeze tst_ns_create tst_ns_exec\
 			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_\
-			   tst_run_shell tst_remaining_runtime
+			   tst_run_shell tst_remaining_runtime tst_runas
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/lib/tst_runas.c b/testcases/lib/tst_runas.c
new file mode 100644
index 0000000000..e8d5d8dd9d
--- /dev/null
+++ b/testcases/lib/tst_runas.c
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


