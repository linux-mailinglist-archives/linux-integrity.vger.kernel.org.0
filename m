Return-Path: <linux-integrity+bounces-6313-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB9AC6272
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 08:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4340C4A2103
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 06:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312B24337D;
	Wed, 28 May 2025 06:59:44 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDEDE55B;
	Wed, 28 May 2025 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415584; cv=none; b=GywnpgbQx/TK46PIOFCvORIXAUWoIy4ZmzIWNr/hGHP98cJnQFHwhdaDEWOcO50pHH2PVaiY8j/F4H0g28+Vo0tTqeLk35y/V5+l+AoRg1Xb45esG0NWiIPpo3zaW9X2sq4aNaEVScevEwp4rPxvdVREYtfVtrpbd485FQUrm6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415584; c=relaxed/simple;
	bh=RuGpvcaQzP9nQ2WHgqYd3xi93wAwSSlvvq9QiQCOnrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ba+qzhXLnyoNtDluWxa58kxg8+ASwyLHpydM2a1+zG5XEoz3F7LCJUE+c58FpwdJbTMa7pqaBrx8Z+PDmHNFJvpES5NuhAEnqZrkyV83AoKBHqlLYsOGeJmSEFbCwFcF/A4OBq8W684wbg9FJNibGzV2t6Dd6Xo++Acqu/JCqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.178])
	by gateway (Coremail) with SMTP id _____8Bx63FStDZoFq7_AA--.18759S3;
	Wed, 28 May 2025 14:59:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.178])
	by front1 (Coremail) with SMTP id qMiowMAxzxtQtDZoEG33AA--.60923S2;
	Wed, 28 May 2025 14:59:28 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: lee@kernel.org,
	herbert@gondor.apana.org.au,
	jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Qunqin Zhao <zhaoqunqin@loongson.cn>
Subject: [PATCH v10 0/5] Add Loongson Security Engine chip driver
Date: Wed, 28 May 2025 14:59:39 +0800
Message-ID: <20250528065944.4511-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxzxtQtDZoEG33AA--.60923S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr43XFy5WrW7Zw1kGr47ZFc_yoW5Gw4xpF
	45C3yfCr4UJr47Cr93t34UCFyfZa4fJr9xKa9rXw15Wr9rAa48XrW3AFyUZF47ZFn3Jry2
	vFWkCF4UGF1UXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
accelerator engines. Each engine have its own DMA buffer provided
by the controller. The kernel cannot directly send commands to the
engine and must first send them to the controller, which will
forward them to the corresponding engine. Based on these engines,
TPM2 have been implemented in the chip, then let's treat TPM2 itself
as an engine.

v10: mfd: Cleanned up coding style.
     crypto: Unlimited tfm
     tpm: Added error check

v9: Moved the base driver back to drivers/mfd. Cleanned up coding style.

v8: Like Lee said, the base driver goes beyond MFD scope. Since these
    are all encryption related drivers and SM2, SM3, and SM4 drivers
    will be added to the crypto subsystem in the future, the base driver
    need to be changed when adding these drivers. Therefore, it may be
    more appropriate to place the base driver within the crypto
    subsystem.

    Removed complete callback in all driver. Removed the concepts of
    "channel", "msg" and "request" as they may be confusing. Used

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
 drivers/char/tpm/tpm_loongson.c        |  84 ++++++++
 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   5 +
 drivers/crypto/loongson/Makefile       |   1 +
 drivers/crypto/loongson/loongson-rng.c | 211 +++++++++++++++++++++
 drivers/mfd/Kconfig                    |  11 ++
 drivers/mfd/Makefile                   |   2 +
 drivers/mfd/loongson-se.c              | 253 +++++++++++++++++++++++++
 include/linux/mfd/loongson-se.h        |  53 ++++++
 13 files changed, 641 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_loongson.c
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-rng.c
 create mode 100644 drivers/mfd/loongson-se.c
 create mode 100644 include/linux/mfd/loongson-se.h


base-commit: c89756bcf406af313d191cfe3709e7c175c5b0cd
-- 
2.45.2


