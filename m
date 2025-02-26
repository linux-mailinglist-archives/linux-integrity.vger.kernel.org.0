Return-Path: <linux-integrity+bounces-4990-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF1CA4539F
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 04:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049053AD6FB
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2025 03:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7621CA0F;
	Wed, 26 Feb 2025 03:04:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7483718801A;
	Wed, 26 Feb 2025 03:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539072; cv=none; b=YKa1qYB4wYDDZdW2IfdcTdTWEb2Jovz3A4LgKll2JoN3ahkf7Vsr7214zVXNrRnPD/ykSKjCY5VcFszoinIXnYaR3ZskvoveaTXqfxCBfLC/K4KfVyph/RdCRRDjnaxR1LAklEtc2uXoKuiTJAT/aVpMIz9O8hOaSRkZ0Yc6pVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539072; c=relaxed/simple;
	bh=WVzS0lrko+iwd9TRGf+P9gh1kuQeNV5z7+Qwtc6kmec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TwmUuCA5VZdRmopF/Ar5my+k+zfGknmAHUYREYz/QYlnCi9WIXuwt2eqZAPjkAeKW+4wl7ytbg9HwpTviatQmJFfvHpNN0ckECKYFXrGYzNAAR9i+jVjZvM+lhkEngdK27ozFb81cL8Ok+A1+YGpj2qhtF4VxPz/wYVMAfTnDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8AxmnG3hL5ntOqCAA--.27824S3;
	Wed, 26 Feb 2025 11:04:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMCxPseyhL5nLxIpAA--.23547S2;
	Wed, 26 Feb 2025 11:04:19 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: lee@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-crypto@vger.kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Qunqin Zhao <zhaoqunqin@loongson.cn>
Subject: [PATCH v4 0/6] Drivers for Loongson security engine
Date: Wed, 26 Feb 2025 11:03:52 +0800
Message-Id: <20250226030358.15924-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxPseyhL5nLxIpAA--.23547S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1xKry3Aw4DGw4UGry5Jrc_yoW8Ar4DpF
	45AayFkr4UJrZrGrn3Jry8uFyfXa4fXrW3KFW2qwn8W3sxAa48J3yakFy7Aa9rJF17JryI
	qF93Cr4UGF1UZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Loongson security engine supports random number generation, hash,
symmetric encryption and asymmetric encryption. Based on these
encryption functions, TPM2 have been implemented in it.

mfd is the baser driver, crypto and tpm are users.

v4: Please look at changelog in tpm and MAINTAINERS. No changes to tpm
    and crypto. 
v3: Put the updates to the MAINTAINERS in a separate patch.
v2: Removed misc driver. Added tpm driver.

Qunqin Zhao (6):
  mfd: Add support for Loongson Security Module
  MAINTAINERS: Add entry for Loongson Security Module driver
  crypto: loongson - add Loongson RNG driver support
  MAINTAINERS: Add entry for Loongson RNG driver
  tpm: Add a driver for Loongson TPM device
  MAINTAINERS: Add tpm_lsse.c to LOONGSON CRYPTO DRIVER entry

 MAINTAINERS                            |  14 +
 drivers/char/tpm/Kconfig               |   9 +
 drivers/char/tpm/Makefile              |   1 +
 drivers/char/tpm/tpm_lsse.c            | 103 +++++++
 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   6 +
 drivers/crypto/loongson/Makefile       |   2 +
 drivers/crypto/loongson/ls6000se-rng.c | 190 +++++++++++++
 drivers/mfd/Kconfig                    |  10 +
 drivers/mfd/Makefile                   |   2 +
 drivers/mfd/ls6000se.c                 | 374 +++++++++++++++++++++++++
 include/linux/mfd/ls6000se.h           |  75 +++++
 13 files changed, 788 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_lsse.c
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/ls6000se-rng.c
 create mode 100644 drivers/mfd/ls6000se.c
 create mode 100644 include/linux/mfd/ls6000se.h


base-commit: bd315242821784e9384abae911a70d5fda9a3298
-- 
2.43.0


