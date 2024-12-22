Return-Path: <linux-integrity+bounces-4459-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42B99FA86A
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 23:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1DF16531F
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Dec 2024 22:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CD1189F2F;
	Sun, 22 Dec 2024 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgAhT+bC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DECE632;
	Sun, 22 Dec 2024 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734905871; cv=none; b=NZjnoRv2JIHGzLSwlfo5g5IXpxKXqJQGpfB5nWoJ22GHHKQRn7ecuDLrCCrQ1NjHgLCBdbvhmIGtrR8bcXq9WrOfMx57JzxKRHn0T8GfirJKyHN4vDkI5goKgvI5gA0KDigXKg8hn28vb6UIUOYZBBJjG67aJAbOAnmyJbl6QEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734905871; c=relaxed/simple;
	bh=kZq0kvqMDNMRIJh8QdbpJF2Fil+/zv42OPU3jk4xcW0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cb/LKdR1dBmc62VL6/d27jHBtlPEguL7MMSQmybDdbufAnv/gFnvMfrzI54JhsvqEBbmZphlRuaJp5qrPpCN6Vws1mOmY0g40Yy7ZGwk0NVvujDZIjY/qDfluePgUCU7Fe64jLf33KBALn/klK9SDYxDMfIhdS6iDduHsOjFC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgAhT+bC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54AAC4CECD;
	Sun, 22 Dec 2024 22:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734905870;
	bh=kZq0kvqMDNMRIJh8QdbpJF2Fil+/zv42OPU3jk4xcW0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=AgAhT+bCxujWSlJEb7Lwr75XVfW/+AWwvlmqu9e4JGEpN9FcMdxN4b061I3KXHK1H
	 tpvTf353rguO7wgedMKDN3BI0pCz+KJv6G7oiDCdY/aVY9kW4UUaNHrHHy3/AQq05S
	 ze5gkaqutnArDUVZOmlZyqrR0TBXZDm/0GEtjP/xOfZfoP4RfiwZZnO9iOYsCUIjQH
	 SBhB7kdsVdPn/lUA9pEK+fi4PCxzS03EO5JxWhKtH1DUgDJYjYctZ2HbB6ryM/EUyx
	 Ign1YRgABKNqGiZWdoirmb8cldKczfpwONJ4zI7wucpHNTsWh6SfpzPiiH9hlJ5i2E
	 kf5uRDdP6W99Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Dec 2024 00:17:45 +0200
Message-Id: <D6IKSVZR56HD.3MZHMZMHRU85D@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Joe Hattori" <joe@pf.is.s.u-tokyo.ac.jp>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Al Viro" <viro@zeniv.linux.org.uk>, "Andy
 Liang" <andy.liang@hpe.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>, "Mimi
 Zohar" <zohar@linux.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Jarkko
 Sakkinen" <jarkko.sakkinen@iki.fi>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241221113318.562138-1-jarkko@kernel.org>
 <CAMj1kXHPpz2sH_MSjJ3wRP64tB2pSZJDUoMv4uKXh-HpgHWfvQ@mail.gmail.com>
 <fc11e26d9a202d60a56403af9bd0bae4bd3a852f.camel@HansenPartnership.com>
 <D6HNHJM9L4BS.MNNTVW049NZJ@iki.fi>
 <e8037b6dd77c3105ac94e0fe68aad39e9f3b9656.camel@HansenPartnership.com>
 <D6IBZOIZPHG9.33MA1XLBELFNF@iki.fi> <D6IC7BH3A75U.31VJX6T6QRKKI@kernel.org>
 <56aa08af3da583366ca3053f51ec5a36ac61a386.camel@HansenPartnership.com>
In-Reply-To: <56aa08af3da583366ca3053f51ec5a36ac61a386.camel@HansenPartnership.com>

On Sun Dec 22, 2024 at 7:41 PM EET, James Bottomley wrote:
> On Sun, 2024-12-22 at 17:33 +0200, Jarkko Sakkinen wrote:
> > On Sun Dec 22, 2024 at 5:23 PM EET, Jarkko Sakkinen wrote:
> > > On Sun Dec 22, 2024 at 5:00 PM EET, James Bottomley wrote:
> > > > If event logs grow to greater than KMALLOC_MAX_SIZE then
> > > > absolutely it makes sense to map them instead of copying them.=C2=
=A0
> > > > But we'd have to do that for all event log locators: ACPI, EFI
> > > > and OF, because event log size should be independent of the
> > > > mechanism used to locate it.=C2=A0 So, even as a long term fix
> > > > (assuming we think there's a possibility of logs expanding by
> > > > 50x), this patch doesn't do the right thing because it only maps
> > > > ACPI logs.
> > >=20
> > > Because we have a test target only on ACPI where this happens fix
> > > should still fix only ACPI. It's not hard to reiterate this but=20
> > > precursory iteration is a bad idea.
> >=20
> > Also, "event log size should be independent of the mechanism used to
> > locate it" is a sentence that is sky high too abstract to say much.
> >=20
> > I don't know what it means to be frank.
>
> event log size means the number of bytes from the beginning to the end
> of the event log.  Since the event log is created by the pre-boot
> environment, there is a convention for how to communicate this
> information from pre-boot to the kernel; this is the mechanism used to
> locate it.  We decode three mechanisms: an ACPI table, an EFI table and
> an OF entry.
>
> The pre-boot environment generating the event log is supposed to
> conform to the TCG standards for what events it contains; none of the
> entries depends on the mechanism used to locate the log, which is why
> the size also can't depend on the mechanis.  There are many optional
> events, but even if the pre-boot took a maximalist approach the most it
> could contain is a couple of hundred entries.  The variable entries are
> mostly small but several types can contain device paths or
> certificates, but even if you allow a 10k size for each entry, that's
> still at most 2MB.  So I think if a pre-boot declared log area goes
> over KMALLOC_MAX_SIZE (4MB on x86) it's safe to truncate the area
> because the log will never fill all of it.
>
> The corollary is that if we ever did find an actual log over 4MB, then
> the EFI and OF mechanisms used to locate it would also fail in the
> kmalloc, which is why KMALLOC_MAX_SIZE is the correct cap for the
> declared size.

Have you verified this with the failing system?

>
> Regards,
>
> James

BR, Jarkko

