Return-Path: <linux-integrity+bounces-5388-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC3A6CFA4
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0205189996F
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A38139566;
	Sun, 23 Mar 2025 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rhL80bl3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hr82Tufh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rhL80bl3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hr82Tufh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B96136E37
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739015; cv=none; b=sAd5JY0buPQK+2kIw4h5u8CbF86lIm3yAWB+W3WLpj074RVi6cnG1cW+FHLkfjHFi5T4L7s/FQ5PkdLls40Xdhhcvmx4Vwhp4M/0jqVJCpfOsouVjU2N5F/9FBPCP3LAyhWGJtrF/OT76iFqF18iWjZS29Ybxv07RFhVCTFPNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739015; c=relaxed/simple;
	bh=zLfYHYzKHZZUziJQ2voZBXjm67Fh/DrkSqq60SrZLlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQqISJYdXHeiKCOIxs4nkQzFhebSa6tWyqeQgEEbdsjv3hKzWaAm9PGe1m8EtINp0/ZFMztr2bDVUEcBNkQk49RIhJNQsYNhyw2AEYTufWeDJqTluu46ZtEbKI2/EE8TD5KskxucduvuCyX57iyys1IiWu0jDEPUqT+m7f9O06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rhL80bl3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hr82Tufh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rhL80bl3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hr82Tufh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 264071F458;
	Sun, 23 Mar 2025 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzlaUYsL4gaBxvghA6DZt5QXZeorfSSYq5S6SNCMBN8=;
	b=rhL80bl3rX8BCxCCh4dxEeCspqEZfhl4PxTM75X+IejAjkZ+R98a3oaVPSUab5VfF91F6F
	RpCa+GPaoIuZocJQdjZ/GWqrf8JSkrgxD4NuAoGKuwpgCo+WaPhkmYJPDff4207Ujnq9x4
	WHXRy81cRhFJLvR5RCBcAOW5TpmmF9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzlaUYsL4gaBxvghA6DZt5QXZeorfSSYq5S6SNCMBN8=;
	b=hr82TufhCgx5dpw3Wz2ZBC6TsIxYg2P4u6pVdMGMDuUbo6w0vNpUB7f3Fduie2IwDYKl0U
	WE9O/yrsCyN1AvAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzlaUYsL4gaBxvghA6DZt5QXZeorfSSYq5S6SNCMBN8=;
	b=rhL80bl3rX8BCxCCh4dxEeCspqEZfhl4PxTM75X+IejAjkZ+R98a3oaVPSUab5VfF91F6F
	RpCa+GPaoIuZocJQdjZ/GWqrf8JSkrgxD4NuAoGKuwpgCo+WaPhkmYJPDff4207Ujnq9x4
	WHXRy81cRhFJLvR5RCBcAOW5TpmmF9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzlaUYsL4gaBxvghA6DZt5QXZeorfSSYq5S6SNCMBN8=;
	b=hr82TufhCgx5dpw3Wz2ZBC6TsIxYg2P4u6pVdMGMDuUbo6w0vNpUB7f3Fduie2IwDYKl0U
	WE9O/yrsCyN1AvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15E4B1339F;
	Sun, 23 Mar 2025 14:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jp8kBD4W4GeYPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:06 +0000
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
Subject: [RFC PATCH v2 03/13] ima: invalidate unsupported PCR banks
Date: Sun, 23 Mar 2025 15:09:01 +0100
Message-ID: <20250323140911.226137-4-nstange@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Normally IMA would extend a template hash of each bank's associated
algorithm into a PCR. However, if a bank's hash algorithm is unavailable
to the kernel at IMA init time, it would fallback to extending padded SHA1
hashes instead.

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
b.) Don't extend unsupported banks at all.
c.) Record every event as a violation, i.e. extend unsupported banks
    with 0xffs.
d.) Invalidate unsupported banks at least once by extending with a unique
    constant (e.g. with 0xfes).

a.) would make verification from tools like ima_measurement nearly
    impossible, as it would have to guess or somehow determine ima_hash.
b.) is a security risk, because the bank would validate an empty
    measurement list.
c.) isn't ideal security-wise either, because an unsupported bank would
    then validate an all-violations measurement log.
d.) is the only remaining viable option: extending unsupported PCR banks
    at least once with a unique constant of 0xfe ... fe not used for
    anything else would make those not to validate anything from that
    point on.

For this last alternative d.), there are some variations possible, which
differ in the number of times the magic 0xfe ... fe gets extended into
unsupported banks for invalidation purposes. Among the practical ones
are:
- invalidate each unsupported bank over and over again for each new
  measurement log entry or
- invalidate each unsupported bank exactly once.

