Return-Path: <linux-integrity+bounces-8537-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 51exGiZsnGlNGQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8537-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 16:03:02 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C6178654
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 16:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5AC9303A8E7
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084727380A;
	Mon, 23 Feb 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMjFkSTk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5FF27144B;
	Mon, 23 Feb 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858626; cv=none; b=tx69CbjcrLF2Rn3dHdMArBkXU9HdNvW89CEMPzeA2kgmpKnBf25v0Co/J5tY73G3syrVa8mw1Up2cUDUDiuBZZ5Js7i+bwltoU8gx6aFb4rqpxmALUloUWbASpqLsvYfLrkxToPUhmgdRuw0hU/j29ySnZS36d5G0gZZWod3kkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858626; c=relaxed/simple;
	bh=0QkG7IXYCVY7+kXNdqi/xvny/8zHAyZSF7ImhneqUvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WgwiEydSqRJBtAA8qY0XN0oAZLJZeOjdYZHP4OLcqEhMHVjxI5vhN7nOvDrSDws9bhCamQ9KfTfKzYWYUyKmiAzpnYViZKZHpXdqFxvEY9pOGFSxUmxyx6qOyCv3TQy1iNALURrN39eF7RWbyQwkgr8sE4i3s2IgaDt9rgFJ2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMjFkSTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43863C116C6;
	Mon, 23 Feb 2026 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771858626;
	bh=0QkG7IXYCVY7+kXNdqi/xvny/8zHAyZSF7ImhneqUvM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=AMjFkSTkrSanhesNmQ7LN96u9B4gaJtWkbpgjNowXVJOGM2L5qYuL3kqvBTeqozZd
	 aaMiNGugn4+Le2W0LAAeWuEPdcM/69jjWyOCoAuAwW79yaUN8eD37UpJzoZ9aYJ33z
	 dAkX3Ot2BMJKchYfxtLNGWtOSWKuwXbJJAHKnRUUuWX1Le3qvzVHMpvBRqrx37r7aN
	 I2KuBRgDAbJzTBmj/gmvpgaJaqD+Xuon29y9jNzEr0Hlv33D1Ka4znRK1AnX6S5RgW
	 fqXr+RfXe16T3rO1M0+U94cDAyaIwTxYUOVtiBqQy18AKKltYYjHJY0K6Sl8pOCilm
	 jdMtYvMZGnGmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F47CEA4FCE;
	Mon, 23 Feb 2026 14:57:06 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Mon, 23 Feb 2026 14:56:57 +0000
Subject: [PATCH v5] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-ima-oob-v5-1-91cc1064e767@arista.com>
X-B4-Tracking: v=1; b=H4sIALhqnGkC/3XNSw6CMBgE4KuQrq3pCyiuvIdx8fclXUBNSxoN4
 e627AxhOcl8MytKNnqb0K1ZUbTZJx/mEtpLg/QI88tib0pGjLCOUNZjPwEOQeHBgeTQcWF6hUr
 7Ha3zn33p8SxZQbJYRZj1WP0EabGxFkeflhC/+2OmtX4czxRTzIxgjgsqbdvfIRYGVx0mVNczO
 4GsQMclUKllS7Q7QH4CeYHUGDI4oRl0cIDiBIoClSPa9G5Qwog/uG3bD4rTvItjAQAA
X-Change-ID: 20260127-ima-oob-9fa83a634d7b
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Silvia Sisinni <silvia.sisinni@polito.it>, 
 Enrico Bravi <enrico.bravi@polito.it>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
 Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771858625; l=7264;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=1zfQNwMpVQJJaErTAqhxb6R+h8DyzMNUh2coTShYYwI=;
 b=nhQathIFcET8SfpfXIav3K2AOzBW6ism7bQXCJsUkL79MmyGOx2g3SREXbaG8SA6L98h6xupL
 DYdLNLtOFVNAWW9by0sqNAxU3d/NPNweGe3GN8KQ8zKG/pLhT8WPQuH
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8537-lists,linux-integrity=lfdr.de,dima.arista.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,gmail.com,arista.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[dima@arista.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-integrity@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,polito.it:email]
X-Rspamd-Queue-Id: 0C6C6178654
X-Rspamd-Action: no action

