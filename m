Return-Path: <linux-integrity+bounces-9345-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MF5LLmP72mhCwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9345-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 18:32:57 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F1476715
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 18:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85D28300ACBE
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517683D170C;
	Mon, 27 Apr 2026 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CeHTSXuE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B63CE494;
	Mon, 27 Apr 2026 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307571; cv=none; b=W+dTvQI2h+hLfMsCxJK+f4nLwO+xdm5Al2KT5+yWxl0S1j9W+qZkEfokDGyU/2MYoOmMA4Bl99AClC1h9cjGf+iB33simOrri2ZhAS640ua+drtO3DoIi/8Ny+XL4FvaRAGjJ3gUwE6ArRchLR/1pMSlRUC5K7LLYHhO4+qgcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307571; c=relaxed/simple;
	bh=p4UKGqD6C7b3udkeyuFvC3EfgxBlb5ErBTlFtC+zrdQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CxBycCGEppyltQKh2gXQPASFOLFodZosHVCLe4D6FKCWIqTTQYbJzHP/X5Rb3lKMHotyYyN1/3pqMaKNBGaojFJWL3gtfsbFdB0pZq3lwQCgbnfqzYV4Kfglyvy7nH08IKIGEGDr4E9rzyh6poAOOE7xPPq+0j3KjSzRyJsQik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CeHTSXuE; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777307570; x=1808843570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o69ajucQMyLbEF1Vdi5clQnb5b5FpfC212GOHD7k2go=;
  b=CeHTSXuEBK57KGcBp9GFvTvsCoUZ5ifv0xDYiT2v+t4bEozvUECScU6y
   IJgefqE4ElDht0oDRvMFUCPmCh/kaf1ioh/YQX7C+sabyaM5KFt14jiO8
   p7nYO88T3wWKkk8OTdyg2dJUp7i3nJw7+gwiXPzO2GepISBuGpDL9X2VR
   9yn3AKwATPNepVyc3Murfbuh51A8EzB/kx1lYJc70Y/ayY6w0bZkXRVHy
   CKZzW6yRVX9D1/wnf0EXjgouadfQb3Lx0KQh4xMpootbKQm6V0qq59Uzr
   x+XKoh6X8gKIdikx5l/sKGN5hrbXo2n/5F/AA2PitLDM4zDnGKwCqfKM2
   g==;
X-CSE-ConnectionGUID: 1hFfGHE1SgSzybhJDYYPhw==
X-CSE-MsgGUID: 30mXS9GmQgufQuZMiHEbTQ==
X-IronPort-AV: E=Sophos;i="6.23,202,1770595200"; 
   d="scan'208";a="17817296"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 16:32:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:4382]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.2:2525] with esmtp (Farcaster)
 id d00fe269-7e7b-4609-a5f5-8f243fbca50c; Mon, 27 Apr 2026 16:32:49 +0000 (UTC)
X-Farcaster-Flow-ID: d00fe269-7e7b-4609-a5f5-8f243fbca50c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 27 Apr 2026 16:32:47 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 27 Apr 2026
 16:32:46 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC: <jgg@ziepe.ca>, <noodles@meta.com>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Justinien Bouron <jbouron@amazon.com>
Subject: [PATCH] tpm: Remove dead NULL check in tpm2_flush_space()
Date: Mon, 27 Apr 2026 16:32:26 +0000
Message-ID: <20260427163238.20230-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 842F1476715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-9345-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gunnarku@amazon.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

The 'space' pointer in tpm2_flush_space() is assigned from
&chip->work_space, which is the address of an embedded struct member
within struct tpm_chip. This address can never be NULL, making the
NULL check dead code. The new code follows the existing pattern
established by the other callers in tpm2-space.c which also assign
from &chip->work_space without a NULL check. Remove the dead code
to avoid confusion.

Fixes: e3aaebcbb7c6 ("tpm: Clean up TPM space after command failure")
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Assisted-by: Kiro:claude-opus-4.6
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
---
 drivers/char/tpm/tpm2-space.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 60354cd53b5c..1eec72eb8208 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -169,9 +169,6 @@ void tpm2_flush_space(struct tpm_chip *chip)
 	struct tpm_space *space = &chip->work_space;
 	int i;
 
-	if (!space)
-		return;
-
 	for (i = 0; i < ARRAY_SIZE(space->context_tbl); i++)
 		if (space->context_tbl[i] && ~space->context_tbl[i])
 			tpm2_flush_context(chip, space->context_tbl[i]);

base-commit: 949692da7211572fac419b2986b6abc0cd1aeb76
-- 
2.47.3


