Return-Path: <linux-integrity+bounces-2943-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 040DA91E193
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 15:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA341F24EED
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ADE15FCF1;
	Mon,  1 Jul 2024 13:54:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48716B74B;
	Mon,  1 Jul 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842073; cv=none; b=MlRsNBebqjMssPIB9iN9Pth13f0bvcN9F5VVI+R+llYAI0L63h46Shw8TrQMVpyH920dCekcTDu6/R7sNWuOg6qXN+NdJjCfeiih2/+m/5ocvIkD1xKWFweIT1AAoH3PF2LxrsESGsWUOk9PePeiRwwayZQ9CwLBVh8MtrHnqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842073; c=relaxed/simple;
	bh=oQD3wYGpeTJpeIOtGsN3baGvWrgJshKVwvhIQEoAVGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfrQ802KIjydQ65nEiRzPqb1rv5ZJzX3oOrf4HHI7ZYxUlD06uVHG7FFbJG5lifVpSH/Re4VvSv1+rfSpPfqCvAyMktWHKjkrpo4MyCG3/V8QOCSM/8MIUOaVvHcurN0ph2bKA+cMddGkyF3TDMWEFtXVxe7zIulj4X+QVk9KJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BFF3461E5FE01;
	Mon,  1 Jul 2024 15:53:45 +0200 (CEST)
Message-ID: <c090cd3c-f4c6-4923-a9fa-b54768ca2a26@molgen.mpg.de>
Date: Mon, 1 Jul 2024 15:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] integrity: wait for completion of i2c initialization using
 late_initcall_sync()
To: Romain Naour <romain.naour@smile.fr>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
 eric.snowberg@oracle.com, dmitry.kasatkin@gmail.com,
 roberto.sassu@huawei.com, zohar@linux.ibm.com,
 Romain Naour <romain.naour@skf.com>
References: <20240701133814.641662-1-romain.naour@smile.fr>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240701133814.641662-1-romain.naour@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Romain,


Thank you for your patch.

Am 01.07.24 um 15:38 schrieb Romain Naour:
> From: Romain Naour <romain.naour@skf.com>
> 
> It has been reported that on some plateforms the ima and evm

platforms

> initialization were performed too early during initcall initialization
> process and misses TPM chip detection [1] [2].
> 
> Indeed, ima may uses a TPM chip but requires to wait for bus
> interface (spi or i2c) and TPM driver initialization.
> 
> [    0.166261] ima: No TPM chip found, activating TPM-bypass!
> ...
> [    0.166322] evm: Initialising EVM extended attributes:
> ...
> [    0.182571] ti-sci 44083000.system-controller: ABI: 3.1 (firmware rev 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
> [    0.281540] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
> [    0.282314] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
> [    0.282972] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
> [    0.335177] tpm_tis_i2c 2-002e: 2.0 TPM (device-id 0x1C, rev-id 22)
> [    0.471596] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
> [    0.472310] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
> [    0.472951] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
> [    0.473596] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
> [    0.474274] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz
> 
> The ima stack was expecting to start after the TPM device (hence the
> comment) using late_initcall() but fail to do so on such plateforms:

platforms

> 
>    late_initcall(init_ima);	/* Start IMA after the TPM is available */
> 
> Using late_initcall_sync() variant allows to really wait for i2c
> initialization completion.
> 
> [    0.285986] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
> [    0.286706] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
> [    0.287382] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
> [    0.331503] tpm_tis_i2c 2-002e: 2.0 TPM (device-id 0x1C, rev-id 22)
> [    0.677185] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
> [    0.677904] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
> [    0.678557] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
> [    0.679167] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
> [    0.679792] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz
> ...
> [    3.062788] ima: Allocated hash algorithm: sha256
> ...
> [    3.318975] ima: No architecture policies found
> [    3.323536] evm: Initialising EVM extended attributes:
> [    3.328662] evm: security.selinux (disabled)
> [    3.332919] evm: security.SMACK64 (disabled)
> [    3.337177] evm: security.SMACK64EXEC (disabled)
> [    3.341781] evm: security.SMACK64TRANSMUTE (disabled)
> [    3.346819] evm: security.SMACK64MMAP (disabled)
> [    3.351422] evm: security.apparmor (disabled)
> [    3.355764] evm: security.ima
> [    3.358721] evm: security.capability
> [    3.362285] evm: HMAC attrs: 0x1
> 
> [1] https://lore.kernel.org/linux-integrity/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr/
> [2] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order
> 
> Signed-off-by: Romain Naour <romain.naour@skf.com>

Should this get a Fixes: tag and be also applied to the stable series?

> ---
>   security/integrity/evm/evm_main.c | 2 +-
>   security/integrity/ima/ima_main.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 62fe66dd53ce..316f8d140825 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1180,4 +1180,4 @@ DEFINE_LSM(evm) = {
>   	.blobs = &evm_blob_sizes,
>   };
>   
> -late_initcall(init_evm);
> +late_initcall_sync(init_evm);	/* Start EVM after IMA */
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f04f43af651c..0aa7cd9aabfa 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1220,4 +1220,4 @@ DEFINE_LSM(ima) = {
>   	.blobs = &ima_blob_sizes,
>   };
>   
> -late_initcall(init_ima);	/* Start IMA after the TPM is available */
> +late_initcall_sync(init_ima);	/* Start IMA after the TPM is available */

Looks good to me.


Kind regards,

Paul

