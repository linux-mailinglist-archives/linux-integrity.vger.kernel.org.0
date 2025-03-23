Return-Path: <linux-integrity+bounces-5395-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DDA6CFAD
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921703B5FFD
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571DC78F33;
	Sun, 23 Mar 2025 14:10:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881B1779AE
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739038; cv=none; b=KnmQOY1AvX/Z/283o+RJHEE+PF5WPFOz3Mn+6Sbac3jByschk8y4/8BmKW1zAulsDkfIdpWtkBvzpS8MhE3I9ZL8Vx+KcGr6nGV3WByPEgefL9sxC2gaEQrNlPwyD5T2hAY3lI3EX3w3eRXlRZH/XcnseWvsj4BP745rlwNDues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739038; c=relaxed/simple;
	bh=ilkcgqMawpbRXVpG7EBIu+pEGcey+Q1f2F/+6j21r+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdhsyQzIMpgMORGiETA+gIlVixJombiPHVKsdHYSIwvWq4VM4uee2DoSlj4zsC8yEZkFP+cU58ksC7MQDf/NVRG07Tn6xZYkcpHcB/JBVgDszxlYJfuhzYrXZctydCTcq6v7MR0d2nS+sqN0ug7f/m050Nyn+tsBaU+cts+O6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5326211B4;
	Sun, 23 Mar 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BED1C1339F;
	Sun, 23 Mar 2025 14:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ng1sLVUW4Ge2PAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:29 +0000
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
Subject: [RFC PATCH v2 11/13] ima: introduce ima_pcr_invalidated_banks() helper
Date: Sun, 23 Mar 2025 15:09:09 +0100
Message-ID: <20250323140911.226137-12-nstange@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D5326211B4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

At the current stage, IMA would invalidate PCR banks corresponding to
unsupported hash algorithms exactly once by extending with the special
0xfe ... fe from each kernel in a kexec chain.

In order to work towards the goal of doing that only once for the
overall chain, subsequent kernels must be able to recognize already
invalidated PCR banks.

PCR banks invalidated when in their initial reset state would have a value
of HASH(0x00 ... 00 | fe ... fe).

Introduce the ima_pcr_invalidated_banks() implementing this comparison for
a couple of selected hash algorithms, namely the set the current TPM
driver code knows about.

Note that false positives would be fatal as far as soundness is concerned,
as a future patch will make IMA to skip invalidations for banks reported
to have been invalidated already. False negatives however will only cause
superfluous re-invalidations, i.e. a PCR bank would not be recognizable as
unsupported anymore, but any attempt to verify a measurement list against
it would still fail. Thus, ima_pcr_invalidated_banks() doesn't necessarily
need to support every hash algorithm possible and in particular, failure
to keep it in sync with the TPM driver code, should the latter learn about
some more hash algorithms in the future, would not be an issue.

Let ima_pcr_invalidated_banks() read back all of a given PCR's bank
digests from the TPM. Attempt to compare each against the well-known
value of HASH(0x00 ... 00 | fe ... fe) and, in case of a match, set the
corresponding bit in a bitmask returned eventually back to the caller.

The type chosen for the returned bitmask is unsigned long. If the number
of allocated banks exceeds its width, stop early after BITS_PER_LONG banks
have been examined -- as mention earlier false negatives aren't fatal.

In order to enable ima_pcr_invalidated_banks() to make comparisons against
those well-known HASH(...) values from above, even in the scenario of
interest here where the kernel's crypto API is lacking a usable
implementation for some hash, provide them as pre-computed values in a
lookup table for a number of selected hash algorithms, namely those
recognized by the current TPM driver code.

Lastly a word of caution towards the cherry-pickers among us: you will
likely also want that other patch to the TPM driver code making
tpm2_pcr_read() to authenticate the TPM response -- otherwise an
interposer could potentially trick IMA to skip a needed PCR bank
invalidation from a kexeced kernel even with CONFIG_TCG_TPM2_HMAC=y.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima.h        |   1 +
 security/integrity/ima/ima_crypto.c | 125 ++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7ad4a1eefd94..67b78f5512f1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -274,6 +274,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		       struct ima_iint_cache *iint, const char *op,
 		       const char *cause);
 int ima_init_crypto(void);
+unsigned long ima_pcr_invalidated_banks(u32 pcr);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 int template_desc_init_fields(const char *template_fmt,
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index c78bf4872b6a..c1d9cd85a66d 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -900,3 +900,128 @@ int ima_calc_boot_aggregate(struct ima_digest_data *hash)
 
 	return rc;
 }
