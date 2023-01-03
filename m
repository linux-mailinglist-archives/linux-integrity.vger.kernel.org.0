Return-Path: <linux-integrity+bounces-634-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F65C8230D1
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C99A1C23750
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27841B27F;
	Wed,  3 Jan 2024 15:52:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D71BDC4;
	Wed,  3 Jan 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 16EA4100DCEC0;
	Wed,  3 Jan 2024 16:52:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BE5BC2CD19; Wed,  3 Jan 2024 16:52:03 +0100 (CET)
Message-Id: <ea312fdaab76efd1cbcc4ed9fd0e15e5afd1ef88.1704296746.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 3 Jan 2023 16:51:14 +0100
Subject: [PATCH] dt-bindings: tpm: Add compatible string atmel,attpm20p
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Tim Harvey <tharvey@gateworks.com>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM device")
added a devicetree node for the Trusted Platform Module on certain
Gateworks boards.

The commit only used the generic "tcg,tpm_tis-spi" compatible string,
but public documentation shows that the chip is an ATTPM20P from Atmel
(nowadays Microchip):
https://trac.gateworks.com/wiki/tpm

Add the chip to the supported compatible strings of the TPM TIS SPI
schema.

For reference, a datasheet is available at:
https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Tim Harvey <tharvey@gateworks.com>
---
This patch depends on the following series to consolidate TCG TIS bindings:
https://lore.kernel.org/all/cover.1702806810.git.lukas@wunner.de/

 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
index c3413b4..6cb2de7 100644
--- a/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
+++ b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     items:
       - enum:
+          - atmel,attpm20p
           - infineon,slb9670
           - st,st33htpm-spi
           - st,st33zp24-spi
-- 
2.40.1


