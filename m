Return-Path: <linux-integrity+bounces-9482-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDdAHqn0/GlmVgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9482-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 22:23:05 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B354EE62D
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 22:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DEE53006955
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2026 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB9533BBB1;
	Thu,  7 May 2026 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mwUAAwHy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AF175A85;
	Thu,  7 May 2026 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778185127; cv=none; b=m0bj5j2CF27LcAcvb+9h4q5sbUndyLUK6o1Dbs1wLECdztPPgUQY2gtL51UE3+vAcpIl2Fd8nG72SFaKXVyG4YR6CEDJQIoFXrHqgYQJYLPd7KbEYFmbkSdX7jdXULPlwrJRmhDV/VkCrhl2EZ3AnMPrbo2ctL1qyk5JZ5PZLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778185127; c=relaxed/simple;
	bh=q86PLE5BtL5+rIrPUoYnn46PTMDS0p9UScgqzEvr31A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RppOVegvSHehZPdKz/nLFyzeifFdHN7YKw/CfKLBg2EmxHgHNTtxtFcMOFpkYTm2nRVsutiVx6IWBsYHMSE4ANYIYgh37rfzmrm2eTtlJzrHvkiRvtKu/Qhn5X66lWnJ5trDIonsz5g6J+G73dRdQL26b1rSvm/KQPfFfAUC1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mwUAAwHy; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778185126; x=1809721126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tU3A8vvFdMUK2PUASz93j1+CopNSEFt4ejO0SDPwOBM=;
  b=mwUAAwHyPEInRTKYGysmQ6Eq6uHLvjr6hPl1e0l/utTisNn3hGUQT/46
   NruFjLYGUBgW7v7EbZkgMFBlgS17LS1Yh+4ioOypFnmbSm+Se0BsiJaEP
   7ccXncdy/FZQ6wB2oz9w3WEB9fYxkptwWAe59YZYoWN8x9ykJdljfZr1K
   oqpHJxXaRPWVbvFpi4VY9tLAuuRhQNxSnGfm2iclh5x8ingHlM86B7Q0u
   CegfD0PseOky10JNOeGYO/g4zmzfT7qdgAanNM+4kRRR7UNtnJmHcdvpd
   gYA0L80+ttxpWbBcTdvtT2jFLUqRKQqsocAYn/Qo7/eZ2hzL+eztxaUS2
   w==;
X-CSE-ConnectionGUID: b4uWqY0+S7WFGWsgoP801A==
X-CSE-MsgGUID: P+De94LVR1aiAVaYWEfg1A==
X-IronPort-AV: E=Sophos;i="6.23,222,1770595200"; 
   d="scan'208";a="19128507"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:18:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:4626]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.77:2525] with esmtp (Farcaster)
 id cb03cbba-98d4-4c5e-8a73-7c12267be444; Thu, 7 May 2026 20:18:45 +0000 (UTC)
X-Farcaster-Flow-ID: cb03cbba-98d4-4c5e-8a73-7c12267be444
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 7 May 2026 20:18:43 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 7 May 2026
 20:18:42 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC: <jgg@ziepe.ca>, <noodles@meta.com>, <gunnarku@amazon.com>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Justinien
 Bouron" <jbouron@amazon.com>, Muhammad Hammad Ijaz <mhijaz@amazon.com>
Subject: [PATCH] tpm: Fix uninitialized name_size_alg in tpm_buf_append_name()
Date: Thu, 7 May 2026 20:18:22 +0000
Message-ID: <20260507201837.8282-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: F1B354EE62D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9482-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gunnarku@amazon.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When tpm_buf_append_name() is called with a non-NULL name for a
handle, the code skips the tpm2_read_public() path (which sets
name_size_alg from the return value) and falls through to memcpy()
with an uninitialized name_size_alg as the size argument.

The contract for tpm_buf_append_name() supports callers passing a
non-NULL name. No current in-tree callers do so, making this a latent
bug that would trigger if a caller ever provides a pre-computed name
for a handle.

Fix this by restructuring the if/else to call name_size() when name
is provided, sharing the error check and name_size_alg assignment
with the existing tpm2_read_public() path. This restores the type of
validation that existed before commit bda1cbf73c6e ("tpm2-sessions:
Fix tpm2_read_public range checks") refactored the function.

Tested with KASAN by assigning 0xDEAD to name_size_alg to simulate an
undefined initial value. Calling tpm_buf_append_name() with a non-NULL
value for name results in the following warnings from KASAN:

  BUG: KASAN: stack-out-of-bounds in tpm_buf_append_name+0x1e0/0x680
  Read of size 57005 at addr ffff80009e5e79f0 by task sh/49616

  Call trace:
   show_stack+0x34/0xa0 (C)
   dump_stack_lvl+0x5c/0x80
   print_report+0x160/0x4b8
   kasan_report+0x7c/0xd0
   kasan_check_range+0xe8/0x190
   __asan_memcpy+0x3c/0xa0
   tpm_buf_append_name+0x1e0/0x680
   run_test.isra.0+0x14c/0x1d8

There are no KASAN errors with the fix applied, and the function
behaves as expected.

Fixes: bda1cbf73c6e ("tpm2-sessions: Fix tpm2_read_public range checks")
Assisted-by: Kiro:claude-opus-4.6
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Muhammad Hammad Ijaz <mhijaz@amazon.com>
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---
 drivers/char/tpm/tpm2-sessions.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index c4da6fde748f..795cd99dc6fe 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -285,11 +285,14 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	    mso == TPM2_MSO_NVRAM) {
 		if (!name) {
 			ret = tpm2_read_public(chip, handle, auth->name[slot]);
-			if (ret < 0)
-				goto err;
-
-			name_size_alg = ret;
+		} else {
+			ret = name_size(name);
 		}
+
+		if (ret < 0)
+			goto err;
+
+		name_size_alg = ret;
 	} else {
 		if (name) {
 			dev_err(&chip->dev, "handle 0x%08x does not use a name\n",

base-commit: 9ec4175a30eb5adb95e446af83ddf6cb3286a82a
-- 
2.47.3


