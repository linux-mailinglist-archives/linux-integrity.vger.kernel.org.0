Return-Path: <linux-integrity+bounces-6136-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD6AAB981
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 08:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2A87AACB7
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D5D2C257C;
	Tue,  6 May 2025 04:05:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1164B35EBA6;
	Tue,  6 May 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746501537; cv=none; b=C4ZwTaUhydG55Nj3pLXxLk5h57dhgEZnP4euD8npPSmwFF/iLxhdaKZyXR8Rb6+n7Zw9NJvETpBCnPxJCCTJdX1qbonvB9/Gp6HlY1Wd7xUXGNmPbEeIwvHbDVHWpqJHdE+jYNjREkZEqrFi7GZRsgIbyp16l3KXhqsC4N96IfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746501537; c=relaxed/simple;
	bh=2A6JQf6nMBe59h6dBlVjCIOa4LyO+MYa8F434CoNhJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D92vtpxMKXLTk0RB1hOo0aVyUfWmowQsYMzjjQWIXuUyoVRUTFVL0hit2D4bOnvaSIaGrv4S/cK7ebzIAS2B+skO8CeL3IIIR67X/x02KenrIEf76GbwEKWwa/3LFcUR/EBwpMhQDZR7uKt3FwG7dsYSiCoOncCJo5oz+HRZryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.178])
	by gateway (Coremail) with SMTP id _____8CxvOKUfxloj0rWAA--.25898S3;
	Tue, 06 May 2025 11:18:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.178])
	by front1 (Coremail) with SMTP id qMiowMCx7MSPfxloqre1AA--.770S2;
	Tue, 06 May 2025 11:18:39 +0800 (CST)
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
Subject: [PATCH v9 0/5] Add Loongson Security Engine chip driver
Date: Tue,  6 May 2025 11:19:42 +0800
Message-ID: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx7MSPfxloqre1AA--.770S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr43XFy5WrW7try5tF43urX_yoW5GFWrpF
	45C3yfCr4UJr47Cr93J34UCFy3Z3s3Jr9Iga9rXw15ur9rAa4xXrWakFyUAF47AFn3Jry2
	vFWkCF4UCF1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
accelerator engines. Each engine have its own DMA buffer provided
by the controller. The kernel cannot directly send commands to the
engine and must first send them to the controller, which will
forward them to the corresponding engine. Based on these engines,
TPM2 have been implemented in the chip, then let's treat TPM2 itself
as an engine.

v9: Moved the base driver back to drivers/mfd. Cleanned up coding style.

v8: Like Lee said, the base driver goes beyond MFD scope. Since these
    are all encryption related drivers and SM2, SM3, and SM4 drivers
    will be added to the crypto subsystem in the future, the base driver
    need to be changed when adding these drivers. Therefore, it may be
    more appropriate to place the base driver within the crypto
    subsystem.

    Removed complete callback in all drivers. Removed the concepts of
    "channel", "msg" and "request" as they may be confusing. Used the
    concepts of "egnine" and "command" may be better.

v7: Addressed Huacai's comments.

v6: mfd :MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c

    crypto :CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG,
    ls6000se-rng.c ->loongson-rng.c

    tpm: TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c

v5: Registered "ls6000se-rng" device in mfd driver

Qunqin Zhao (5):
  mfd: Add support for Loongson Security Engine chip controller
  crypto: loongson - add Loongson RNG driver support
  MAINTAINERS: Add entry for Loongson crypto driver
  tpm: Add a driver for Loongson TPM device
  MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO DRIVER entry

 MAINTAINERS                            |   9 +
 drivers/char/tpm/Kconfig               |   9 +
 drivers/char/tpm/Makefile              |   1 +
 drivers/char/tpm/tpm_loongson.c        |  78 ++++++++
 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   5 +
 drivers/crypto/loongson/Makefile       |   1 +
 drivers/crypto/loongson/loongson-rng.c | 197 +++++++++++++++++++++
 drivers/mfd/Kconfig                    |  11 ++
 drivers/mfd/Makefile                   |   2 +
 drivers/mfd/loongson-se.c              | 235 +++++++++++++++++++++++++
 include/linux/mfd/loongson-se.h        |  52 ++++++
 13 files changed, 602 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_loongson.c
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-rng.c
 create mode 100644 drivers/mfd/loongson-se.c
 create mode 100644 include/linux/mfd/loongson-se.h


base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.45.2


