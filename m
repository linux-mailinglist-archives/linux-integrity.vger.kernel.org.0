Return-Path: <linux-integrity+bounces-4473-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897B69FC5E0
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2024 16:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230D3160832
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Dec 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9E7404E;
	Wed, 25 Dec 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfWzio1E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71857323D;
	Wed, 25 Dec 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735140702; cv=none; b=rJ9oBbQ1o8lA7WESO5qy5KEOwDDSYdccBU7ZrXxgBlZRqfZSuiT1Nm21/geEygXWfe1A9jUYrFiZ5SggwXyfM/HD7+NNsm04O+lnTjhZxMbHJjiRoaMPWkNHcwfnh2nixAsQYfJl8uTlK+YNDdMKYTxWhJCTBOQ2uzAWKZk7cNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735140702; c=relaxed/simple;
	bh=FZkV9uzm95KrAFEyeCD5yphOWPgla1ScpoA6jlklpXs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=glxct++HBZF2bl2SzBQ1AOgxNec5rxGsY6nq1NvfXm++kETb3nRl8N6A37plDTQyHobXOFK3Fzp6Ii1wXrpBEr5dAoFtuR7RK4poFSfGB0wTZA59PW1DwPAhCN+zK2iOX3VYiD81UF6tCIq9yrNUHEeuSx4BBi4BuYLwjhyxVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfWzio1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20267C4CECD;
	Wed, 25 Dec 2024 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735140702;
	bh=FZkV9uzm95KrAFEyeCD5yphOWPgla1ScpoA6jlklpXs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DfWzio1EnResUWEURQ3sF9KJ+wzE6xZ3nfPPhC88ZSBlPmLuvaDGTvjsgSZ8NArkm
	 tWVPsxXuJIDDnpdeG9ZhdWfAsxUfQx3R/iSawVE2xcxSGuMZfczCPslFrLnhC6tKPm
	 04nILjD3CIwSo/0VpJkP58YJQ10C8PclclwGH/dMWmBcEItHaHB8hU+jDGb8JKLpOa
	 hBvOJBueNxKPquQgX8wSFpIcU5CfiJqTSlAGvosN6P/+HiAw7J050D3wnXaoa+fYP2
	 woICazUVArxmxP1pB0eNUMDYip1mCh6fKBiZ7TrwKlskoyowzPxRzaRih1Eoavpuxt
	 /tKGd25k6wr4g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Dec 2024 17:31:36 +0200
Message-Id: <D6KW1JU6RBR0.2QL8BTX01XZNP@kernel.org>
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
In-Reply-To: <CAMj1kXGOcqEH68-Pp4+-WMpG-2D-iN6xAHFTQvQLobO1sE3QFA@mail.gmail.com>

On Tue Dec 24, 2024 at 6:05 PM EET, Ard Biesheuvel wrote:
> On Tue, 24 Dec 2024 at 05:03, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > The following failure was reported:
> >
> > [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-=
id 0)
> > [   10.848132][    T1] ------------[ cut here ]------------
> > [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 =
__alloc_pages_noprof+0x2ca/0x330
> > [   10.862827][    T1] Modules linked in:
> > [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainte=
d 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd=
98293a7c9eba9013378d807364c088c9375
> > [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant=
 DL320 Gen12, BIOS 1.20 10/28/2024
> > [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> > [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 =
fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 =
ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e=
1
> > [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> > [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX:=
 0000000000000000
> > [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI:=
 0000000000040cc0
> >
> > Above shows that ACPI pointed a 16 MiB buffer for the log events becaus=
e
> > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address th=
e
> > bug by mapping the region when needed instead of copying.
> >
>
> How can you be sure the memory contents will be preserved? Does it say
> anywhere in the TCG spec that this needs to use a memory type that is
> preserved by default?

TCG log calls the size as the minimum size for the log area but is not
too accurate on details [1]. I don't actually know what "minimum" even
means in this context as it is just a fixed size cut of the physical
address space.

I don't think that can ever change. It would be oddballs if some
dynamic change would make ACPI tables show incorrect information=20
on memory ranges. Do you know any pre-existing example of such
behavior (not sarcasm, just interested)?

Anyway considering this type of dynamics TCG spec is inaccurate.

>
> Also, the fact that we're now at v5 kind of proves my point that this
> approach may be too complex for a simple bug fix. Why not switch to
> kvmalloc() for a backportable fix, and improve upon that for future
> kernels?

OK, I could possibly live with this. 16 MiB is not that much with
current memory sizes so if everyone agrees this then it is fine and I'll
change this patch as feature for my next PR. I just don't want to decide
any abritrarily chosen truncate range. For me it just feels wasting
memory for no reason, that's all.

Alternatively the code do pre-fetch iteration of what happens when
you do "cat /sys/kernel/security/tpm0/binary_measurements" and then
we would end up about 100 kB or similar figure with this hardware
but that would require code I already did and few bits more for
full implementation.

[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpe=
c_v1p3_r8_pub.pdf

BR, Jarkko

