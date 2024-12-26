Return-Path: <linux-integrity+bounces-4477-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD89FCC56
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 18:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE341631A1
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22939145B00;
	Thu, 26 Dec 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JVoETtp8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF8143723;
	Thu, 26 Dec 2024 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735233111; cv=none; b=Q2GsJiS4xMNLXvmDL6fsUIpsJSQITjHitUDVQfDkbaHgP/Rv1lg4oKMF2+x9owrdh9A6CeJFeY1zEGHIH5ABtkYU8docCtDlCfVrkOUAXcWflb3Zrq5IsCRK0Qf9MNj7r9vbRPomjavO+B/yuksyEgrKjwmEWCq5tMuVtUv8B4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735233111; c=relaxed/simple;
	bh=TbmZQZkQHLfg2VzUOu0CVDkOBgbtu17sYaBVDlJi1z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mJudOvo7vfqSkh1iG86u/B/fSi4WbcFLW7hdp8TObNji2nwqo50linZgu5biNhM78Q/vA8waeSwzd3bXOWzUxaqF4R3F/ulBuCjqgIn1h90sSuYQJaLDYTArrxbM1Tc68eZZ32XfIXLvAFmErMaCFHpZz6i3pigjmaXbfLVrlfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JVoETtp8; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 114D510408FAF;
	Thu, 26 Dec 2024 18:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1735233106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R0Oy2sXap8aDR2cwmY9i1WivgGktx0zLs8o0teT9WBw=;
	b=JVoETtp8LaY+jKy/o7pSJTNzxfzWYPjFUE8KSDDhj55ldNYOhx1wor8lP2KuJnWMy+nd0b
	hcMZLO+Fiq223aKUdSWx2OeOLim1qqD5ZdM8JQXVXEwaOlPFteHCjzMs4Zf3RpNbxmtS87
	BUBGlJHJFaUS2ESjRpCFywzbiDeIHXsc7ciSJ2HceT+Bzc66CeSyBRW936BkPlj7yp/93r
	oGb2+ijI08Qg3xl5cNB3DsnPZbcqAvJwaBCFxKIgyyHiieyRfusLr6a66GD05v4w9Tkg+8
	7aCFCbYFR7gHBVVLiVmKlBi7KvrJjdjkr9+yeoXYs2es7X0lHpoxjuGzSt/ftg==
From: Marek Vasut <marex@denx.de>
To: devicetree@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Rob Herring <robh@kernel.org>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] dt-bindings: tpm: Add st,st33tphf2ei2c
Date: Thu, 26 Dec 2024 18:10:52 +0100
Message-ID: <20241226171124.83735-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add the ST chip st33tphf2ei2c to the supported compatible strings of the
TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
Profile specification.

For reference, a databrief is available at:
https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
---
 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
index af7720dc4a12c..fdd7fd874e01e 100644
--- a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
+++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
@@ -33,6 +33,7 @@ properties:
               - infineon,slb9673
               - nuvoton,npct75x
               - st,st33ktpm2xi2c
+              - st,st33tphf2ei2c
           - const: tcg,tpm-tis-i2c
 
       - description: TPM 1.2 and 2.0 chips with vendor-specific I²C interface
-- 
2.45.2


