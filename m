Return-Path: <linux-integrity+bounces-5277-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B47A5FDF0
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27E87AC2BB
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19881EB5FE;
	Thu, 13 Mar 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kImw4fCp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6FL8huor";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kImw4fCp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6FL8huor"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54041E9907
	for <linux-integrity@vger.kernel.org>; Thu, 13 Mar 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887319; cv=none; b=LI3t4tuOl1y6z8RYiUez8IkuJXYWjdDP0MMslIVk3+alvKyPlB++1UZy93q1DfT9VRYSu0Wbhm4wRYYF3dlH8T+P6VBFZQazfIUTtYEFr3pXilWylUJMpY9uW8Ur5UD6pG5WfPjJO/zMu0TxB11hahnKrtj19ul9hzfDOEo5PJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887319; c=relaxed/simple;
	bh=AsIkeK09hk52nluzfxUarovF7udCAcT3sMsQxqv/FkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSyjGmt7RHK6/7XSKzDzdpwW/ONSQONle3+fxhP2fhwi9hKwOm/DWQtMbpAV7afccGbZNIpT759/KLqHpWbny+5DEFjGjp7TJwn8NNEpiKJAo3auj7qE5US7bZhpu5O0AP0z5fH3t1PifBkGAXpob2xjS8K7yp/4bDI9PUlPhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kImw4fCp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6FL8huor; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kImw4fCp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6FL8huor; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 823A421196;
	Thu, 13 Mar 2025 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741887315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0m1Yv5mHukwYIyLV3KcW9iiUDiW+55hMfyF/aLIeB8=;
	b=kImw4fCpmlh8Fob1aahnQGx2a9+eQ0dUeeDUkAcZT1Q7gIB6fgHGOj9ZXbe03YP6CVnzJU
	yVtZMfqKzmxiwskkcit2MYgjtSGaYBXqTKHOeL5Wc/kuaChwuzOLOoiZz0k+dPNibITo8i
	dgZAu5n6XRWtA9UgVMBenBIfMZES8Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741887315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0m1Yv5mHukwYIyLV3KcW9iiUDiW+55hMfyF/aLIeB8=;
	b=6FL8huorIfULzfGjfXkbQOt1NCpiTHN0FG00kAfmKbBa24hwabMFMAzTQceUoQwqjRkUks
	qP6EE/O/tZPhjHDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741887315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0m1Yv5mHukwYIyLV3KcW9iiUDiW+55hMfyF/aLIeB8=;
	b=kImw4fCpmlh8Fob1aahnQGx2a9+eQ0dUeeDUkAcZT1Q7gIB6fgHGOj9ZXbe03YP6CVnzJU
	yVtZMfqKzmxiwskkcit2MYgjtSGaYBXqTKHOeL5Wc/kuaChwuzOLOoiZz0k+dPNibITo8i
	dgZAu5n6XRWtA9UgVMBenBIfMZES8Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741887315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0m1Yv5mHukwYIyLV3KcW9iiUDiW+55hMfyF/aLIeB8=;
	b=6FL8huorIfULzfGjfXkbQOt1NCpiTHN0FG00kAfmKbBa24hwabMFMAzTQceUoQwqjRkUks
	qP6EE/O/tZPhjHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72872137BA;
	Thu, 13 Mar 2025 17:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JWTLGlMX02chQwAAD6G6ig
	(envelope-from <nstange@suse.de>); Thu, 13 Mar 2025 17:35:15 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v1 5/7] tpm: enable bank selection for PCR extend
Date: Thu, 13 Mar 2025 18:33:37 +0100
Message-ID: <20250313173339.3815589-6-nstange@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313173339.3815589-1-nstange@suse.de>
References: <20250313173339.3815589-1-nstange@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.30
X-Spam-Flag: NO

The existing tpm_pcr_extend() extends all of a PCR's allocated banks with
the corresponding digest from the provided digests[] argument.

An upcoming code change to IMA will introduce the need to skip over those
banks it does not have a hash algorithm implementation available for.

Introduce tpm_pcr_extend_sel() to support this.

tpm_pcr_extend_sel() also expects a digests[] array, always being the
number of allocated PCR banks in size, just as it's the case for the
existing tpm_pcr_extend(). In addition to that however, it takes a
'banks_skip_mask', and will skip the extension of any bank having its
corresponding bit set there.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/char/tpm/tpm-interface.c | 29 +++++++++++++++++++++++++++--
 drivers/char/tpm/tpm.h           |  3 ++-
 drivers/char/tpm/tpm2-cmd.c      | 29 +++++++++++++++++++++++++++--
 include/linux/tpm.h              |  3 +++
 4 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index b1daa0d7b341..2bab251034b5 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -314,6 +314,26 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
  */
 int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		   struct tpm_digest *digests)