From: Dmitry Safonov <dima@arista.com>

ima_tpm_chip->allocated_banks[i].crypto_id is initialized to
HASH_ALGO__LAST if the TPM algorithm is not supported. However there
are places relying on the algorithm to be valid because it is accessed
by hash_algo_name[].

On 6.12.40 I observe the following read out-of-bounds in hash_algo_name:
  ==================================================================
  BUG: KASAN: global-out-of-bounds in create_securityfs_measurement_lists+0x396/0x440
  Read of size 8 at addr ffffffff83e18138 by task swapper/0/1

  CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.40 #3
  Call Trace:
   <TASK>
   dump_stack_lvl+0x61/0x90
   print_report+0xc4/0x580
   ? kasan_addr_to_slab+0x26/0x80
   ? create_securityfs_measurement_lists+0x396/0x440
   kasan_report+0xc2/0x100
   ? create_securityfs_measurement_lists+0x396/0x440
   create_securityfs_measurement_lists+0x396/0x440
   ima_fs_init+0xa3/0x300
   ima_init+0x7d/0xd0
   init_ima+0x28/0x100
   do_one_initcall+0xa6/0x3e0
   kernel_init_freeable+0x455/0x740
   kernel_init+0x24/0x1d0
   ret_from_fork+0x38/0x80
   ret_from_fork_asm+0x11/0x20
   </TASK>

  The buggy address belongs to the variable:
   hash_algo_name+0xb8/0x420

  Memory state around the buggy address:
   ffffffff83e18000: 00 01 f9 f9 f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9
   ffffffff83e18080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffffffff83e18100: 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 00 05 f9 f9
                                          ^
   ffffffff83e18180: f9 f9 f9 f9 00 00 00 00 00 00 00 04 f9 f9 f9 f9
   ffffffff83e18200: 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9 f9 f9
  ==================================================================

Seems like the TPM chip supports sha3_256, which isn't yet in
tpm_algorithms:
  tpm tpm0: TPM with unsupported bank algorithm 0x0027

Thus solve the problem by creating a file name with "_tpm_alg_<ID>"
postfix if the crypto algorithm isn't initialized.

This is how it looks on the test machine (patch ported to v6.12 release):
  # ls -1 /sys/kernel/security/ima/
  ascii_runtime_measurements
  ascii_runtime_measurements_tpm_alg_27
  ascii_runtime_measurements_sha1
  ascii_runtime_measurements_sha256
  binary_runtime_measurements
  binary_runtime_measurements_tpm_alg_27
  binary_runtime_measurements_sha1
  binary_runtime_measurements_sha256
  policy
  runtime_measurements_count
  violations

Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash algorithm")
Signed-off-by: Dmitry Safonov <dima@arista.com>
Cc: Enrico Bravi <enrico.bravi@polito.it>
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
---
Changes in v5:
- Use lower-case for sysfs file name (as suggested-by Jonathan and Roberto)
- Don't use email quotes for patch description (Roberto)
- Re-word the patch description (suggested-by Roberto)
- Link to v4: https://lore.kernel.org/r/20260127-ima-oob-v4-1-bf0cd7f9b4d4@arista.com

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
index 012a58959ff0..3d9996ed486d 100644
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
+			sprintf(file_name, "ascii_runtime_measurements_tpm_alg_%x",
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
+			sprintf(file_name, "binary_runtime_measurements_tpm_alg_%x",
+				ima_tpm_chip->allocated_banks[i].alg_id);
+		else
+			sprintf(file_name, "binary_runtime_measurements_%s",
+				hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
 						ima_dir, (void *)(uintptr_t)i,
 						&ima_measurements_ops);

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260127-ima-oob-9fa83a634d7b

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



