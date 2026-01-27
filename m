Return-Path: <linux-integrity+bounces-8332-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBeYGjrLeGnBtQEAu9opvQ
	(envelope-from <linux-integrity+bounces-8332-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:27:06 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A5959D8
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A40B6304C97D
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 14:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB5354AF7;
	Tue, 27 Jan 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFrn+HAl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58868345740;
	Tue, 27 Jan 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523679; cv=none; b=ocn7qutGVVsHAMD+bam5wlRbpne118TWQcujGWC+YxXwzRJBSJzvOO+nl/qQfwjsXRsLUzkwge4lU2D2IB9VwO89AmfTWcNjySMI8u190yJ61hdu/O6tmRz5oioNyBEoT3QPpfB4vIpkhf1/R1K6wxLULgkXND9WuEh7m6bxETo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523679; c=relaxed/simple;
	bh=dDpxkPdnRm1fkMewEhZzGAC/bAqiHsPjefxiu7vJRls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RGhFDiNOnu0Bx48Yhm1sFbxFCpEotV0edtZDl0Ck9eiOntBroIGgMy4g3hmClPTj1XPwdwab4+71mvsroQE8uf82Cr6wzPeL2lbRaS5qLqejFFOysbC0xfdPJuCI7G2Zvf75RZQCmWxsSOXPMc7pnw7QcwDeDEXb06txTJvrYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFrn+HAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E934AC116C6;
	Tue, 27 Jan 2026 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769523679;
	bh=dDpxkPdnRm1fkMewEhZzGAC/bAqiHsPjefxiu7vJRls=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=TFrn+HAlIp2db7NFiGmR7TDo57S1yDmRZrdXPvJ4F7BTQsA6rO6jKtdGftVwBZKvs
	 9iKuDFzgDNqe/FEq0PgA0uCNixurAfhMkhpdfv+AZMcyHXSlWSqf2It3Cz02JP4bCE
	 tKFluM1U9bc9DWgPsuKSI269yQYH4bpbTPNsLQA4CeI15SwQSDo3Ck6v/RjCluwMdh
	 1aSvLoiqI2OonKNXeGc+53VDbzJePLyxg3OHrQU1t/2MD1NUBeqZ5zZwvX3moIez6E
	 BeTs033gcF19PbwjcxBZXcvuwlVWdd4MuRM4OzJS15c4RrH1xLy3+Teg3Sj/IyGBpx
	 zjEUxkKzkSyFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D981CD2F02C;
	Tue, 27 Jan 2026 14:21:18 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Tue, 27 Jan 2026 14:21:13 +0000
Subject: [PATCH v3] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-ima-oob-v3-1-1dd09f4c2a6a@arista.com>
X-B4-Tracking: v=1; b=H4sIANjJeGkC/3WNyw7CIBBFf6VhLaZAH+jK/zAuBjpYFi3N0BBN0
 38XujPG5UnuOXdjEcljZNdqY4TJRx/mDOpUMTvC/ETuh8xM1rKrhey5n4CHYPjFgVbQqWboDcv
 rhdD511G6PzIbiMgNwWzH4k8QV6QyHH1cA72PxyTK/DeeBBdcDo10qhEa2/4GlDU42zCxUk/yj
 yiz6JQGoa1ua+u+xH3fP3jSKJ/xAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769523678; l=6162;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=0sOqVBGUzXxUF/x1KV8ei9ehoXPsbfmVILKXs/dm3qI=;
 b=6Oe938tXgYfn5XA2flg3KJkYx5yIM2R+mkTsJ47I2H5OejG+aib56b2bSZNDkV6g+8pE1ijK7
 77K8hfut1hcB8eIsnm3BBdO8BN3G10R3WEH38P/nPNu2UC4/bce6lTk
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
	TAGGED_FROM(0.00)[bounces-8332-lists,linux-integrity=lfdr.de,dima.arista.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,arista.com:replyto,arista.com:email,arista.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,polito.it:email]
X-Rspamd-Queue-Id: 084A5959D8
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

Grepping HASH_ALGO__LAST in security/integrity/ima/ shows that is
the check other logic relies on, so add files under TPM_ALG_<ID>
and print 0 as their hash_digest_size.

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
Changes in v3:
- Now fix the spelling *for real* (sorry, messed it up in v2)
- Link to v2: https://lore.kernel.org/r/20260127-ima-oob-v2-1-f38a18c850cf@arista.com

Changes in v2:
- Instead of skipping unknown algorithms, add files under their TPM_ALG_ID (Roberto Sassu)
- Fix spelling (Roberto Sassu)
- Copy @stable on the fix
- Link to v1: https://lore.kernel.org/r/20260127-ima-oob-v1-1-2d42f3418e57@arista.com
---
 security/integrity/ima/ima_fs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 012a58959ff0..3b442e3f84d0 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -160,7 +160,10 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
+	if (algo == HASH_ALGO__LAST)
+		ima_putc(m, "0", 1);
+	else
+		ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -252,7 +255,10 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	seq_printf(m, "%2d ", e->pcr);
 
 	/* 2nd: template hash */
-	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
+	if (algo == HASH_ALGO__LAST)
+		ima_putc(m, "0", 1);
+	else
+		ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
@@ -404,16 +410,24 @@ static int __init create_securityfs_measurement_lists(void)
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