+
+/*
+ * Expected values for unsupported PCR banks after invalidating once
+ * with 0xfe ... fe, i.e. HASH(0x00 ... 00 fe ... fe).
+ * The list might not be exhaustive as far as the set of recognized
+ * algorithms is concerned.
+ */
+static const struct {
+	u16 tpm_alg_id;
+	u8 digest_length;
+	const u8 *digest;
+} unsupported_pcr_bank_values[] = {
+	{
+		TPM_ALG_SHA1, 20,
+		(const u8[]) {
+			0x74, 0x43, 0x5f, 0x39, 0xb5, 0x05, 0x21, 0x26,
+			0x9d, 0xaa, 0xfd, 0x3e, 0x11, 0x1b, 0xf1, 0xd9,
+			0x14, 0x1d, 0x9a, 0x5f,
+		},
+	},
+	{
+		TPM_ALG_SHA256, 32,
+		(const u8[]) {
+			0x7a, 0x42, 0xe1, 0xf2, 0x6c, 0x07, 0x82, 0x7f,
+			0xaa, 0x54, 0x87, 0x47, 0x62, 0xfd, 0x7f, 0xe7,
+			0xa1, 0xdf, 0xbb, 0x8f, 0xfa, 0x51, 0xbf, 0x53,
+			0x22, 0xa7, 0x71, 0xd2, 0xc8, 0x80, 0xc5, 0x86,
+		},
+	},
+	{
+		TPM_ALG_SHA384, 48,
+		(const u8[]) {
+			0x68, 0xaa, 0xdf, 0xd3, 0x3e, 0x54, 0x15, 0x40,
+			0x73, 0xc8, 0x6a, 0x95, 0x8d, 0x5d, 0x7b, 0xb2,
+			0x68, 0xf3, 0x0c, 0x14, 0x9e, 0x19, 0x6d, 0x08,
+			0x24, 0x7d, 0x51, 0x26, 0x05, 0xe5, 0x1c, 0x40,
+			0xdd, 0xc8, 0x44, 0x4e, 0x93, 0x8a, 0x37, 0x05,
+			0xfc, 0xd6, 0xa2, 0x80, 0xe3, 0x27, 0x0d, 0x71,
+		},
+	},
+	{
+		TPM_ALG_SHA512, 64,
+		(const u8[]) {
+			0x58, 0x8c, 0x38, 0x64, 0x06, 0xdb, 0x9b, 0xcc,
+			0x26, 0xa4, 0x13, 0x9c, 0x8a, 0xff, 0x6a, 0x10,
+			0xf4, 0xe6, 0x5a, 0x92, 0xbd, 0xed, 0x9d, 0x62,
+			0xbe, 0x92, 0x1b, 0x40, 0xf6, 0x7d, 0x9b, 0xc3,
+			0x0d, 0x07, 0xc8, 0xfb, 0x1a, 0x8d, 0x56, 0xfa,
+			0xa4, 0xf2, 0x05, 0xb6, 0x81, 0x29, 0x14, 0x5f,
+			0xf6, 0x71, 0x32, 0xbb, 0x0d, 0x31, 0xca, 0xf3,
+			0x5e, 0x8e, 0x95, 0xd9, 0xd8, 0x55, 0x28, 0x95,
+		},
+	},
+	{
+		TPM_ALG_SM3_256, 32,
+		(const u8[]) {
+			0x05, 0xff, 0xaf, 0x59, 0x7e, 0x50, 0x39, 0x5b,
+			0xaf, 0x69, 0xc0, 0xdc, 0x19, 0xb0, 0xe0, 0xfe,
+			0x3f, 0x6b, 0x6f, 0x03, 0xcd, 0x04, 0xf6, 0x80,
+			0x6c, 0x59, 0xdc, 0xd2, 0x06, 0xbf, 0x38, 0x78
+		},
+	},
+};
+
+/*
+ * Return true if the supplied PCR digest can get confirmed to match
+ * the expected value a bank with unsupported associated hash algorithm
+ * would have after invalidating it exactly once.
+ * Otherwise, return false.
+ *
+ * False negatives are tolerable from a soundness POV, but would
+ * potentially cause additional re-invalidations e.g. after kexec.
+ */
+static bool is_pcr_bank_invalidated(const struct tpm_digest * const digest)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(unsupported_pcr_bank_values); ++i) {
+		if (unsupported_pcr_bank_values[i].tpm_alg_id == digest->alg_id)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(unsupported_pcr_bank_values))
+		return false;
+
+	return memcmp(unsupported_pcr_bank_values[i].digest, digest->digest,
+		      unsupported_pcr_bank_values[i].digest_length) == 0;
+}
+
+/*
+ * Read all of a PCR's banks and check which of those have a value
+ * matching the expected digest after invalidating once for
+ * unsupported algorithms.
+ *
+ * A bitmask of banks found to have been invalidated is getting
+ * returned. The set is not guaranteed to be complete.
+ */
+unsigned long ima_pcr_invalidated_banks(u32 pcr)
+{
+	int i, r;
+	struct tpm_digest d;
+	unsigned long invalidated_banks_mask = 0;
+
+	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
+		if (i >= BITS_PER_LONG)
+			break;
+
+		d.alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
+		r = tpm_pcr_read(ima_tpm_chip, pcr, &d);
+		if (r) {
+			/*
+			 * Failure to read is non-fatal, emit a
+			 * warning only and move on to the next bank.
+			 */
+			pr_warn("TPM PCR read failed %d, pcr=%d, bank=0x%02x\n",
+				r, pcr,
+				ima_tpm_chip->allocated_banks[i].alg_id);
+		}
+
+		if (is_pcr_bank_invalidated(&d))
+			invalidated_banks_mask |= BIT(i);
+	}
+
+	return invalidated_banks_mask;
+}
-- 
2.49.0


