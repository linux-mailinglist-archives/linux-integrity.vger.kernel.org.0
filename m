Return-Path: <linux-integrity+bounces-8144-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7829FCE87F3
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Dec 2025 02:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B0DD300E7FF
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Dec 2025 01:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563232BE7AA;
	Tue, 30 Dec 2025 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jW7ESLbd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Q78Zf77n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F883A14;
	Tue, 30 Dec 2025 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767058869; cv=none; b=Y/cqHpLsIdwG9s6peHlN/8HbouFY1CL4zXiiU/vGrBBLGArZOkbyXYaulBO3rBPTwyZnGQfQrZD3pqyiL2bIexh8IsUiuQaDZO0C6huEIP8HkatteHZ+UHOz+TPwpIA3j5r7mjmT06rdzmcTApaw55sRbbz1vgWspi2UPrEuKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767058869; c=relaxed/simple;
	bh=3jOHULBKhVbyzM6NbSRmk35tyefGTJYuanirFekbSs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dcfTqDFmUkRNzxLUedwIUcei8lvTlqct8drgHTJj+gRykQfT60j/yowxYKSsz9EvsGvlyCLcJqvsBrpSXMV2083HVFl3TMY7N8l+Y2Gi50IUoxdF2zVmv0iCE2d8msvLB4xhTItB8e9Wnsnsat1pLDaVJ4ATiDocVsv6NdRj6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jW7ESLbd; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Q78Zf77n; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dgG5F1dYTz9tk9;
	Tue, 30 Dec 2025 02:41:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767058865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ssd4BciXQz+Gn/vBf6xCjurqrI43qxNxgTkSD8uqSk=;
	b=jW7ESLbdu/qmz3y8KLDmHascdwS/ghDG4YmiLmZSbD3SoNmpCsVtkIl/C07UNxgX7miLUu
	jt7z055ID4XK47sPptIDmgelRaB0FQN+x+4HwDlesvR1xhBJY9hVep/hFPbatwG1XbEsne
	nmcqCDOawTngP+Esr3STi9bgtpm6wjnwNWow3iYfP/s0G7I5IARhnsefexxLrIWLdmH4aE
	u7K6dK2zDy31SGMJokp0Poq6mShpNY6NOKv93C1mbSkshIJHoXAcB/SY+SwCMB1C8afxET
	RgTQOffXOLMyTUQ6wrQbWNBnNp4Csnu+EdMZRctFLauDjd9CrR1mfTZumcLu+g==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767058863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ssd4BciXQz+Gn/vBf6xCjurqrI43qxNxgTkSD8uqSk=;
	b=Q78Zf77n5wwRLa3iID7PPgeDCHC1zxeDioXek93c+azWJFLA1BWtSs4fhNfsw3IobWtVM6
	WUxf0CdpKZz/P9LaKlBo6+ThpMc52WEo4w5C1xj6J7pUEN0Ccm3NEv3SltHGhKKId2DgMS
	Kjnbpei5RZ1f6qcMr483NzgWGxMy1+jg+osAFESdy/QtRzoTLz4p+WHTZQnfWHkYoDc7G3
	OtwjqlYXtQiEQSpyhCxT2WJh11Sb22EjEZOxg1JV6KG3x93tbvQ5cALJHc4t2/t313orNM
	ZepGBlqyyEIwp6pJ+BVnCJOTSXn5ypG/7Ka37RMwSlLgExO7VF3GYSY2r8FYcw==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: tpm: Add st,st33tphf2ei2c
Date: Tue, 30 Dec 2025 02:40:34 +0100
Message-ID: <20251230014047.149677-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f6mz559iybyxjt7ykoyogncmr9zmeqit
X-MBO-RS-ID: dac313bfe24767e9b80

Add the ST chip st33tphf2ei2c to the supported compatible strings of the
TPM TIS I2C schema. The chip is compliant with the TCG PC Client TPM
Profile specification.

For reference, a databrief is available at:
https://www.st.com/resource/en/data_brief/st33tphf2ei2c.pdf

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
V2: - Rebase on current next, update email address
    - Add AB from Krzysztof
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
2.51.0


