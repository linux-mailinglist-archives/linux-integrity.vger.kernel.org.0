Return-Path: <linux-integrity+bounces-2942-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6366E91E0F5
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35C1B23216
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE11615EFA6;
	Mon,  1 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="02MZcKf0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314814B96C
	for <linux-integrity@vger.kernel.org>; Mon,  1 Jul 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841106; cv=none; b=YDBIbCKXYMXmk5Sx2WJa9H4cz/VF7pIHVx8aYWBKAfUz7iFd1jaPMcfzdetfF58JRjh1zxDh18z1phhWSqg8vWvFbdCcsP7wSHZIuD+wW+gp8IuZuM4ED3ttDmsrb44/Mu+eRQl6c0dHKnQoXOWChMCODQvuuWdzPkaDtqqFQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841106; c=relaxed/simple;
	bh=IN2Pz7feRSB89N45CnxvbpbzXQIdjfaQZf+/3twSXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lq8bjANYzs3VmVpeNtt4yQ7pSC+eD4G8iv8smygAlXuTFnEC0ph3/NaJQLF+pfiM7L7VvSNUbkPTNBiO/g/AeE0p4eff8vBjVxbj93uIi590tu9wEMV4VyPuRM0VXyMy+jW+59pF44QN4TvIW46AKuhAFhC0UO4hrDqa+ZMYwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=02MZcKf0; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so35310361fa.3
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jul 2024 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1719841099; x=1720445899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5sD7PnRdPX0lFwpY8jX67XXDkztmCAH2fY727c2mDM=;
        b=02MZcKf0LQ3T+MiaBjc8YXR816vctgKAJ33jaB//yAU1DhUC7tyiDI3wqx4DWj4IEr
         IVtZHZT+Rq2o7jcRFQUGNszDxmp8y7wlMTbDjU/9p1VUHuAu3LmxHwmH3Y8TuiJhRuxP
         Do9fXpdRsdSQldYyr9hDPK46CPnxVtrlKBOn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841099; x=1720445899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5sD7PnRdPX0lFwpY8jX67XXDkztmCAH2fY727c2mDM=;
        b=WrTQbWwX+VNf95p1yhYW2gMI6HQdfDedG66y+UUCP0RwiZruWnqMNPi7L6nb0HdqC3
         eFN0njNynJuDsG437Km0E16nLAk+M1WszB4c0IU3fDJT6lqtOtnAxrBo9hNoGMpq/mIJ
         iDugAiGUClJ1OEQZ+DAz9eMvOJw3MQ7FQRPmF42XBOey3HonTi/CVON31Uydj5x92YOV
         9uU8WRCay0myndSxmpU9PCT5p6l247yvFyRSCbeo9DcIuLHYKinE8jtE8z7E12BU8g0j
         NaY2x6bi8rBPnQQliIFMJsUbqLupJ94r2of1maueZoEVCFJZUyIQw0jazdTKtXiiMNWM
         Ni6g==
X-Gm-Message-State: AOJu0YzmkTbQpazZd6EK6gzMhNOFHBfA4hqMvJU9mMrKDQ0C52Hjpb7s
	s/cdTyrX/MXIfEwjeI0GK2TNhljpUZU5HGmMRt1wZo4B/N5xF8DETQJinIBsXy5ECxo7+ZXRRGJ
	r
X-Google-Smtp-Source: AGHT+IHmRxD0Ok8fKaC0DosRpV2IDl7uw7clyTO+K42aYv3Bil+q7gUIwRukGNNBTLKKJQSiA1uKog==
X-Received: by 2002:a05:651c:4d2:b0:2ee:5301:945d with SMTP id 38308e7fff4ca-2ee5e37e0e8mr43871931fa.11.1719841098600;
        Mon, 01 Jul 2024 06:38:18 -0700 (PDT)
Received: from P-NTS-Evian.home (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5ba67sm153562855e9.19.2024.07.01.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:38:18 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	serge@hallyn.com,
	jmorris@namei.org,
	paul@paul-moore.com,
	eric.snowberg@oracle.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com,
	zohar@linux.ibm.com,
	Romain Naour <romain.naour@skf.com>
Subject: [RFC] integrity: wait for completion of i2c initialization using late_initcall_sync()
Date: Mon,  1 Jul 2024 15:38:14 +0200
Message-ID: <20240701133814.641662-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Romain Naour <romain.naour@skf.com>

It has been reported that on some plateforms the ima and evm
initialization were performed too early during initcall initialization
process and misses TPM chip detection [1] [2].

Indeed, ima may uses a TPM chip but requires to wait for bus
interface (spi or i2c) and TPM driver initialization.

[    0.166261] ima: No TPM chip found, activating TPM-bypass!
...
[    0.166322] evm: Initialising EVM extended attributes:
...
[    0.182571] ti-sci 44083000.system-controller: ABI: 3.1 (firmware rev 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
[    0.281540] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
[    0.282314] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
[    0.282972] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
[    0.335177] tpm_tis_i2c 2-002e: 2.0 TPM (device-id 0x1C, rev-id 22)
[    0.471596] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
[    0.472310] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
[    0.472951] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
[    0.473596] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
[    0.474274] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz

The ima stack was expecting to start after the TPM device (hence the
comment) using late_initcall() but fail to do so on such plateforms:

  late_initcall(init_ima);	/* Start IMA after the TPM is available */

Using late_initcall_sync() variant allows to really wait for i2c
initialization completion.

[    0.285986] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
[    0.286706] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
[    0.287382] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
[    0.331503] tpm_tis_i2c 2-002e: 2.0 TPM (device-id 0x1C, rev-id 22)
[    0.677185] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
[    0.677904] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
[    0.678557] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
[    0.679167] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
[    0.679792] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz
...
[    3.062788] ima: Allocated hash algorithm: sha256
...
[    3.318975] ima: No architecture policies found
[    3.323536] evm: Initialising EVM extended attributes:
[    3.328662] evm: security.selinux (disabled)
[    3.332919] evm: security.SMACK64 (disabled)
[    3.337177] evm: security.SMACK64EXEC (disabled)
[    3.341781] evm: security.SMACK64TRANSMUTE (disabled)
[    3.346819] evm: security.SMACK64MMAP (disabled)
[    3.351422] evm: security.apparmor (disabled)
[    3.355764] evm: security.ima
[    3.358721] evm: security.capability
[    3.362285] evm: HMAC attrs: 0x1

[1] https://lore.kernel.org/linux-integrity/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr/
[2] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order

Signed-off-by: Romain Naour <romain.naour@skf.com>
---
 security/integrity/evm/evm_main.c | 2 +-
 security/integrity/ima/ima_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 62fe66dd53ce..316f8d140825 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1180,4 +1180,4 @@ DEFINE_LSM(evm) = {
 	.blobs = &evm_blob_sizes,
 };
 
-late_initcall(init_evm);
+late_initcall_sync(init_evm);	/* Start EVM after IMA */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..0aa7cd9aabfa 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1220,4 +1220,4 @@ DEFINE_LSM(ima) = {
 	.blobs = &ima_blob_sizes,
 };
 
-late_initcall(init_ima);	/* Start IMA after the TPM is available */
+late_initcall_sync(init_ima);	/* Start IMA after the TPM is available */
-- 
2.45.0


