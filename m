Return-Path: <linux-integrity+bounces-8680-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II38MvSIoWmVuAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8680-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 13:07:16 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 614431B6EAD
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 13:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE610304EA44
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Feb 2026 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4973A0E97;
	Fri, 27 Feb 2026 12:07:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4CC3195F0;
	Fri, 27 Feb 2026 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194033; cv=none; b=brfRb79o0xJTgiX5pxuOxq0bIFro1d+vbwdZnSnW2LfhGEXNiOOpZqn1PJMoDZGBKmAw68pTS1slBCJauSswuqEf8U2lbMtzRns9G3GsDxMyxU04fIdqRZgrzISx8U2Emi5XSa5S0yH2W7k41ZwHr8Lyt7QbtTFZ33y/A7jN6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194033; c=relaxed/simple;
	bh=04SHwE5oCQpOakymHVJTL2yLNocaSt4O1akHJnQ7FKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwPKAI05/3xSSwNJxtaL+JuICFj38QqMrq3XT0ud8vKdmoY3C7sRwyez3+188IzcawoXbWmBaLOh+HCLz5Io30TWgtt/fQfx8GIEZORn09jv2JnUfmhTgnxDb9ftjfIiY5Jm1vMZrq8Fo4ByhEUo4DWnuv6GcEs4wY4WfhIR2M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fMn6W3c77zpVBV;
	Fri, 27 Feb 2026 20:03:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 214074056B;
	Fri, 27 Feb 2026 20:07:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCX0wXdiKFpsT6ZBA--.60481S2;
	Fri, 27 Feb 2026 13:07:01 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devnull+dima.arista.com@kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2] ima: Define and use a digest_size field in the ima_algo_desc structure
Date: Fri, 27 Feb 2026 13:06:45 +0100
Message-ID: <20260227120645.1374192-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCX0wXdiKFpsT6ZBA--.60481S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3uFy7Xw1Dtw1xJFyDtrb_yoW7Jw47p3
	Z5WF1FkF1kAFy2krn3CasxCFWagrWY9Fy7W395J34vyFn8Wr1UKwn3CrySkrW5WrW5JFyx
	trWqqr15Cwn8taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGmhDaAIPwAAsF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8680-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity,dima.arista.com];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 614431B6EAD
X-Rspamd-Action: no action

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the digest_size field to the ima_algo_desc structure to determine the
digest size from the correct source.

If the hash algorithm is among allocated PCR banks, take the value from the
TPM bank info (equal to the value from the crypto subsystem if the TPM
algorithm is supported by it; otherwise, not exceding the size of the
digest buffer in the tpm_digest structure, used by IMA).

If the hash algorithm is SHA1, use the predefined value. Lastly, if the
hash algorithm is the default one but not among the PCR banks, take the
digest size from the crypto subsystem (the default hash algorithm is
checked when parsing the ima_hash= command line option).

Finally, use the new information to correctly show the template digest in
ima_measurements_show() and ima_ascii_measurements_show().

Link: https://github.com/linux-integrity/linux/issues/14
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_crypto.c |  6 ++++++
 security/integrity/ima/ima_fs.c     | 18 ++++++------------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 89ebe98ffc5e..c38a9eb945b6 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -53,6 +53,7 @@ extern atomic_t ima_setxattr_allowed_hash_algorithms;
 struct ima_algo_desc {
 	struct crypto_shash *tfm;
 	enum hash_algo algo;
+	unsigned int digest_size;
 };
 
 /* set during initialization */
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 8ae7821a65c2..c2a859710d20 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -109,6 +109,7 @@ static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
 
 int __init ima_init_crypto(void)
 {
+	unsigned int digest_size;
 	enum hash_algo algo;
 	long rc;
 	int i;
@@ -147,7 +148,9 @@ int __init ima_init_crypto(void)
 
 	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
 		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+		digest_size = ima_tpm_chip->allocated_banks[i].digest_size;
 		ima_algo_array[i].algo = algo;
+		ima_algo_array[i].digest_size = digest_size;
 
 		/* unknown TPM algorithm */
 		if (algo == HASH_ALGO__LAST)
@@ -183,12 +186,15 @@ int __init ima_init_crypto(void)
 		}
 
 		ima_algo_array[ima_sha1_idx].algo = HASH_ALGO_SHA1;
+		ima_algo_array[ima_sha1_idx].digest_size = SHA1_DIGEST_SIZE;
 	}
 
 	if (ima_hash_algo_idx >= NR_BANKS(ima_tpm_chip) &&
 	    ima_hash_algo_idx != ima_sha1_idx) {
+		digest_size = hash_digest_size[ima_hash_algo];
 		ima_algo_array[ima_hash_algo_idx].tfm = ima_shash_tfm;
 		ima_algo_array[ima_hash_algo_idx].algo = ima_hash_algo;
+		ima_algo_array[ima_hash_algo_idx].digest_size = digest_size;
 	}
 
 	return 0;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 012a58959ff0..23d3a14b8ce3 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -132,16 +132,12 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	char *template_name;
 	u32 pcr, namelen, template_data_len; /* temporary fields */
 	bool is_ima_template = false;
-	enum hash_algo algo;
 	int i, algo_idx;
 
 	algo_idx = ima_sha1_idx;
-	algo = HASH_ALGO_SHA1;
 
-	if (m->file != NULL) {
+	if (m->file != NULL)
 		algo_idx = (unsigned long)file_inode(m->file)->i_private;
-		algo = ima_algo_array[algo_idx].algo;
-	}
 
 	/* get entry */
 	e = qe->entry;
@@ -160,7 +156,8 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
+	ima_putc(m, e->digests[algo_idx].digest,
+		 ima_algo_array[algo_idx].digest_size);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -229,16 +226,12 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	enum hash_algo algo;
 	int i, algo_idx;
 
 	algo_idx = ima_sha1_idx;
-	algo = HASH_ALGO_SHA1;
 
-	if (m->file != NULL) {
+	if (m->file != NULL)
 		algo_idx = (unsigned long)file_inode(m->file)->i_private;
-		algo = ima_algo_array[algo_idx].algo;
-	}
 
 	/* get entry */
 	e = qe->entry;
@@ -252,7 +245,8 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	seq_printf(m, "%2d ", e->pcr);
 
 	/* 2nd: template hash */
-	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
+	ima_print_digest(m, e->digests[algo_idx].digest,
+			 ima_algo_array[algo_idx].digest_size);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
-- 
2.43.0


