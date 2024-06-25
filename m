Return-Path: <linux-integrity+bounces-2933-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7AF9160FF
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 10:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703A31C21B17
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7222313;
	Tue, 25 Jun 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="SasoUlfb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132F146019
	for <linux-integrity@vger.kernel.org>; Tue, 25 Jun 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303776; cv=none; b=NvDKjyu++1okL/zs352Xg2fqfgOVDhRvZxp/zLDEquo6KuyYtENdhd8nGgSxJQx7+fFd7/4UxdSDRhcngtiui00t5yq1fPvJka3Y3eRCoz3ioo2UTNCkgdZUKnIX/xkfcsNjYLlmEug0Df+KtIyKYKET/spuz7ZQhZgbk34ecwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303776; c=relaxed/simple;
	bh=Q+YrmjZs4oe5ZJTdmj0R6VSIHXNV9pQpPi8ho+qXu/0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=deCIyUVh1F4SwFnkPJ5Snxz3yUvilqbXZb4OYjg/ylbBgAAXgsN3ERIQYAtUGsl4H9pp5xqFi2r/UYtkQEfN/6yTMfEGjrpT1moEyrxtM+7uxmu/PaKoutdJhWyvmH8DCWGG3BPTttUr4TgCWQUfnGX6IUyiqxa/aQ5EZQpdVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=SasoUlfb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d26a4ee65so4939894a12.2
        for <linux-integrity@vger.kernel.org>; Tue, 25 Jun 2024 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1719303771; x=1719908571; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e18YwSjKxByUnUZuRkz9TebjIb8MUoAG7CQdcKCGLFo=;
        b=SasoUlfb4UceCFT9Yl2eQcD0I8AVReyz+z6UPmyH7njUG6KT6DOS0K/2yjhy6Jw9Wp
         GBrq4wHE5UP6Nd9DU/pVjqjo55n0JDrPxpdgWNSTdCuG5Nu5NIaU3nxcTNoSXfiWELhS
         8Vx/ED5rWsRrgeIuigN1Erw/RikAvjp5rZa6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303771; x=1719908571;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e18YwSjKxByUnUZuRkz9TebjIb8MUoAG7CQdcKCGLFo=;
        b=UAd0GNbzLZWplmlBLXEiNWWLD0a+hNxqRxA5LMsWtnPUZmt3db+JMFkOwRDet6dz3M
         QygltKVqgII8zxzroqZcBj0Rkh7ayjUFBUryk12hf8o6P46Cxuhl8pgVl7kzSYPzKaN4
         1mTnByLn1PL4x7k83/f+F/e4k3ZvO+BEJuT2oZeT46hkgMHknagyZlUJeP0LvZ57jPFk
         o++5s0CPSISyE7QekBdSS6yxuhjbokiThZheSpPvnMl227LOQLtRr6CsjWvyeYbp80T0
         NjQzh5kdqhv7dk3mO9/6ah5eVHQyIFJ+OofwYpw6QnFrrFzs/L93DBFIC5FUWgpQU2DZ
         WezQ==
X-Gm-Message-State: AOJu0Ywdl7355iJYOPs1NJJsN4BBWifmmRk2DpLa1AzhZMXOs9T7aSoQ
	Ng73pAl3VBoQDPBArO9IYyoFbudXiDp46tY2zT/7XaEzcN9lqoXFS7zF0szu6y1dLMpShRwXHyg
	r
X-Google-Smtp-Source: AGHT+IH/0zk+8uTR5PtCAM9jdPXVXsiMZreteKxvbXyGs/QdPmLYYjvDsgim4HTFvw5EmCqVPUuw4A==
X-Received: by 2002:a50:a693:0:b0:57c:68fd:2bc9 with SMTP id 4fb4d7f45d1cf-57d49c976d1mr4981241a12.3.1719303770984;
        Tue, 25 Jun 2024 01:22:50 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:949d:5800:e3ef:2d7a:4131:71f? (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b88easm12215389f8f.39.2024.06.25.01.22.50
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 01:22:50 -0700 (PDT)
Message-ID: <9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr>
Date: Tue, 25 Jun 2024 10:22:50 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr, en-US
To: linux-integrity@vger.kernel.org
From: Romain Naour <romain.naour@smile.fr>
Subject: IMA vs TPM (i2c) builtin driver boot order
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I'm using the kernel 6.1.80-ti-arm64-r50 provided by Debian Bullseye image for
the beaglebone-ai-64 [1] (the same happen with a Yocto/Buildroot based image
with the latest 6.9.x vanilla kernel)

  $ uname -a
  Linux BeagleBone 6.1.80-ti-arm64-r50 #1 bullseye SMP PREEMPT_DYNAMIC Fri May
24 19:44:30 UTC 2024 aarch64 GNU/Linux

But I noticed that the i2c bus is probed after the IMA/EVM infra.
What if a TPM is connected by i2c bus ?

[ 1.306865] ima: No TPM chip found, activating TPM-bypass!
...
[ 1.370601] ti-sci 44083000.system-controller: ABI: 3.1 (firmware rev 0x0015
'21.5.0--v2021.05 (Terrific Llam')
[ 1.428399] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
[ 1.434666] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
[ 1.440738] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
[ 1.446798] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
[ 1.452907] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
[ 1.458983] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
[ 1.465082] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
[ 1.471146] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz

I'm not sure this issue is really specific to the board, there were a similar
issue on rpi board:

  https://github.com/Cybersecurity-LINKS/tpm-ima-patch

After digging into this problem, I did two changes to ima/evm driver to replace
late_initcall() by late_initcall_sync()
(Tested on a vanilla 6.6.33 kernel)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ff9a939dad8e..339f6e8d7e56 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -960,4 +960,4 @@ static int __init init_evm(void)
        return error;
 }

-late_initcall(init_evm);
+late_initcall_sync(init_evm);  /* Start EVM after the IMA */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cc1217ac2c6f..1e9417ffdf08 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1120,4 +1120,4 @@ static int __init init_ima(void)
        return error;
 }

-late_initcall(init_ima);       /* Start IMA after the TPM is available */
+late_initcall_sync(init_ima);  /* Start IMA after the TPM is available */

Now, the IMA/EVM stack are initialized *after* the TPM device.

[    0.285986] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
[    0.286706] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
[    0.287382] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
[    0.331503] tpm_tis_i2c 2-002e: 2.0 TPM (device-id 0x1C, rev-id 22)
[    0.677185] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
[    0.677904] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
[    0.678557] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
[    0.679167] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
[    0.679792] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz

[    3.062788] ima: Allocated hash algorithm: sha256

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

Thoughts?

Initially reported on TI forum and Beaglebord Discord [2]

[1]: https://www.beagleboard.org/boards/beaglebone-ai-64
[2]:
https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order

Best regards,
Romain

