Return-Path: <linux-integrity+bounces-9926-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Djf1Ix7eU2rcfgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9926-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jul 2026 20:34:06 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E0C745A31
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jul 2026 20:34:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IX4f3KAn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9926-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9926-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A4AF3001CC0
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jul 2026 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A80D367F58;
	Sun, 12 Jul 2026 18:33:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9336654F
	for <linux-integrity@vger.kernel.org>; Sun, 12 Jul 2026 18:33:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783881239; cv=none; b=vCjDApZW89+esjjHErY0NHTytPCukixVvEU9O6Gw/6HmBPcGcOXHGO5lo3T8X26kAaMmTzAZC6p/GMn4OaBuXBM8XTi8z7H1coAY6nMqvyw7ZEJ6/pW5+JCP7NVJ//nUqVaWh7/Cg6Y9PiHROydbh4Y45GmbigE0zgVjw79SF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783881239; c=relaxed/simple;
	bh=n0NdavEk8AJsJlMZam+bX1N0duCdedBEQvsT+rVIgpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HLlrqYv+B9QBCDISZO2qBkqnVtIA/ajzaMz840Mac6/TzypJcY0q+g6LpQd+6uzpXia6v5zNAaP45qNHAZ3stLA4JRyzyISmZiaU0QBExzJhnQC/oqFqaSxEAZAIzGFmkqOBXGVp52qR00kWthO749jsEo9wb6ILjFp2PGu5n9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX4f3KAn; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so22359625e9.0
        for <linux-integrity@vger.kernel.org>; Sun, 12 Jul 2026 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783881236; x=1784486036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jTESNNgw+DFxBk7ppm0MiG9qKYAv0/boV+7AJ2S4T+k=;
        b=IX4f3KAn8QFG2F2OZkqlXKWT4AzmijNrCjQkzSab6gCT14BQZZPrpjkmZggWiyhwHd
         wDXNf1ib3bI4WPQqft4OW1kTGcZY0X+gGY/KX0rpdnLg0tlS0oD8ytdoTtev1hXsqfU2
         iqqW+2P008rHXPLU31V2VpxFeyhVo4pFqsG2eLCWX3XyeUWznEN6iBidX8QcyWgE93o4
         v38x1AtTeFb+O4nxuQzbPO5vB63o7jpke9XoayPZRqaVLJ6IS1KxuDeoEd0Cy1YYciKZ
         Ma9C9oUzUyz9P8VdaERFEJ+1jItTe+sj/a3FxTQEWJ9QgeI0Cm9AlQTk5EOcKFewlUWj
         eL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783881236; x=1784486036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTESNNgw+DFxBk7ppm0MiG9qKYAv0/boV+7AJ2S4T+k=;
        b=AYXaSQgyrs5FUim53MDt8n7IBD0YZkluZgRKE9EHOVIn5r+of7HPGsiWeRT5Ba5Sgp
         9OE6h030UyZjmpc91o2BzONL5rz4j0q8/ogTJT0Hs2G6LlRu8fJXb9OIXndHyBS1x8xJ
         virjfbdbxko2PzLvhkMQs9ZMwb0M1EQtr+otmxmEnQCz76wJ+sASCDi35YlVPGQvw7r6
         DjnUGq2OiiLYozYNeTrPFaxFXNx4dJThmk9WDSfSN6KokVT0YXfXJwi5y/8n4ZmoFG45
         CmweLV6XVdb1YqpaRf5vY8J2lnbmtd+nLWpNZrloVPr29BwfSX5aFSGbgF0ekLWYzI1N
         wjlA==
X-Forwarded-Encrypted: i=1; AHgh+RqS84POp90nDMkrak+jJR69UVKJrjRLnafVyJnzRFe3LjhnCx8reTK8M8w8+4X+QnuhocmFHx8Z9nBj6FMDjC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwIs/z41jRCvUJNEkkTNFSfriKmhFDarb0nn4rkgoAdkAsXzb
	EQRpVBW/pGA0C4Ew8nCNhl+kxnKHUcCFBrvt2ziNXPGBsQkbf96o98qO
X-Gm-Gg: AfdE7ck/oUGVO1+XoD3T3Lgw/+ZHLJdFNfW066BARORHtHSF9OdfpvdnpkKMPZ4Uz7j
	Zj/fkW3qWUYojTrcViJlMSmgw/wXYLhu9jq0ui08pQyYIcyosFTyt6yTO6ot3AgkPrHEZmJN8eb
	/FlcF/JIv5c+YjxtFcjH+TQ8qlNXnZmDP19scDtkme5JMFFFRukwxfUzRR+oiQLw+lL4oztBOZi
	FKrAMB+O2S7EJVr1cT/ADSHrtuTgeUVNrKivJlBVuk4ZtkcFZaUjjuXutfiNmAeQsUPoiby8eZk
	dnxdTyIgvuOzbLBBj5ZZlKjkxK4etcY6KpaNs2t2ikcHoFPQKWJVqwgCWdGIb3o+vVCaC2TmNiK
	OnFT8m2c0UFrgAmKhlWTHhoXNdmfwKoV49RXwbqDdK13PibEbgNSAXfRqa7yBLIpUNfdBjc/Ia6
	sWe0/agsc6f14mUGSQeQ2zzob5Rwewp28d0COH2ktXZbwX6ZPjGPu0/qlfgWJXNs+PVGwQb/lN/
	RZl3zMXHsnN5nh9y02X+5n9ZAG4lJiM3Vk4U1ZHgLVCFYx/Ay3wWHzI
X-Received: by 2002:a05:600c:4ed4:b0:493:d1e0:a4f1 with SMTP id 5b1f17b1804b1-493f877fe8cmr73738575e9.0.1783881236010;
        Sun, 12 Jul 2026 11:33:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-112-249.95.117.pool.telefonica.de. [95.117.112.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm430312735e9.10.2026.07.12.11.33.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Jul 2026 11:33:54 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH] tpm: atmel: depend on X86
Date: Sun, 12 Jul 2026 20:32:34 +0200
Message-Id: <20260712183234.23125-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-9926-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kmehltretter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kmehltretter@gmail.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmehltretter@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76E0C745A31

tpm_atmel probes for the chip at fixed x86 Super-I/O ports (0x4e) with
inb()/outb(), so it only works on x86. TCG_ATMEL nevertheless depends
only on HAS_IOPORT_MAP/HAS_IOPORT, which arm and arm64 also satisfy.
There the probe is useless, and on platforms whose unbacked I/O access
faults it oopses in init_atmel() at boot (e.g. arm/versatile):

  Unable to handle kernel paging request at virtual address fee0004e
  PC is at init_atmel+0x34/0x244

TCG_NSC and TCG_TIS already "depends on X86" (commit 2f592f2a7d74 ("TPM:
NSC and TIS drivers X86 dependency fix")); TCG_ATMEL was missed. Add the
same dependency.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/char/tpm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 8a8f692b6088..5f672f2c01b0 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -163,8 +163,7 @@ config TCG_NSC
 
 config TCG_ATMEL
 	tristate "Atmel TPM Interface"
-	depends on HAS_IOPORT_MAP
-	depends on HAS_IOPORT
+	depends on X86
 	help
 	  If you have a TPM security chip from Atmel say Yes and it 
 	  will be accessible from within Linux.  To compile this driver 
-- 
2.39.5 (Apple Git-154)


