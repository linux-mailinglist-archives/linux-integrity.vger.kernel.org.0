Return-Path: <linux-integrity+bounces-519-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6928815E71
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 11:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3DD1C20FE2
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Dec 2023 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C8E3D8E;
	Sun, 17 Dec 2023 10:25:56 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E6538D;
	Sun, 17 Dec 2023 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 68DA710189BEB;
	Sun, 17 Dec 2023 11:18:27 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 3923660C436B;
	Sun, 17 Dec 2023 11:18:27 +0100 (CET)
X-Mailbox-Line: From 99523409eb5aec9276055ff358ae6f2ceb10be6d Mon Sep 17 00:00:00 2001
Message-Id: <cover.1702806810.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 17 Dec 2023 11:13:30 +0100
Subject: [PATCH v3 0/4] dt-bindings: tpm: Clean all the things
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Nayna Jain <nayna@linux.ibm.com>, Thirupathaiah Annapureddy <thiruan@microsoft.com>, Sasha Levin <sashal@kernel.org>, Andrey Pronin <apronin@chromium.org>, Alexander Steffen <Alexander.Steffen@infineon.com>, Johannes Holland <Johannes.Holland@infineon.com>, Amir Mizinski <amirmizi6@gmail.com>, Benoit HOUYERE <benoit.houyere@st.com>, Peter Delevoryas <peter@pjd.dev>, Ninad Palsule <ninad@linux.ibm.com>, Guenter Roeck <linux@roeck-us.net>, Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>

TPM dt-bindings cleanup, take three.

The existing devicetrees in arch/arm and arch/arm64 contain a few
violations of the schemas contained herein.  E.g. the nodename is
not "tpm@..." but "tpmdev@..." in some cases.  I've got patches
lined up to fix these issues and will submit them separately.

Changes v2 -> v3:
* [PATCH 1/4]:
  * Drop clock-frequency property from tcg,tpm-tis-i2c.yaml.
    It doesn't exist at the peripheral level, only at the
    controller level.  Document maximum clock frequency for
    infineon,slb9635tt and infineon,slb9645tt in textual form
    (as was previously done in trivial-devices.yaml).
  * Document reset-gpios property as used by:
    arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts

* [PATCH 2/4]:
  * Introduce new schema specifically for google,cr50 (Rob).
    Note that I can't use "oneOf" for SPI and I²C properties
    because a node with only a "reg" property is a valid SPI
    and I²C node and would match both subschemas.
    So "anyOf" it is.

* [PATCH 4/4]:
  * Use "const" instead of "enum" for singleton compatible string.

Link to v2:
https://lore.kernel.org/linux-devicetree/cover.1701093036.git.lukas@wunner.de/


Lukas Wunner (4):
  dt-bindings: tpm: Consolidate TCG TIS bindings
  dt-bindings: tpm: Convert Google Cr50 bindings to DT schema
  dt-bindings: tpm: Convert IBM vTPM bindings to DT schema
  dt-bindings: tpm: Document Microsoft fTPM bindings

 .../bindings/security/tpm/google,cr50.txt     |  19 ----
 .../bindings/security/tpm/ibmvtpm.txt         |  41 -------
 .../bindings/security/tpm/st33zp24-i2c.txt    |  34 ------
 .../bindings/security/tpm/st33zp24-spi.txt    |  32 ------
 .../bindings/security/tpm/tpm-i2c.txt         |  26 -----
 .../bindings/security/tpm/tpm_tis_mmio.txt    |  25 -----
 .../bindings/security/tpm/tpm_tis_spi.txt     |  23 ----
 .../devicetree/bindings/tpm/google,cr50.yaml  |  65 +++++++++++
 .../devicetree/bindings/tpm/ibm,vtpm.yaml     | 104 ++++++++++++++++++
 .../bindings/tpm/microsoft,ftpm.yaml          |  47 ++++++++
 .../bindings/tpm/tcg,tpm-tis-i2c.yaml         |  90 +++++++++++++++
 .../bindings/tpm/tcg,tpm-tis-mmio.yaml        |  49 +++++++++
 .../bindings/tpm/tcg,tpm_tis-spi.yaml         |  75 +++++++++++++
 .../devicetree/bindings/tpm/tpm-common.yaml   |  87 +++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  16 ---
 15 files changed, 517 insertions(+), 216 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
 create mode 100644 Documentation/devicetree/bindings/tpm/google,cr50.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/tpm/tpm-common.yaml

-- 
2.40.1


