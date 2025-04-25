Return-Path: <linux-integrity+bounces-6026-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17374A9C973
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Apr 2025 14:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D89C1BA5016
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Apr 2025 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B45724C067;
	Fri, 25 Apr 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="boZMPiaA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wV1wWgS2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GrCk+eQG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rTlNnZIH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CE250BED
	for <linux-integrity@vger.kernel.org>; Fri, 25 Apr 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585473; cv=none; b=sWrCR5aMoimFX3973PMf+xcjcHti6Xj/SaRUpEY/DJ4Ihk2SlnyPN5s6G0qthp47OHgD4Xj00T/eqHDrUpBin/graEXoT/pmF/P1oICRApTc1GTvtuh/szaPAblHDK1t5jyamYoGOFkjfvtsExO9TTj5wVMFbR/0iAZlZe8X358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585473; c=relaxed/simple;
	bh=f2/JCQQqUFXRVdB7C+TWWxdvLN4Yr97Axw1If1xE/Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTg87s5gJzOq8sv62MvPOTavwnUygvmteRO4ZwqoXojWlLww3e0h34ClNfhGNvyEBZ6mVyLj5zEDjvrekrk3EKiSmC0g3uTBPHpuocKkMDxmAEfY5thnOPW1AuX139ccIk/HBIf8/iTJaNGMPxsSeqnSWlhZaAQGPSkST9ZTZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=boZMPiaA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wV1wWgS2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GrCk+eQG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rTlNnZIH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F208421166;
	Fri, 25 Apr 2025 12:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745585470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IHYZLewIjoN9AVHdydol59j4Xl0Q5xSSfEm3kpeUAp8=;
	b=boZMPiaAVWLLQJzkxOMscuUgVy3S5rEhpUjEX4w8731r8RaFYxdMAjkEH7vB4ASGkiKx05
	LRUxmLFtHB8sPAnPPkf/BZfHRP7t5k0TjLJdbPvS4I2JwG2HM/qvtgaPDHNJOJbCVAqvrV
	nPGyTZ6O7418QwD99G7TPXvV7iOO+Fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745585470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IHYZLewIjoN9AVHdydol59j4Xl0Q5xSSfEm3kpeUAp8=;
	b=wV1wWgS27FHLxlV5xXpQwFihJLo5AHtHxtc4p4YnVLnGBZLkYrjb0n2X8P/WPX7ye3KIHw
	QfyQQ/cmb+pY0oBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GrCk+eQG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rTlNnZIH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745585469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IHYZLewIjoN9AVHdydol59j4Xl0Q5xSSfEm3kpeUAp8=;
	b=GrCk+eQGuVX2berEZ+AQwds2LMUZPH5INeUfLLkmPaqbqTHXKJijPC7Iw2SamxbjS6g/P9
	nQuu5I6Gal48Q5ebfjaG8jZS+rlfOpsTUZdOA1zmVbr7/KvDw3f38YXnvrGJulds9lz1iW
	tooBFMr6OztAqKPz1PqmyH1M4ci5Cdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745585469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IHYZLewIjoN9AVHdydol59j4Xl0Q5xSSfEm3kpeUAp8=;
	b=rTlNnZIHvGfDm3bni670CmTBIARaaemnmnJUCG8hNTZG05ixd5YCTRXoD4fhSF1+HjCnU5
	1YAk8QkL8p8oRQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9B391388F;
	Fri, 25 Apr 2025 12:51:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nNuXJzyFC2gISgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 25 Apr 2025 12:51:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] tst_security.sh: Use the same value for checkreqprot
Date: Fri, 25 Apr 2025 14:50:57 +0200
Message-ID: <20250425125057.38992-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F208421166
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[suse.cz,linux.ibm.com,paul-moore.com,vger.kernel.org,linux.microsoft.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Flag: NO

kernel commit e9c38f9fc2cc ("Documentation,selinux: deprecate setting
checkreqprot to 1") from v5.10-rc1 deprecated checkreqprot value 1
(emit warning in dmesg). Code is used only in ima_selinux.sh
which requires 5.12. Touching /sys/fs/selinux/checkreqprot is required
to trigger the measurement via selinux_ima_measure_state().

Using the same value (0 by default) works on recent 6.14, it should be
safe changing to use the same value. This way misleading warning is
avoided and hopefully kept working in the future.

Also, this way it does not modify SUT setting (don't influence other
tests), which is always better.

Fixes: 36c695e497 ("tst_security.sh: Add helper tst_update_selinux_state()")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
@SELinux developers: FYI tst_security.sh is used in LTP test in
ima_selinux.sh [1] test.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh

 testcases/lib/tst_security.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 4e2d34ca98..820736c723 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -142,11 +142,10 @@ tst_get_enforce()
 
 tst_update_selinux_state()
 {
-	local cur_val new_val
+	local val
 	local dir=$(tst_get_selinux_dir)
 	[ -n "$dir" ] || return 1
 
-	cur_val=$(cat $dir/checkreqprot)
-	[ $cur_val = 1 ] && new_val=0 || new_val=1
-	echo $new_val > $dir/checkreqprot
+	val=$(cat $dir/checkreqprot)
+	echo $val > $dir/checkreqprot
 }
-- 
2.49.0


