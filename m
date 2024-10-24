Return-Path: <linux-integrity+bounces-3905-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776699ADB91
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 07:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090B62832EB
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2024 05:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F414165F01;
	Thu, 24 Oct 2024 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="uD/31oaC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F1C8F0;
	Thu, 24 Oct 2024 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729748598; cv=none; b=CQZC4gghRksORkGIUGSjiUOe1JYvgSSxFRi1A4lh//NH8bL794Xzyp0C9ugPm1SNbBN0NRfaWKYWMwy7CI/VafglPOu/K2EeH74jiDLi8PjuIVMIII8RPshepZs9lye6N6tcjVwSUaJYP9smJfumaKLiOlJpNq3SntnHeNjSg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729748598; c=relaxed/simple;
	bh=wjqS/t8+rcOU09Cga1EforbscJmeUuOflPkZevgZ7B8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9swSg48lfQw4yHYbmkQ6zlfVIGB3HFCbAt4iilDHNfDarNhjQt/tj3W+G3yCp9s/lIOI2V/iVtNZf1LX89e5oq3Y9/qAxpiVamEpMFItnzIrPvBVAeFj9wApOFtaO6LYGVcIgxxlnB5yTfEConUn3BJ0wSNkP6o262ptJP11Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=uD/31oaC; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (82-131-200-27.pool.digikabel.hu [82.131.200.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0838888E0F;
	Thu, 24 Oct 2024 07:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729748594;
	bh=67XcJrpAeWLTopuAGqI8NMDSv4lhCuMcrzl9ZzSiXug=;
	h=From:To:Cc:Subject:Date:From;
	b=uD/31oaCMBI34Ew9AH7yCtoh/G8kSIEnWl8L+NX3j/um1WNeBGCv0jJBObFACk//e
	 LpPnXPf622DwJHThGb3Yb75oaMN3cMe5C8C1NtagePsWKhNO+0pqPCHUgqOXAtJdxD
	 hhPcGbUjOJiAjHHErz3g8laEJjoCR5ckLOct0Zqx3ITLkkOjVySJzW9c2IrVTPTO7Z
	 iJFj3bEAp3hyu3Bpf6+IMyWUj2wNgYRFPmngycNiLTB4RnecnTl8RiJv6sShaUnEQM
	 irQDXp9DVsBGoulXwbdnsLPUlM6Y+WF0+81jvNC3Xx8e1T2dNWRLVo85OshaKChLLe
	 RccIIuHwGyJ6w==
From: Heiko Schocher <hs@denx.de>
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v1] tpm: tis_i2c: add ST33KTPM2XI2C compatible entry
Date: Thu, 24 Oct 2024 07:43:04 +0200
Message-Id: <20241024054304.26714-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

add compatible entry "st,st33ktpm2xi2c" for ST33KTPM2XI2C
chip from ST.

datasheet:
https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf

This entry is already documented in
Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml

and so we should add this compatible entry in the
related driver.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 drivers/char/tpm/tpm_tis_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 6cd07dd34507..933e10c7522e 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -384,6 +384,7 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 static const struct of_device_id of_tis_i2c_match[] = {
 	{ .compatible = "infineon,slb9673", },
 	{ .compatible = "nuvoton,npct75x", },
+	{ .compatible = "st,st33ktpm2xi2c", },
 	{ .compatible = "tcg,tpm-tis-i2c", },
 	{}
 };
-- 
2.20.1


