Return-Path: <linux-integrity+bounces-765-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3A82CDE0
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 18:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D71D283A58
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4984E4C8E;
	Sat, 13 Jan 2024 17:17:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48114C80;
	Sat, 13 Jan 2024 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1F9ED100F00CE;
	Sat, 13 Jan 2024 18:17:02 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E7B732BC2F7; Sat, 13 Jan 2024 18:17:01 +0100 (CET)
Message-Id: <8886271d52025065eddf5915bb7778ab14362255.1705140898.git.lukas@wunner.de>
In-Reply-To: <cover.1705140898.git.lukas@wunner.de>
References: <cover.1705140898.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 13 Jan 2024 18:10:51 +0100
Subject: [PATCH v2 1/4] dt-bindings: tpm: Add compatible string atmel,attpm20p
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>
---
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


