Return-Path: <linux-integrity+bounces-7087-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A74B58479
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 20:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DC6161BB6
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA92DF3CF;
	Mon, 15 Sep 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="GfuVNvcX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0842D12E0;
	Mon, 15 Sep 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960472; cv=none; b=brCWwrq1Pv9gZqAxiTjob1IjzJR0px8p3d0nWvk7Eg9mvCeigA69i8rYbWJ4Tem7cxYtGy8/tszR49TeClLuiJQDPOGOsyuhd257PbdWL6HpO4Ohx+MH435AiBzrdKBpjj5wwpbEcfYVS/btD0AtYccOXIG+Gc5u6AWg1DozcNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960472; c=relaxed/simple;
	bh=PEoO1C0Hv5+CbTVQ1qWI2SP+EpjMKGXQ2cmIg+TUaJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMA8zdXH5FHfZZjxIJYp42uJURhlSqDW8cH2trA7D4kximNj+6AxWvD1PHjthGH8tJCa+AQryAXY++Sl/SvSYByrSmhkTb+NqEfYW28ZvqOX/nklIJVIu3ZmwH+RmvAjQPA1Ezu+gMZfOnTwDLCl4llX5vbYpYEl3LX6z686ndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GfuVNvcX; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757960471; x=1789496471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7O3IYagJoiX+gt77T0OesTy7GT31k4QznuVmMo0p8hw=;
  b=GfuVNvcXxuXRk+hkUsUIXY7bSxKJ4nvny/oRiHMICBs6R0g0u8CnIhO+
   cshbsqzxYuUBOzFkytK4yENSkWjms/eneOCU85R72buJsFb0Ey4Il8L5N
   lVJmRvUL+pF4SVfslN7DvB08UNxEQuf1TXwNHMfv9nO1NMGZYWR5flgUp
   qYEWbfkdPGGS62Cs5XaQBRNFwNBkD1yAJ3YhyoG9tWkZNR7AYJxNpBVXu
   OSJX013S8nbP+uTDLNULPKyOelnPsp9ecGhmVxmUnErXN52bfOUvlpQ+W
   iJY29pUaTCxAdncT6OUBmbY9OuCpjGNDBb7LYbsV3eV+UG0sd50m/Gowx
   A==;
X-CSE-ConnectionGUID: zjNEpi3ARzS8x1cSF+zIUw==
X-CSE-MsgGUID: KTG2D8NPQk2JTh8nBAwJCg==
X-IronPort-AV: E=Sophos;i="6.18,266,1751241600"; 
   d="scan'208";a="3035264"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 18:21:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:6558]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.38:2525] with esmtp (Farcaster)
 id f94009dd-42bf-40c8-a998-032c66133717; Mon, 15 Sep 2025 18:21:10 +0000 (UTC)
X-Farcaster-Flow-ID: f94009dd-42bf-40c8-a998-032c66133717
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 18:21:10 +0000
Received: from dev-dsk-gunnarku-2c-36117f29.us-west-2.amazon.com
 (172.23.139.22) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 15 Sep 2025
 18:21:10 +0000
From: Gunnar Kudrjavets <gunnarku@amazon.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC: <jgg@ziepe.ca>, <stefanb@linux.vnet.ibm.com>,
	<christophe.ricard@gmail.com>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Justinien Bouron <jbouron@amazon.com>
Subject: [PATCH] tpm_tis: Fix incorrect arguments in tpm_tis_probe_irq_single
Date: Mon, 15 Sep 2025 18:20:44 +0000
Message-ID: <20250915182105.6664-1-gunnarku@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The tpm_tis_write8() call specifies arguments in wrong order. Should be
(data, addr, value) not (data, value, addr). The initial correct order
was changed during the major refactoring when the code was split.

Fixes: 41a5e1cf1fe1 ("tpm/tpm_tis: Split tpm_tis driver into a core and TCG TIS compliant phy")
Signed-off-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 4b12c4b9da8b..8954a8660ffc 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -978,8 +978,8 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	 * will call disable_irq which undoes all of the above.
 	 */
 	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
-		tpm_tis_write8(priv, original_int_vec,
-			       TPM_INT_VECTOR(priv->locality));
+		tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality),
+			       original_int_vec);
 		rc = -1;
 	}


base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
--
2.47.3


