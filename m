Return-Path: <linux-integrity+bounces-137-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6597F294E
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 10:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A832282966
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6453C089;
	Tue, 21 Nov 2023 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D36C1705;
	Tue, 21 Nov 2023 01:49:21 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7BEEF30001180;
	Tue, 21 Nov 2023 10:49:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6FF1E35E2B; Tue, 21 Nov 2023 10:49:19 +0100 (CET)
Message-Id: <cover.1700555862.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 21 Nov 2023 10:48:40 +0100
Subject: [PATCH 0/3] dt-bindings: tpm: Clean all the things
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>

Rob asked me to consolidate and convert the TPM dt-bindings:
https://lore.kernel.org/all/20230927115300.GA1587935-robh@kernel.org/

I came across several issues:

First, this pull request is needed to cope with ibm,#dma-address-cells
and ibm,#dma-size-cells properties used in ibm,vtpm.yaml:

  https://github.com/devicetree-org/dt-schema/pull/116

Second, the compatible string "google,cr50" refers to a chip which has
both an i2c and an spi interface (see drivers/char/tpm/tpm_tis_i2c_cr50.c
as well as tpm_tis_spi_main.c)  This confuses the schema validator
because it thinks that "google,cr50" may only use i2c properties but
tcg,tpm_tis-spi.yaml contains an spi example, which causes some warnings.
It seems deeper code changes to the schema validator are required to
avoid them:

  Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.example.dtb: tpm@0: compatible:1: 'tcg,tpm-tis-i2c' was expected
  from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
  Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.example.dtb: tpm@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
  from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#

Third, the schema validator raises warnings about three properties
I've defined in tpm-common.yaml:  "linux,sml-base" and "linux,sml-size"
are nested in a oneOf/allOf clause and "lpcpd-gpios" is nested in an
allOf/if-then clause.  This seems to confuse the validator:

  Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.example.dtb: tpm@57: Unevaluated properties are not allowed ('linux,sml-base', 'linux,sml-size' were unexpected)
  from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
  Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.example.dtb: tpm@13: Unevaluated properties are not allowed ('lpcpd-gpios' was unexpected)
  from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#

I can get rid of those warnings by setting "unevaluatedProperties: true",
but that doesn't seem to be desirable.


Lukas Wunner (3):
  dt-bindings: tpm: Consolidate TCG TIS bindings
  dt-bindings: tpm: Convert IBM vTPM bindings to DT schema
  dt-bindings: tpm: Document Microsoft fTPM bindings

 .../bindings/security/tpm/google,cr50.txt     |  19 ----
 .../bindings/security/tpm/ibmvtpm.txt         |  41 -------
 .../bindings/security/tpm/st33zp24-i2c.txt    |  34 ------
 .../bindings/security/tpm/st33zp24-spi.txt    |  32 ------
 .../bindings/security/tpm/tpm-i2c.txt         |  26 -----
 .../bindings/security/tpm/tpm_tis_mmio.txt    |  25 ----
 .../bindings/security/tpm/tpm_tis_spi.txt     |  23 ----
 .../devicetree/bindings/tpm/ibm,vtpm.yaml     | 101 +++++++++++++++++
 .../bindings/tpm/microsoft,ftpm.yaml          |  48 ++++++++
 .../bindings/tpm/tcg,tpm-tis-i2c.yaml         | 107 ++++++++++++++++++
 .../bindings/tpm/tcg,tpm-tis-mmio.yaml        |  50 ++++++++
 .../bindings/tpm/tcg,tpm_tis-spi.yaml         |  88 ++++++++++++++
 .../devicetree/bindings/tpm/tpm-common.yaml   |  56 +++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  16 ---
 14 files changed, 450 insertions(+), 216 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
 create mode 100644 Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tpm-common.yaml

-- 
2.40.1


