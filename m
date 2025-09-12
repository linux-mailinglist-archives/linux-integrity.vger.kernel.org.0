Return-Path: <linux-integrity+bounces-7060-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9268DB543F0
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 09:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70F2F4E2267
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Sep 2025 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF602AD20;
	Fri, 12 Sep 2025 07:32:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB525F96D
	for <linux-integrity@vger.kernel.org>; Fri, 12 Sep 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662350; cv=none; b=MhRDWcVKS/H6HDxwI5cpwLxEyqt63rDKuUYaP5CqLiyEg+8izkQJB2D0IkiqNAYeweWtB3FrfI7gAl9ynPINGLvU54uH3HYUpkHgtdy9K+oaLRTvgOSi0tXfZv1jkeiTU43RtYJPttsheRZPJIC2jPCbmpC5sI8NwX6zpFN6WSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662350; c=relaxed/simple;
	bh=SF5EN6pGbT6CnKsTPyGD0Nz6YR/VT2Nd5Gvdg3iJ4DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP1vfrNREL62kMRGBhNNjFEr0T8pfkhI65Kg53kddAK5epncwpk1m2MFl0HL6k0rtR1v8pT+jqY4lk5kT5p8UItrJhTe4v25z5vGdLu3utXM3eL3LK30vqWmkS8AN9qTtjgMVs4v1e2WFr7Dot9UpegHqH84K1VngLbWCS0Bk3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBE593F692;
	Fri, 12 Sep 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EE18136DB;
	Fri, 12 Sep 2025 07:32:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IIQrIX3Mw2g7GgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 12 Sep 2025 07:32:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Coiby Xu <coxu@redhat.com>
Subject: [PATCH 2/2] ima_{conditionals,policy}: Handle policy required to be signed
Date: Fri, 12 Sep 2025 09:32:09 +0200
Message-ID: <20250912073210.47637-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912073210.47637-1-pvorel@suse.cz>
References: <20250912073210.47637-1-pvorel@suse.cz>
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
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DBE593F692
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Since kernel 6.6 policy needs to be signed on enabled UEFI secure boot.
Skip testing in that case.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56dc986a6b20b

This fixes errors:

    ima_policy 2 TINFO: verify that policy file is not opened concurrently and able to loaded multiple times
    ima_policy 2 TFAIL: problem loading or extending policy (may require policy to be signed)
    https://openqa.suse.de/tests/18723792#step/ima_conditionals/6

    ima_conditionals 1 TINFO: verify measuring user files when requested via uid
    echo: write error: Permission denied
    ima_conditionals 1 TBROK: echo measure uid=65534 > /sys/kernel/security/ima/policy failed

Ideally there would be test which check that unsigned policy cannot be
written.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_conditionals.sh  | 11 ++++++++++-
 .../kernel/security/integrity/ima/tests/ima_policy.sh |  5 ++++-
 .../kernel/security/integrity/ima/tests/ima_setup.sh  |  7 +++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index b59f330cac..9125616890 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2021 VPI Engineering
-# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2021-2025 Petr Vorel <pvorel@suse.cz>
 # Author: Alex Henrie <alexh@vpitech.com>
 #
 # Verify that conditional rules work.
@@ -10,8 +10,16 @@
 # support") from v5.16.
 
 TST_NEEDS_CMDS="cat chgrp chown id sg sudo"
+TST_SETUP="setup"
 TST_CNT=1
 
+setup()
+{
+	if check_need_signed_policy; then
+		tst_brk TCONF "policy have to be signed"
+	fi
+}
+
 verify_measurement()
 {
 	local request="$1"
@@ -22,6 +30,7 @@ verify_measurement()
 	local value="$(id -u $user)"
 	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $user)"
 
+	# needs to be checked each run (not in setup)
 	require_policy_writable
 
 	ROD rm -f $test_file
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 1c4763d838..490c8b6c2e 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -61,12 +61,15 @@ test2()
 	load_policy $VALID_POLICY & p2=$!
 	wait "$p1"; rc1=$?
 	wait "$p2"; rc2=$?
+
 	if [ $rc1 -eq 0 ] && [ $rc2 -eq 0 ]; then
 		tst_res TFAIL "policy opened concurrently"
 	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
 		tst_res TPASS "policy was loaded just by one process and able to loaded multiple times"
+	elif check_need_signed_policy; then
+		tst_res TCONF "policy have to be signed"
 	else
-		tst_res TFAIL "problem loading or extending policy (may require policy to be signed)"
+		tst_res TFAIL "problem loading or extending policy"
 	fi
 }
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 83fcefb4fc..2a7d651818 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -449,6 +449,13 @@ require_evmctl()
 	fi
 }
 
+# 56dc986a6b20b ("ima: require signed IMA policy when UEFI secure boot is enabled") # v6.5-rc4
+check_need_signed_policy()
+{
+	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs \
+		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY'
+}
+
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
 if tst_supported_fs -d $TMPDIR -s "tmpfs"; then
-- 
2.51.0


