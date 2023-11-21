Return-Path: <linux-integrity+bounces-140-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554E77F299B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 11:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101162823A4
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2253C693;
	Tue, 21 Nov 2023 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAAA183;
	Tue, 21 Nov 2023 02:00:19 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id D2C732800B6C4;
	Tue, 21 Nov 2023 11:00:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C726D36F7C; Tue, 21 Nov 2023 11:00:14 +0100 (CET)
Message-Id: <ad4b484da8190c83902b2525823ceb3439a7576e.1700555862.git.lukas@wunner.de>
In-Reply-To: <cover.1700555862.git.lukas@wunner.de>
References: <cover.1700555862.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 21 Nov 2023 10:48:43 +0100
Subject: [PATCH 3/3] dt-bindings: tpm: Document Microsoft fTPM bindings
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>
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