+{
+	return tpm_pcr_extend_sel(chip, pcr_idx, digests, 0);
+}
+EXPORT_SYMBOL_GPL(tpm_pcr_extend);
+
+/**
+ * tpm_pcr_extend_sel - extend a PCR value into selected banks.
+ * @chip:	a &struct tpm_chip instance, %NULL for the default chip
+ * @pcr_idx:	the PCR to be retrieved
+ * @digests:	array of tpm_digest structures used to extend PCRs
+ * @banks_skip_mask:	pcr banks to skip
+ *
+ * Note: callers must pass a digest for every allocated PCR bank, in the same
+ * order of the banks in chip->allocated_banks.
+ *
+ * Return: same as with tpm_transmit_cmd()
+ */
+int tpm_pcr_extend_sel(struct tpm_chip *chip, u32 pcr_idx,
+		       struct tpm_digest *digests,
+		       unsigned long banks_skip_mask)
 {
 	int rc;
 	int i;
@@ -330,7 +350,13 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	}
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		rc = tpm2_pcr_extend(chip, pcr_idx, digests);
+		rc = tpm2_pcr_extend(chip, pcr_idx, digests, 0);
+		goto out;
+	}
+
+	/* There's only one SHA1 bank with TPM 1. */
+	if (banks_skip_mask & 1) {
+		rc = 0;
 		goto out;
 	}
 
@@ -341,7 +367,6 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	tpm_put_ops(chip);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(tpm_pcr_extend);
 
 int tpm_auto_startup(struct tpm_chip *chip)
 {
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7bb87fa5f7a1..f4ed49cb4101 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -291,7 +291,8 @@ int tpm2_get_timeouts(struct tpm_chip *chip);
 int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 		  struct tpm_digest *digest, u16 *digest_size_ptr);
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
-		    struct tpm_digest *digests);
+		    struct tpm_digest *digests,
+		    unsigned long banks_skip_mask);
 int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
 ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
 			u32 *value, const char *desc);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index dfdcbd009720..23ded8ea47dc 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -226,16 +226,34 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
  * @chip:	TPM chip to use.
  * @pcr_idx:	index of the PCR.
  * @digests:	list of pcr banks and corresponding digest values to extend.
+ * @banks_skip_mask:	pcr banks to skip
  *
  * Return: Same as with tpm_transmit_cmd.
  */
 int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
-		    struct tpm_digest *digests)
+		    struct tpm_digest *digests,
+		    unsigned long banks_skip_mask)
 {
 	struct tpm_buf buf;
+	unsigned long skip_mask;
+	u32 banks_count;
 	int rc;
 	int i;
 
+	banks_count = 0;
+	skip_mask = banks_skip_mask;
+	for (i = 0; i < chip->nr_allocated_banks; i++) {
+		const bool skip_bank = skip_mask & 1;
+
+		skip_mask >>= 1;
+		if (skip_bank)
+			continue;
+		banks_count++;
+	}
+
+	if (banks_count == 0)
+		return 0;
+
 	if (!disable_pcr_integrity) {
 		rc = tpm2_start_auth_session(chip);
 		if (rc)
@@ -257,9 +275,16 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
 	}
 
-	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
+	tpm_buf_append_u32(&buf, banks_count);
 
+	skip_mask = banks_skip_mask;
 	for (i = 0; i < chip->nr_allocated_banks; i++) {
+		const bool skip_bank = skip_mask & 1;
+
+		skip_mask >>= 1;
+		if (skip_bank)
+			continue;
+
 		tpm_buf_append_u16(&buf, digests[i].alg_id);
 		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
 			       chip->allocated_banks[i].digest_size);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 20a40ade8030..7587eecc82fd 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -447,6 +447,9 @@ extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
 			struct tpm_digest *digest);
 extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 			  struct tpm_digest *digests);
+extern int tpm_pcr_extend_sel(struct tpm_chip *chip, u32 pcr_idx,
+			      struct tpm_digest *digests,
+			      unsigned long banks_skip_mask);
 extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
 extern struct tpm_chip *tpm_default_chip(void);
 void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
-- 
2.47.1


