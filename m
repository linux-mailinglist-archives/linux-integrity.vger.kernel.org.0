Return-Path: <linux-integrity+bounces-220-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8263B7FA20B
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 15:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE13B20E2D
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953B30F9E;
	Mon, 27 Nov 2023 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
X-Greylist: delayed 414 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 06:10:12 PST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E784319AB;
	Mon, 27 Nov 2023 06:10:12 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 7822810189CF9;
	Mon, 27 Nov 2023 15:03:14 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 420A5609C75F;
	Mon, 27 Nov 2023 15:03:14 +0100 (CET)
X-Mailbox-Line: From 86f0fa5ea2759586a871db9978b2fcedd3de6b6f Mon Sep 17 00:00:00 2001
Message-Id: <cover.1701093036.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 27 Nov 2023 15:02:50 +0100
Subject: [PATCH v2 0/3] dt-bindings: tpm: Clean all the things
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Nayna Jain <nayna@linux.ibm.com>, Thirupathaiah Annapureddy <thiruan@microsoft.com>, Sasha Levin <sashal@kernel.org>, Alexander Steffen <Alexander.Steffen@infineon.com>, Johannes Holland <Johannes.Holland@infineon.com>, Amir Mizinski <amirmizi6@gmail.com>, Benoit HOUYERE <benoit.houyere@st.com>, Peter Delevoryas <peter@pjd.dev>

TPM dt-bindings cleanup, take two.

Changes v1 -> v2:

* [PATCH 1/3]:
  * Overhaul i2c compatible definitions.  Turns out that the fallback
    tcg,tpm-tis-i2c only applies to chips conforming to the PTP spec,
    wheras other chips use a vendor-specific interface and thus omit
    the fallback.
  * Don't enforce fallback compatible tcg,tpm_tis-spi for google,cr50.
  * Add nodename restriction to tpm-common.yaml.
  * Add clock constraints that were previously documented for
    infineon,slb9635tt and infineon,slb9645tt.
  * Drop google,cr50 SPI example (Rob).
  * Fix errors for linux,sml-base, linux,sml-size and lpcpd-gpios
    properties (Rob).

* [PATCH 2/3]:
  * Amend device_type with enum (Rob).
  * Fix nodename in example (Rob).

Link to v1:

https://lore.kernel.org/linux-devicetree/cover.1700555862.git.lukas@wunner.de/

Lukas Wunner (3):
  dt-bindings: tpm: Consolidate TCG TIS bindings
  dt-bindings: tpm: Convert IBM vTPM bindings to DT schema
  dt-bindings: tpm: Document Microsoft fTPM bindings

 .../bindings/security/tpm/google,cr50.txt     |  19 ---
 .../bindings/security/tpm/ibmvtpm.txt         |  41 -------
 .../bindings/security/tpm/st33zp24-i2c.txt    |  34 ------
 .../bindings/security/tpm/st33zp24-spi.txt    |  32 -----
 .../bindings/security/tpm/tpm-i2c.txt         |  26 ----
 .../bindings/security/tpm/tpm_tis_mmio.txt    |  25 ----
 .../bindings/security/tpm/tpm_tis_spi.txt     |  23 ----
 .../devicetree/bindings/tpm/ibm,vtpm.yaml     | 104 ++++++++++++++++
 .../bindings/tpm/microsoft,ftpm.yaml          |  48 ++++++++
 .../bindings/tpm/tcg,tpm-tis-i2c.yaml         | 113 ++++++++++++++++++
 .../bindings/tpm/tcg,tpm-tis-mmio.yaml        |  49 ++++++++
 .../bindings/tpm/tcg,tpm_tis-spi.yaml         |  79 ++++++++++++
 .../devicetree/bindings/tpm/tpm-common.yaml   |  72 +++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  16 ---
 14 files changed, 465 insertions(+), 216 deletions(-)
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


