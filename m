Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA031CB99
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 15:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhBPOKo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 09:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhBPOKm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 09:10:42 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56696C061574
        for <linux-integrity@vger.kernel.org>; Tue, 16 Feb 2021 06:10:00 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z6so6213222pfq.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Feb 2021 06:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lgEmlA9dWiiiJGtV7nbpIDjeizZT09Gj9WrN3WhdD7E=;
        b=B+xWUsA9NCQiW0swlICckRlhUfjlZhWJ3DnKGfsZlBuwdOTznHPGdn1F4vpFbx1whn
         zD1taQFlv/oddETFxrqRJXHlvq6pw5NhhxbUkl4nTb8rfEaM1NInvkfQlBOPHOH6TBeG
         2hvzsucym4bGzSCtBdlFmhnVRHEjUiJ2s51BkDIzVA5I6tiJ4IiTTPfR+NFcTswcGXt/
         FRuFhqytzfWEVQLfQgzWOr4oOAnaw+ZFEFcjcAEzpYmj1hAJGmdYu8wH3nxqzixqsHB+
         0Y8CeI29eWV6HqK6DustPiFrPxn4gUmcdslJZZW4hAvoc/Rh92wh3ZAcS9Qj8XGzWUKV
         M5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lgEmlA9dWiiiJGtV7nbpIDjeizZT09Gj9WrN3WhdD7E=;
        b=XVRu+/XtJbPf1jDj1QEpjiZEeYvWcjQYW/JDS7LP/xu6/riFMQYaRmFGTfbFml8xM0
         UJa0zBbDXCgptHHuplRaF6kSu0ipWZVhpuz5r50xygNUcnJHqUAXFVNDh4v5tU4GxdJt
         SxcbruaWxY1qp+iZGL/fjl7nj9Uojj1F02p1YSbgBSzxrZJ4auraeLIEDZv5ej8R5tfW
         xUb0yZKiG28oShHEuY3+aPc1ajJLELOTT5emZnCwVJDLiWuWzxW1FroPgMR8MPkibTv3
         MJeRT9vg+oJqcKHxRtO6lw95hg6f3zSntKKcHNO/TRt+M8bi9jGOsBGEfF9iFu/9CvKS
         gMzQ==
X-Gm-Message-State: AOAM532Pf0TMhz5O9nPbE3/8dozGlxJeggUvF7n7p3qnkblY2Sd5CpVu
        FfmHVEY6rP8I4KbJCzMiI3xzrYLpx/6UIu1+nel1DQ==
X-Google-Smtp-Source: ABdhPJwhyEW/HpHykaj5T6FGMDiIANvyUvlpjQDzcYXdXolJ114XEVyreMx9P4I4PMSks6QGKSzaOuB4y9MSrYBOxmI=
X-Received: by 2002:a63:1843:: with SMTP id 3mr11538913pgy.253.1613484599812;
 Tue, 16 Feb 2021 06:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20210216081750.191250-1-jarkko@kernel.org> <ccb8ff69-5223-c293-bdda-46f041b7b770@debian.org>
In-Reply-To: <ccb8ff69-5223-c293-bdda-46f041b7b770@debian.org>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Tue, 16 Feb 2021 15:09:49 +0100
Message-ID: <CAFJ_xbooQp5FqEuSGu3ChqdKj0YfLzfhLYMYUDfOiQ+vaVnOdw@mail.gmail.com>
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in tpm_tis_gen_interrupt()
 and tpm_get_timeouts()
To:     Laurent Bigonville <bigon@debian.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Laurent,

I think your case is different, as the trace shows the issue occurs in
the place already guarded by tpm_chip_start()/stop() - tpm2_probe().
Can you paste more dmesg log? (With tpm prefix?). I believe
tpm_tis_status() might return something different than 0xff here.
Please ensure you have applied Jarkko's patch that logs status
(https://patchwork.kernel.org/project/linux-integrity/patch/20210202222150.=
120664-1-jarkko@kernel.org/)

Best regards
Lukasz

wt., 16 lut 2021 o 12:02 Laurent Bigonville <bigon@debian.org> napisa=C5=82=
(a):
>
> Le 16/02/21 =C3=A0 09:17, Jarkko Sakkinen a =C3=A9crit :
> > From: Lukasz Majczak <lma@semihalf.com>
> >
> > This is shown with Samsung Chromebook Pro (Caroline) with TPM 1.2
> > (SLB 9670):
> >
> > [    4.324298] TPM returned invalid status
> > [    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.=
c:275 tpm_tis_status+0x86/0x8f
> >
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > TCG PC Client Platform TPM Profile (PTP) Specification, paragraph 6.1 F=
IFO
> > Interface Locality Usage per Register, Table 39 Register Behavior Based=
 on
> > Locality Setting for FIFO - a read attempt to TPM_STS_x Registers retur=
ns
> > 0xFF in case of lack of locality. The described situation manifests its=
elf
> > with the following warning trace:
> >
> > The fix
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > Add the proper decorations to tpm_tis_gen_interrupt() and
> > tpm_get_timeouts().
>
> I tried that patch (alone on the top of the HEAD of Linus master) and I
> still get the same trace in dmesg
>
