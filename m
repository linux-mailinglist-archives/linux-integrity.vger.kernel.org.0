Return-Path: <linux-integrity+bounces-5936-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1BCA9355F
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CDD166863
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597826FDBD;
	Fri, 18 Apr 2025 09:33:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28382270EA2;
	Fri, 18 Apr 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968805; cv=none; b=d/n6puKPyy+AukmFbrSyZ/3RqtpkNB/4y5TVvQqEOF+12pR5UtQEi8OTkHlhnHrAMJ0rw4vJRJAnB1u28wuveR6iwfAfpFJuFNWe1L33XplnydsI+MY0tnL1DwRfEXbqFzGcLFncmS/3NZOJjs3HZ2cUkFfX0WQPhNwxfo7iFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968805; c=relaxed/simple;
	bh=xlGgPVpqt2TPjugDY3fL3HsKO/7Xllow9Gh8xKfsZjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFRMt85sbffcJVlXKFEFUMH+KsnmVmqapy7x3Yk3HN/HoAP4Ya8S01LxU1cZIPhNMDXXUJR2DbD1H2X+SO14gudUFS3AZYKWysugIbp05+jiPcJsNZ7K/1jzx5UvG636cNBHm75DqcemZ/udcWwpoGgAnO6aI8wQXFX8chBuouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8CxLGthHAJom6LBAA--.58470S3;
	Fri, 18 Apr 2025 17:33:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMCxPsdeHAJogkKJAA--.14975S2;
	Fri, 18 Apr 2025 17:33:18 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: herbert@gondor.apana.org.au,
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
Subject: [PATCH v8 0/5] Add Loongson Security Engine chip driver
Date: Fri, 18 Apr 2025 17:35:05 +0800
Message-ID: <20250418093506.1349-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxPsdeHAJogkKJAA--.14975S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr43XFy5WrW7trW7KFWxuFX_yoW5XryDpF
	45C3yfCr4UJr47Gr93try8GFyfZas3Xr9IganrXw15Wr9xAa48XrW3CFyUCF47AF95Xry2
	vFZYkF4UGF1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUjU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b1UUUUUUUU=

The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
accelerator engines. Each engine have its own DMA buffer provided
by the controller. The kernel cannot directly send commands to the
engine and must first send them to the controller, which will
forward them to the corresponding engine. Based on these engines,
TPM2 have been implemented in the chip, then let's treat TPM2 itself
as an engine.

v8: Like Lee said, the base driver goes beyond MFD scope. Since these
    are all encryption related drivers and SM2, SM3, and SM4 drivers
    will be added to the crypto subsystem in the future, the base driver
    need to be changed when adding these drivers. Therefore, it may be
    more appropriate to place the base driver within the crypto subsystem.

    Removed complete callback in all drivers. Removed the concepts of
    "channel", "msg" and "request" as they may be confusing. Used the
    concepts of "egnine" and "command" may be better.

v7: Addressed Huacai's comments.

v6: mfd :MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c

    crypto :CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG,
    ls6000se-rng.c ->loongson-rng.c

    tpm: TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c

v5: Registered "ls6000se-rng" device in mfd driver.
v4: Please look at changelog in tpm and MAINTAINERS. No changes to mfd
    and crypto.
v3: Put the updates to the MAINTAINERS in a separate patch.

Qunqin Zhao (5):
  crypto: loongson - Add Loongson Security Engine chip controller driver
  crypto: loongson - add Loongson RNG driver support
  MAINTAINERS: Add entry for Loongson crypto driver
  tpm: Add a driver for Loongson TPM device
  MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO DRIVER entry

 MAINTAINERS                            |   7 +
 drivers/char/tpm/Kconfig               |   9 +
 drivers/char/tpm/Makefile              |   1 +
 drivers/char/tpm/tpm_loongson.c        |  78 ++++++++
 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |  17 ++
 drivers/crypto/loongson/Makefile       |   3 +
 drivers/crypto/loongson/loongson-rng.c | 198 ++++++++++++++++++++
 drivers/crypto/loongson/loongson-se.c  | 239 +++++++++++++++++++++++++
 drivers/crypto/loongson/loongson-se.h  |  52 ++++++
 11 files changed, 606 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_loongson.c
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-rng.c
 create mode 100644 drivers/crypto/loongson/loongson-se.c
 create mode 100644 drivers/crypto/loongson/loongson-se.h


base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
-- 
2.45.2


