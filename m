Return-Path: <linux-integrity+bounces-8325-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACl4GMIseGl7oQEAu9opvQ
	(envelope-from <linux-integrity+bounces-8325-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 04:10:58 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B82A8F6C1
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 04:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7953D300C5A3
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 03:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A412F12B3;
	Tue, 27 Jan 2026 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0sePrhs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922602C030E;
	Tue, 27 Jan 2026 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483168; cv=none; b=StO2UsukjSLrEAONWWvtVb40RAg2Il4Yf2CUSkCfEitaWNUM/VRE1pLW/2K5lCH9y5kXyzI7fB5LH4k6q8kubtb1VsPxOzJ6Oy5Wcp+7jR/cShfE0PiPOh1UbpeimR5EowmDnkvgPWByCao2O509pm/T4OG9P90e+ClkkpKn0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483168; c=relaxed/simple;
	bh=MeCnz1aCV6Fh1ZznDw2OQ4yrDxptXIf27TrTE2OGsCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R9GSa0U4do3RIaaIUgBCwxzlQ8bUv2WjMSQLUVxTPRMmB16ApspxuRo8RZV9kSHda9wdXstGYibfihyLXtcTNcP6pk2RI9b9uqfcvfBRk0kb7nNqS9d7g7j922+xkTZYdMJYF6I3Wmcl9SEzyQPOSg7omIu3g2vTqLsmcWEWN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0sePrhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34950C116C6;
	Tue, 27 Jan 2026 03:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769483168;
	bh=MeCnz1aCV6Fh1ZznDw2OQ4yrDxptXIf27TrTE2OGsCY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=G0sePrhsKm7bFcun25J6yP4+MkwBLDx1ZbMW3kuG4mZJrBAli7q7yFiLwE1HtnmQJ
	 OONyIcP0KRRyXqGV7XEXoaTwxJgv5PNvWx0orgwt3IwPltdk+Gj1/yI25x5FFDLdVA
	 z+1wiFH/FS46aODIjKOi9y2ObTKwzOD3YKpo4ev8iOcS3gq1NJ7GXRW/BX4DLwPnPq
	 5kO61v0ktbv8EdEaNrvD9kiiflBQV9dYwC7R/YKfELz7O7wYQatr8TS3jJxZYUwhHt
	 a12RXw4zFVCUHDiFZmNDit1Dkm1i8uA/wJSvPe7k6zFqJrD59jEh5vaRV+wCV8Ygeh
	 ws6FBz8jXy4LA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E7CD25924;
	Tue, 27 Jan 2026 03:06:08 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Date: Tue, 27 Jan 2026 03:05:47 +0000
Subject: [PATCH] ima_fs: Avoid creating measurement lists for unsupported
 hash algos
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-ima-oob-v1-1-2d42f3418e57@arista.com>
X-B4-Tracking: v=1; b=H4sIAIoreGkC/x3MQQqDQAyF4atI1gZ0lLHtVaSLjBNrFs6URIog3
 t2xyw/+9w4wVmGDV3WA8k9Mcipo6wqmhdKHUWIxuMb5pnUDykqYc8DnTI+OfNfHIUCpv8qz7P+
 n8V0cyBiDUpqWe7+SbaxwnhevFZN9cgAAAA==
X-Change-ID: 20260127-ima-oob-9fa83a634d7b
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Silvia Sisinni <silvia.sisinni@polito.it>, 
 Enrico Bravi <enrico.bravi@polito.it>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
 Dmitry Safonov <dima@arista.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769483167; l=3581;
 i=dima@arista.com; s=20250521; h=from:subject:message-id;
 bh=c+A1wVTblU3Pa0pnPVfuEEFYkjoaAOyomgx0XFJM0mw=;
 b=pSgR7v4OOF6hVP4J6eiaNzfI8UORA86wojK8puty4pIe0NC8rzcIo6Q3HUDBNlvDLQaavjIv1
 GcKOa6qXOS7A+NoSOy31MinrqTkD/FAPYeOlqJDqQe1gupg6xzm8wLH
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
	TAGGED_FROM(0.00)[bounces-8325-lists,linux-integrity=lfdr.de,dima.arista.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,arista.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[dima@arista.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-integrity@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:replyto,arista.com:email,arista.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,polito.it:email,huawei.com:email]
X-Rspamd-Queue-Id: 0B82A8F6C1
X-Rspamd-Action: no action

From: Dmitry Safonov <dima@arista.com>

ima_init_crypto() skips initializing ima_algo_array[i] if the alogorithm
from ima_tpm_chip->allocated_banks[i].crypto_id is not supported.
It seems avoid adding the unsupported algorithm to ima_algo_array will
break all the logic that relies on indexing by NR_BANKS(ima_tpm_chip).

Grepping HASH_ALGO__LAST in security/integrity/ima/ shows that is
the check other logic relies on, so make
create_securityfs_measurement_lists() ignore unknown algorithms.

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

Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash algorithm")
Signed-off-by: Dmitry Safonov <dima@arista.com>
Cc: Enrico Bravi <enrico.bravi@polito.it>
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 012a58959ff0..e9283229acea 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -404,6 +404,9 @@ static int __init create_securityfs_measurement_lists(void)
 		char file_name[NAME_MAX + 1];
 		struct dentry *dentry;
 
+		if (algo == HASH_ALGO__LAST)
+			continue;
+
 		sprintf(file_name, "ascii_runtime_measurements_%s",
 			hash_algo_name[algo]);
 		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,

---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260127-ima-oob-9fa83a634d7b

Best regards,
-- 
Dmitry Safonov <dima@arista.com>



