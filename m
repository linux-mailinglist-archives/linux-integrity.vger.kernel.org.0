Return-Path: <linux-integrity+bounces-5278-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6026FA5FDF4
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 18:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397847AC102
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 17:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B5E1BB6BA;
	Thu, 13 Mar 2025 17:35:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E751EE7B1
	for <linux-integrity@vger.kernel.org>; Thu, 13 Mar 2025 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887328; cv=none; b=XIeffg0rflN0E7zP3YZ7eMy2uYUGmg8SUr2+EoYhx6nMYTE9iaCV0XHqz+6ID4GGuUDDJSo/HoJAHy6Y06H+bMsia8EAx8bEfA3L2lQHznGE5x3yz+E9lSffQdZ2PckUy2Yg18dXbumq9kmSMZNjf1YwJ4dbEJME3AsWMwVyxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887328; c=relaxed/simple;
	bh=8arRVF8Ot/JXKah4Mg83WJFCmCwufI/OEu7Cnmyg7CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LewkuYHQhijvpGEd0wmcxFr5ObYs6Y4cer4IYGOUh3f6dPhamAyG2mkmLAePMtbs9+H0ncjX6CqYGLQpLajbCjsBLxjlZcUwAlhV+mUPf1FLKHSRGxttHv9rzfVUYV0t10P/mAgW0EGNhFkJNph547isiJaZMDwAzEGrK0+wLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE4611F769;
	Thu, 13 Mar 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE86D137BA;
	Thu, 13 Mar 2025 17:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 57FjKVwX02cqQwAAD6G6ig
	(envelope-from <nstange@suse.de>); Thu, 13 Mar 2025 17:35:24 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v1 6/7] ima: invalidate unsupported PCR banks once at first use
Date: Thu, 13 Mar 2025 18:33:38 +0100
Message-ID: <20250313173339.3815589-7-nstange@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BE4611F769
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Normally IMA would extend a template hash of each bank's associated
algorithm into a PCR. However, if a bank's hash algorithm is unavailable
to the kernel at IMA init time, it would fallback to extending padded
SHA1 hashes instead.

That is, if e.g. SHA-256 was missing at IMA init, it would extend padded
SHA1 template hashes into a PCR's SHA-256 bank.

The ima_measurement command (marked as experimental) from ima-evm-utils
would accordingly try both variants when attempting to verify a measurement
list against PCRs. keylime OTOH doesn't seem to -- it expects the template
hash type to match the PCR bank algorithm. I would argue that for the
latter case, the fallback scheme could potentially cause hard to debug
verification failures.

There's another problem with the fallback scheme: right now, SHA-1
availability is a hard requirement for IMA, and it would be good for a
number of reasons to get rid of that. However, if SHA-1 is not available to
the kernel, it can hardly provide padded SHA-1 template hashes for PCR
banks with unsupported algos.

There are several more or less reasonable alternatives possible, among
them are:
a.) Instead of padded SHA-1, use padded/truncated ima_hash template
    hashes.
b.) Record every event as a violation, i.e. extend unsupported banks
    with 0xffs.
c.) Don't extend unsupported banks at all.
d.) Invalidate unsupported banks only once (e.g. with 0xffs) at first
    use.

a.) would make verification from tools like ima_measurement nearly
    impossible, as it would have to guess or somehow determine ima_hash.
b.) would still put an significant and unnecessary burden on tools like
    ima_measurement, because it would then have to exercise three
    possible variants on the measurement list:
    - the template hash matches the bank algorithm,
    - the template hash is padded SHA-1,
    - the template hash is all-ones.
c.) is a security risk, because the bank would validate an empty
    measurement list.

AFAICS, d.) is the best option to proceed, as it allows for determining
from the PCR bank value in O(1) whether the bank had been maintained by
IMA or not and also, it would not validate any measurement list (except
one with a single violation entry at the head).

So implement d.). As it potentially breaks existing userspace, i.e.
the current implementation of ima_measurement, put it behind a Kconfig
option, "IMA_COMPAT_FALLBACK_TPM_EXTEND". If set to "y", the original
behavior of extending with padded SHA-1 is retained. Otherwise the new
scheme to invalidate unsupported PCR banks once upon their first extension
from IMA is implemented instead. As ima_measurement is marked as
experimental and I find it unlikely that other existing tools depend on
the padded SHA-1 fallback scheme, make the IMA_COMPAT_FALLBACK_TPM_EXTEND
Kconfig option default to "n".

For IMA_COMPAT_FALLBACK_TPM_EXTEND=n,
- make ima_calc_field_array_hash() to fill the digests corresponding to
  banks with unsupported hash algorithms with 0xffs,
- make ima_pcr_extend() to extend these into the unsupported PCR banks only
  upon the PCR's first usage, skip them on subsequent updates and
- let ima_init_ima_crypto() help it with that by populating the new
  ima_unsupported_tpm_banks_mask with one bit set for each bank with
  an unavailable hash algorithm at init.

[1] https://github.com/linux-integrity/ima-evm-utils

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/Kconfig      | 14 ++++++++++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_crypto.c | 27 +++++++++++++++++++++++++--
 security/integrity/ima/ima_queue.c  | 20 +++++++++++++++++++-
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..d6ba392c0b37 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -122,6 +122,20 @@ config IMA_DEFAULT_HASH
 	default "wp512" if IMA_DEFAULT_HASH_WP512
 	default "sm3" if IMA_DEFAULT_HASH_SM3
 
