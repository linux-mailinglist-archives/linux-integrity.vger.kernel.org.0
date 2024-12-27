Return-Path: <linux-integrity+bounces-4487-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67E9FD34D
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 11:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AA53A10B1
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE641B85E4;
	Fri, 27 Dec 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGEwMaE5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490142A83;
	Fri, 27 Dec 2024 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296741; cv=none; b=p0HwwCqGp+vkP6pNLDCSUo2gfCNz3FI4Uo9lDUGr76PMpITYY5Hh69oKkpPGaCBYfKVYT5PiqqLHTj/JaXh2WYN384Z6PzBrrNXWdIcOeQZNxT7lrDp9SaD/q2vhTzxQ+w0ZRFn32Fb/rEietjI21188IkoPsRkkxFi6gM3SpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296741; c=relaxed/simple;
	bh=CpXDEwkM0CXIZnHpZlypows8vrS2hXuKtz/+JVlDTCk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FfaTQuEjIfp1FerYnejbQZh1kNV8JelAEXRhal/gwUqYIwUOrZVwkHXJPFRbt9JKNRaoL0kVYqNw27CKI3imMU+9QG8604FvwG3X81IyJjV7m09ob5yBlPBn9TlQONfZfHcGv6QpP0t4jHOjga/3kRJeeZJ6Mf4lwXn7E4eF/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGEwMaE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE5DC4CED0;
	Fri, 27 Dec 2024 10:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735296740;
	bh=CpXDEwkM0CXIZnHpZlypows8vrS2hXuKtz/+JVlDTCk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=vGEwMaE56EyGHNGUy1Rj4UZ1GSKm5tCv2+QkEfnE6GNlK3vl3CJLxDvvZ3mvIp1Zu
	 UUXbh/u/fgbVVPJGgcJ2SquodV85fAkbvY2QHDmSHk63CmIgOpdGn0PPjYoUO+6foC
	 /cEoV65orLNxrKlqfDVQBZTxZCzwmbVBu4wLz8k9A7NblWa+NcFLxcvgW1IrO6T57R
	 6ita6dJTCAEOCFIc6AcN8nwsloCm0G7xFqwXBYuL4+8aHwQd/79Jiwnt0+HX5aryH1
	 k8CVT9+DRQeRHLhhjIXc4ZaA8qVrd7/KjZItScTWjQc0ftyd64PTRQWyp3CkImsnQV
	 3axAOttlscTPg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Dec 2024 12:52:15 +0200
Message-Id: <D6MFCR89KWG3.1KHDSMSF3LA6G@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Joe Hattori" <joe@pf.is.s.u-tokyo.ac.jp>, "James
 Bottomley" <James.Bottomley@hansenpartnership.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>, "Al
 Viro" <viro@zeniv.linux.org.uk>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "Andy Liang" <andy.liang@hpe.com>, "Mimi Zohar" <zohar@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ard Biesheuvel"
 <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241227060053.174314-1-jarkko@kernel.org>
 <20241227060053.174314-2-jarkko@kernel.org>
 <CAMj1kXFB6NL4EASV9_XeRM=iYaoVHQks0pXyVt2tGSQbD-St6g@mail.gmail.com>
 <D6MFAUNRJ8GX.22HLDPXR7EZ5W@kernel.org>
In-Reply-To: <D6MFAUNRJ8GX.22HLDPXR7EZ5W@kernel.org>

On Fri Dec 27, 2024 at 12:49 PM EET, Jarkko Sakkinen wrote:
> On Fri Dec 27, 2024 at 10:43 AM EET, Ard Biesheuvel wrote:
> > On Fri, 27 Dec 2024 at 07:01, Jarkko Sakkinen <jarkko@kernel.org> wrote=
:
> > >
> > > The following failure was reported:
> > >
> > > [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, re=
v-id 0)
> > > [   10.848132][    T1] ------------[ cut here ]------------
> > > [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:472=
7 __alloc_pages_noprof+0x2ca/0x330
> > > [   10.862827][    T1] Modules linked in:
> > > [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tain=
ted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588=
cd98293a7c9eba9013378d807364c088c9375
> > > [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLia=
nt DL320 Gen12, BIOS 1.20 10/28/2024
> > > [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> > > [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 8=
8 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e=
6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80=
 e1
> > > [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> > > [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RC=
X: 0000000000000000
> > > [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RD=
I: 0000000000040cc0
> > >
> > > Above shows that ACPI pointed a 16 MiB buffer for the log events beca=
use
> > > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address =
the
> > > bug by mapping the region when needed instead of copying.
> > >
> > > Earlier fix does address the warning but wastes 16 MiB of memory. Thi=
s
> > > finalizes the fix.
> > >
> > > Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
> > > Tested-by: Andy Liang <andy.liang@hpe.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > Where are patch 1/2 and the cover letter?
>
> https://lore.kernel.org/linux-integrity/20241227060053.174314-1-jarkko@ke=
rnel.org/T/#mc34835f6d6f946c50a580f895f24b7b1dab85204
>
> You did not request a cover letter, and I did not think it was
> really necessary. I can do it for next version on request.

Hmm.. right so this is how I generate Cc's:

    tocmd =3D"`pwd`/scripts/get_maintainer.pl --norolestats --nol"
    cccmd =3D"`pwd`/scripts/get_maintainer.pl --norolestats --nom"

It clearly did not pick you (sorry about that).  I'll add manual cc to
the next version. And yeah, cover letter is fine, but I did not see any
(practical) use for it as the patches carry change logs.

BR, Jarkko


