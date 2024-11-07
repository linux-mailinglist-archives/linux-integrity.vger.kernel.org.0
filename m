Return-Path: <linux-integrity+bounces-4069-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA799C0FC5
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 21:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6175A284A78
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 20:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D31D63C2;
	Thu,  7 Nov 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrZ08EgK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB331CF7BB
	for <linux-integrity@vger.kernel.org>; Thu,  7 Nov 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011567; cv=none; b=V5pL4XYzftmeh0QyE+c6bodQLDFgZ9bZfr0tyyvSzHsoHBvulb0GklwvXDpUAFBXduKcng8xxC1RXnq/hVyti+wjxRGsrxTQQiuA38lG7ecTtCf0b9IkE9DbVvnqPQivCuIq70CghJX4dduCZuI3ruRJsA6nD5Kbu5ynXz990Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011567; c=relaxed/simple;
	bh=Lbiye/0uaNlQjjE/6cr4kDWiXX1MKOg652V9XQN1HIQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=QcQrBeq6N4kColn7kxSKnF4eqZbCThJriQCPJXU/6QkjY9W2hXrN2dOADcgA4wpRyPC43jg2or6qGnmeXcMIb+rQ+uWOz6sGHZgjJ11Y/GxjN94Gg03IRqEJazjRLmVTzIsIokAhH7usNw6/Bln06s8Vs139mstUHmXt/1SV2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrZ08EgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8415FC4CECE;
	Thu,  7 Nov 2024 20:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011567;
	bh=Lbiye/0uaNlQjjE/6cr4kDWiXX1MKOg652V9XQN1HIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrZ08EgKd8dCqeptZeIrHlU6thDtZZKJ/lq0EWyJ4dkv8cpTgz8bnQR+RRfV2fmgR
	 C0AnyiB8ax9pJOQPQBEUfCrvFkfqO5EuSxsSu2GIEs9r7gJBrnrj9xeFycxdMade+D
	 zJP8LvFXe+reNEQ+3gnAv9x32HkrItmpCT3TpU2I4Mw756WS8EnZUqKTgjsGwc9eoX
	 fh31uG3TSWHfbxx4v6Sxvb97Vrqcw2lfwQx0jm1ImV+gJQMod5N9a+bhqTAiE7QIHD
	 mU4lO9jxFkgV4hkUcKFx5lCM3U4ZeHJ/q76hHn/OMKkaJqS25qCYKo9AoSf8+OgM1p
	 LcIL1FKIbqSfA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 22:32:42 +0200
Message-Id: <D5G8DXQ15SFC.SDV9NC2LH1CF@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>, "Andy Liang" <andy.liang@hpe.com>,
 <jenifer.golmitz@hpe.com>
Subject: Re: [PATCH] tpm/eventlog: Use kvmalloc() for event log buffer
X-Mailer: aerc 0.18.2
References: <20241107112054.28448-1-tiwai@suse.de>
In-Reply-To: <20241107112054.28448-1-tiwai@suse.de>

On Thu Nov 7, 2024 at 1:18 PM EET, Takashi Iwai wrote:
> The TPM2 ACPI table may request a large size for the event log, and it
> may be over the max size of kmalloc().  When this happens, the driver
> spews the kernel WARNING at the probe time, but the error is
> eventually ignored in the caller side, and it results in the missing
> TPM event log exposure.


TPM2 ACPI table is data structure ;-) Just to make the commit message
less confusing, please refer to active actors.


>
> This patch replaces the devm_kmalloc() call with kvmalloc() to allow
> larger sizes.  Since there is no devm variant for kvmalloc(), now it's
> managed manually via devres_alloc() and devres_add().
>
> Reported-and-tested-by: Andy Liang <andy.liang@hpe.com>
> Cc: jenifer.golmitz@hpe.com
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1232421

"You are not authorized to access bug #1232421. To see this bug, you must
first log in to an account with the appropriate permissions."

Please remove  this link as it gives no information without login
access, *or* make it available w/o acocunt, *or* repost a bug to the
kernel bugzilla.

I've been cursing SUSE accounts for over a year now. Never been able
to successfully get either to the bugzilla or forums (still I get
some weekly spam about the forums). And no, no interest to recall
or figure out this problem.

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/char/tpm/eventlog/acpi.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog=
/acpi.c
> index 69533d0bfb51..56f7d73fa6bf 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -63,6 +63,13 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 =
len)
>  	return n =3D=3D 0;
>  }
> =20
> +static void bios_event_log_release(struct device *dev, void *res)
> +{
> +	void **logp =3D res;
> +
> +	kvfree(*logp);
> +}
> +
>  /* read binary bios log */
>  int tpm_read_log_acpi(struct tpm_chip *chip)
>  {
> @@ -71,6 +78,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	void __iomem *virt;
>  	u64 len, start;
>  	struct tpm_bios_log *log;
> +	void **logp;
>  	struct acpi_table_tpm2 *tbl;
>  	struct acpi_tpm2_phy *tpm2_phy;
>  	int format;
> @@ -136,9 +144,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	}
> =20
>  	/* malloc EventLog space */
> -	log->bios_event_log =3D devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> -	if (!log->bios_event_log)
> +	logp =3D devres_alloc(bios_event_log_release, sizeof(*logp), GFP_KERNEL=
);
> +	if (!logp)
>  		return -ENOMEM;

How big is it?

> +	devres_add(&chip->dev, logp);
> +	log->bios_event_log =3D kvmalloc(len, GFP_KERNEL);
> +	if (!log->bios_event_log) {
> +		ret =3D -ENOMEM;
> +		goto err;
> +	}
> +	*logp =3D log->bios_event_log;
> =20
>  	log->bios_event_log_end =3D log->bios_event_log + len;
> =20
> @@ -164,7 +179,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  	return format;
> =20
>  err:
> -	devm_kfree(&chip->dev, log->bios_event_log);
> +	devres_release(&chip->dev, bios_event_log_release, NULL, NULL);
>  	log->bios_event_log =3D NULL;
>  	return ret;
>  }

BR, Jarkko

