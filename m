Return-Path: <linux-integrity+bounces-6541-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E3AE9BE9
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 12:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34C21C235D4
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39A426B2A6;
	Thu, 26 Jun 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EszjdSlM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11E926A1AC;
	Thu, 26 Jun 2025 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935276; cv=none; b=u8f1mhDSU2F6GKbh6tsulMLNBnewU3jXuI+nIzYiu0zq3KZkLb5Wy5JlThDipCrOy5w2UTfOyo4Qmp0bM4/H7L8TdSGoBZH4JOX2fXPTGQBfv5iBRd9S2Lyr+5tjucLAavb5Bi/m6l/78k024g1SoSP3/aZsW1aNquubdS10cHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935276; c=relaxed/simple;
	bh=vl24n8aM4Ut+tNFLr2AcJcy6+Q0gPPmMquqRtf8KWs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UuUWGtL3Tgls6RlnEVxUHMVZCzoTsB8t78TIiyiaNWEo923MNauruPRCfZD1twNNIdqsv6xUSqrVT5oTukJK/a/yniG0JDaqaJoh8cjEmI9j1fxZYe7Lex21hHHMKVJYGxkYKTZLhf9RgQICepbbcyBLGf54bhzGXrXpxzl41fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EszjdSlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1D7C4CEEB;
	Thu, 26 Jun 2025 10:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750935276;
	bh=vl24n8aM4Ut+tNFLr2AcJcy6+Q0gPPmMquqRtf8KWs8=;
	h=From:To:Cc:Subject:Date:From;
	b=EszjdSlMkl07Gyybl7i66ZVdVnlx5kjBXnhmCwqJwqJCUxMM595+tJXToqRWxM+2d
	 3XJWQfUKRl34GKW1sSNus1WvM1NEQMfFgdsSgmu4GQUTkU+PJsw6yautu47Ahhvd4z
	 wyfWny5+hOarz98l8P54pCOWlBcJcppNCVpkfNrgiXhfcObZHBjCrmS2SIu7ipDbZt
	 aEIlgQd91T4dRjG/8RmJv8EShJmOJEav508TjfAnUMFW/bcQfaLOstNSFMTPgTGFPI
	 rPcxz5EA1pk1owAXKccysnhY2t6r9HA/Uhrkdb9gbLM3IC5MGa8ZaRHZLh/eszt1AH
	 /C7i8ns2FgBxg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER)
Subject: [PATCH] tpm_crb_ffa: Remove unused export
Date: Thu, 26 Jun 2025 13:54:23 +0300
Message-Id: <20250626105423.1043485-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Remove the export of tpm_crb_ffa_get_interface_version() as it has no
callers outside tpm_crb_ffa.

Cc: stable@vger.kernel.org # v6.15+
Fixes: eb93f0734ef1 ("tpm_crb: ffa_tpm: Implement driver compliant to CRB over FF-A")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 3 +--
 drivers/char/tpm/tpm_crb_ffa.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 462fcf610020..9c6a2988a598 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -247,7 +247,7 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
  *
  * Return: 0 on success, negative error code on failure.
  */
-int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
+static int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
 {
 	int rc;
 
@@ -275,7 +275,6 @@ int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
 
 	return rc;
 }
-EXPORT_SYMBOL_GPL(tpm_crb_ffa_get_interface_version);
 
 /**
  * tpm_crb_ffa_start() - signals the TPM that a field has changed in the CRB
diff --git a/drivers/char/tpm/tpm_crb_ffa.h b/drivers/char/tpm/tpm_crb_ffa.h
index 645c41ede10e..d7e1344ea003 100644
--- a/drivers/char/tpm/tpm_crb_ffa.h
+++ b/drivers/char/tpm/tpm_crb_ffa.h
@@ -11,11 +11,9 @@
 
 #if IS_REACHABLE(CONFIG_TCG_ARM_CRB_FFA)
 int tpm_crb_ffa_init(void);
-int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor);
 int tpm_crb_ffa_start(int request_type, int locality);
 #else
 static inline int tpm_crb_ffa_init(void) { return 0; }
-static inline int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor) { return 0; }
 static inline int tpm_crb_ffa_start(int request_type, int locality) { return 0; }
 #endif
 
-- 
2.39.5


