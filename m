Return-Path: <linux-integrity+bounces-4541-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64967A1055A
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 12:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8109D167870
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEFD246347;
	Tue, 14 Jan 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RRxI3UcN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NbyRglXW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RRxI3UcN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NbyRglXW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3EE224B1A
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854167; cv=none; b=o2Ir35bwNGPATEM73BMmI4FI457HaVGUUMUSpB6L3S5iSLAOORccq2rclLYr2t4gBZ2wzjkK/TgMC9KS1dxa60LxEbWjDMSUJDE3BivnN9lnk050oBwyv0jCEuJzeZwParDZZmWCYtoyA4n4ZySGz2B0panL2s/3GC0RIt+Qm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854167; c=relaxed/simple;
	bh=tUBmltWzAosUQLN6w0BQsphAYeRlGwEhQ0G7oIn6WNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S44J5ZAU6hsIOKteyo71cPk20BaQ92oXC9+gNayKOOPmfvefKMgEzY9ROOBYxFvZD1yJVtkMD/jofHfX9WPDWmLzoPPxKFGMlkuYAgqNCCyZuqzqu2Q0dOoLmy/19nQZA8YyrkRgHTUPbpMb+DNLbrEbE/0ByHmHTlzx5IjKm3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RRxI3UcN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NbyRglXW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RRxI3UcN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NbyRglXW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DF0221161;
	Tue, 14 Jan 2025 11:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0s/frsk6RFXoxvXBXW/i5hroD+8/U2yuZ2yviEeqlBU=;
	b=RRxI3UcNYRlaUI9aIrB8L3vuHRqnbIDES1s/29ias/aCvmsMAN1gvVg9fGZzW/atkV/M5b
	HcwCV9ulBHTOB20kDMtWgxT1/Vl+24uyGBaixd0iuEXd393wD8lWWN/vaNzpuc0VILbZw9
	xyMKLTag7YNt/MUJKIMV9YakdV3pYoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0s/frsk6RFXoxvXBXW/i5hroD+8/U2yuZ2yviEeqlBU=;
	b=NbyRglXW1tVKn1ITVxgHsF5VlBChmCIgUl8TAvelL2znaJcWcdO1LxdeBm+V5SzhVFd8h2
	fyvj53dMjSMMD7BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0s/frsk6RFXoxvXBXW/i5hroD+8/U2yuZ2yviEeqlBU=;
	b=RRxI3UcNYRlaUI9aIrB8L3vuHRqnbIDES1s/29ias/aCvmsMAN1gvVg9fGZzW/atkV/M5b
	HcwCV9ulBHTOB20kDMtWgxT1/Vl+24uyGBaixd0iuEXd393wD8lWWN/vaNzpuc0VILbZw9
	xyMKLTag7YNt/MUJKIMV9YakdV3pYoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0s/frsk6RFXoxvXBXW/i5hroD+8/U2yuZ2yviEeqlBU=;
	b=NbyRglXW1tVKn1ITVxgHsF5VlBChmCIgUl8TAvelL2znaJcWcdO1LxdeBm+V5SzhVFd8h2
	fyvj53dMjSMMD7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A85813A86;
	Tue, 14 Jan 2025 11:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GEecGJNKhmeMIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 01/10] ima_violations.sh: Fix log detection
Date: Tue, 14 Jan 2025 12:29:06 +0100
Message-ID: <20250114112915.610297-2-pvorel@suse.cz>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Fix TBROK on systems which does not have /var/log/messages
(any modern distro is using systemd) not auditd installed:

    ima_violations 1 TBROK: log /var/log/messages does not exist (bug in detection?)

Instead TCONF with more meaningful message:

    ima_violations 1 TCONF: log file not found, install auditd

Fixes: https://github.com/linux-test-project/ltp/issues/372
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
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


