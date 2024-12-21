Return-Path: <linux-integrity+bounces-4453-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016909FA25F
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Dec 2024 21:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4161606AA
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Dec 2024 20:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92EB189916;
	Sat, 21 Dec 2024 20:13:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D602187872;
	Sat, 21 Dec 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734812015; cv=none; b=JI4R/oY4fXfAMoNALfB69rKeBO6pp2Y75UixRVQEXY0Bz3GnOeUukvNcLXXo9DwuJiM3f3hEWw+sya3RIi0oP346SRgHEXgcyKTQmDKoFufionmeWEirELzq0wesu6LlNXvRa9zHM2/LafapVqdlBKgyH3XE39bvJ7RWKBkFn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734812015; c=relaxed/simple;
	bh=HRdHNdrJ+YduYVvOHMuRz6FSAXfycWE5uOCRtNJgOcc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=QV9j4yuzKer2jgvwArlHQG3AEY1wXVvP5moV2cCammsRZrgFDQsGJ8I9kCeo7SWPCxtAh0pEzyjYvE/t42UZ8lxe7D9aY84nn4bdnmOq8fWHxhGCZJAViBk8ODPadBfTxW02I4E3WTqueYlq78ZNBO6GDWsuVC86xLyz8Ve6J/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB01DC4CECE;
	Sat, 21 Dec 2024 20:13:34 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 22:13:31 +0200
Message-Id: <D6HNJ7RTLY54.31KMCV15CLC6@iki.fi>
To: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Joe Hattori" <joe@pf.is.s.u-tokyo.ac.jp>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Al Viro" <viro@zeniv.linux.org.uk>, "Andy
 Liang" <andy.liang@hpe.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
X-Mailer: aerc 0.18.2
References: <20241221113318.562138-1-jarkko@kernel.org>
 <CAMj1kXHPpz2sH_MSjJ3wRP64tB2pSZJDUoMv4uKXh-HpgHWfvQ@mail.gmail.com>
 <fc11e26d9a202d60a56403af9bd0bae4bd3a852f.camel@HansenPartnership.com>
 <D6HNHJM9L4BS.MNNTVW049NZJ@iki.fi>
In-Reply-To: <D6HNHJM9L4BS.MNNTVW049NZJ@iki.fi>

On Sat Dec 21, 2024 at 10:11 PM EET, Jarkko Sakkinen wrote:
> On Sat Dec 21, 2024 at 7:16 PM EET, James Bottomley wrote:
> > On Sat, 2024-12-21 at 17:04 +0100, Ard Biesheuvel wrote:
> > > On Sat, 21 Dec 2024 at 12:33, Jarkko Sakkinen <jarkko@kernel.org>
> > > wrote:
> > > >=20
> > > > The following failure was reported:
> > > >=20
> > > > [=C2=A0=C2=A0 10.693310][=C2=A0=C2=A0=C2=A0 T1] tpm_tis STM0925:00:=
 2.0 TPM (device-id 0x3,
> > > > rev-id 0)
> > > > [=C2=A0=C2=A0 10.848132][=C2=A0=C2=A0=C2=A0 T1] ------------[ cut h=
ere ]------------
> > > > [=C2=A0=C2=A0 10.853559][=C2=A0=C2=A0=C2=A0 T1] WARNING: CPU: 59 PI=
D: 1 at
> > > > mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
> > > > [=C2=A0=C2=A0 10.862827][=C2=A0=C2=A0=C2=A0 T1] Modules linked in:
> > > > [=C2=A0=C2=A0 10.866671][=C2=A0=C2=A0=C2=A0 T1] CPU: 59 UID: 0 PID:=
 1 Comm: swapper/0 Not
> > > > tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed
> > > > (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
> > > > [=C2=A0=C2=A0 10.882741][=C2=A0=C2=A0=C2=A0 T1] Hardware name: HPE =
ProLiant DL320
> > > > Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
> > > > [=C2=A0=C2=A0 10.892170][=C2=A0=C2=A0=C2=A0 T1] RIP: 0010:__alloc_p=
ages_noprof+0x2ca/0x330
> > > > [=C2=A0=C2=A0 10.898103][=C2=A0=C2=A0=C2=A0 T1] Code: 24 08 e9 4a f=
e ff ff e8 34 36 fa ff e9
> > > > 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09
> > > > c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08
> > > > 00 75 42 89 d9 80 e1
> > > > [=C2=A0=C2=A0 10.917750][=C2=A0=C2=A0=C2=A0 T1] RSP: 0000:ffffb7cf4=
0077980 EFLAGS: 00010246
> > > > [=C2=A0=C2=A0 10.923777][=C2=A0=C2=A0=C2=A0 T1] RAX: 00000000000000=
00 RBX: 0000000000040cc0
> > > > RCX: 0000000000000000
> > > > [=C2=A0=C2=A0 10.931727][=C2=A0=C2=A0=C2=A0 T1] RDX: 00000000000000=
00 RSI: 000000000000000c
> > > > RDI: 0000000000040cc0
> > > >=20
> > > > Above shows that ACPI pointed a 16 MiB buffer for the log events
> > > > because RSI maps to the 'order' parameter of
> > > > __alloc_pages_noprof(). Address the bug by mapping the region when
> > > > needed instead of copying.
> > > >=20
> > > > Reported-by: Andy Liang <andy.liang@hpe.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219495
> > > > Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > >=20
> > > This is a very intrusive fix - care to provide some more context on
> > > why all these changes are needed?
> >
> > Since the bug reports never found an actual log over a few tens of
> > kilobytes this is caused by the BIOS implementation allocating a huge
> > buffer that is mostly unused.
> >
> > There are two other possibilities for fixing this, which were both part
> > of the original suggestions.  One would be to work out the size of the
> > log and then allocate an exact size.  This would require implementing
> > tpm1 and tpm2 parsers for log size.  However, since we can never go
> > over KMALLOC_MAX_SIZE without an error even with this calculated size,
> > the simplest straight line fix would be to cap the copy at
> > KMALLOC_MAX_SIZE if it's over.  That would be a simple one liner.
>
> All I'm saying is this.
>
> I've got bunch of complains of this from mainly SUSE, and now I'm
> here with a response to that feedback. So I don't care. You decide.
>
> I'm 100% sure that the fix that Stefan proposed is not a sustainable
> path in long-term, so I guess this was more like more long-term but
> intrusive fix.
>
> Ya, and also please test the changes, especially anything that can
> reach of OF eventlogs would be welcome feedback.

Note that I precision cut that transcript because it includes all
infos of the debatable hardware.

BR, Jarkko

