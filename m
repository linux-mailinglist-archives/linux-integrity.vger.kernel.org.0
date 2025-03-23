Return-Path: <linux-integrity+bounces-5389-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB25A6CF97
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FE13B0613
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB05145B3E;
	Sun, 23 Mar 2025 14:10:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02F481DD
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739020; cv=none; b=o0PDOVRDUC3aT2neDLWQczaeMZnOsUJBK7rua7fjCZrJe8VTAk0TUHhMtGaPgdQIudbBNAhw60EkesKMOk4V5P8IxU2j9sYkOzE2fzzjQq/rnTrUtjqx6Cn+/hVDAZg0cBkaHp5zTkKFfc+Xy1GEi/rxrQ2pnFq1kld4J8n1HXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739020; c=relaxed/simple;
	bh=L5sIx5bpO6PtncF8T4SEFBw7PybTVFGOr0/LuCv+KGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHoyscN+dwcQnlog0AVW40pbKMeWplbD/OqsnKD57l9UOb6Y4UQCUHZgJsjLIMNEubFA87e1G55dI+A3s8p7tLAlpSAa2Ual38qcetEU++6B7I+T9mvaqDaBMHPLFui3zsADbY4BQx9a59UBwygWn2/e5LASPLREfg7hYJBC4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2475211AB;
	Sun, 23 Mar 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C001D1339F;
	Sun, 23 Mar 2025 14:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UBSzLUQW4GekPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:12 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v2 07/13] tpm: enable bank selection for PCR extend
Date: Sun, 23 Mar 2025 15:09:05 +0100
Message-ID: <20250323140911.226137-8-nstange@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323140911.226137-1-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
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
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D2475211AB
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

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
index b1daa0d7b341..88b4496de1df 100644
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
+		rc = tpm2_pcr_extend(chip, pcr_idx, digests, banks_skip_mask);
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
2.49.0


