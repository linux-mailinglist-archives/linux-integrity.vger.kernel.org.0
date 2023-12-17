Return-Path: <linux-integrity+bounces-523-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83F0815E97
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38416282F07
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED53566F;
	Sun, 17 Dec 2023 10:52:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32379C8;
	Sun, 17 Dec 2023 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 8D69B10189BEB;
	Sun, 17 Dec 2023 11:52:50 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 4F3A66073EFF;
	Sun, 17 Dec 2023 11:52:50 +0100 (CET)
X-Mailbox-Line: From 99523409eb5aec9276055ff358ae6f2ceb10be6d Mon Sep 17 00:00:00 2001
Message-Id: <99523409eb5aec9276055ff358ae6f2ceb10be6d.1702806810.git.lukas@wunner.de>
In-Reply-To: <cover.1702806810.git.lukas@wunner.de>
References: <cover.1702806810.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 17 Dec 2023 11:13:34 +0100
Subject: [PATCH v3 4/4] dt-bindings: tpm: Document Microsoft fTPM bindings
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Nayna Jain <nayna@linux.ibm.com>, Thirupathaiah Annapureddy <thiruan@microsoft.com>, Sasha Levin <sashal@kernel.org>, Andrey Pronin <apronin@chromium.org>, Alexander Steffen <Alexander.Steffen@infineon.com>, Johannes Holland <Johannes.Holland@infineon.com>, Amir Mizinski <amirmizi6@gmail.com>, Benoit HOUYERE <benoit.houyere@st.com>, Peter Delevoryas <peter@pjd.dev>, Ninad Palsule <ninad@linux.ibm.com>, Guenter Roeck <linux@roeck-us.net>, Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>
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
Changes v2 -> v3:
  * Use "const" instead of "enum" for singleton compatible string.

 .../bindings/tpm/microsoft,ftpm.yaml          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml

diff --git a/Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml b/Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml
new file mode 100644
index 000000000000..fdb81968f03d
--- /dev/null
+++ b/Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml
@@ -0,0 +1,47 @@
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
+    const: microsoft,ftpm
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


