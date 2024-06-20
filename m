Return-Path: <linux-integrity+bounces-2881-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE0F90FA74
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 02:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A261C21069
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 00:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD7BAD2C;
	Thu, 20 Jun 2024 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5mUZD0e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF030AD21
	for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844800; cv=none; b=oyRUgbZk+caviiEsrQtEfBvxCvf5wnWTCN5oul6cWRbiiQ2qwWojdq7HNyCd7ea2N8PmKwesxsm/nV5vZvjrIJQ0B4dAmGld7TTQETA/RX00XA0ahRliwiJKb+1T6kH1Bf4YmRyjIzopCGfWU1f0YBEzc3An5PttpouyEBTz21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844800; c=relaxed/simple;
	bh=C742umFNrhms5NpoIWnYMqouzXDtmBEuA+kiy3iqnt8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=FxbAhrk1lY/EouSdx1YduXth64aAIGtA6oSOE37OHn8NFEylQZWFquSvXWZCGZsnkymvJ2cx/2q15XADaCui589zkfQDDjWtzOElRn1vn6j5c1mWYHknzN+0YoQkGUM74hTu6tEv3uTK//fN0joysRtXA4GsGNgEcXLtowvKvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5mUZD0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81611C2BBFC;
	Thu, 20 Jun 2024 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718844799;
	bh=C742umFNrhms5NpoIWnYMqouzXDtmBEuA+kiy3iqnt8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Z5mUZD0efQoOjSUrX9zkQ0QSlSb6t8rvmHZWW9sHo/CvS6Dm5PrJ4Xak43NAz40Ub
	 F8hcVkJgrSo5yGJ9YUKKz8CZ1LOEwOJ9ASSZEIpDi9P7SALjOwcxiScx5M0aM8Fu4r
	 sRkCR4Wg9fg4tqfOhKXPDRsyE8zgGbV65TNF5ZvHfGFpQ1RtxwIc9d8DNQ3MiLiPOB
	 8nUCCtDpmEzscTmI31phI7C4XgGYsy0lMOrqU+nEKcb40NSsFne2jxFL1WidfWv6Rb
	 Q7SRv1Baq0QCojSCuN3QQpwMBZir8YD6+m/0SN4yqFwLgoWV/XDNPLHIps3t3HljK1
	 GxlRmTOBVTlWg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Jun 2024 03:53:16 +0300
Message-Id: <D24FMMS9HM8A.1EKLA59QSET6H@kernel.org>
Subject: Re: [PATCH] char: tpm: Fix possible memory leak in
 tpm_bios_measurements_open()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Joe Hattori" <joe@pf.is.s.u-tokyo.ac.jp>, <peterhuewe@gmx.de>
Cc: <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240609092937.2874379-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20240609092937.2874379-1-joe@pf.is.s.u-tokyo.ac.jp>

On Sun Jun 9, 2024 at 12:29 PM EEST, Joe Hattori wrote:
> In tpm_bios_measurements_open(), get_device() is called on the device
> embedded in struct tpm_chip. In the error path, however, put_device() is
> not called. This could result in a reference count leak, which could

When it does not then?


> prevent the device from being properly released. This commit makes sure
> to call put_device() when the tpm_bios_measurements_open() fails.

s/could//g
Either *is* or *is not*.


>
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/char/tpm/eventlog/common.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventl=
og/common.c
> index 639c3f395a5a..df213ec428ca 100644
> --- a/drivers/char/tpm/eventlog/common.c
> +++ b/drivers/char/tpm/eventlog/common.c
> @@ -44,11 +44,13 @@ static int tpm_bios_measurements_open(struct inode *i=
node,
> =20
>  	/* now register seq file */
>  	err =3D seq_open(file, seqops);
> -	if (!err) {
> -		seq =3D file->private_data;
> -		seq->private =3D chip;
> +	if (err) {
> +		put_device(&chip->dev);
> +		return err;
>  	}
> =20
> +	seq =3D file->private_data;
> +	seq->private =3D chip;

So this does two things:

1. It restructures code.
2. Possibly fixes a leak (with quick skimo does).

So it breaks "Separate your changes" section of [1].

Instead:

if (!err) {
	seq =3D file->private_data;
	seq->private =3D chip;
} else {
	put_device(&chip->dev);
}

I.e. least likelyhood of merge conflicts, when backporting.

Also, add a fixes tag (also [1]).

[1] https://docs.kernel.org/process/submitting-patches.html

BR, Jarkko

