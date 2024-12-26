Return-Path: <linux-integrity+bounces-4476-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F19FCBCE
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 17:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4BE7A0FF6
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFA254728;
	Thu, 26 Dec 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/nVLrLx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97D23DE;
	Thu, 26 Dec 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735229894; cv=none; b=jakqQc/OlmPhdMg3RHPRYOIZWuoHIXIxJQ+KWUTtXoc+DpWIchwbQJNEqCBLLUNd/4loTPL23oQQwyosMN4yQLU6TmMiNbCMel0HiVvx9oz+Lrv63l35aLjhRIxnNyGXYE/G7wsiwNvQcISOU+DYvifJtopIjyua+zZf3/4IsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735229894; c=relaxed/simple;
	bh=xBzKVc0zsF+BC9a+wrkqk6S0Rzck6wgo/MgyWgmtGiM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TNXV4fQOGnicZ9bHSLEneCHtMcoJUMBIVR7f7ZiX3+g2ACqhiQ+wK+ppdbAIqBMrLtmvJB7hh45+bNvz+JEjEjbaO0J51x9dYdeqM3rYzF1arjCIO+3xTf8fwDa42cq2OsYfo0oUjU5UDQ2hFV6eP3mxa8R2FvqzYDYbr3ebxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/nVLrLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CBFC4CED1;
	Thu, 26 Dec 2024 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735229893;
	bh=xBzKVc0zsF+BC9a+wrkqk6S0Rzck6wgo/MgyWgmtGiM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=H/nVLrLxxMOUsyZs/6PLBOKtVNMNK6LBA1FLcPw//kHXtumtKvfnPSEOWweGZAZyk
	 ks6jTyQdgYYT5IpTrmMLf6fDwCYRR5hLbAzEn1uQctq790S8laXeu4FLL3umfLtIjK
	 dSqeb8MjpMCEyJijV7xcYYfLUpSqKeghK19NHOhYHYVfocdKpLKPAZCv6E1Huvxwab
	 Pd+Rzy8UUfAImNhJ8ozfEvho3vXE4yzLvHNEp5cEvoAZ42A3sojtXvQb2Bz6tXQbor
	 6dceYlF+T9eO9yfQVI27F0w5xKv41+V0cOvZBXQ3nvQu447LkiKTWRFZJCyhqFX2tB
	 3y6slYamlPUSg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Dec 2024 18:18:02 +0200
Message-Id: <D6LRNN9Q88F8.3EVLQ1JYK3UEW@kernel.org>
Cc: <stable@vger.kernel.org>, "Andy Liang" <andy.liang@hpe.com>, "Matthew
 Garrett" <mjg59@srcf.ucam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Seiji Munetoh" <munetoh@jp.ibm.com>, "Andrew
 Morton" <akpm@osdl.org>, "Reiner Sailer" <sailer@us.ibm.com>, "Kylene Jo
 Hall" <kjhall@us.ibm.com>, "Stefan Berger" <stefanb@us.ibm.com>
X-Mailer: aerc 0.18.2
References: <20241225193242.40066-1-jarkko@kernel.org>
In-Reply-To: <20241225193242.40066-1-jarkko@kernel.org>

On Wed Dec 25, 2024 at 9:32 PM EET, Jarkko Sakkinen wrote:
> The following failure was reported:
>
> [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id=
 0)
> [   10.848132][    T1] ------------[ cut here ]------------
> [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __=
alloc_pages_noprof+0x2ca/0x330
> [   10.862827][    T1] Modules linked in:
> [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted =
6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98=
293a7c9eba9013378d807364c088c9375
> [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant D=
L320 Gen12, BIOS 1.20 10/28/2024
> [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe=
 ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce=
 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
> [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0=
000000000000000
> [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0=
000000000040cc0
>
> Above shows that ACPI pointed a 16 MiB buffer for the log events because
> RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
> bug with kvmalloc() and devres_add().
>
> Cc: stable@vger.kernel.org # v2.6.16+
> Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> Reported-by: Andy Liang <andy.liang@hpe.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219495
> Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>

Oops, needs to be dropped from this.

> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v6:
> * A new patch.
> ---
>  drivers/char/tpm/eventlog/acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog=
/acpi.c
> index 69533d0bfb51..7cd44a46a0d7 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -136,10 +136,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	}
> =20
>  	/* malloc EventLog space */
> -	log->bios_event_log =3D devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> +	log->bios_event_log =3D kvmalloc(len, GFP_KERNEL);
>  	if (!log->bios_event_log)
>  		return -ENOMEM;
> =20
> +	devres_add(&chip->dev, log->bios_event_log);
> +

We either need to git revert 441b7152729f ("tpm: Use managed allocation
for bios event log") OR alternatively use devm_add_action() creating a
fix that wastes 16 MiB of memory and obfuscates flows more than needed.

I don't necessarily get how come this is "less intrusive"...

BR, Jarkko

