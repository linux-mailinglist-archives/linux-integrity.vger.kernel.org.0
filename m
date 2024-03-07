Return-Path: <linux-integrity+bounces-1666-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460E875A1C
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 23:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C761F21072
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 22:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4613B795;
	Thu,  7 Mar 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktTQ+DkF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE6813BAD4
	for <linux-integrity@vger.kernel.org>; Thu,  7 Mar 2024 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849849; cv=none; b=FOixh6NScwN3Hz2D+JS+jdTlrPqK6Dile35PDb4JtH4k4OdTMVn4MbxY1wfScxOQtXyH2PvzQ0kaTtub5yshuR/DKFavPuC+bC2On8uMkYsv1ysQX4OCSTP6aObVI5XQ38d7rt2DVBS/wVi/2fY7rCz60eWyLjibnbBJoiyozwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849849; c=relaxed/simple;
	bh=el81ln6XAgZeNQn9GhoaHQJOgSEAVnD65JLP5Ix8n3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfXXdMsdzre0lDXuaNzFuGrTZbqOZ/w4iRr4++0MroVaduwuVSSLyIhtU7gZMaYDkF06FV0O5cJ9XovZfVrXhe4wACxzGR4Gw11OdcNAa3+WGGvLDPqYp1h4uxFsuM8b4amkVAJzvIZ5R1xtJEK3rFjjeNTtMeCxWrmoUrGFWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktTQ+DkF; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso1408617276.0
        for <linux-integrity@vger.kernel.org>; Thu, 07 Mar 2024 14:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709849847; x=1710454647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i4nWr8S2Ps6+IO4mf7w2td+iD4KuHaR0PERGp8huRI=;
        b=ktTQ+DkFizNbIMjqjVmx0Z8A5CaP6dyujlxl4tfLI22pgzL89TUDNpIBrHHuPkXp+z
         nIlGANWk/xC2YRL3ztWAlOMcqUtCpb/TdWyilrGHr45zRnhkPOaboik3oUkTb1AxbWg/
         Q7Xq2YX8j1WacIeLOrxkaBiMeJgphThLojS13jamPePy7cdFUcnPUCXRQB0u2IQNdEPO
         E1hF0jdrz8WdXBBDEkfn7kUTBjyEukDJapRCXMwHr07eIRuXe1GGr8JlZTFAyP4xaDG+
         rXkFC8LKOs8MKuPSENcR6QmtXfAmet4U8KhWqC0DgyqybcVzI68RJRARMq5S3ItZBDqL
         V+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709849847; x=1710454647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i4nWr8S2Ps6+IO4mf7w2td+iD4KuHaR0PERGp8huRI=;
        b=kJX1va09Tu3t3GU7xh27+FoWdpAxsa38wCVob6K+1aedviBGSILFzBGgU7gB+j+xps
         p5k0bjGWiMe/Rx4kExgRaHW4pIFf1koAGt3tJ9vVmyOrZPxZJgZM1aBOIPc8DA4hiQdY
         tVHv8h8gc9YQ+GZnzj07Oim6upjtSun4Dl2wNB5yqaVd2bPKiTs6lxPGW3ZursuqBdaz
         y26ITDjrJrW6aoDHDvXIdIX5sMTvHcsP6ckKlpCx0Pu42Twwnn/Y4dLbAQ86Uz7Da7ZX
         jUG0kCkxSoxioDPU8BVNwk7lvFvsevlN2gsgiAVXNgbKSBnSj2CqPQ0lx1UDALXuKgny
         /Vbg==
X-Forwarded-Encrypted: i=1; AJvYcCU1v51IhMFGjcLBEzlr1hzrtVub5cC/NkFzXkubHXdFF8ZmFf+2CQmk0a/teipIaOlcLK9OV/GT3Dbl1VHXsvlw9EDUA6+KXxix6j4UbiMB
X-Gm-Message-State: AOJu0Yw9YlaY38lkfnhbEN+dAR399Bhn+U1FFl9uPDz+MGRVqrwYk15U
	HuyEGXKsoRF7Xp66IYNY5O2nHL30we4teu7ifDUzoL9kzfsP+ap6nTx+PnVv1WnlXbMcKyNyTXJ
	rQGNgG4ouMgTsR1NcAfmKm/p15x0VGD7t9xY=
