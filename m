Return-Path: <linux-integrity+bounces-2934-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E291725D
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 22:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D771F22172
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Jun 2024 20:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF817C9E3;
	Tue, 25 Jun 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AsDHTZXq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDC178394
	for <linux-integrity@vger.kernel.org>; Tue, 25 Jun 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346687; cv=none; b=qlwtceCJcaKc5iOtyqEbWnlIyRK18XajLNjwYEe7BY6DW4RKFjuPjwfTR8kQZTgzK1RN1Y9yphX9oFu0B6gaSWefng6yMTwhrGIanQgbdX9dv2fLDe906K0LGK+HnpJpwdZEaAXFPKIwo8qCCeieHbvioauz9IQDkC74Dt/Pgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346687; c=relaxed/simple;
	bh=pwX4UncxMoMSG0sJ1bBbIZqUSSePO8SM9zXSg/h0BHI=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=qD6dajKvrqYBva9PS2Mn6CMhi/y9AwyzPLq7N8e2kbgF7a71nXqCQqwvt94NLCMJ6DIMTHSsBcem/A9JoXLvT0moNrAhHCOsmwT4qHt24QjNsNvTJI8Wdvr8XCCyve0vczrKSP7yPpaNUXPyaxKaMnDtho8QaaXm3qdCWY+N9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AsDHTZXq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PJSxVQ012529;
	Tue, 25 Jun 2024 20:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:in-reply-to:references:content-type
	:date:content-transfer-encoding:mime-version; s=pp1; bh=BQGwREko
	P8WmEtUhDPb5gWkUGIkt4Ob70nZ9RvYUS04=; b=AsDHTZXqV84VyCqBwjk5LqHQ
	PhffyE/UOW6/3BlMbINAkUHX0LTZSnOySZQmRSYgWdBK6DN9/+tNa4Bym0QRGtvO
	xiuDaSRDoE0DU45YK+JYSOthpdOlA3P/FrSoD4olzLaSFp04RKObjw7ifaNpIPkH
	GGsSXJ5ieOKc6ebjqewLlHMUH9WUfLzqc/LjgYQT2ZN/gTjbW5jDNvrvmY+9wa23
	etwAkE1tJTHlqexnCSIJpH2/GWVyK47jg7EpwkEuYWTvvCnnZF8U9MCb39FvKkMV
	uxmoxeYhc/P0s/wKoLn3qLq3JBZodK2Ej9FUyBzeZI0Via161pXGR7sH5H5q4A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400433r4ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 20:18:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45PJgYlp000397;
	Tue, 25 Jun 2024 20:18:01 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn382ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 20:18:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45PKHwi0459272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 20:18:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BE155803F;
	Tue, 25 Jun 2024 20:17:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D32AC58068;
	Tue, 25 Jun 2024 20:17:57 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 20:17:57 +0000 (GMT)
Message-ID: <e127ce2ea09b6db53403662122f01044bc324fa5.camel@linux.ibm.com>
Subject: Re: IMA vs TPM (i2c) builtin driver boot order
From: Mimi Zohar <zohar@linux.ibm.com>
To: Romain Naour <romain.naour@smile.fr>, linux-integrity@vger.kernel.org
In-Reply-To: <9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr>
References: <9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 25 Jun 2024 16:17:50 -0400
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: glKxupzW_gGax_rvuiMW7iUUYKkBNjYW
X-Proofpoint-ORIG-GUID: glKxupzW_gGax_rvuiMW7iUUYKkBNjYW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250143

Hi Romain,

On Tue, 2024-06-25 at 10:22 +0200, Romain Naour wrote:
> Hello,
> 
> I'm using the kernel 6.1.80-ti-arm64-r50 provided by Debian Bullseye image for
> the beaglebone-ai-64 [1] (the same happen with a Yocto/Buildroot based image
> with the latest 6.9.x vanilla kernel)
> 
>   $ uname -a
>   Linux BeagleBone 6.1.80-ti-arm64-r50 #1 bullseye SMP PREEMPT_DYNAMIC Fri May
> 24 19:44:30 UTC 2024 aarch64 GNU/Linux
> 
> But I noticed that the i2c bus is probed after the IMA/EVM infra.
> What if a TPM is connected by i2c bus ?
> 
> [ 1.306865] ima: No TPM chip found, activating TPM-bypass!
> ...
> [ 1.370601] ti-sci 44083000.system-controller: ABI: 3.1 (firmware rev 0x0015
> '21.5.0--v2021.05 (Terrific Llam')
> [ 1.428399] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
> [ 1.434666] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
> [ 1.440738] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
> [ 1.446798] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
> [ 1.452907] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
> [ 1.458983] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
> [ 1.465082] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
> [ 1.471146] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz
> 
> I'm not sure this issue is really specific to the board, there were a similar
> issue on rpi board:
> 
>   https://github.com/Cybersecurity-LINKS/tpm-ima-patch
> 
> After digging into this problem, I did two changes to ima/evm driver to replace
> late_initcall() by late_initcall_sync()
> (Tested on a vanilla 6.6.33 kernel)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index ff9a939dad8e..339f6e8d7e56 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -960,4 +960,4 @@ static int __init init_evm(void)
>         return error;
>  }
> 
> -late_initcall(init_evm);
> +late_initcall_sync(init_evm);  /* Start EVM after the IMA */
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index cc1217ac2c6f..1e9417ffdf08 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1120,4 +1120,4 @@ static int __init init_ima(void)
>         return error;
>  }
> 
> -late_initcall(init_ima);       /* Start IMA after the TPM is available */
> +late_initcall_sync(init_ima);  /* Start IMA after the TPM is available */
> 
> Now, the IMA/EVM stack are initialized *after* the TPM device.
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
> 
> [    3.062788] ima: Allocated hash algorithm: sha256
> 
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
> Thoughts?
> 
> Initially reported on TI forum and Beaglebord Discord [2]
> 
> [1]: https://www.beagleboard.org/boards/beaglebone-ai-64
> [2]:
> https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order

As long as IMA (and EVM) are initialized before accessing files from real root
or loading kernel modules, I don't have a problem with moving it to
late_initcall_sync().

Please post the IMA and EVM patches here on the linux-integrity mailing list.

thanks,

Mimi


