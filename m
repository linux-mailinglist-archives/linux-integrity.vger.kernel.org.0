Return-Path: <linux-integrity+bounces-5393-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F4AA6CFA6
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF38E16FAA2
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF7130AC8;
	Sun, 23 Mar 2025 14:10:32 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC412FF6F
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739032; cv=none; b=c/nDOu+Eo+BD7VS9GJOWQi3HlMY/SWifIkaJibtOWTPn1+MKwU8lFcxed424+iEE5XEqyObbvKvlqUTscO0+CHVURO3X1R/KvSuRw9dciWWSVON8cReDC+MvD5xfcE9wYh2ZhLP5ChdeYpLVOAx/CMe2QrcWu2/BifI+yiCx8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739032; c=relaxed/simple;
	bh=IzP6QKoVhZwNqwbkC/6zkiAnPo2TojmeLMtdlXFS8BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzxpIiPxhP3mlz0MbFVFUGAhtgxKMhBGtOfmLYOPGM3+x4Vs3TxRbi5k+eXLwv/7nkgKnl6LVxveMy2s2zUx/pfuFHJSokj2rZC89Or+R7K8nX8PSlmGFXYeo4rxXgSHkwECxbVIVw+me3A03q95KjEhtbXk3t45Iq+6wMz7/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39C3F211B0;
	Sun, 23 Mar 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 299161339F;
	Sun, 23 Mar 2025 14:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kKkGCU0W4GevPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:21 +0000
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
Subject: [RFC PATCH v2 09/13] ima: invalidate unsupported PCR banks only once
Date: Sun, 23 Mar 2025 15:09:07 +0100
Message-ID: <20250323140911.226137-10-nstange@suse.de>
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
X-Rspamd-Queue-Id: 39C3F211B0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

As it currently stands, IMA would invalidate a PCR bank corresponding to
an unsupported hash algorithm over and over again by extending it with
0xfe ... fe for each measurement list entry recorded (for
CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND=n).

This however, makes the problem of deciding from the PCR bank value
whether or not the bank had been invalidated or not linear in the
measurement list length: one would have to reproduce the potential
invalidation extension sequence incrementally for each event recorded
and compare whether the PCR bank value would match at any given point.

From a soundness POV, the repeated invalidations are not needed: a single
one would suffice to ensure no verifier would (wrongly) verify any
measurement list against the invalidated PCR bank value.

With only a single invalidation, an invalidated PCR bank value can get
recognized easily in O(1) by comparing against
HASH(0x00 ... 00 | fe ... fe), i.e. the value a PCR bank would have if
invalidated once in its initial state.

This would potentially help userspace tools such as ima-evm-utils
ima_measurement ([1]) which might want to filter unmaintained PCR banks
and also, it will enable the kernel to log some meaningful meassages when
the set of supported hash algorithm differs between kernel instances in a
kexec chain.

Start out by invalidating unsupported PCR banks exactly once from each
kernel in a kexec chain. Skipping re-invalidations from subsequent kernels
in a kexec chain will be the subject of a future patch.

Make IMA's crypto __init code to fill in a bitmask of banks with
unsupported hash algorithms, ima_unsupported_pcr_banks_mask.
ima_unsupported_pcr_banks_mask has been chosen to be of type unsigned
long, with the expectation that it will be sufficient to represent all
banks allocated on a TPM in practice -- note that 32 > the number of hash
algorithm identifiers defined by the TCG. If not, the code would
implictly fall back to re-invalidating "excess" banks over and over again,
so it is always sound.

Make ima_pcr_extend() to skip the extension of a PCR's unsupported banks
in case the given PCR had not been extend before, as already tracked in
the ima_extended_pcrs_mask introduced by a previous patch. That is,
invalidate unsupported banks only once at any given PCR's first extension.

Note that ima_extended_pcrs_mask is not retained across kernels in a
kexec chain, so each booted kernel would re-invalidate the unsupported
banks again. As said above, taking care of this as well will be handled
in a separate patch.

[1] https://github.com/linux-integrity/ima-evm-utils.git

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_crypto.c | 21 +++++++++++++++++----
 security/integrity/ima/ima_queue.c  | 18 +++++++++++++++++-
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f99b1f81b35c..7ad4a1eefd94 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -62,6 +62,7 @@ extern int ima_sha1_idx __ro_after_init;
 extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
 extern struct ima_algo_desc *ima_algo_array __ro_after_init;
+extern unsigned long ima_unsupported_pcr_banks_mask __ro_after_init;
 
 extern unsigned long ima_extended_pcrs_mask;
 
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 4ac4138d98de..c78bf4872b6a 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -67,6 +67,8 @@ int ima_extra_slots __ro_after_init;
 
 struct ima_algo_desc *ima_algo_array __ro_after_init;
 
+unsigned long ima_unsupported_pcr_banks_mask __ro_after_init;
+
 static int __init ima_init_ima_crypto(void)
 {
 	long rc;
@@ -184,6 +186,16 @@ int __init ima_init_crypto(void)
 		}
 	}
 
+	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
+		if (i >= BITS_PER_LONG) {
+			pr_warn("Too many TPM PCR banks, invalidation tracking capped");
+			break;
+		}
+
+		if (!ima_algo_array[i].tfm)
+			ima_unsupported_pcr_banks_mask |= BIT(i);
+	}
+
 	return 0;
 #if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
 out_array:
@@ -644,10 +656,11 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 		 * padded SHA1 if backwards-compatibility fallback PCR
 		 * extension is enabled. Otherwise fill with
 		 * 0xfes. This is the value to invalidate unsupported
-		 * PCR banks with. Also, a non-all-zeroes value serves
-		 * as an indicator to kexec measurement restoration
-		 * that the entry is not a violation and all its
-		 * template digests need to get recomputed.
+		 * PCR banks with once at first use. Also, a
+		 * non-all-zeroes value serves as an indicator to
+		 * kexec measurement restoration that the entry is not
+		 * a violation and all its template digests need to
+		 * get recomputed.
 		 */
 		if (!ima_algo_array[i].tfm) {
 #if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 6e8a7514d9f6..83d5c7034919 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -150,11 +150,27 @@ unsigned long ima_get_binary_runtime_size(void)
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 {
 	int result;
+	unsigned long pcr_banks_skip_mask;
 
 	if (!ima_tpm_chip)
 		return 0;
 
-	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
+#if !IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
+	pcr_banks_skip_mask = ima_unsupported_pcr_banks_mask;
+	if (!(ima_extended_pcrs_mask & BIT(pcr))) {
+		/*
+		 * Invalidate unsupported banks once upon a PCR's
+		 * first usage. Note that the digests_arg[] entries for
+		 * unsupported algorithms have been filled with 0xfes.
+		 */
+		pcr_banks_skip_mask = 0;
+	}
+#else
+	pcr_banks_skip_mask = 0;
+#endif
+
+	result = tpm_pcr_extend_sel(ima_tpm_chip, pcr, digests_arg,
+				    pcr_banks_skip_mask);
 	if (result != 0) {
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
 		return result;
-- 
2.49.0


