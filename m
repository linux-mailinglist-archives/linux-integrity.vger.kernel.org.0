Return-Path: <linux-integrity+bounces-224-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCF7FA2E2
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 15:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5F21F20C74
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CFE2EB0C;
	Mon, 27 Nov 2023 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 06:33:23 PST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A18ABF;
	Mon, 27 Nov 2023 06:33:23 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 30FD8101E6982;
	Mon, 27 Nov 2023 15:25:18 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id E7E1260F070B;
	Mon, 27 Nov 2023 15:25:17 +0100 (CET)
X-Mailbox-Line: From 86f0fa5ea2759586a871db9978b2fcedd3de6b6f Mon Sep 17 00:00:00 2001
Message-Id: <86f0fa5ea2759586a871db9978b2fcedd3de6b6f.1701093036.git.lukas@wunner.de>
In-Reply-To: <cover.1701093036.git.lukas@wunner.de>
References: <cover.1701093036.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 27 Nov 2023 15:02:53 +0100
Subject: [PATCH v2 3/3] dt-bindings: tpm: Document Microsoft fTPM bindings
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Nayna Jain <nayna@linux.ibm.com>, Thirupathaiah Annapureddy <thiruan@microsoft.com>, Sasha Levin <sashal@kernel.org>, Alexander Steffen <Alexander.Steffen@infineon.com>, Johannes Holland <Johannes.Holland@infineon.com>, Amir Mizinski <amirmizi6@gmail.com>, Benoit HOUYERE <benoit.houyere@st.com>, Peter Delevoryas <peter@pjd.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

A driver for Microsoft's firmware-based Trusted Platform Module (fTPM)
was merged with commit 09e574831b27 ("tpm/tpm_ftpm_tee: A driver for
firmware TPM running inside TEE"), but its devicetree bindings were not.

This is the only remaining undocumented compatible string for a TPM,
so add a DT schema based on the patch linked below.

Link: https://lore.kernel.org/all/20190409184958.7476-2-sashal@kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/tpm/microsoft,ftpm.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml

diff --git a/Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml b/Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml
new file mode 100644
index 000000000000..cc9c3aa6d48d
--- /dev/null
+++ b/Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tpm/microsoft,ftpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft firmware-based Trusted Platform Module (fTPM)
+
+maintainers:
+  - Thirupathaiah Annapureddy <thiruan@microsoft.com>
+  - Sasha Levin <sashal@kernel.org>
+
+description: |
+  Commodity CPU architectures, such as ARM and Intel CPUs, have started to
+  offer trusted computing features in their CPUs aimed at displacing dedicated
+  trusted hardware.  Unfortunately, these CPU architectures raise serious
+  challenges to building trusted systems because they omit providing secure
+  resources outside the CPU perimeter.
+
+  Microsoft's firmware-based TPM 2.0 (fTPM) leverages ARM TrustZone to overcome
+  these challenges and provide software with security guarantees similar to
+  those of dedicated trusted hardware.
+
+  https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/
+  https://github.com/Microsoft/ms-tpm-20-ref/tree/main/Samples/ARM32-FirmwareTPM
+
+properties:
+  compatible:
+    enum:
+      - microsoft,ftpm
+
+required:
+  - compatible
+  - linux,sml-base
+  - linux,sml-size
+
+allOf:
+  - $ref: tpm-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    tpm {
+        compatible = "microsoft,ftpm";
+        linux,sml-base = <0x0 0xc0000000>;
+        linux,sml-size = <0x10000>;
+    };
-- 
2.40.1


