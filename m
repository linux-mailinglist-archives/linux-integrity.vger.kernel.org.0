Return-Path: <linux-integrity+bounces-8343-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OeILSTVeGmNtQEAu9opvQ
	(envelope-from <linux-integrity+bounces-8343-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 16:09:24 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A0E965C9
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 16:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB05730DCFD9
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484535D5E0;
	Tue, 27 Jan 2026 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTa4+Y5x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD135CBB8;
	Tue, 27 Jan 2026 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526245; cv=none; b=b57hcD5HWmJQTATArTUBKppDsSYRzkTUrQz/1pC5kIj9uCBuGkvT8mcjNvxNBZWJd6DEakbOr0pa+sU4SvDnnBTDAPLFqUt0V2njc8A+eFoO6dae5B4ks9F+29xxchOqL+kdDKWeKQedWf8JiIOAoII8pkEImY9NCVVSAfQncR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526245; c=relaxed/simple;
	bh=IZ2U++iYob4bPRc7rFTS3Idcps1mxPfWbxAVVkGL7/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SIudaQjlfQQJX0HqaOvtmCvf+JH+Yf7zoaLzMpvWt02EXFxsM3CW3r7+lTyUuZlR/dGMLMvCPvFD2xSoqZONgkuwPoxDnPst45tDYOFtt9TzJRPlduL8jBp+FevmaAqNOwglixyMlcbyYwGFUm8ax35IAJnU11yls0aJeqd5oC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTa4+Y5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4B8EC2BC86;
	Tue, 27 Jan 2026 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526244;
	bh=IZ2U++iYob4bPRc7rFTS3Idcps1mxPfWbxAVVkGL7/s=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=aTa4+Y5xMzjNAghho/Z/w/Tedb86dRQAnxKxdBPJTfB8XOsB7feyYxrBJti/tUwZP
	 LxisqYmGazgTUgg9YAtexV4eUlcnxrI8lDP4SZN61W2zgy44XOpWG3nW5kxmHZi3Ks
	 5nePBIjodvoRkOQT+lgzhedsTTqEb2lU8Vx6nzuFwOrf/KsnFabX6C96iIZhAHUZ8d
	 SOh32bzjBXbadIm0rrlr4NydBOZB2SOQhqMM/SgSUv0m7TsISJ6b70Ldt5HC+xPPzf
	 GtCkWLafbBiTVjQRf489ojCHi571BS8w6781zzA+v7ofzqPJG/WuuJFgkPJyVc3NsS
	 oIXdCpew7hKoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABDDD2F033;
	Tue, 27 Jan 2026 15:04:04 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Tue, 27 Jan 2026 15:03:55 +0000
Subject: [PATCH v4] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-ima-oob-v4-1-bf0cd7f9b4d4@arista.com>
X-B4-Tracking: v=1; b=H4sIANvTeGkC/3XNSw6CMBgE4KuQrq3pCyiuvIdx8fclXUBNSxoN4
 e627AxhOcl8MytKNnqb0K1ZUbTZJx/mEsSlQXqE+WWxNyUjRlhHKOuxnwCHoPDgQHLouDC9QqX
 9jtb5z770eJasIFmsIsx6rH6CtNhYi6NPS4jf/THTWj+OZ4opZkYwxwWVtu3vEAuDqw4TquuZn
 UBWoOMSqNSyJdodID+BvEBqDBmc0Aw6+IPbtv0A426wqSoBAAA=
X-Change-ID: 20260127-ima-oob-9fa83a634d7b
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Silvia Sisinni <silvia.sisinni@polito.it>, 
 Enrico Bravi <enrico.bravi@polito.it>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>, Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769526243; l=7350;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=0AkeOCmKPP2c51CYjq6niks0p6IekSQkns2k9gvZ5rA=;
 b=SXYOCsFlGx3soR/M0Cmf8qp4u6OBq5w85w+BL6cTLhDO2my4HxDLurlst54YX+cjQfWOSs4sb
 1RQdPqC9VAnBcSvbcCCvr9mhFHWRb4FB80w1/a+B5Q5jLNK9LQjyjKa
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8343-lists,linux-integrity=lfdr.de,dima.arista.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,arista.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[dima@arista.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-integrity@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arista.com:replyto,arista.com:email,arista.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 55A0E965C9
X-Rspamd-Action: no action

From: Dmitry Safonov <dima@arista.com>

ima_init_crypto() skips initializing ima_algo_array[i] if the algorithm
from ima_tpm_chip->allocated_banks[i].crypto_id is not supported.
It seems avoid adding the unsupported algorithm to ima_algo_array will
break all the logic that relies on indexing by NR_BANKS(ima_tpm_chip).

On 6.12.40 I observe the following read out-of-bounds in hash_algo_name:

> ==================================================================
> BUG: KASAN: global-out-of-bounds in create_securityfs_measurement_lists+0x396/0x440
> Read of size 8 at addr ffffffff83e18138 by task swapper/0/1
>
> CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.40 #3
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x61/0x90
>  print_report+0xc4/0x580
>  ? kasan_addr_to_slab+0x26/0x80
>  ? create_securityfs_measurement_lists+0x396/0x440
>  kasan_report+0xc2/0x100
>  ? create_securityfs_measurement_lists+0x396/0x440
>  create_securityfs_measurement_lists+0x396/0x440
>  ima_fs_init+0xa3/0x300
>  ima_init+0x7d/0xd0
>  init_ima+0x28/0x100
>  do_one_initcall+0xa6/0x3e0
>  kernel_init_freeable+0x455/0x740
>  kernel_init+0x24/0x1d0
>  ret_from_fork+0x38/0x80
>  ret_from_fork_asm+0x11/0x20
>  </TASK>
>
> The buggy address belongs to the variable:
>  hash_algo_name+0xb8/0x420
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107ce18
> flags: 0x8000000000002000(reserved|zone=2)
> raw: 8000000000002000 ffffea0041f38608 ffffea0041f38608 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffffffff83e18000: 00 01 f9 f9 f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9
>  ffffffff83e18080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffffff83e18100: 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 00 05 f9 f9
>                                         ^
>  ffffffff83e18180: f9 f9 f9 f9 00 00 00 00 00 00 00 04 f9 f9 f9 f9
>  ffffffff83e18200: 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9 f9 f9
> ==================================================================

Seems like the TPM chip supports sha3_256, which isn't yet in
tpm_algorithms:
> tpm tpm0: TPM with unsupported bank algorithm 0x0027

Use TPM_ALG_<ID> as a postfix for file names for unsupported hashing algorithms.

This is how it looks on the test machine I have:
> # ls -1 /sys/kernel/security/ima/
> ascii_runtime_measurements
> ascii_runtime_measurements_TPM_ALG_27
> ascii_runtime_measurements_sha1
> ascii_runtime_measurements_sha256
> binary_runtime_measurements
> binary_runtime_measurements_TPM_ALG_27
> binary_runtime_measurements_sha1
> binary_runtime_measurements_sha256
> policy
> runtime_measurements_count
> violations

Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash algorithm")
Signed-off-by: Dmitry Safonov <dima@arista.com>
Cc: Enrico Bravi <enrico.bravi@polito.it>
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
---
Changes in v4:
- Use ima_tpm_chip->allocated_banks[algo_idx].digest_size instead of hash_digest_size[algo]
  (Roberto Sassu)
- Link to v3: https://lore.kernel.org/r/20260127-ima-oob-v3-1-1dd09f4c2a6a@arista.com
Testing note: I test it on v6.12.40 kernel backport, which slightly differs as
lookup_template_data_hash_algo() was yet present.

Changes in v3:
- Now fix the spelling *for real* (sorry, messed it up in v2)
- Link to v2: https://lore.kernel.org/r/20260127-ima-oob-v2-1-f38a18c850cf@arista.com

Changes in v2:
- Instead of skipping unknown algorithms, add files under their TPM_ALG_ID (Roberto Sassu)
- Fix spelling (Roberto Sassu)
- Copy @stable on the fix
- Link to v1: https://lore.kernel.org/r/20260127-ima-oob-v1-1-2d42f3418e57@arista.com
---
 security/integrity/ima/ima_fs.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 012a58959ff0..9a00a0547619 100644
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
+		 ima_tpm_chip->allocated_banks[algo_idx].digest_size);
 
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
+			 ima_tpm_chip->allocated_banks[algo_idx].digest_size);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
@@ -404,16 +398,24 @@ static int __init create_securityfs_measurement_lists(void)
 		char file_name[NAME_MAX + 1];
 		struct dentry *dentry;
 
-		sprintf(file_name, "ascii_runtime_measurements_%s",
-			hash_algo_name[algo]);
+		if (algo == HASH_ALGO__LAST)
+			sprintf(file_name, "ascii_runtime_measurements_TPM_ALG_%x",
+				ima_tpm_chip->allocated_banks[i].alg_id);
+		else
+			sprintf(file_name, "ascii_runtime_measurements_%s",
+				hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
 						ima_dir, (void *)(uintptr_t)i,
 						&ima_ascii_measurements_ops);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 
-		sprintf(file_name, "binary_runtime_measurements_%s",
-			hash_algo_name[algo]);
+		if (algo == HASH_ALGO__LAST)
+			sprintf(file_name, "binary_runtime_measurements_TPM_ALG_%x",
+				ima_tpm_chip->allocated_banks[i].alg_id);
+		else
+			sprintf(file_name, "binary_runtime_measurements_%s",
+				hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
 						ima_dir, (void *)(uintptr_t)i,
 						&ima_measurements_ops);

---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260127-ima-oob-9fa83a634d7b

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



