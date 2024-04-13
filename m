Return-Path: <linux-integrity+bounces-2084-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C58A3B6A
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 09:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127851F21726
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 07:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B241CABF;
	Sat, 13 Apr 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b="noGgncqN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8F1D559
	for <linux-integrity@vger.kernel.org>; Sat, 13 Apr 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712992610; cv=none; b=i7yY9c9T2CINLTVjOtqsIXpvmaQ72qO2IUGmlA+TTRd4P7YrN1oGUuoUjVKSt1pLFZnXpHkr2oGaOhKhNzRVPNORZvW6COrmvg8xgV0GVuuI2RIAJFzRDWjc2wfSCPX4CLEylTL1oeHFjZpcx1FsYCuaZH9s3SzArpbg1oNA6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712992610; c=relaxed/simple;
	bh=VYCAoTa/V/nFhj2VwkHIfOAHACMhnfVxJTdBdmtICIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ24RHKCXuL15qWfKGK8S9WzFpcqj8aPx78CE4WrdZRuAuSE2H4DckW1tevzwhLKquJPrsOSLadafTDN+nLmeFlxMSjne0zEayzNrh4T4W7C+xLugpLW5PIjZIQQ+Kn3mMJ43trg6Aftatb9gYKdnEGljtkcSNa1LhvTfujCAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b=noGgncqN; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240413071641e2e890a746ba3960e4
        for <linux-integrity@vger.kernel.org>;
        Sat, 13 Apr 2024 09:16:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xsKJ0SsOx0zGh02X8aXwuRhZZ+HQQlUaqaI2dbR4X/I=;
 b=noGgncqNdEsXeWDcacL14GwgaeyD+T1mxWVXmnyzB4xmZLjcth+8P5P77Y6h+MpKcPXB0b
 L+4e1VGW8osEPc9bpI3KNtr9vuX/GuMc9oOQtkBjPHn7ZczoFtOfmmVL1U2Tv/CNEpLePqcr
 QxsuDpsZxov3LaTr5xlxj7DSxESUQ=;
From: "M. Haener" <michael.haener@siemens.com>
To: linux-integrity@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 1/2] tpm: tis_i2c: Add compatible string st,st33ktpm2xi2c
Date: Sat, 13 Apr 2024 09:15:06 +0200
Message-ID: <20240413071621.12509-2-michael.haener@siemens.com>
In-Reply-To: <20240413071621.12509-1-michael.haener@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

From: Michael Haener <michael.haener@siemens.com>

Add "st,st33ktpm2xi2c" to the TPM TIS I2C driver. The Chip is compliant
with the TCG PC Client TPM Profile specification.

For reference, a datasheet is available at:
https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 9511c0d50185..1f277c34e6da 100644
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
2.44.0


