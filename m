Return-Path: <linux-integrity+bounces-9144-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QACPK1KG1mmwFwgAu9opvQ
	(envelope-from <linux-integrity+bounces-9144-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 18:46:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FB83BF0BA
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 18:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54A38302E816
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2026 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F23D9DB8;
	Wed,  8 Apr 2026 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="pNssZCCg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC943D9DB7;
	Wed,  8 Apr 2026 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666654; cv=none; b=usvVEN6pBdXjIQZ2oAx9NX9vy9J5JtLzXMhwHMJrLKqiAYGBoIMAri+INFGFHpK2SOLrHOVIykII1g9rIojPJhzwQk2mzhnHyrfuRWN+FTuLg9x1iRuqVrT7witWJc1nhx2i/fp+/NI4LkJb62gpMouGDHgMRsGaiEemWEBh0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666654; c=relaxed/simple;
	bh=PRThXXGbU/4/LGOybescKdfgpEYP31ViqFHTEwhbbb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gU9/kbs6RoM+f0mppGA3JO1yjuNoOjkoVoGVCyPdGDyOJFSEJW4ArrttOh25Ou5Y3gD3+xj5FRPR7X9C9+GpDeiNYZ7ccKD2g14pJ+Oo3AzuWG595KSqSUKocCZ6dIhwGaoVu9+rHB7rEHXDYCskjAPfOpwxnP3PE8spemZFW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=pNssZCCg; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775666653; x=1807202653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nH5MfrstfZz4Dm2BLWIZz+6jC+pa0W8TnjH4a6+SEtw=;
  b=pNssZCCgyzvHQlgCfK3BIxCEtk2Krxo+Ob6aVjeE7mBYYhRoxbH3motq
   PeLQPgagjvrjyJeLBEHx4GPzAYMVo6WHWH81mDvqmpp6BuaGzVRJqW6zb
   7Kq5axPJ7YS+I9ibHSx6O8NGcqU7r2o+Zm7SeeGioLZ5OWJ+XK+NnUlnX
   U0f6Jbkn7Z/H53dI52QXQaejcT8RmW1LqdOweavsP1lFW/87tNV6g/71M
   yg8b3mTymdXXpko2NPVITVJMtLCsMOjG3x7IeaAkR8H2lRDh08M2soQgu
   xI90KnhqoLdpfIlrTcBda94/7JMvsSB/5jnzy6ReUgmLW9GV9j75rKaHm
   w==;
X-CSE-ConnectionGUID: X8DYxly3SturjzobxZ3q2A==
X-CSE-MsgGUID: XJzqVLYITNKadoLg+RpHJQ==
X-IronPort-AV: E=Sophos;i="6.23,167,1770595200"; 
   d="scan'208";a="16852231"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 16:44:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:22395]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.173:2525] with esmtp (Farcaster)
 id 4fee2abb-c879-4c48-9f68-018981f5e227; Wed, 8 Apr 2026 16:44:12 +0000 (UTC)
X-Farcaster-Flow-ID: 4fee2abb-c879-4c48-9f68-018981f5e227
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 8 Apr 2026 16:44:12 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 8 Apr 2026
 16:44:11 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC: <jgg@ziepe.ca>, <noodles@meta.com>, <gunnarku@amazon.com>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Justinien
 Bouron" <jbouron@amazon.com>
Subject: [PATCH] tpm2-sessions: Fix missing tpm_buf_destroy() in tpm2_read_public()
Date: Wed, 8 Apr 2026 16:43:37 +0000
Message-ID: <20260408164359.24968-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9144-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gunnarku@amazon.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 83FB83BF0BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tpm2_read_public() calls tpm_buf_init() but fails to call
tpm_buf_destroy() on two exit paths, leaking a page allocation:

1. When name_size() returns an error (unrecognized hash algorithm),
   the function returns directly without destroying the buffer.

2. On the success path, the buffer is never destroyed before
   returning.

All other error paths in the function correctly call
tpm_buf_destroy() before returning.

Fix both by adding the missing tpm_buf_destroy() calls.

Fixes: bda1cbf73c6e ("tpm2-sessions: Fix tpm2_read_public range checks")
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
---
 drivers/char/tpm/tpm2-sessions.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 09df6353ef04..f7c6c043fef4 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -203,8 +203,10 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
 	rc = tpm_buf_read_u16(&buf, &offset);
 	name_size_alg = name_size(&buf.data[offset]);
 
-	if (name_size_alg < 0)
+	if (name_size_alg < 0) {
+		tpm_buf_destroy(&buf);
 		return name_size_alg;
+	}
 
 	if (rc != name_size_alg) {
 		tpm_buf_destroy(&buf);
@@ -217,6 +219,7 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
 	}
 
 	memcpy(name, &buf.data[offset], rc);
+	tpm_buf_destroy(&buf);
 	return name_size_alg;
 }
 #endif /* CONFIG_TCG_TPM2_HMAC */

base-commit: 03e5553f5fb99cb47c315e167a604a9c69e6f724
-- 
2.47.3


