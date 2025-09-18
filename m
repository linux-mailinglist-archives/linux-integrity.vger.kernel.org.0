Return-Path: <linux-integrity+bounces-7151-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C37B8415C
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 12:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CD9720C74
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 10:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B392773F0;
	Thu, 18 Sep 2025 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mke/9Qfj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9i5W7NkQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vKvETKgi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eespccwz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB49D2FE598
	for <linux-integrity@vger.kernel.org>; Thu, 18 Sep 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191213; cv=none; b=shKc0ReOGtJamDdzbG/fydXO3cPleELQGwiXwEq6cOeMk2u32rbbRmkI5EJ8snTSK53Fb1NEcrIukbIppJeRR7GhIw5paFQxQaBKVEeB1LoqXzH4zfUdv9k5MtSWHEM6cn/pdxRYuiQmILhOZ1V8lBlEb1wGQqwaHxudVwGLkcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191213; c=relaxed/simple;
	bh=6oLJUX3/cJL/EUlcT80OxffDOzh3DE5y+gzoPD66ocU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nBqhOs6bLml5AQs/vkMBp80TEqZDUy97fXpOu5BNdCuFZ8LUom3x8vkK6q0CCBH6UsKspCyClwCj+KEWQ0jjRJCyxdy/g7LInoFsHw6StFoHx8SE90wzDOIQMowgGTizIajwWw3flMIux6e1gWJBX5EpgZqTrGJYzayNCHYHFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mke/9Qfj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9i5W7NkQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vKvETKgi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eespccwz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 683843370E;
	Thu, 18 Sep 2025 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758191210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m3k6NCq9ThFMgnENfwBchg7fSqv7ePRaCT5p4aXg7wk=;
	b=mke/9QfjtbI88nKOogYQllJQV6T9ibBBzCXXj6dF4/+8NdloH9KYiGSrykgJ8uuoOBQm0m
	PTCKIYGg9vhH+Vkn1ZUyeTuhQyVM8XeF8tOUOnAbAQ4dDCd3V/0nB2nqaT/JiAEgTcUMDB
	ICdvkeMACQLXyuIcJpRQbiB74Cql2eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758191210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m3k6NCq9ThFMgnENfwBchg7fSqv7ePRaCT5p4aXg7wk=;
	b=9i5W7NkQ7zWSldVaG0MkRNX4MGdLbAerggt10F5CBhsm2Cwc3w+w1uuTnbFt9PfyHBV/XX
	KkbVRUf4NRsiVZDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758191209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m3k6NCq9ThFMgnENfwBchg7fSqv7ePRaCT5p4aXg7wk=;
	b=vKvETKgitM5gw27KaajfwgOMHoK3TFu6U+ekpBp4uOAqWxbSfj8X8RlaVNocKoGxBHL9nE
	+f9p/squcvqa7oxHnkepSen78KwilzjkuN06ItWhhl2mgX38z/9KUbPuxhIAWUMZ10nhzJ
	r2VU05LRascPhaBBHBQw2Ukv4RhGYkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758191209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=m3k6NCq9ThFMgnENfwBchg7fSqv7ePRaCT5p4aXg7wk=;
	b=Eespccwz1Eotd6KgE9kccmYy1/H49BtbUNgheKfJMD7TItE9Mx3AA5YU1vmvclnhYqr3RS
	1c8zgBIkFK70jdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 251D213A51;
	Thu, 18 Sep 2025 10:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1l77B2ney2iubQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 18 Sep 2025 10:26:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Cyril Hrubis <chrubis@suse.cz>,
	linux-integrity@vger.kernel.org,
	Avinesh Kumar <akumar@suse.de>,
	Petr Cervinka <pcervinka@suse.com>
Subject: [COMMITTED] Revert "ima_policy.sh: Optimize check for policy writable"
Date: Thu, 18 Sep 2025 12:26:46 +0200
Message-ID: <20250918102646.403590-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:mid,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

This reverts commit 31bb2bbdd3ecfe4b4557d3678f80fe61ace340d0.

c38b528783 demonstrated a bug introuduced by 31bb2bbdd3 on SUT on kernel
without CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.

on tmpfs TMPDIR fails on umount:
...
ima_policy 2 TCONF: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)
ima_policy 2 TCONF: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)
umount: /tmp/LTP_ima_policy.23MpPS2XWr/mntpoint: target is busy.
ima_policy 2 TINFO: umount(/tmp/LTP_ima_policy.23MpPS2XWr/mntpoint) failed, try 1 ...
ima_policy 2 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.

on non-tmpfs TMPDIR (fails to remove temporary directory):
...
ima_policy 2 ima_policy 2 TCONF: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)
TCONF: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)
rm: cannot remove '/var/tmp/LTP_ima_policy.bujyrIYMGz': No such file or directory

Both errors are caused due load_policy() calling require_policy_writable(),
which calls tst_brk(). load_policy() spaws a new process, therefore it
should not call tst_brk (or otherwise exit a test) because ima_cleanup()
is then called twice (which causes the above problems).

Reported-by: Avinesh Kumar <akumar@suse.de>
Reported-by: Petr Cervinka <pcervinka@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_policy.sh  | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 490c8b6c2e..d66f261a81 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2025 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 #
 # Test replacing the default integrity measurement policy.
@@ -11,6 +11,8 @@ TST_CNT=2
 
 setup()
 {
+	require_policy_writable
+
 	VALID_POLICY="$TST_DATAROOT/measure.policy"
 	[ -f $VALID_POLICY ] || tst_brk TCONF "missing $VALID_POLICY"
 
@@ -18,11 +20,13 @@ setup()
 	[ -f $INVALID_POLICY ] || tst_brk TCONF "missing $INVALID_POLICY"
 }
 
+# NOTE: function spaws a new process, therefore it should not call tst_brk()
+# (or otherwise exit a test), because that calls ima_cleanup() twice (which
+# breaks umount on TMPDIR or removing TMPDIR).
 load_policy()
 {
 	local ret
 
-	require_policy_writable
 	exec 2>/dev/null 4>$IMA_POLICY
 	[ $? -eq 0 ] || exit 1
 
@@ -42,6 +46,7 @@ test1()
 
 	local p1
 
+	require_policy_writable
 	load_policy $INVALID_POLICY & p1=$!
 	wait "$p1"
 	if [ $? -ne 0 ]; then
@@ -57,6 +62,7 @@ test2()
 
 	local p1 p2 rc1 rc2
 
+	require_policy_writable
 	load_policy $VALID_POLICY & p1=$!
 	load_policy $VALID_POLICY & p2=$!
 	wait "$p1"; rc1=$?
-- 
2.51.0


