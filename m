Return-Path: <linux-integrity+bounces-4544-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F76A1055D
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 12:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482FE1882A84
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AF22963F;
	Tue, 14 Jan 2025 11:29:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642A2309AC
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854168; cv=none; b=UaFq1mVcZQ3ewCDwDJ/aoYKo7XShgnlFTfpmKjX7h39t/W/y987LDqRf32uS0ywIdwBl+vv2UjJPnQGFoJryQ7dHhwy1F6W3YNSDtgkmaP66g/jZCXa3Pxu6hCBhqtlZk3DCB13MJhsE/ozfl2cIWcc9ITZMajDQsH2X0E5dchI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854168; c=relaxed/simple;
	bh=1CY20wFTb+0JTbVWOOH3TvJF4ouDuXlbMofT+Dk3xn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB4J5KfSCNcGH3UIqXdgNINFpdD/uklMtEeZL+e4Tvmf50llObe1+zCrPfAg0k4ggQGJzlHYAFzSBqYwg30VUDhXMZhiW5zSzF/Tw4IU0it8ongQwSkn4rPJUrnheK9NPORabDu5kFe8X5Lgr8FzigCoDDOpNy7rK2PbSTqJtGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8FF101F391;
	Tue, 14 Jan 2025 11:29:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D08A139CB;
	Tue, 14 Jan 2025 11:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6AxaEJRKhmeMIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 04/10] IMA: Add example policy for ima_violations.sh
Date: Tue, 14 Jan 2025 12:29:09 +0100
Message-ID: <20250114112915.610297-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 8FF101F391
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/datafiles/Makefile  |  2 +-
 .../integrity/ima/datafiles/ima_violations/Makefile   | 11 +++++++++++
 .../ima/datafiles/ima_violations/violations.policy    |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy

diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
index 0f2b4fdb11..2013bfc918 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -8,6 +8,6 @@ top_srcdir	?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-SUBDIRS	:= ima_kexec ima_keys ima_measurements ima_policy ima_selinux
+SUBDIRS	:= ima_kexec ima_keys ima_measurements ima_policy ima_selinux ima_violations
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violations/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/Makefile
new file mode 100644
index 0000000000..58d474f076
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2025
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_violations
+INSTALL_TARGETS	:= *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
new file mode 100644
index 0000000000..466b8c5a64
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
@@ -0,0 +1,2 @@
+measure func=FILE_CHECK mask=^MAY_READ euid=0
+measure func=FILE_CHECK mask=^MAY_READ uid=0
-- 
2.47.1


