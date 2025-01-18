Return-Path: <linux-integrity+bounces-4589-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8921A15AC1
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2025 01:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4953A432B
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2025 00:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759FADF59;
	Sat, 18 Jan 2025 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItqBaSxV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351E15E97;
	Sat, 18 Jan 2025 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737161987; cv=none; b=iRIwMyEsF04pSu0NOVG1mo4eqYeSxq5mS20+xXLNBlUXfAZE0wUa5nsJSyAwvnUz+bXjdxqbjcNIDMt/Rc19mFZYX4vKGaPzEZ5wC/NYnYXbg63RiUacvXWZy/GnbPATtjj7Hl70joUWXjldnavJ9OJgaUkLl0U9liAjWN+R7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737161987; c=relaxed/simple;
	bh=uaEJZevoStR+cPvxphxQmN77PF6t7QNpu/VGdhXGNPk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DKyvgtuReTT59fIGgBr2ANluKox4RTN9qRoUwl8O6acTEMqro4j1y8v6N/rMQSVfWlcA01yQUCRdZl53u9voeUPyLe60zgOgO5hU5SRfHHAKPR/kkP1rzj47R0WNJWL46k+MkCn2H/089ZqalfpdVwzEv04T0P7Qzg4iDNwroT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItqBaSxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1A4C4CEDD;
	Sat, 18 Jan 2025 00:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737161986;
	bh=uaEJZevoStR+cPvxphxQmN77PF6t7QNpu/VGdhXGNPk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ItqBaSxVUU9XHkoXX3hnFj/W2EaUts8cezDfAOW+ov9foW/4TT+cP330s6fZqJU/Y
	 Ub5fO6XAaD3jG35OMbPyUV6KkPN7wuYAwE4UX5+mCzmFZAh2AmiGnT2phyMM7WTBo+
	 sMW3Mzwck8yRvAXbXgxRUrH1liapqttjE7QbjlCJGtadHkWTXegH+f7uig2C6TkRp7
	 51RtFMmbQQNgSk4VJS6U6cBA/tYauqN/cEvXEvKOhMbFmCfqv+GbEuz2trOSTdoSsv
	 sW5eMlqMQycwwwgG6ZhZXkO/2NceE5Q6uArXm6wEmqKKuZtdbW/DH8/67fiodrtrKX
	 bjtqSkBKCDYlA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jan 2025 02:59:41 +0200
Message-Id: <D74SJ1CDKZRF.A6XC66V9UT1U@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Stefan Berger" <stefanb@us.ibm.com>, "Reiner
 Sailer" <sailer@us.ibm.com>, "Seiji Munetoh" <munetoh@jp.ibm.com>, "Andrew
 Morton" <akpm@osdl.org>, "Kylene Jo Hall" <kjhall@us.ibm.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <stable@vger.kernel.org>, "Andy Liang"
 <andy.liang@hpe.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.18.2
References: <20250115224315.482487-1-jarkko@kernel.org>
 <87cyglsjdh.wl-tiwai@suse.de> <D74DJJTER7IQ.3KT9ECIRLN0JW@kernel.org>
 <878qr9shga.wl-tiwai@suse.de>
In-Reply-To: <878qr9shga.wl-tiwai@suse.de>

On Fri Jan 17, 2025 at 3:22 PM EET, Takashi Iwai wrote:
> On Fri, 17 Jan 2025 14:15:05 +0100,
> Jarkko Sakkinen wrote:
> >=20
> > On Fri Jan 17, 2025 at 2:41 PM EET, Takashi Iwai wrote:
> > > On Wed, 15 Jan 2025 23:42:56 +0100,
> > > Jarkko Sakkinen wrote:
> > > >=20
> > > > The following failure was reported:
> > > >=20
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
> > > >=20
> > > > Above shows that ACPI pointed a 16 MiB buffer for the log events be=
cause
> > > > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Addres=
s the
> > > > bug with kvmalloc() and devm_add_action_or_reset().
> > > >=20
> > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > Cc: stable@vger.kernel.org # v2.6.16+
> > > > Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> > > > Reported-by: Andy Liang <andy.liang@hpe.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219495
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > >
> > > One of my previous review comments overlooked?
> > > The subject line still doesn't match with the actual code change.
> >=20
> > True, thanks for catching this.
> >=20
> > >
> > > I guess "Map the ACPI provided event log" is meant for another patch,
> > > not for this fix.
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/=
commit/
> >=20
> > I edited also the description a bit. Does this make more sense to you
> > now? (also denote any additonal possible tags)
>
> Yes, looks good.  Thanks!

Can I add your reviewd-by? Just asking so that tags will be what is
expected.

>
>
> Takashi

BR, Jarkko

