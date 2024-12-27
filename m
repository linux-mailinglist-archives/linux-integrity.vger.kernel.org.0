Return-Path: <linux-integrity+bounces-4486-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5A9FD324
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 11:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DEC1883F0C
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Dec 2024 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438F1F12FD;
	Fri, 27 Dec 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS/4N9DJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF88154C07;
	Fri, 27 Dec 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296592; cv=none; b=C+j+s6Cx3SMc3VAqt1PCSB30FwSMO4ICDnT27gkiJiU1FX6ApFO/FwDufvbwLjxNFzg6kC3Iv0abII5hpvc33WLW9MOYTE19BefkDek1x7rJfS4fBNq7B2U+zr9GgVCu80uyH5MS388rKTg1f4zKwE7WJ0LwTbaM74Fh5DyCYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296592; c=relaxed/simple;
	bh=RBUAs+nBykVK5wTeMHJgFI+3MpUIhp73ODhGtybw7QM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U6Wdzc4MPQXagZ7vXWe26jXW4CARsSViCil9jTlR4my//81pelEAfBQYONjHq+vOVwHh42rT0TX/vc1NGqhMbENAq/W6lK2cbB+uXuCFucHzP+xg9C2G04N1wLh/Q91taBbAZotpRw9cZHjszRWRb0vj5z5PMclU5xL7aH8315U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS/4N9DJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294F3C4CED0;
	Fri, 27 Dec 2024 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735296591;
	bh=RBUAs+nBykVK5wTeMHJgFI+3MpUIhp73ODhGtybw7QM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JS/4N9DJ1Tak9YNrnncNbkVqWXL23p//2SYPw2XV3wQjnImjeZatRJN7EYDLsV+CN
	 LX156skaaqXupwMz+hBZvrOsNCNFBhkAriTv/qbU6mdv5+B+Y/oy1+0rmkBNdVXzIo
	 XMaDTRjBz7Eh9NEHQ/knppceUuIWOJJIWvlxAJsWhfGbVa/Qe+xJjDTHdHyG+WLzfL
	 5jE5Jhpvt/4TCp+2LU+a+S8u2w2Bd9Qf7MQLrF6qRhAiX28ihbajKTGRUfT+yrQZxu
	 lX6Xb4FA1ySFmizd9UlBXsmQlNHobRq1z5vUMghzg0VzPL43XEga0yIC8Gx1PiE9Bq
	 Kf081AzYuw8YQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Dec 2024 12:49:46 +0200
Message-Id: <D6MFAUNRJ8GX.22HLDPXR7EZ5W@kernel.org>
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
To: "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241227060053.174314-1-jarkko@kernel.org>
 <20241227060053.174314-2-jarkko@kernel.org>
 <CAMj1kXFB6NL4EASV9_XeRM=iYaoVHQks0pXyVt2tGSQbD-St6g@mail.gmail.com>
In-Reply-To: <CAMj1kXFB6NL4EASV9_XeRM=iYaoVHQks0pXyVt2tGSQbD-St6g@mail.gmail.com>

On Fri Dec 27, 2024 at 10:43 AM EET, Ard Biesheuvel wrote:
> On Fri, 27 Dec 2024 at 07:01, Jarkko Sakkinen <jarkko@kernel.org> wrote:
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
> > Earlier fix does address the warning but wastes 16 MiB of memory. This
> > finalizes the fix.
> >
> > Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
> > Tested-by: Andy Liang <andy.liang@hpe.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Where are patch 1/2 and the cover letter?

https://lore.kernel.org/linux-integrity/20241227060053.174314-1-jarkko@kern=
el.org/T/#mc34835f6d6f946c50a580f895f24b7b1dab85204

You did not request a cover letter, and I did not think it was
really necessary. I can do it for next version on request.

BR, Jarkko

