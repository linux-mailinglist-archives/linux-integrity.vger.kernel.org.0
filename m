Return-Path: <linux-integrity+bounces-764-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A4482CDD5
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 18:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE59B22598
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0921E4C83;
	Sat, 13 Jan 2024 17:10:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF194C6D;
	Sat, 13 Jan 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D196A300002A1;
	Sat, 13 Jan 2024 18:10:50 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C357F2BC2F7; Sat, 13 Jan 2024 18:10:50 +0100 (CET)
Message-Id: <cover.1705140898.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 13 Jan 2024 18:10:50 +0100
Subject: [PATCH v2 0/4] Add missing TPM compatible strings
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>

Dear Jarkko,

you've requested me to resend two patches which add "atmel,attpm20p"
as a compatible string to the dt-bindings and to the driver:

https://lore.kernel.org/all/CY65RSEA4VMD.MXHPX898TSW4@suppilovahvero/

The patches depend on a commit which landed in Linus' tree yesterday,
it consolidates the TPM dt-bindings:

https://git.kernel.org/linus/26c9d152ebf3

So after pulling from Linus, you should be able to apply the enclosed
patches cleanly.

I am also including two patches to add other missing compatible strings
to the driver.  I already submitted them in November and December but
they haven't been picked up yet:

https://lore.kernel.org/all/096e5d9d22eaed0a256d2d9b315a77245bd423c6.1701095446.git.lukas@wunner.de/
https://lore.kernel.org/all/5c92620082189dc4e6be277952d0b46df26a6478.1702811113.git.lukas@wunner.de/

Because all these patches merely add device IDs, I believe they can be
picked up and forwarded to Linus at any time, even outside the merge
window.  (According to Documentation/process/stable-kernel-rules.rst,
patches which "just add a device ID" are eligible for stable and
should thus be fair game for fixes pulls.)

Thank you!

Lukas Wunner (4):
  dt-bindings: tpm: Add compatible string atmel,attpm20p
  tpm_tis_spi: Add compatible string atmel,attpm20p
  tpm_tis: Add compatible string atmel,at97sc3204
  tpm: tis_i2c: Add compatible string nuvoton,npct75x

 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml | 1 +
 drivers/char/tpm/tpm_tis.c                                 | 1 +
 drivers/char/tpm/tpm_tis_i2c.c                             | 2 ++
 drivers/char/tpm/tpm_tis_spi_main.c                        | 1 +
 4 files changed, 5 insertions(+)

-- 
2.40.1


