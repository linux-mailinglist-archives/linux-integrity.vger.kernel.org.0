Return-Path: <linux-integrity+bounces-9120-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOApA/Oyzml+pQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9120-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Apr 2026 20:18:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5F638D008
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Apr 2026 20:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB72730440BF
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Apr 2026 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F289C374187;
	Thu,  2 Apr 2026 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PZiHFbl6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B26373C07;
	Thu,  2 Apr 2026 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153525; cv=none; b=DYGOv8Tg3V933gvBu1E8+Pqx9e9Ki+EsEbytRCky+CvrENqaek9hSy3oMV4qQu7jSgoAP6XjAr+4PQkjiRgQaDXpnAM/5kFpEPqYPQnyLJeSlwuEPak0/YPUROhGdo35SyBp8a6p5YBwMAlBHNe7wFcirPx3jtjRHc7mSFjMzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153525; c=relaxed/simple;
	bh=j5phvZtHnGC+rv5Ivu5FcvsJiXH6M7sRc5K8MdsGmz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U1SctGYTbmJe5IWmZMEjuCQMePDZI7+lPyBhpfbLARtp4DGC+PKqhst5D+qwtIP4upY4M7Ai1ENvt7wTy0Lv++Fy4/RwkKB+LF4uWr8W7qYi9DlqBOZhY7E8T/J68oD2plXCxSp4tVVmNLbY3Z3tOkvDttEULEGAdVHzmel0K3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PZiHFbl6; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775153524; x=1806689524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HPrgD0gFn9XH2K603ipb0GsV9ZsxI0ma86h25Xlg5cM=;
  b=PZiHFbl6iWzMdIkRZFmVBgc47rb/DAcjFYGBDKMuQlbfEvqc7B08xynK
   jXZ+Z0XxiixlCe1GSAW3SH6gmX8JJSPYBAu52la+Bw31YP5atxzCBzyoL
   1cfGEU71XMzzXm4/pnF0uKXlPImaBU4smcuI4aObkxpKNMuNgQCpOzSqo
   iFXAa8QjBlBLYJ+q3TE8GvqksKGf0uHml8yOv9ynlex+2Qc2dtcd2zaeY
   ZlMA0D4C5HXLDpRfCerLWFG5gznc+PtpmmWYP39jwjZaQaG1ystdH/yp6
   0wqJbgv38n4bdKBRvIngXWozomFzMH7bJYtfMWKKDHdSGe59sBICDd3Ka
   A==;
X-CSE-ConnectionGUID: aXHbrcVoSM+H8lbcyFTBCQ==
X-CSE-MsgGUID: W6vXUdCWTbqHk8kxRxdVbQ==
X-IronPort-AV: E=Sophos;i="6.23,156,1770595200"; 
   d="scan'208";a="16441061"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 18:12:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:13607]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.193:2525] with esmtp (Farcaster)
 id a2cbbcfa-97c9-40a7-a7e3-6a8bc043a356; Thu, 2 Apr 2026 18:12:03 +0000 (UTC)
X-Farcaster-Flow-ID: a2cbbcfa-97c9-40a7-a7e3-6a8bc043a356
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 2 Apr 2026 18:12:02 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 2 Apr 2026
 18:12:02 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC: <jgg@ziepe.ca>, <noodles@meta.com>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Justinien Bouron <jbouron@amazon.com>
Subject: [PATCH] tpm: Fix auth session leak in tpm2_get_random() error path
Date: Thu, 2 Apr 2026 18:11:39 +0000
Message-ID: <20260402181156.29396-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9120-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gunnarku@amazon.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E5F638D008
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When tpm_buf_fill_hmac_session() fails inside the do-while loop in
tpm2_get_random(), the function returns directly after destroying the
buffer, without ending the auth session via tpm2_end_auth_session().

This leaks the TPM auth session resource. All other error paths within
the loop correctly reach the 'out' label which calls both
tpm_buf_destroy() and tpm2_end_auth_session().

Fix this by replacing the early return with a goto to the existing 'out'
label, which already handles both cleanup operations. The redundant
tpm_buf_destroy() call is removed since 'out' takes care of it.

Fixes: 6e9722e9a7bf ("tpm2-sessions: Fix out of range indexing in name_size")
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
---
 drivers/char/tpm/tpm2-cmd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index e00f668f8c84..b11e6fa8b740 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -295,10 +295,8 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		}
 		tpm_buf_append_u16(&buf, num_bytes);
 		err = tpm_buf_fill_hmac_session(chip, &buf);
-		if (err) {
-			tpm_buf_destroy(&buf);
-			return err;
-		}
+		if (err)
+			goto out;
 
 		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,

base-commit: 7f2a32c0e87814f0e7852b17fa9f10321f882c36
-- 
2.47.3


