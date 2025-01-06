Return-Path: <linux-integrity+bounces-4526-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4014A031FB
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2025 22:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C563A1CC3
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2025 21:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5772E1DF749;
	Mon,  6 Jan 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzL90aou"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267BE15886C;
	Mon,  6 Jan 2025 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198455; cv=none; b=BWDMLxERZSBWjKfzgMgDNMKofnCOpq1mrlGNEDyTZm0gwO5eFoyyFu1DcnBNCiPEaK1v2kOfhCC3CJT1r6xST54MNaXhQWQ4qVypQjhsVPmzRvOTExDkGRTjNsB450YLytp58jLwF46vZ31hhA1p6MwV88TBTr+y5uaBM4lpVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198455; c=relaxed/simple;
	bh=zDmervT9GBXH5Lv4juG3yIw7tNrPmUjt9WDwtI0ZY9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uHrOVYwxzyQlkIufo4KU9tGrEqldKH5m7VlVEYD9TwvHczmxmat5TNtmM3cKJOn2EyYc4NMUoOPKp81Kt4I9cO9AgDxpY7X9fTnz9UZG5sFuH97lM56418cl6xQ13GlM0Ch8DTVxqK3MknmTdvGWoEY2nXUD/mDbxmFZaPuW7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzL90aou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BB3C4CED2;
	Mon,  6 Jan 2025 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736198454;
	bh=zDmervT9GBXH5Lv4juG3yIw7tNrPmUjt9WDwtI0ZY9o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QzL90aou1k8ioKSHfW9q482SoIQyIdOf1upsKB8h0JQFO6BYt6UhgzKyRyxLzBeqc
	 +2QZbM+n/rWHPFB90pm8xlpZfeUiPY+OXpQDEud0fclEcLgiJqBEF6RroCY+q+cKpF
	 4FOGntB2iwg40OE+GRMq2L6kWujmnlgrLCy/KGRNMRuz2vVVELWr5QPSdzpL173p0e
	 62+ba2wikkD/qWXfS4oTuqhLW/dY//WqRvEcrW2d7XG45NIvKSr/NfelSZ6TXs/syd
	 5qRp829V+EEGj4dmB7A7jD1eGDRz+Z/lgJ5dz8RaJh1mDJ2OckW46NgXvtEzXzY7vj
	 5PXs+rSXybD4Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jan 2025 23:20:49 +0200
Message-Id: <D6VAZGXPWLUY.31RHNWW6ROQMA@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Joe Hattori" <joe@pf.is.s.u-tokyo.ac.jp>, "James
 Bottomley" <James.Bottomley@hansenpartnership.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Al Viro"
 <viro@zeniv.linux.org.uk>, "Kylene Jo Hall" <kjhall@us.ibm.com>, "Reiner
 Sailer" <sailer@us.ibm.com>, "Seiji Munetoh" <munetoh@jp.ibm.com>, "Andrew
 Morton" <akpm@osdl.org>, <stable@vger.kernel.org>, "Andy Liang"
 <andy.liang@hpe.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241224040334.11533-1-jarkko@kernel.org>
 <CAMj1kXGOcqEH68-Pp4+-WMpG-2D-iN6xAHFTQvQLobO1sE3QFA@mail.gmail.com>
 <D6KW1JU6RBR0.2QL8BTX01XZNP@kernel.org>
 <CAMj1kXHTJ_=g1dnuGV2PWiNC1o=wKFOkZxEAcrMWYbUNWkxKNg@mail.gmail.com>
In-Reply-To: <CAMj1kXHTJ_=g1dnuGV2PWiNC1o=wKFOkZxEAcrMWYbUNWkxKNg@mail.gmail.com>

On Mon Jan 6, 2025 at 7:23 PM EET, Ard Biesheuvel wrote:
> On Wed, 25 Dec 2024 at 16:31, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue Dec 24, 2024 at 6:05 PM EET, Ard Biesheuvel wrote:
> > > On Tue, 24 Dec 2024 at 05:03, Jarkko Sakkinen <jarkko@kernel.org> wro=
te:
> > > >
> > > > The following failure was reported:
> > > >
> > > > [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, =
rev-id 0)
> > > > [   10.848132][    T1] ------------[ cut here ]------------
> > > > [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4=
727 __alloc_pages_noprof+0x2ca/0x330
> > > > [   10.862827][    T1] Modules linked in:
> > > > [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not ta=
inted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 5=
88cd98293a7c9eba9013378d807364c088c9375
> > > > [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProL=
iant DL320 Gen12, BIOS 1.20 10/28/2024
> > > > [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> > > > [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9=
 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8=
 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 =
80 e1
> > > > [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> > > > [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 =
RCX: 0000000000000000
> > > > [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c =
RDI: 0000000000040cc0
> > > >
> > > > Above shows that ACPI pointed a 16 MiB buffer for the log events be=
cause
> > > > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Addres=
s the
> > > > bug by mapping the region when needed instead of copying.
> > > >
> > >
> > > How can you be sure the memory contents will be preserved? Does it sa=
y
> > > anywhere in the TCG spec that this needs to use a memory type that is
> > > preserved by default?
> >
> > TCG log calls the size as the minimum size for the log area but is not
> > too accurate on details [1]. I don't actually know what "minimum" even
> > means in this context as it is just a fixed size cut of the physical
> > address space.
> >
> > I don't think that can ever change. It would be oddballs if some
> > dynamic change would make ACPI tables show incorrect information
> > on memory ranges. Do you know any pre-existing example of such
> > behavior (not sarcasm, just interested)?
> >
> > Anyway considering this type of dynamics TCG spec is inaccurate.
> >
>
> Thanks for the context but that is not at all what I was asking.
>
> This change assumes that the contents of the memory region described
> by the ACPI table will be reserved in some way, and not be released to
> the kernel for general allocation.
>
> This is not always the case for firmware tables: EFI configuration
> tables need to be reserved explicitly unless the memory type is
> EfiRuntimeServicesData. For ACPI tables, the situation might be
> different but there is at least one example (BGRT) where the memory
> type typically used is not one that the kernel usually reserves by
> default.
>
> So my question is whether there is anything in the TCG platform spec
> (or whichever spec describes this ACPI table) that guarantees that the
> region that the TCPA or TPM2 table points to is of a type that does
> not require an explicit reservation?

I agree that we must assume that we cannot guarantee taht  since it is
open in the spec. I think I went over the top with this.

Let's go with the simpler devm_add_action_or_reset() fix.

BR, Jarkko

