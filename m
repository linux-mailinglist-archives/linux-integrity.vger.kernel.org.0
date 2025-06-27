Return-Path: <linux-integrity+bounces-6564-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B40E8AEB43F
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jun 2025 12:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527FA7B80ED
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jun 2025 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2212989B7;
	Fri, 27 Jun 2025 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnhnTgEo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B32951D2;
	Fri, 27 Jun 2025 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019359; cv=none; b=Iuz2j7N7txsGR8pjLPR0vThMruJgotvbLAuh7+hHX2Cfv2q2YEMKsJ1gLrYVXNbRvPTzdaOrrviInuQQInR0C0sfNDDBt/HWqgeron0aZSuwwCc8MsGaQMPcUkLOejv9pxHELgDav9ViWakcGHhyF96KfIJlYVQGTUW5RiVjYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019359; c=relaxed/simple;
	bh=3s6q/x000fxdjTd8nipUwFWpBcy6fLFPtzHW1ADaES8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhAily4XV08BLCRzWQ12AbSc+i3nGNj/piPCnJIQr6ptqXWRYEP8Czt7Ylc/t8wIrfInBKz5Y5Bz+xxUbqtb9U3dWW5bA3Vl6+zRGHN6Wr/Ko1i5pt7bKE5CoIl2qjbvqES1lJUepKdStgjjheW4reIXruXcfbDKkJM3XF6EDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnhnTgEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEE9C4CEEB;
	Fri, 27 Jun 2025 10:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751019359;
	bh=3s6q/x000fxdjTd8nipUwFWpBcy6fLFPtzHW1ADaES8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tnhnTgEoCUVtmDaHRWJU/1Hn/S2PMjvOoZDeIQ6We3xo1I3Qrbj9qsK/+5GbQNx65
	 H0aZDYLAvG3HmDDaHLeyPpwzl+/rTchbLjTGfuG6oLTVnYKydKVEX8XUcLDUJXc51Z
	 lGZCr12WwxZwvqk1yUCDRx2GI0GGLq46v5mMztLbfpDFIOQXj7ax9UfD9Uz6IfdXqK
	 aPnfUJ1npAwsypLnjLZBobK7BkIAwBacWsSeyFHyDGnlnBxqPSf8G0vYLqBg9kN+kr
	 7pCwayqp0Ikrfdkm3PTl3dvD9ZYP9rljQzzpy95zWMFZPIZx9SRWbtTYXibFMx5OPC
	 GEyqnE0r78hKQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so2363445a12.3;
        Fri, 27 Jun 2025 03:15:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhxYS8XZ80mZnCEDRgycyxjAbDYlR9yuP15s26h4jaADlK6zXO/JlXtJmhyhaZnjX/dgzvIV/Ww4QbNZIy@vger.kernel.org, AJvYcCWFwYfZWT/HLL7fWshBCRmDM8KxfseRGStVA2zaM1s7pTSSrBvEKewWTr+RKhbmekErZvT1ROahuH1lvwI=@vger.kernel.org, AJvYcCXsPy33xS7l2M1K+9bmxn/TaY+CYJxcCLysMl3tE2K8Gggs0zoJmPTRpFJ5P8b2TU8eo86ZqjMpN3MBKFmEWmb2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WvqCx62M/DkpdQiju5t5lqUc5hDcXxxNXdxFKVE4B22gLjDE
	5GGI3VDGU9o98whN+/D2Pl5Xac3dGOv3gdhhLwmFPyU4Z4LqGQgweH3G4XC2kChfG8uj3Gt9L5s
	9V0s28ZbnrAITI3VHIw7eu9yfDR4BvUI=
X-Google-Smtp-Source: AGHT+IEC0RlMZ0dBSk+i/oRcQH/9JIC09lTKPfqTuntyMRorx+R8qqxJK7/9jgwr4DviueaaQI2nTlixyx18/q/CnoY=
X-Received: by 2002:aa7:d98f:0:b0:60c:42ce:27e2 with SMTP id
 4fb4d7f45d1cf-60c88ec2ademr1766441a12.30.1751019357555; Fri, 27 Jun 2025
 03:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn> <20250619025138.2854-4-zhaoqunqin@loongson.cn>
 <aFs2RDOeOKvWUN2L@kernel.org> <20250625080527.GN795775@google.com>
 <aFvhorr3kZSuzVpv@kernel.org> <20250625134047.GX795775@google.com>
 <aFwsIs6ri3HZictC@kernel.org> <20250626103030.GA10134@google.com>
 <aF0oHDVQKVfGZNV2@kernel.org> <CAAhV-H7nyKHS70BGh7nwjuGwSWayCbUY=1-zWMU4N3bJZtH1gQ@mail.gmail.com>
 <aF2Rn0R4AlopEwz8@kernel.org> <86b5e396-54d4-7b36-8848-06f41083ba59@loongson.cn>
In-Reply-To: <86b5e396-54d4-7b36-8848-06f41083ba59@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 27 Jun 2025 18:15:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5JkzOOq-1pJFXmGLLtXmrDEErfTfvcQUe-9bzCJ9znWA@mail.gmail.com>
X-Gm-Features: Ac12FXzDlC7jJ5hahCiQAD4Tlirbeiu71uFZpCn5cbdTSSpq6MQ0DvfKW-Bp0ag
Message-ID: <CAAhV-H5JkzOOq-1pJFXmGLLtXmrDEErfTfvcQUe-9bzCJ9znWA@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] tpm: Add a driver for Loongson TPM device
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Lee Jones <lee@kernel.org>, herbert@gondor.apana.org.au, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, Yinggang Gu <guyinggang@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 2:47=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
>
> =E5=9C=A8 2025/6/27 =E4=B8=8A=E5=8D=882:29, Jarkko Sakkinen =E5=86=99=E9=
=81=93:
> > On Thu, Jun 26, 2025 at 08:48:35PM +0800, Huacai Chen wrote:
> >> But there is another coherency, you can see this in the 1st patch:
> >>
> >> +static const struct mfd_cell engines[] =3D {
> >> + { .name =3D "loongson-rng" },
> >> + { .name =3D "loongson-tpm" },
> >> +};
> > I thought already after ffa driver from ARM that I need to fix up
> > the naming a bit before it explodes. Thus, I'll stick to this.
> >
> > And e.g., I could easily find DRM driver with opposite order.
> Next revision:
>
> +static const struct mfd_cell engines[] =3D {
> +       { .name =3D "loongson-rng" },
> +       { .name =3D "tpm_loongson" },
> +};
> Then
> "loongson-rng" can match MFD and Crypto subsystem naming convention.
> "tpm_loongson" can match TPM subsystem naming convention.
If possible, I prefer the old names.

Huacai

>
>
> Thanks,
> Qunqin
>
> >> Huacai
> > BR, Jarkko
>

