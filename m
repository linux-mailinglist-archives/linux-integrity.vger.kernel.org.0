Return-Path: <linux-integrity+bounces-3442-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348BA96D281
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594541C22FB5
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D156F189901;
	Thu,  5 Sep 2024 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="w3IN+vsm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B46145B10;
	Thu,  5 Sep 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526533; cv=none; b=oPppr4fGFNrGWqnY8Rq1HyZdRbXZSF8HSbFnJ1hrAZSO//XUT88qKNlxNi6vCjoYCAhpemI1kZZoFCL+4RqU2K4cilORZRRpRP/8QKBKlu9as00VOfT5sbi+36NZxNeUerRgkCK7ereZ7y9fIIli3u8jcB53lHzA9LS1srlHKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526533; c=relaxed/simple;
	bh=f1MPAD4O/d2BtmRLp4/BYgjptMhBAm5TS4m5Ii3NVJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHIS/58hm4nxXTu6/kcWm6Bj8zDo26MjL2D/3yvudJlStZc++uG5eVzXvU9rbj/D/ki/FmGxfZi/rV5+Vhpx3xwsSiGwfCaJ9LCoFdC2kU44QjEFFWKrHmpYSj0LQFOGiv5ZJvkAScJviwQ+UGxGbxr52t3qhUdzHsXBlZFOz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=w3IN+vsm; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 69D5220114;
	Thu,  5 Sep 2024 08:55:24 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 96F293E970;
	Thu,  5 Sep 2024 10:55:16 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 91B81400B3;
	Thu,  5 Sep 2024 08:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1725526514; bh=f1MPAD4O/d2BtmRLp4/BYgjptMhBAm5TS4m5Ii3NVJY=;
	h=From:To:Cc:Subject:Date:From;
	b=w3IN+vsmPVD4TLlGAVgh4wAY9Bqv2QZbp8Oj/VVoDmNq6/9tyh4jXwVK6JAzQ/LVF
	 8uQeyoQK7+wn1+qwvO6gy5cOT2U1uHPL1qEAP22SWNT8bbwYFwhtipACq8SzjrU2E8
	 GQ/nP3k13J5pz/FrVkhMNSb55MnWeqkqwxHWitsw=
Received: from localhost.localdomain (unknown [58.32.40.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id ECFFF42639;
	Thu,  5 Sep 2024 08:55:07 +0000 (UTC)
From: Kexy Biscuit <kexybiscuit@aosc.io>
To: stefanb@linux.ibm.com,
	jarkko@kernel.org,
	linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	zohar@linux.ibm.com,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Mingcong Bai <jeffbai@aosc.io>
Subject: [PATCH v2 RESEND] tpm: export tpm2_sessions_init() to fix ibmvtpm building
Date: Thu,  5 Sep 2024 16:52:20 +0800
Message-ID: <20240905085219.77240-2-kexybiscuit@aosc.io>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 91B81400B3
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

Commit 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to
initialize session support") adds call to tpm2_sessions_init() in ibmvtpm,
which could be built as a module. However, tpm2_sessions_init() wasn't
exported, causing libmvtpm to fail to build as a module:

ERROR: modpost: "tpm2_sessions_init" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!

Export tpm2_sessions_init() to resolve the issue.

Cc: stable@vger.kernel.org # v6.10+
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408051735.ZJkAPQ3b-lkp@intel.com/
Fixes: 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support")
Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
V1 -> V2: Added Fixes tag and fixed email format
RESEND: The previous email was sent directly to stable-rc review

 drivers/char/tpm/tpm2-sessions.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index d3521aadd43e..44f60730cff4 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1362,4 +1362,5 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	return rc;
 }
+EXPORT_SYMBOL(tpm2_sessions_init);
 #endif /* CONFIG_TCG_TPM2_HMAC */
-- 
2.46.0


