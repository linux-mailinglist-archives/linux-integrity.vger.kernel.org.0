Return-Path: <linux-integrity+bounces-4488-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C29FD57D
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 16:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02F9167D99
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367091F7089;
	Fri, 27 Dec 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw2fUnLq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8AC1F540C;
	Fri, 27 Dec 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735312531; cv=none; b=Be3ZdwQ2H26LHhavQl0HxRarI/Tgfo/9fRHkGcI6Wj0+sn9+v1MSW93KeDll23VfLXG5QO6sEn9k0J0PnoCAa2oQOrHMsM2yt+YgZ4yHgkZHZmQC9YZbP3N1ce5K+kxRBmmygH5tXboh14Fvetvye/LITUahM+leC8J3X9KwjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735312531; c=relaxed/simple;
	bh=R5Y1e+xl95y7/ycw9Cztvg/noQpwuPHWt+dLP3k3hNs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FC/c0Kv1bqfH4MuTVw2rsXsHKv7wsXmBZNWV93Bm5RC3FeTUxCZh6AwzpfqtKi4Tymmg7LKU6Le6rD4a2/xqvEGW8mOyvi2JpwpKRD3ErPPw0UcseCTWQFJpAn6/kZqdH+gUvEbeSO1SwxFyFw2QpW0iDLlF17ZGcQKi8eGylTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw2fUnLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFDCC4CED3;
	Fri, 27 Dec 2024 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735312530;
	bh=R5Y1e+xl95y7/ycw9Cztvg/noQpwuPHWt+dLP3k3hNs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Iw2fUnLq9Urfyi0OTZPrj8yQMS1IhKs6TCZ/aNfe6XMwkrPDTV0SjgdSdTdIpYmjY
	 wL1u1suPkoYqgyQQvJPzDPN+DB2TG2RchZF4gBsYRRks5p97iJK+HIJzUBT6DIjsCf
	 pmz+jEej097O34hDnUZ5YeZnuWiQfbCyAni2zVyAYj83YetUsObKnyqZg6uOedVUgz
	 2UsWYCZ4UtRx/dStM4f0n3xjD9Dlxj0cCBMUCVI3YgYiQwkhUJ+rJY6SjURDeGPB/S
	 fi+SGlnL9GfP3QBk6x4UAZi1c5VOPOY/YsN9B3Oc5zpJn87z8UQzHF8J9WgmWEb4jD
	 cWQruQPjc7Pzw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Dec 2024 17:15:25 +0200
Message-Id: <D6MKY8VHP3WT.NKKPW4TC64W8@kernel.org>
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
 <D6MFCR89KWG3.1KHDSMSF3LA6G@kernel.org>
In-Reply-To: <D6MFCR89KWG3.1KHDSMSF3LA6G@kernel.org>

On Fri Dec 27, 2024 at 12:52 PM EET, Jarkko Sakkinen wrote:
> On Fri Dec 27, 2024 at 12:49 PM EET, Jarkko Sakkinen wrote:
> > On Fri Dec 27, 2024 at 10:43 AM EET, Ard Biesheuvel wrote:
> > > On Fri, 27 Dec 2024 at 07:01, Jarkko Sakkinen <jarkko@kernel.org> wro=
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
> > > > Earlier fix does address the warning but wastes 16 MiB of memory. T=
his
> > > > finalizes the fix.
> > > >
> > > > Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
> > > > Tested-by: Andy Liang <andy.liang@hpe.com>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > >
> > > Where are patch 1/2 and the cover letter?
> >
> > https://lore.kernel.org/linux-integrity/20241227060053.174314-1-jarkko@=
kernel.org/T/#mc34835f6d6f946c50a580f895f24b7b1dab85204
> >
> > You did not request a cover letter, and I did not think it was
> > really necessary. I can do it for next version on request.
>
> Hmm.. right so this is how I generate Cc's:
>
>     tocmd =3D"`pwd`/scripts/get_maintainer.pl --norolestats --nol"
>     cccmd =3D"`pwd`/scripts/get_maintainer.pl --norolestats --nom"
>
> It clearly did not pick you (sorry about that).  I'll add manual cc to
> the next version. And yeah, cover letter is fine, but I did not see any
> (practical) use for it as the patches carry change logs.

I'll reduce this to quick fix after reconsidering. We have the mapped
version drafted and backed up in lore. I'll re-send just that with and
CC you. Or actually I'll put suggested-by tag.

BR, Jarkko