+config IMA_COMPAT_FALLBACK_TPM_EXTEND
+	bool
+	default n
+	help
+	  In case a TPM PCR hash algorithm is not supported by the kernel,
+	  retain the old behaviour to extend the bank with padded SHA1 template
+	  digests.
+
+	  If Y, IMA will be unavailable when SHA1 is missing from the kernel.
+	  If N, existing tools may fail to verify IMA measurement lists against
+	  TPM PCR banks corresponding to hashes not supported by the kernel.
+
+	  If unsure, say N.
+
 config IMA_WRITE_POLICY
 	bool "Enable multiple writes to the IMA policy"
 	default n
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f99b1f81b35c..58e9a81b3f96 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -62,6 +62,7 @@ extern int ima_sha1_idx __ro_after_init;
 extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
 extern struct ima_algo_desc *ima_algo_array __ro_after_init;
+extern unsigned long ima_unsupported_tpm_banks_mask __ro_after_init;
 
 extern unsigned long ima_extended_pcrs_mask;
 
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 6f5696d999d0..118ea15d737b 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -67,6 +67,8 @@ int ima_extra_slots __ro_after_init;
 
 struct ima_algo_desc *ima_algo_array __ro_after_init;
 
+unsigned long ima_unsupported_tpm_banks_mask __ro_after_init;
+
 static int __init ima_init_ima_crypto(void)
 {
 	long rc;
@@ -150,8 +152,10 @@ int __init ima_init_crypto(void)
 		ima_algo_array[i].algo = algo;
 
 		/* unknown TPM algorithm */
-		if (algo == HASH_ALGO__LAST)
+		if (algo == HASH_ALGO__LAST) {
+			ima_unsupported_tpm_banks_mask |= BIT(i);
 			continue;
+		}
 
 		if (algo == ima_hash_algo) {
 			ima_algo_array[i].tfm = ima_shash_tfm;
@@ -167,6 +171,7 @@ int __init ima_init_crypto(void)
 			}
 
 			ima_algo_array[i].tfm = NULL;
+			ima_unsupported_tpm_banks_mask |= BIT(i);
 		}
 	}
 
@@ -625,26 +630,44 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 	u16 alg_id;
 	int rc, i;
 
+#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
 	rc = ima_calc_field_array_hash_tfm(field_data, entry, ima_sha1_idx);
 	if (rc)
 		return rc;
 
 	entry->digests[ima_sha1_idx].alg_id = TPM_ALG_SHA1;
+#endif
 
 	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
+#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
 		if (i == ima_sha1_idx)
 			continue;
+#endif
 
 		if (i < NR_BANKS(ima_tpm_chip)) {
 			alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
 			entry->digests[i].alg_id = alg_id;
 		}
 
-		/* for unmapped TPM algorithms digest is still a padded SHA1 */
+		/*
+		 * For unmapped TPM algorithms, the digest is still a
+		 * padded SHA1 if backwards-compatibility fallback PCR
+		 * extension is enabled.  Otherwise fill with
+		 * 0xffs. This is the value to invalidate unsupported
+		 * PCR banks with once at first PCR use. Also, a
+		 * non-all-zeroes value serves as an indicator to
+		 * kexec measurement restoration that the entry is not
+		 * a violation and all its template digests need to
+		 * get recomputed.
+		 */
 		if (!ima_algo_array[i].tfm) {
+#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
 			memcpy(entry->digests[i].digest,
 			       entry->digests[ima_sha1_idx].digest,
 			       TPM_DIGEST_SIZE);
+#else
+			memset(entry->digests[i].digest, 0xff, TPM_DIGEST_SIZE);
+#endif
 			continue;
 		}
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index f00ba2222c34..4db6c4be58fc 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -150,11 +150,27 @@ unsigned long ima_get_binary_runtime_size(void)
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
 {
 	int result = 0;
+	unsigned long tpm_banks_skip_mask;
 
 	if (!ima_tpm_chip)
 		return result;
 
-	result = tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
+#if !IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
+	tpm_banks_skip_mask = ima_unsupported_tpm_banks_mask;
+	if (!(ima_extended_pcrs_mask & BIT(pcr))) {
+		/*
+		 * Invalidate unsupported banks once upon a PCR's
+		 * first usage. Note that the digests[] entries for
+		 * unsupported algorithms have been filled with 0xffs.
+		 */
+		tpm_banks_skip_mask = 0;
+	}
+#else
+	tpm_banks_skip_mask = 0;
+#endif
+
+	result = tpm_pcr_extend_sel(ima_tpm_chip, pcr, digests_arg,
+				    tpm_banks_skip_mask);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
 	ima_extended_pcrs_mask |= BIT(pcr);
@@ -280,9 +296,11 @@ int __init ima_init_digests(void)
 		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
 		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
 
+#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
 		/* for unmapped TPM algorithms digest is still a padded SHA1 */
 		if (crypto_id == HASH_ALGO__LAST)
 			digest_size = SHA1_DIGEST_SIZE;
+#endif
 
 		memset(digests[i].digest, 0xff, digest_size);
 	}
-- 
2.47.1


