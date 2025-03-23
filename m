Return-Path: <linux-integrity+bounces-5391-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB3A6CF9F
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F67616F96D
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A51537AC;
	Sun, 23 Mar 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NDEYx4LN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8ryjcKdK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NDEYx4LN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8ryjcKdK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8501519B8
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739026; cv=none; b=CUN5BmZDTZSJ9BpDdMeB15OehnKM/V+SilOraOjS5JQBQh8c2gg2B6HRjlTM6Bq8VGVgIOXP96KT6904jnEa1BmTesiKTrsiT33sHhqNp2cbLjDxZLQ89oBRdbhVIvDDX6fzrd5G+tc63/ILXGYCEJ9Cr6dfsW7r5gH9sduIGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739026; c=relaxed/simple;
	bh=cZDI1XugvOeFP1ILeyqBbilL5frkSex2NgY1F2eJUqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyyLmkkytdQmPYuMrzf6zE7bTbabP21NGzH897nUV8o9pO9rKccCoBsBF7G7I/RkQgHwImNpYH0nIe3i6WrFjkKABDd/1z2NSCFrXBUHFOjnDO4gm4fpfg3ERnRm++udRP4rKZgIWct4xsfCPtpEZ4K1jZZkigwRdC2xBnJdjRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NDEYx4LN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8ryjcKdK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NDEYx4LN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8ryjcKdK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B10D5211AC;
	Sun, 23 Mar 2025 14:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44tClsKTm9qmPcLEvqqp56Ijx7dz9J8weJK+foMELhc=;
	b=NDEYx4LNQFAiTAxZlRwM5/hYCLbqi0q7sCz458jI+YSiv5G/nEPErewHCGSzqy+6CSVNqE
	chfmTfY7bhRepUPXIOIVjGhll6Z1J0ivE2dr7oEngja5JKoJgZ2cV+wvLjzLihtEV1I/nF
	sgdeoedVeyNIi8UJBlpmaw3/VRDOcUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44tClsKTm9qmPcLEvqqp56Ijx7dz9J8weJK+foMELhc=;
	b=8ryjcKdKMwkaz/4Nmgh4Mw7FJn0WbXjy4tQeelLvgK2BZIFJ63wG2TW09tAFCL+oASzmql
	cUReLFKp8WAbnyDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44tClsKTm9qmPcLEvqqp56Ijx7dz9J8weJK+foMELhc=;
	b=NDEYx4LNQFAiTAxZlRwM5/hYCLbqi0q7sCz458jI+YSiv5G/nEPErewHCGSzqy+6CSVNqE
	chfmTfY7bhRepUPXIOIVjGhll6Z1J0ivE2dr7oEngja5JKoJgZ2cV+wvLjzLihtEV1I/nF
	sgdeoedVeyNIi8UJBlpmaw3/VRDOcUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44tClsKTm9qmPcLEvqqp56Ijx7dz9J8weJK+foMELhc=;
	b=8ryjcKdKMwkaz/4Nmgh4Mw7FJn0WbXjy4tQeelLvgK2BZIFJ63wG2TW09tAFCL+oASzmql
	cUReLFKp8WAbnyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F1821339F;
	Sun, 23 Mar 2025 14:10:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9umXJUYW4GemPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:14 +0000
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
Subject: [RFC PATCH v2 08/13] ima: track the set of PCRs ever extended
Date: Sun, 23 Mar 2025 15:09:06 +0100
Message-ID: <20250323140911.226137-9-nstange@suse.de>
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
X-Spam-Score: -5.30
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL6owce66jwsk5yhus1j8gn7jo)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

Right now, PCR banks with unsupported hash algorithms are getting
invalidated over and over again for each new measurement list entry
recorded.

A subsequent patch will make IMA to invalidate PCR banks associated with
unsupported hash algorithms only once at a PCR's first use. To prepare for
that, make it track the set of PCRs ever extended.

Maintain the set of touched PCRs in an unsigned long bitmask,
'ima_extended_pcrs_mask'.

Amend the IMA_INVALID_PCR() #define to check that a given PCR can get
represented in that bitmask. Note that this is only for improving code
maintainablity, it does not actually constain the set of allowed PCR
indices any further.

Make ima_pcr_extend() to maintain the ima_extended_pcrs_mask, i.e. to set
the currently extented PCR's corresponding bit.

Note that at this point there's no provision to restore the
ima_extended_pcrs_mask value after kexecs yet, that will be the subject of
later patches.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima.h       |  8 ++++++--
 security/integrity/ima/ima_queue.c | 17 +++++++++++++----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 1158a7b8bf6b..f99b1f81b35c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -20,6 +20,7 @@
 #include <linux/hash.h>
 #include <linux/tpm.h>
 #include <linux/audit.h>
+#include <linux/minmax.h>
 #include <crypto/hash_info.h>
 
 #include "../integrity.h"
@@ -62,6 +63,8 @@ extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
 extern struct ima_algo_desc *ima_algo_array __ro_after_init;
 
+extern unsigned long ima_extended_pcrs_mask;
+
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
@@ -198,8 +201,9 @@ struct ima_iint_cache {
 	struct ima_digest_data *ima_hash;
 };
 
-#define IMA_INVALID_PCR(a) (((a) < 0) || \
-	(a) >= (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
+#define IMA_INVALID_PCR(a) (((a) < 0) ||				    \
+	(a) >= (8 * min(sizeof_field(struct ima_iint_cache, measured_pcrs), \
+			sizeof(ima_extended_pcrs_mask))))
 
 
 extern struct lsm_blob_sizes ima_blob_sizes;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 0cc1189446a8..6e8a7514d9f6 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -51,6 +51,11 @@ static DEFINE_MUTEX(ima_extend_list_mutex);
  */
 static bool ima_measurements_suspended;
 
+/*
+ * Set of PCRs ever extended by IMA.
+ */
+unsigned long ima_extended_pcrs_mask;
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -144,15 +149,19 @@ unsigned long ima_get_binary_runtime_size(void)
 
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 {
-	int result = 0;
+	int result;
 
 	if (!ima_tpm_chip)
-		return result;
+		return 0;
 
 	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
-	if (result != 0)
+	if (result != 0) {
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
-	return result;
+		return result;
+	}
+
+	ima_extended_pcrs_mask |= BIT(pcr);
+	return 0;
 }
 
 /*
-- 
2.49.0


