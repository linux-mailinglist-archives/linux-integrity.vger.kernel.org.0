Return-Path: <linux-integrity+bounces-8963-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAQdK61XsGlciQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8963-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 18:41:01 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC7255C1A
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 18:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B53C430098AB
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0AD3D1710;
	Tue, 10 Mar 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBYs+kuw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE4314D08;
	Tue, 10 Mar 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164457; cv=none; b=dy22hqZkYIzg/iTX97QAZ61DVwQWid66vL4IHUHCjnZ3oLGjKNNzjd/XbQPvVGPWDl7kLZdkfG5OB9/Srmtcffwm3ULdd28zUIIzCShiAz7SaYGis466YZAtXCGY7DHQfgsjJhp9Abq5hx56TM9zBB7WoycB2m2wrJbYcb2cgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164457; c=relaxed/simple;
	bh=Vh+dv7G9JYYz79ZKRs5UBfA3zrs7LB5npwqEsYHYRpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NbiA5rVe0PS3ilMqQ54DIXWrFT1qWkDj3emDJ9pl5xPNovZ0Om1AEE3jVb0UyYrF7ivK1trW6QJSP+LrB8/WAQr1CVJG/hsaf5xsEBRjBr8GyTctJ6Jth8nsKKWRjC7Y/FbLEQpTS5NMBVuP6ssPUu5qqUhrpAz2INouSGs9as0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBYs+kuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 559C3C19425;
	Tue, 10 Mar 2026 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773164457;
	bh=Vh+dv7G9JYYz79ZKRs5UBfA3zrs7LB5npwqEsYHYRpc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=aBYs+kuwKvZ0aYvGTXyvc+fuvvQ6XpGehugZpXagGcjSotftPXN7YLlTmaOBg4USw
	 0nhGG7bqIqbXBktvddTiEMWctddAZOVmbpaA5aEVnMUiJbNea6wZ97/+RaOEsaUvbz
	 gQFdoRYpalCTwwazDiLHhC4xKL88Gr5hmiAZuqZBculktceFQcqD9SdFLbo5SvTEbc
	 ieNlum6zxusZ3qyjJkO9ZI76lquOzMedGCncJV2PBN0ZntyOduUe5xPcB909w8C1N9
	 mIyXKCWZj+FWzlXTFwM3msgK3mLXvM9ifENLitcxAAP5PuUJBrhVxWhMN2lD24NJwW
	 HcYxI1gTTCxCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C52FD4F0F;
	Tue, 10 Mar 2026 17:40:57 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Tue, 10 Mar 2026 17:40:39 +0000
Subject: [PATCH v6] ima_fs: Correctly create securityfs files for
 unsupported hash algos
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-ima-oob-v6-1-dc111c846ff4@arista.com>
X-B4-Tracking: v=1; b=H4sIAJZXsGkC/3XPzWrEIBQF4FcZXNdWr0aTrvoeQxfXv0ZotGgaM
 gx595rZDCVkeeB+53DvpPoSfSXvlzspfok15tSCerkQO2L68jS6lgkwUIyDpnFCmrOhQ8BeoBL
 SaUPa9U/xIa6Pputnywarp6ZgsuPuv2P6XWny6/w2YZ192c0Y65zL7TG+8F0edxZOOQUnIQjJe
 9/pDyyN4avNE9mHFjiB0GAQPfLe9h2z4QDFCRQNcufYEKQFVHiA8gTKBk1g1ukwGOnkAXZPCCC
 esGtw4NZypqTX6v+P27b9AZ+1ApqnAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773164456; l=6024;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=aq1ttERu1XDpBBqiZqrxKRBcfhL+biDFjN6ZxrU3vP8=;
 b=o30ye5QpjVsbTScv873hURw3Nubq8cWd8rhurtiSKi+Od3xBv+9DMJuhs5e6Eit8c6zphrtSk
 XL5EKGrXQhqBkeEwOzBcBHhJgB+oCZgA5FNkXQUVv4Vtg0RyNt/JDEg
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=/z94x2T59rICwjRqYvDsBe0MkpbkkdYrSW2J1G2gIcU=
X-Endpoint-Received: by B4 Relay for dima@arista.com/20250521 with
 auth_id=405
X-Original-From: Dmitry Safonov <dima@arista.com>
Reply-To: dima@arista.com
X-Rspamd-Queue-Id: 50BC7255C1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8963-lists,linux-integrity=lfdr.de,dima.arista.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,gmail.com,arista.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-integrity@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_WP_URI(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_REPLYTO(0.00)[dima@arista.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:email,trustedcomputinggroup.org:url,arista.com:replyto,arista.com:email,arista.com:mid]
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

That's TPM_ALG_SHA3_256 == 0x0027 from "Trusted Platform Module 2.0
Library Part 2: Structures", page 51 [1].
See also the related U-Boot algorithms update [2].

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

[1]: https://trustedcomputinggroup.org/wp-content/uploads/Trusted-Platform-Module-2.0-Library-Part-2-Version-184_pub.pdf
[2]: https://lists.denx.de/pipermail/u-boot/2024-July/558835.html

Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash algorithm")
Signed-off-by: Dmitry Safonov <dima@arista.com>
Cc: Enrico Bravi <enrico.bravi@polito.it>
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
---
Changes in v6:
- Change subject now that securityfs files are created (Mimi Zohar)
- Added a link to TCG document and the related U-Boot changes
- Link to v5: https://lore.kernel.org/r/20260223-ima-oob-v5-1-91cc1064e767@arista.com

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
 security/integrity/ima/ima_fs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 23d3a14b8ce3..ca4931a95098 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -398,16 +398,24 @@ static int __init create_securityfs_measurement_lists(void)
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
base-commit: 343f51842f4ed7143872f3aa116a214a5619a4b9
change-id: 20260127-ima-oob-9fa83a634d7b

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



