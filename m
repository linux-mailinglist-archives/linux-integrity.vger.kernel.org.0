Return-Path: <linux-integrity+bounces-4390-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2FD9F1905
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 23:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CDC188F1D6
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 22:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6C41A8F8F;
	Fri, 13 Dec 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OSmMXXfB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XV33A1Rj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D351A7AC7
	for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128423; cv=none; b=KjAwbQrU9HYzm15ORMapVMdwMwUq16lhU/G1nbgScXDtVXVEz4SrE8nHarzQg1eMeUqicUZYbJruGQeQ1TOy7Xrdj8bzM8R0/Kv5HICE0Ck082iVFcEO5A4duI9T5S5g02U7BKpw0zW75j/iJ/VG8Y/efKJw9hQICDC09YMTCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128423; c=relaxed/simple;
	bh=6JGVyxPNoiscfSKcDdoi/LHfvDQdcicvK0gRYEKH4Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK00agVaDEPJkYTF3bbzvtYa9gdo6yMi3GMtWDt3qIk+EiE8R3nQudRQ3Q15fSn4m6zKqJRQ7ela3h+zKVztl3sWNWg/PkdGuI/l+DAdltkv0V0CtIX+MiaPPqOF70LEDCYjCRMu3rGiLVBI1rxwMrdF8mzDe/j4Cmih5LiiS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OSmMXXfB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XV33A1Rj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EF4B1F445;
	Fri, 13 Dec 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUpq1cVt6R5qZy8sb67a4RKAP7lOu8qrYbdQ9+PCRvA=;
	b=OSmMXXfBnSTDfNIMz6/mufiVu2OMU/A9ICpJdWq1ILSp96UcSpHKkh/dZcfKCaUtE0HpyI
	REAGXD3zwDSoJoHRDb9TFwbLYrZj8On0jmYsnIb8xDhTuNyRKaY3vsz7cBHUdXwlP4bSSo
	HEItmarNkzMdfPBHtBXyMqLmgSXpzuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUpq1cVt6R5qZy8sb67a4RKAP7lOu8qrYbdQ9+PCRvA=;
	b=XV33A1RjEqbJtpSqC+r115E6jRvEKIf+AVoqfv8AjuWqjMfr/SqrKdu8oYMTwo+quJsANQ
	C6wCzGvqeFIoDGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D03D113A75;
	Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uCsiMSGzXGf5QQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH v2 3/8] tst_test.sh: IMA: Allow to disable LSM warnings and use it for IMA
Date: Fri, 13 Dec 2024 23:20:09 +0100
Message-ID: <20241213222014.1580991-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213222014.1580991-1-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2EF4B1F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
@Cyril: or should we use the opposite approach - by default unused and
declare tests where should be used? I guess tests for typical userspace
tools should use it (e.g. runtest/commands or tests which use
tst_net.sh).

 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 1 +
 testcases/lib/tst_test.sh                                  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 7afb1a0967..cf769ac751 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -11,6 +11,7 @@ TST_CLEANUP_CALLER="$TST_CLEANUP"
 TST_CLEANUP="ima_cleanup"
 TST_NEEDS_ROOT=1
 TST_MOUNT_DEVICE=1
+TST_SKIP_LSM_WARNINGS=1
 
 # TST_MOUNT_DEVICE can be unset, therefore specify explicitly
 TST_NEEDS_TMPDIR=1
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index cfdae02300..3e03a1717f 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -81,7 +81,7 @@ _tst_do_exit()
 	fi
 
 	if [ $TST_BROK -gt 0 -o $TST_FAIL -gt 0 -o $TST_WARN -gt 0 ]; then
-		_tst_check_security_modules
+		[ -z "$TST_SKIP_LSM_WARNINGS" ] && _tst_check_security_modules
 	fi
 
 	cat >&2 << EOF
-- 
2.47.1


