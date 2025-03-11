Return-Path: <linux-integrity+bounces-5230-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0BA5C6BA
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 16:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07BC3AB3D5
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128C225EF89;
	Tue, 11 Mar 2025 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="bLKeJfqL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB0249F9;
	Tue, 11 Mar 2025 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706509; cv=none; b=cGT+wFlekQDI31cs5rAkyaZp5sznKKXbFdLklfi3l9ZP9Xq7KY8V8m0VFSZkWVDJdXo44brzpUDz5sauWrgZs4PI86qKD5TkPIcantcRqghWm5ZRmZmsyYFaTVr8n/pIsbC/Ry6Tb4HOuXzeF7VYfhoQSrKvorr1/1jEGtDnwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706509; c=relaxed/simple;
	bh=BRIerRhMDBgnyf720IdQcAp71wVmGDkhMc0a+8VEsT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQvFzBwxH999xdGo4FhOx+Eatdln6Y10b37PbCk9twEz93Y5aFkzdTim109ppL2J5CMZsbIwRa0Pzw79dnvwd3JKDEVkbS1nnSrFjL8OPndSD/Qjqi0pTY7FVN0J14v+y2gbfy6XY/QPbfvzodN4QI8fb5fUvOQsDiZfcGuqQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=bLKeJfqL; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Ool8GRiW/HZCPfD4470uVk0ukB9vkhzB98xjnc0KA8k=; t=1741706506;
	x=1742138506; b=bLKeJfqL95WWPAZ+gWrkBNis/avoF5mLHlEObMO+1fXtuL3W6QgMeKPojggz1
	qvjfpRl5rh4B2TOlxt6jY6MTASKa0i9HgouORwBRBPOaMElKk+Q07nfpAbdLHrUElpHMsrEcK1i/Z
	/0wmSjOsj0St/YXscaxgPR/zRym3XbNdCp/sTV136O7B0n+AFMnU9QG8yZGEVeiaqlM3KktH9Ddg2
	7RMFe6RFxkFof8sd2qiYiF/H29i7yE+c1Osq2TT/MRP2rWvJ6mx/T2Lf5oFHEN2/AJqeA49msGFQ5
	gmnvz8EPhyJjPUxXtHcVkUMXMYdyTdVLNGpqB10BVeZJ7xbWJA==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1ts1QI-0048RR-2z;
	Tue, 11 Mar 2025 16:21:39 +0100
Message-ID: <0ad035ff-400e-4b15-8b8f-40b69152ec46@leemhuis.info>
Date: Tue, 11 Mar 2025 16:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Build error on -next due to tpm_crb.c changes? (was: Re: [PATCH v6
 0/5] Add support for the TPM FF-A start method)
To: Stuart Yoder <stuart.yoder@arm.com>, jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 lenb@kernel.org, rafael@kernel.org, jgg@ziepe.ca, peterhuewe@gmx.de,
 sudeep.holla@arm.com, linux-integrity@vger.kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250305173611.74548-1-stuart.yoder@arm.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20250305173611.74548-1-stuart.yoder@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1741706507;6cfd430a;
X-HE-SMSGID: 1ts1QI-0048RR-2z

On 05.03.25 18:36, Stuart Yoder wrote:
> Firmware Framework for Arm A-profile (FF-A) is a messaging framework
> for Arm-based systems, and in the context of the TPM CRB driver is used
> to signal 'start' to a CRB-based TPM service which is hosted in an
> FF-A secure partition running in TrustZone.
> 
> These patches add support for the CRB FF-A start method defined
> in the TCG ACPI specification v1.4 and the FF-A ABI defined
> in the Arm TPM Service CRB over FF-A (DEN0138) specification:
> https://developer.arm.com/documentation/den0138/latest/
> [...]
> Stuart Yoder (5):
>   tpm_crb: implement driver compliant to CRB over FF-A
>   tpm_crb: clean-up and refactor check for idle support
>   ACPICA: add start method for Arm FF-A
>   tpm_crb: add support for the Arm FF-A start method
>   Documentation: tpm: add documentation for the CRB FF-A interface
> 
>  Documentation/security/tpm/tpm_ffa_crb.rst |  65 ++++
>  drivers/char/tpm/Kconfig                   |   9 +
>  drivers/char/tpm/Makefile                  |   1 +
>  drivers/char/tpm/tpm_crb.c                 | 105 +++++--
>  drivers/char/tpm/tpm_crb_ffa.c             | 348 +++++++++++++++++++++
>  drivers/char/tpm/tpm_crb_ffa.h             |  25 ++
>  include/acpi/actbl3.h                      |   1 +
> [...]

My daily linux-next builds for Fedora failed building on ARM64 today. I did
not bisect, but from the error message I suspect it's du to  patches in this
series touching drivers/char/tpm/tpm_crb.c :

ld: Unexpected GOT/PLT entries detected!
ld: Unexpected run-time procedure linkages detected!
ld: drivers/char/tpm/tpm_crb.o: in function `crb_cancel':
/builddir/foo//drivers/char/tpm/tpm_crb.c:496:(.text+0x2c0): undefined reference to `tpm_crb_ffa_start'
ld: drivers/char/tpm/tpm_crb.o: in function `__crb_request_locality':
/builddir/foo/drivers/char/tpm/tpm_crb.c:285:(.text+0x768): undefined reference to `tpm_crb_ffa_start'
ld: drivers/char/tpm/tpm_crb.o: in function `__crb_relinquish_locality':
/builddir/foo/drivers/char/tpm/tpm_crb.c:319:(.text+0x81c): undefined reference to `tpm_crb_ffa_start'
ld: drivers/char/tpm/tpm_crb.o: in function `__crb_request_locality':
/builddir/foo/drivers/char/tpm/tpm_crb.c:285:(.text+0x8bc): undefined reference to `tpm_crb_ffa_start'
ld: drivers/char/tpm/tpm_crb.o: in function `__crb_relinquish_locality':
/builddir/foo/drivers/char/tpm/tpm_crb.c:319:(.text+0x958): undefined reference to `tpm_crb_ffa_start'
ld: drivers/char/tpm/tpm_crb.o:/builddir/foo/drivers/char/tpm/tpm_crb.c:474: more undefined references to `tpm_crb_ffa_start' follow
ld: drivers/char/tpm/tpm_crb.o: in function `crb_acpi_add':
/builddir/foo/drivers/char/tpm/tpm_crb.c:830:(.text+0x1518): undefined reference to `tpm_crb_ffa_init'
make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
make[1]: *** [/builddir/foo/Makefile:1242: vmlinux] Error 2
make: *** [Makefile:259: __sub-make] Error 2

Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-41-aarch64/08750241-next-next-all/builder-live.log.gz

Same problem on Fedora 40, 42 and 43. 

Ciao, Thorsten

