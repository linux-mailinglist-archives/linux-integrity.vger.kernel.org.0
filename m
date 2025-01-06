Return-Path: <linux-integrity+bounces-4524-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A355A02ED6
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2025 18:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C290F18855ED
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2025 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B371DED4A;
	Mon,  6 Jan 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gykxl4gz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BF01DE4FE;
	Mon,  6 Jan 2025 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184234; cv=none; b=UBQfAxTR2In3hruADz7QBVK102PR72hDXFQPDLBFqC2qBanUWX5pokIdc57T+o2O5dMt3DXTN0+oEgjLATNeRzj4cS9cI2FETUAI38w+8XGaBF38gTMoEFl4j4e3sCCXrKOvS8o6VnpPls/7fsOtJOqXC+bq06cyeXJjZHRCUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184234; c=relaxed/simple;
	bh=efG3H2hD7NAQzoCtc0eCarWNq6bEDlIWe1vwEj2j7Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJQ9oR1XLgPUOVxTmPE8dUQxoLTu22Mp1rCipGfXiJukfkTBZu67rjYbt5/n1ITQymp9H7hNFplTa9ZsshGOib60kpKJ3n9yJkI8iL9ZdNGb24e+cKAzmjQ9hfirfTy8RYws+86VJSa3ibhnvfHeEVReOjVHV/bUWNc0+5kS5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gykxl4gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B42C4CEE3;
	Mon,  6 Jan 2025 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736184233;
	bh=efG3H2hD7NAQzoCtc0eCarWNq6bEDlIWe1vwEj2j7Jk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gykxl4gzUqNsRtiuT9ce7Od2dpmlSYD1s1fdqHHoKIF3IdM5RAzC3ymWcO4BtcZ2I
	 Vx40NFc5lCHRQyz1SGDt258nIxpJ7BhyN5wlrVsZ7kTnF2+C3oOFPqtFxwrdWxtxG+
	 hGU9oSJaVqha3Qo4XbXcFqA5DRVVJm3IL1ZRbB+YDRes87wwYFoOxUONa1hnKx5qJf
	 da8NY/Pc8lh+CpjIBmJSGaMGR/n/ygTTdAjKfPACbuafxfpkAMSF6kP48MJVhNe1Wo
	 ji7b63KR9IfhGVnij0ZSFcXx9q57BAfBkyG4tf6NPLn6nQRzXMOF7wWelL4D3ArgQj
	 ZQJkqOxFqk14Q==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54252789365so8093996e87.0;
        Mon, 06 Jan 2025 09:23:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURWI3l0Vk9FHLAMv+PoKSKl+viSAgcJxvqnixre+Ugs19GrhhcUgKQvcnyaLHhuiijrApyJaRi@vger.kernel.org, AJvYcCW8nTfzFe99eQDC5YTp6TktHrDV3bOCW2xI1LKSYeI/buLLgiD+xqTBNcWByatlcbCZcGg62bUUXfxLyF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxDHhNGlSEw4UX/Nb3MJyDl+ar7iGO56vcEFHHd5NSjTG4jPh
	dt0bB7guvcl3LiB8b04zGVxsDV6cR7pYluaPp3nNdfTz/38q/4Ss8SaoeJOuMquq+px/gdnEOMz
	Cwd3d0kF/qFxG554arq6lsff9ALI=
X-Google-Smtp-Source: AGHT+IFsWkSx2Ba9vB7qrNFaGiPYVMK0HTHAQVlb2dNFzhN7QCq4dSfD1GNd+jcx9fAXyOA+8+w4bT+MzoJoVPvf0O0=
X-Received: by 2002:a05:6512:3994:b0:542:214c:532 with SMTP id
 2adb3069b0e04-54229538b3amr15388747e87.13.1736184231936; Mon, 06 Jan 2025
 09:23:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224040334.11533-1-jarkko@kernel.org> <CAMj1kXGOcqEH68-Pp4+-WMpG-2D-iN6xAHFTQvQLobO1sE3QFA@mail.gmail.com>
 <D6KW1JU6RBR0.2QL8BTX01XZNP@kernel.org>
In-Reply-To: <D6KW1JU6RBR0.2QL8BTX01XZNP@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 6 Jan 2025 18:23:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHTJ_=g1dnuGV2PWiNC1o=wKFOkZxEAcrMWYbUNWkxKNg@mail.gmail.com>
Message-ID: <CAMj1kXHTJ_=g1dnuGV2PWiNC1o=wKFOkZxEAcrMWYbUNWkxKNg@mail.gmail.com>
Subject: Re: [PATCH v5] tpm: Map the ACPI provided event log
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Colin Ian King <colin.i.king@gmail.com>, 
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kylene Jo Hall <kjhall@us.ibm.com>, 
	Reiner Sailer <sailer@us.ibm.com>, Seiji Munetoh <munetoh@jp.ibm.com>, Andrew Morton <akpm@osdl.org>, 
	stable@vger.kernel.org, Andy Liang <andy.liang@hpe.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Dec 2024 at 16:31, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue Dec 24, 2024 at 6:05 PM EET, Ard Biesheuvel wrote:
> > On Tue, 24 Dec 2024 at 05:03, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > The following failure was reported:
> > >
> > > [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
> > > [   10.848132][    T1] ------------[ cut here ]------------
> > > [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
> > > [   10.862827][    T1] Modules linked in:
> > > [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
> > > [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
> > > [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> > > [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
> > > [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> > > [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
> > > [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0
> > >
> > > Above shows that ACPI pointed a 16 MiB buffer for the log events because
> > > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address the
> > > bug by mapping the region when needed instead of copying.
> > >
> >
> > How can you be sure the memory contents will be preserved? Does it say
> > anywhere in the TCG spec that this needs to use a memory type that is
> > preserved by default?
>
> TCG log calls the size as the minimum size for the log area but is not
> too accurate on details [1]. I don't actually know what "minimum" even
> means in this context as it is just a fixed size cut of the physical
> address space.
>
> I don't think that can ever change. It would be oddballs if some
> dynamic change would make ACPI tables show incorrect information
> on memory ranges. Do you know any pre-existing example of such
> behavior (not sarcasm, just interested)?
>
> Anyway considering this type of dynamics TCG spec is inaccurate.
>

Thanks for the context but that is not at all what I was asking.

This change assumes that the contents of the memory region described
by the ACPI table will be reserved in some way, and not be released to
the kernel for general allocation.

This is not always the case for firmware tables: EFI configuration
tables need to be reserved explicitly unless the memory type is
EfiRuntimeServicesData. For ACPI tables, the situation might be
different but there is at least one example (BGRT) where the memory
type typically used is not one that the kernel usually reserves by
default.

So my question is whether there is anything in the TCG platform spec
(or whichever spec describes this ACPI table) that guarantees that the
region that the TCPA or TPM2 table points to is of a type that does
not require an explicit reservation?

-- 
Ard.

