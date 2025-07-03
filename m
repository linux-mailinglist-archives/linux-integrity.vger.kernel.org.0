Return-Path: <linux-integrity+bounces-6608-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 153E2AF802A
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B178A7B8A91
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465D2F4324;
	Thu,  3 Jul 2025 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO+yULKi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4052F4320;
	Thu,  3 Jul 2025 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567674; cv=none; b=CMYfGu1OevCt/avBvPL36d8eBT4L7NHCXX9wKMRU8uh/Bz9sXBLkVk/Ly4BMdUuxlILOT8aClIX+zxULbXgpn5kM00exijGh+5a0N1Wt+Hqj2Nbr5ioMld9+rXMevwx3TMDnWdEcrIjTWofYzmo1HJrcz8Fn36aeRFD5rIACiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567674; c=relaxed/simple;
	bh=lA9ANhw3QErm4wzUqrLyOddiDx+o1BLzt3YH5G9fTCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qxc9ed4YxXQwXynajafGSN2lqbm5ZtMOYlcgUEnFHHcwnjL1vZXuHtQdtn0Tij8+A9262akAkRXp7WlrL5/6z/rXBRKfS3NAMhJFTsb+vVjGTfd0Vn53/xZxJ24dBoJTROsrFhQyFjsvDCphfYzvTUN5wKZ/j3Hdg0Kt5Pfghok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO+yULKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84993C4CEF1;
	Thu,  3 Jul 2025 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567673;
	bh=lA9ANhw3QErm4wzUqrLyOddiDx+o1BLzt3YH5G9fTCQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EO+yULKiSEhzL8yrGseevChENL0UD3mhn2lN9TSQDBuJhb2eTEu2sgtqL3wLs+NLu
	 j2+wkq7kZTMtmKLUAMhYcNwYuMPvURq/xhgE4b14rnnydm/NGzggzB57ZXW9bQuxga
	 xKqZjiOFykv6Badof5aPat0FiGnQTRPCcxdeZyYLpZ22bemnwTJ7UJ6J/76arCzKxz
	 fyCHV/jyg2ZWuIJhSU/dlz/k8stzkZvUrw/jLj/YZaIIFCybP00Y1WDU34NgKyoD2f
	 omwfjCXKSg040gag0eUJ4g6djQePMxxQ+4DtWLFWRvMyl6Ll75I9Avj7DJ4K73PnRd
	 nXzhGlLiXiu1g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Use of_reserved_mem_region_to_resource() for "memory-region"
Date: Thu,  3 Jul 2025 13:34:24 -0500
Message-ID: <20250703183424.2073075-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the newly added of_reserved_mem_region_to_resource() function to
handle "memory-region" properties.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/char/tpm/eventlog/of.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index 930fe43d5daf..92cec9722ee4 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -24,16 +24,10 @@
 
 static int tpm_read_log_memory_region(struct tpm_chip *chip)
 {
-	struct device_node *node;
 	struct resource res;
 	int rc;
 
-	node = of_parse_phandle(chip->dev.parent->of_node, "memory-region", 0);
-	if (!node)
-		return -ENODEV;
-
-	rc = of_address_to_resource(node, 0, &res);
-	of_node_put(node);
+	rc = of_reserved_mem_region_to_resource(chip->dev.parent->of_node, 0, &res);
 	if (rc)
 		return rc;
 
-- 
2.47.2


