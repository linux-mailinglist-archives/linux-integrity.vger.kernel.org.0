Return-Path: <linux-integrity+bounces-6473-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDE0ADFB76
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 04:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9B47AD105
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 02:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6A221F00;
	Thu, 19 Jun 2025 02:52:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B940224B13;
	Thu, 19 Jun 2025 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301542; cv=none; b=AWmmbusGpMmYmLpJBTdS29UMZAzCKXNYTsfdJJq8my9bXw0WclJ+Khw4uweoEuUNQnlpFTT/9NdNQJoCk3dVAgM9yr64YmR7pmxPgMr9z0yTnD1Q8UyM1w5E92p06GeDSXcRg714zfFCnm2nRs5DEr0WHP1k8OuB6TgrZ9LMWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301542; c=relaxed/simple;
	bh=G0h+9piz8srcxOhaU5NXSgTuFSOxfqLH7RY2q+y74RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFzJ5MTWZNklGhaUgvfviljBF5OMLpWtsH6+d14slctvAU4nD+GeLjST5w8Lz6R0kgv+ru1d4A1bOMiU6D68+4LUwsyx8Xkji/SnZDKLt0qTyrVLdlhSZ+5GrcwST+wGXRctoPtO3dwwt9sfxYAAaCI0aKx+bwu6tiviSWWB0Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8DxQK9ae1NohY0ZAQ--.23696S3;
	Thu, 19 Jun 2025 10:52:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMAxj8VPe1NoOXYgAQ--.34847S2;
	Thu, 19 Jun 2025 10:51:59 +0800 (CST)
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
Subject: [PATCH v11 0/4] dd Loongson Security Engine chip driver
Date: Thu, 19 Jun 2025 10:51:34 +0800
Message-ID: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxj8VPe1NoOXYgAQ--.34847S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr43XFy5WrW7Zw17try3ZFc_yoW5Zr17pF
	45C3yakr4UJFsrCr93J348CFyfZ3s3Jr9xKa9rXw15ur9xAa48XrW2kFyUAa17AFyrJry2
	vFWkCF4UCF1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

v11: Put all updates to the MAINTAINERS in one patch
     crypto: statically initialize rng_devices.lock, use this lock in
             loongson_rng_probe().

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
    "channel", "msg" and "request" as they may be confusing. Used the
    concepts of "egnine" and "command" may be better.

v7: Addressed Huacai's comments.

v6: mfd :MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c

    crypto :CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG,
    ls6000se-rng.c ->loongson-rng.c

    tpm: TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c

v5: mfd: Registered "ls6000se-rng" device in mfd driver
    tpm: Prefix all with tpm_loongson instead of tpm_lsse.
         Replace all "ls6000se" with "loongson"

v4: tpm: Removed MODULE_AUTHOR fields.
         Prefix all with tpm_lsse instead of tpm.

v3: Put the updates to the MAINTAINERS in a separate patch.
    tpm: Added reminder about Loongson security engine to git log.

v2: Removed misc driver. Added tpm driver.

Qunqin Zhao (4):
  mfd: Add support for Loongson Security Engine chip controller
  crypto: loongson - add Loongson RNG driver support
  tpm: Add a driver for Loongson TPM device
  MAINTAINERS: Add entry for Loongson Security Engine drivers

 MAINTAINERS                            |   9 +
 drivers/char/tpm/Kconfig               |   9 +
 drivers/char/tpm/Makefile              |   1 +
 drivers/char/tpm/tpm_loongson.c        |  84 ++++++++
 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   5 +
 drivers/crypto/loongson/Makefile       |   1 +
 drivers/crypto/loongson/loongson-rng.c | 209 ++++++++++++++++++++
 drivers/mfd/Kconfig                    |  11 ++
 drivers/mfd/Makefile                   |   2 +
 drivers/mfd/loongson-se.c              | 253 +++++++++++++++++++++++++
 include/linux/mfd/loongson-se.h        |  53 ++++++
 13 files changed, 639 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_loongson.c
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-rng.c
 create mode 100644 drivers/mfd/loongson-se.c
 create mode 100644 include/linux/mfd/loongson-se.h


base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
-- 
2.45.2


