Return-Path: <linux-integrity+bounces-4895-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B410A3B27D
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 08:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C67D7A5C25
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869181BD017;
	Wed, 19 Feb 2025 07:34:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74217A307;
	Wed, 19 Feb 2025 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950467; cv=none; b=IJNm3dM94fm2JC6iKftjwkF9UgN5uYgBAorwK+30/GldUTIQELsTDvuFCs+4V/SeKb3dVKewYrCInl0i17X2YNWjh0AU8ZlsLwX/W9EAiUBCXDy05o1B3ErB00TWWZKXW/f0AcEPzBSNdHNB0Nln78Rukc0kFAh1kd5EN/g8U5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950467; c=relaxed/simple;
	bh=WgiOFIEinVea8mtpI1tDJE0Ypcap5EdHprwgezfaCoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EmtRUHuYOoC0hLRoIROfivVX5Hj59iWK8A2H2cmArpaR0OqU7du+DA89MCITk0GySDDXO9a7LdDUdU+t4+HC6sy43USSf0o4hQKNvsCt1Cb0JCAINU0EvQjoy0crwBq6DzZNGWs0OecMRRL1bMR2JBeBbxetLG3C+9gXCDAgZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8DxWOF6ibVn5Ll6AA--.15205S3;
	Wed, 19 Feb 2025 15:34:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMCx_cZyibVn17IbAA--.40645S2;
	Wed, 19 Feb 2025 15:34:16 +0800 (CST)
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
	Qunqin Zhao <zhaoqunqin@loongson.cn>
Subject: [PATCH V3 0/6] Drivers for Loongson security engine
Date: Wed, 19 Feb 2025 15:33:48 +0800
Message-Id: <20250219073350.16915-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_cZyibVn17IbAA--.40645S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar47Gw47tF4fKrWUXr15ZFc_yoW8WF4kpF
	45Aa4rCr4UJrZrGrn3J348uFyfXa4fXrW3KrW2qwn8Wr9IyFy8J3yakFyUAFsrJF1UJryI
	qFZ3Cr4UGF1UZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUA529EdanIXcx71UUUUU7KY7ZEXa
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

Loongson security engine supports random number generation, hash,
symmetric encryption and asymmetric encryption. Based on these
encryption functions, TPM2 have been implemented in it.

mfd is the baser driver, crypto and tpm are users.

v3: Put the updates to the MAINTAINERS in a separate patch.
v2: Removed misc driver. Added tpm driver.

Qunqin Zhao (6):
  mfd: Add support for Loongson Security Module
  MAINTAINERS: Add maintainer for Loongson Security Module driver
  crypto: loongson - add Loongson RNG driver support
  MAINTAINERS: Add maintainer for Loongson RNG driver
  tpm: Add a driver for Loongson TPM device
  MAINTAINERS: Add tpm_lsse.c to LOONGSON CRYPTO DRIVER entry

 MAINTAINERS                            |  14 +
 drivers/char/tpm/Kconfig               |   9 +
 drivers/char/tpm/Makefile              |   1 +
 drivers/char/tpm/tpm_lsse.c            | 104 +++++++
 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   6 +
 drivers/crypto/loongson/Makefile       |   2 +
 drivers/crypto/loongson/ls6000se-rng.c | 190 +++++++++++++
 drivers/mfd/Kconfig                    |   9 +
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


base-commit: 2816b0c949af89640b8dc05de53e650cbf1d55fb
-- 
2.43.0