X-Google-Smtp-Source: AGHT+IHm/+3S9ZlmbDFr0tAwN+EpsNi9UjcGqW9YhzQvpjcb8vM9S84oY3Df+/zJt90kVcAWfPCpfhtbjJwZz3HYJbE=
X-Received: by 2002:a25:8746:0:b0:dcd:59e4:620c with SMTP id
 e6-20020a258746000000b00dcd59e4620cmr17920676ybn.49.1709849846932; Thu, 07
 Mar 2024 14:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307000331.14848-1-adamoa@gmail.com> <20240307000331.14848-2-adamoa@gmail.com>
 <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
In-Reply-To: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
From: Adam Alves <adamoa@gmail.com>
Date: Thu, 7 Mar 2024 19:17:15 -0300
Message-ID: <CAHwaaX_Am9zM4PUES11RT5QRs+4QNuRyOw7gBqvcHiDLokRKKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix TPM chip hanging system before suspend/shutdown
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the instructions!

First I used gmail and even setting it to text only it destroyed
formatting. Later I set up git to send the e-mail directly.

I read everything you asked again and implemented all suggestions,
sending it right away.

Em qui., 7 de mar. de 2024 =C3=A0s 16:54, Jarkko Sakkinen
<jarkko@kernel.org> escreveu:
>
> On Thu Mar 7, 2024 at 2:03 AM EET, Adam Alves wrote:
> > My PC would hang on almost every shutdown/suspend until I started
> > testing this patch and so far in the past week I haven=E2=80=99t experi=
enced
> > any problems anymore.
> >
> > I suspect that the root cause on my specific board is that after the
> > ACPI command to put the device to S3 or S5, some firmware
> > application/driver will try to use the TPM chip expecting it to be in
> > Locality 0 as expected by TCG PC Client Platform Firmware Profile
> > Version 1.06 Revision 52 (3.1.1 =E2=80=93 Pre-OS Environment) and then =
when it
> > fails to do so it simply halts the whole system.
> >
> > This issue might be related to the following bug:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217890
> >
> > Enable a user to configure the kernel
> > through =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D boot parameter so=
 that the locality
> > is set before suspend/shutdown in order to diagnose whether or not the
> > board is one of the buggy ones that require this workaround. Since this
> > bug is related to the board/platform instead of the specific TPM chip,
> > call dmi_check_system on the tpm_init function so that this setting is
> > automatically enabled for boards specified in code (ASUS TUF GAMING
> > B460M-PLUS already included) =E2=80=93 automatic configuration only wor=
ks in
> > case CONFIG_DMI is set though, since dmi_check_system is a non-op when
> > CONFIG_DMI is not set.
> >
> > In case =E2=80=9Ctpm.locality_on_suspend=3D0=E2=80=9D (the default) don=
't change any
> > behavior thus preserving current functionality of any other board
> > except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly future
> > boards as we successfully diagnose other boards with the same issue
> > fixed by using =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D.
> >
> > Signed-off-by: Adam Alves <adamoa@gmail.com>
> > ---
> >  drivers/char/tpm/tpm-chip.c      |  9 ++++++++
> >  drivers/char/tpm/tpm-interface.c | 36 +++++++++++++++++++++++++++++++-
> >  drivers/char/tpm/tpm.h           |  1 +
> >  include/linux/tpm.h              |  1 +
> >  4 files changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 42b1062e33cd..8fdf7a137a94 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -139,6 +139,9 @@ void tpm_chip_stop(struct tpm_chip *chip)
> >  {
> >       tpm_go_idle(chip);
> >       tpm_relinquish_locality(chip);
> > +     // If locality is to be preserved, we need to make sure it is Loc=
ality 0.
>
> If you put that kind C++ comment you should also check out
> https://www.kernel.org/doc/html/latest/process/coding-style.html
>
> Other stuff that I said in my earlier response still applies.
>
> BR, Jarkko



--=20
Adam Oliveira Alves

