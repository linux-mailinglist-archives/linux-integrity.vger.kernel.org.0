Return-Path: <linux-integrity+bounces-4055-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2559C03C3
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06031C21FB4
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D65C1F4FAC;
	Thu,  7 Nov 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T+v31g+O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+8NxFTKG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T+v31g+O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+8NxFTKG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE31E6DC1
	for <linux-integrity@vger.kernel.org>; Thu,  7 Nov 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978467; cv=none; b=Q9mewTgRrNDxatng36ziJPvjBLb4SO6cwHLb4HFNSm2itUCq/g2is4rk2oaHPKObhv/e7JOLrsQzNeHxUz6K+ziOdMlc8DnS6NIYTz7GRgTrFcfMxdyoAC/EQZ/UKXy3pk4vFQJxFHvFhhHAQFqG8GKl8LYuYarKW7qKSyfoIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978467; c=relaxed/simple;
	bh=1D/RH6JRtIqxfjDdCrDMVU/qWbguuV3aGQJSzU4pdBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPA93kOECWP8xvKzMJnuiFb1oNDYau/mqexZduz3+um/HkM8b5mKXdoMBh2QJ7kTdomHEcab3dP2N4s8DSA1GR3D4v8fI9KG1EdSI+XFw/MVQvah7C0mvvOPa9ZcENB6jRr6C0mTDSj9BIwDwU2mHLfoAwv5uherMTsXZETjZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T+v31g+O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+8NxFTKG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T+v31g+O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+8NxFTKG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B7141F82F;
	Thu,  7 Nov 2024 11:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730978461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nfjYcHF/4Fo7C2yG+7cfZIoGsUvYrJFfy7x4nFfBmzA=;
	b=T+v31g+OSlYmKFng+ehJm7KKPvBCygKHaGuNfkGRQku5NNhVj6q+q8FTHolv9QId+P4P3f
	bOowUFHqaVSb0P5DAW18kwx82k0nleSdyv1gI38f5qXydk7dNqPZJHjliBD8fHOrphrupH
	btZLS+paz2xfSmWiSyEjDrjohmCX148=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730978461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nfjYcHF/4Fo7C2yG+7cfZIoGsUvYrJFfy7x4nFfBmzA=;
	b=+8NxFTKGDO+3aUKeRgliXh/K+odRX+562H2wA4CvLwsFiX8Yj+3pCQq0y6KpLlm64HXMSc
	ykYQyo65OjXwopCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T+v31g+O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+8NxFTKG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730978461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nfjYcHF/4Fo7C2yG+7cfZIoGsUvYrJFfy7x4nFfBmzA=;
	b=T+v31g+OSlYmKFng+ehJm7KKPvBCygKHaGuNfkGRQku5NNhVj6q+q8FTHolv9QId+P4P3f
	bOowUFHqaVSb0P5DAW18kwx82k0nleSdyv1gI38f5qXydk7dNqPZJHjliBD8fHOrphrupH
	btZLS+paz2xfSmWiSyEjDrjohmCX148=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730978461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nfjYcHF/4Fo7C2yG+7cfZIoGsUvYrJFfy7x4nFfBmzA=;
	b=+8NxFTKGDO+3aUKeRgliXh/K+odRX+562H2wA4CvLwsFiX8Yj+3pCQq0y6KpLlm64HXMSc
	ykYQyo65OjXwopCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57605139B3;
	Thu,  7 Nov 2024 11:21:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l/3lE52iLGdXGwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 07 Nov 2024 11:21:01 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Andy Liang <andy.liang@hpe.com>,
	jenifer.golmitz@hpe.com
Subject: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
Date: Thu,  7 Nov 2024 12:18:15 +0100
Message-ID: <20241107112054.28448-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B7141F82F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,hpe.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The TPM2 ACPI table may request a large size for the event log, and it
may be over the max size of kmalloc().  When this happens, the driver
spews the kernel WARNING at the probe time, but the error is
eventually ignored in the caller side, and it results in the missing
TPM event log exposure.

This patch replaces the devm_kmalloc() call with kvmalloc() to allow
larger sizes.  Since there is no devm variant for kvmalloc(), now it's
managed manually via devres_alloc() and devres_add().

Reported-and-tested-by: Andy Liang <andy.liang@hpe.com>
Cc: jenifer.golmitz@hpe.com
Link: https://bugzilla.suse.com/show_bug.cgi?id=1232421
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/char/tpm/eventlog/acpi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 69533d0bfb51..56f7d73fa6bf 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -63,6 +63,13 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
 	return n == 0;
 }
 
+static void bios_event_log_release(struct device *dev, void *res)
+{
+	void **logp = res;
+
+	kvfree(*logp);
+}
+
 /* read binary bios log */
 int tpm_read_log_acpi(struct tpm_chip *chip)
 {
@@ -71,6 +78,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	void __iomem *virt;
 	u64 len, start;
 	struct tpm_bios_log *log;
+	void **logp;
 	struct acpi_table_tpm2 *tbl;
 	struct acpi_tpm2_phy *tpm2_phy;
 	int format;
@@ -136,9 +144,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
-	if (!log->bios_event_log)
+	logp = devres_alloc(bios_event_log_release, sizeof(*logp), GFP_KERNEL);
+	if (!logp)
 		return -ENOMEM;
+	devres_add(&chip->dev, logp);
+	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
+	if (!log->bios_event_log) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	*logp = log->bios_event_log;
 
 	log->bios_event_log_end = log->bios_event_log + len;
 
@@ -164,7 +179,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	return format;
 
 err:
-	devm_kfree(&chip->dev, log->bios_event_log);
+	devres_release(&chip->dev, bios_event_log_release, NULL, NULL);
 	log->bios_event_log = NULL;
 	return ret;
 }
-- 
2.43.0


