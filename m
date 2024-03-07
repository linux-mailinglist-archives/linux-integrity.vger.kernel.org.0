Return-Path: <linux-integrity+bounces-1652-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC58757A9
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 20:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03505B2495D
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA025136995;
	Thu,  7 Mar 2024 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD0fD3+U"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4E1350D6
	for <linux-integrity@vger.kernel.org>; Thu,  7 Mar 2024 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841281; cv=none; b=Xt5iylOYvy9mNDXrM3rX6TDZhzYapI9uGpUjxpu+0/bcqaS5/fkf5Vuknvq3E3blqGUBsEzu259kdS5W2I4cWiAoiH2cvNUk4SKGnm9sTZaBTBHnsWlFHRL++QMXQ3dsSp8SI40nKWPvDJhRLXdbXD9dZQW56NTmgcmjstNHmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841281; c=relaxed/simple;
	bh=PcYSwwZYKidNMSyMs/Wf1rDiiXJ4spsT21LelZwLxos=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FojN2IpG2g56+8FFEPinFmK9K7X/REcGZnxvsl4wXm7s0f54+yHwk1XX4l16ZZT1uv5BoSIOqpr3PqoU2v810cMLUvl56UeR3X3LbDkGQyBfrtI8Plk4xad2OvLmypU6rPYGJr8vgEFzDgmfQN5gTv2H29xN9ND2s2dhThwiuEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD0fD3+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889F7C433C7;
	Thu,  7 Mar 2024 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841280;
	bh=PcYSwwZYKidNMSyMs/Wf1rDiiXJ4spsT21LelZwLxos=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DD0fD3+UUifv1S6Gilhx1HvWMLO0amXPhusGvZyZHsIZYMDi3yLVvs/mKkS1hA6HN
	 34n00JBIDAY0WF8GERSqcvvusyMtTlDI61cBNhdZXygF/7U65fB3Enw23vJIl5lma3
	 cOEREaOs9HQSqwlzMwDWDLAqNUPkAyqz9FLne5AONBtTHb2aGPC9QAXwrmxInzUIIn
	 AjKi8I3AIV6lLQ70jMsZEggkykrBNl8YBlaQSiHEBumM2USWEhLgxrcfn3iRZg9Fzr
	 UQj85KXD+ZKAoNwposueRnh/5ZxgLlaFcykYv9PPtT+eNusw1VXWgUPZTxVq+0nDQY
	 PbWv2g70nK/Mg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 21:54:37 +0200
Message-Id: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 1/1] Fix TPM chip hanging system before suspend/shutdown
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Adam Alves" <adamoa@gmail.com>, "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <20240307000331.14848-1-adamoa@gmail.com>
 <20240307000331.14848-2-adamoa@gmail.com>
In-Reply-To: <20240307000331.14848-2-adamoa@gmail.com>

On Thu Mar 7, 2024 at 2:03 AM EET, Adam Alves wrote:
> My PC would hang on almost every shutdown/suspend until I started
> testing this patch and so far in the past week I haven=E2=80=99t experien=
ced
> any problems anymore.
>
> I suspect that the root cause on my specific board is that after the
> ACPI command to put the device to S3 or S5, some firmware
> application/driver will try to use the TPM chip expecting it to be in
> Locality 0 as expected by TCG PC Client Platform Firmware Profile
> Version 1.06 Revision 52 (3.1.1 =E2=80=93 Pre-OS Environment) and then wh=
en it
> fails to do so it simply halts the whole system.
>
> This issue might be related to the following bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217890
>
> Enable a user to configure the kernel
> through =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D boot parameter so t=
hat the locality
> is set before suspend/shutdown in order to diagnose whether or not the
> board is one of the buggy ones that require this workaround. Since this
> bug is related to the board/platform instead of the specific TPM chip,
> call dmi_check_system on the tpm_init function so that this setting is
> automatically enabled for boards specified in code (ASUS TUF GAMING
> B460M-PLUS already included) =E2=80=93 automatic configuration only works=
 in
> case CONFIG_DMI is set though, since dmi_check_system is a non-op when
> CONFIG_DMI is not set.
>
> In case =E2=80=9Ctpm.locality_on_suspend=3D0=E2=80=9D (the default) don't=
 change any
> behavior thus preserving current functionality of any other board
> except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly future
> boards as we successfully diagnose other boards with the same issue
> fixed by using =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D.
>
> Signed-off-by: Adam Alves <adamoa@gmail.com>
> ---
>  drivers/char/tpm/tpm-chip.c      |  9 ++++++++
>  drivers/char/tpm/tpm-interface.c | 36 +++++++++++++++++++++++++++++++-
>  drivers/char/tpm/tpm.h           |  1 +
>  include/linux/tpm.h              |  1 +
>  4 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 42b1062e33cd..8fdf7a137a94 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -139,6 +139,9 @@ void tpm_chip_stop(struct tpm_chip *chip)
>  {
>  	tpm_go_idle(chip);
>  	tpm_relinquish_locality(chip);
> +	// If locality is to be preserved, we need to make sure it is Locality =
0.

If you put that kind C++ comment you should also check out
https://www.kernel.org/doc/html/latest/process/coding-style.html

Other stuff that I said in my earlier response still applies.

BR, Jarkko

