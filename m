Return-Path: <linux-integrity+bounces-4539-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13022A0FE3B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 02:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C43E7A22BA
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 01:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421702135AF;
	Tue, 14 Jan 2025 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNVqjBQb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4fZj7l9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNVqjBQb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4fZj7l9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78411CA84
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736819012; cv=none; b=JQRX20myc4VLngnMK1PcYTKUAmMXrKCVzISnPq5q25u+8/518fYLaJoqu6uvW5s9xqDXWG14hrcqKMxypBsdGx6eIygeJwdegPwvdSwTG7mXDkb+fW7pcx7f43SmjOPkYuOJxbdEXP1jgC54lCXJualyqNhgy15U+xcrGiFrKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736819012; c=relaxed/simple;
	bh=kX6JHD9TeFPHc48NbL8oeTA1hVKTbZ8TNi7BL8cavzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPvHl2OJohnhuiqVkqAX80WpjtzKThJ6NlVQZXHWhFggqTaJ/luABKn+gqIVVbSE/+ZcCLkFw0Ct5k8/JOIF0QYUWIlsGghxyV4esiUZHBocY2/gOGc6dzlfwY0iGDToeUYYH8qDG9waMNGAItBs+RzyayueYzUnmOVS6KmyrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNVqjBQb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I4fZj7l9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNVqjBQb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I4fZj7l9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF3342116A;
	Tue, 14 Jan 2025 01:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736819007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BreDCxK6lGAq9faHh0JjxbXM5vba98X/nBjLdRKsSxs=;
	b=KNVqjBQbjaXde2ym2WfVcMARVVpMd06ssAKm04r5Z5+B1abPvSJcoM72O/uIqtbx0DYsez
	TNnZggMVEguMZ3rU8+IxEaU5l4FrfIMXnePNYmQs1LnvvyvMGIogYNhi96g9BWLlxycp9B
	dyTLX8khUlnw4Lxh7nGEOqsNpruCRbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736819007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BreDCxK6lGAq9faHh0JjxbXM5vba98X/nBjLdRKsSxs=;
	b=I4fZj7l9QXUbu8gilBjpm6AwDXty4ST5TmNd2xXaD7rWUcVZHHi+uBisGUiflxcpTgx6Da
	U5pDIshPoaDOH7Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KNVqjBQb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=I4fZj7l9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736819007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BreDCxK6lGAq9faHh0JjxbXM5vba98X/nBjLdRKsSxs=;
	b=KNVqjBQbjaXde2ym2WfVcMARVVpMd06ssAKm04r5Z5+B1abPvSJcoM72O/uIqtbx0DYsez
	TNnZggMVEguMZ3rU8+IxEaU5l4FrfIMXnePNYmQs1LnvvyvMGIogYNhi96g9BWLlxycp9B
	dyTLX8khUlnw4Lxh7nGEOqsNpruCRbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736819007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BreDCxK6lGAq9faHh0JjxbXM5vba98X/nBjLdRKsSxs=;
	b=I4fZj7l9QXUbu8gilBjpm6AwDXty4ST5TmNd2xXaD7rWUcVZHHi+uBisGUiflxcpTgx6Da
	U5pDIshPoaDOH7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02B1713707;
	Tue, 14 Jan 2025 01:43:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y6hzOz7BhWdWewAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 01:43:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] ima_violations.sh: Fix log detection
Date: Tue, 14 Jan 2025 02:43:18 +0100
Message-ID: <20250114014319.547406-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF3342116A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Fix TBROK on systems which does not have /var/log/messages
(any modern distro is using systemd) not auditd installed:

    ima_violations 1 TBROK: log /var/log/messages does not exist (bug in detection?)

Instead TCONF with more meaningful message:

    ima_violations 1 TCONF: log file not found, install auditd

Fixes: https://github.com/linux-test-project/ltp/issues/372
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi, all,

or should we drop /var/log/messages support entirely? I remember some
old systems had problem (not sure if bug in old kernel or
/var/log/messages was not somehow reliable).

https://github.com/linux-test-project/ltp/issues/372

Kind regards,
Petr

 .../kernel/security/integrity/ima/tests/ima_violations.sh   | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 0f710dea2e..b2b597ad08 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -23,8 +23,10 @@ setup()
 		PRINTK_RATE_LIMIT=`sysctl -n kernel.printk_ratelimit`
 		sysctl -wq kernel.printk_ratelimit=0
 	fi
-	[ -f "$LOG" ] || \
-		tst_brk TBROK "log $LOG does not exist (bug in detection?)"
+
+	if [ ! -e "$LOG" ]; then
+		tst_brk TCONF "log file not found, install auditd"
+	fi
 	tst_res TINFO "using log $LOG"
 }
 
-- 
2.47.1