The second option has the advantage over the first that it would enable
tools like ima-evm-utils' ima_measurement to recognize unsupported banks
in O(1) time, just by comparing the PCR bank value against the constant
HASH(00 .. 00 | fe .. fe). Note that if OTOH a bank got invalidated over
and over again for each single log entry, and assuming that it's desired
to report unsupported banks as such instead of just failing their
validation, ima_measurement would have to try to match yet another PCR
extension candidate sequence for the 0xfe .. fe over the complete
measurement list, as it's currently being done for the padded SHA1s
template hashes already.

As appealing as the scheme to invalidate each unsupported bank exactly once
might seem at first glance though, there's also the clear drawback of an
additional tracking burden with a significant complexity on the kernel
side: because IMA can't know ahead of time which out of all possible PCRs
would ever get referenced from some policy rules, it cannot simply run the
invalidation of unsupported banks upfront at __init, but would have to do
it lazily upon a given PCR's first extension. The need for carrying the
required state across kexecs, with the possibility of different kernels in
the kexec chain potentially supporting different sets of hash algorithms,
doesn't exactly make things easier either.

So, to move towards the original goal of disentangling IMA from its hard
dependency on SHA-1, go with the more straightforward route for now to
invalidate unsupported PCR banks over and over again for each new
measurement list entry recorded. The more sophisticated
"invalidate-exactly-once" scheme will be left to future patches, if to be
implemented at all.

As this potentially breaks existing userspace, i.e. the current
implementation of ima_measurement, put it behind a Kconfig option,
"IMA_COMPAT_FALLBACK_TPM_EXTEND". If set to "y", the original behavior of
extending with padded SHA-1 is retained. Otherwise the new scheme to
invalidate unsupported PCR banks by extending with constant 0xfe ... fe
will be effective. As ima_measurement is marked as experimental and I find
it unlikely that other existing tools depend on the padded SHA-1 fallback
scheme, make the IMA_COMPAT_FALLBACK_TPM_EXTEND Kconfig option default
to "n".

For IMA_COMPAT_FALLBACK_TPM_EXTEND=n,
- to cover PCR extensions for "regular" measurement list entries, make
  ima_calc_field_array_hash() to fill the digests corresponding to banks
  with unsupported hash algorithms with 0xfes,
- to cover PCR extensions for violation entries, make ima_init_digest() to
  likewise provision the digests[] elements corresponding to unsupported
  banks with 0xfes.

[1] https://github.com/linux-integrity/ima-evm-utils

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/Kconfig      | 14 ++++++++++++++
 security/integrity/ima/ima_crypto.c | 19 ++++++++++++++++++-
 security/integrity/ima/ima_queue.c  | 12 ++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 475c32615006..c8f12a4a4edf 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -122,6 +122,20 @@ config IMA_DEFAULT_HASH
 	default "wp512" if IMA_DEFAULT_HASH_WP512
 	default "sm3" if IMA_DEFAULT_HASH_SM3
 
+config IMA_COMPAT_FALLBACK_TPM_EXTEND
+	bool "Enable compatibility TPM PCR extend for unsupported banks"
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
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 6f5696d999d0..a43080fb8edc 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -625,26 +625,43 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
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
+		 * extension is enabled. Otherwise fill with
+		 * 0xfes. This is the value to invalidate unsupported
+		 * PCR banks with. Also, a non-all-zeroes value serves
+		 * as an indicator to kexec measurement restoration
+		 * that the entry is not a violation and all its
+		 * template digests need to get recomputed.
+		 */
 		if (!ima_algo_array[i].tfm) {
+#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
 			memcpy(entry->digests[i].digest,
 			       entry->digests[ima_sha1_idx].digest,
 			       TPM_DIGEST_SIZE);
+#else
+			memset(entry->digests[i].digest, 0xfe, TPM_DIGEST_SIZE);
+#endif
 			continue;
 		}
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 83d53824aa98..0cc1189446a8 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -274,11 +274,23 @@ int __init ima_init_digests(void)
 		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
 		crypto_id = ima_tpm_chip->allocated_banks[i].crypto_id;
 
+#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
 		/* for unmapped TPM algorithms digest is still a padded SHA1 */
 		if (crypto_id == HASH_ALGO__LAST)
 			digest_size = SHA1_DIGEST_SIZE;
 
 		memset(digests[i].digest, 0xff, digest_size);
+#else
+		if (ima_algo_array[i].tfm) {
+			memset(digests[i].digest, 0xff, digest_size);
+		} else {
+			/*
+			 * Unsupported banks are invalidated with 0xfe ... fe
+			 * to disambiguate from violations.
+			 */
+			memset(digests[i].digest, 0xfe, digest_size);
+		}
+#endif
 	}
 
 	return 0;
-- 
2.49.0


