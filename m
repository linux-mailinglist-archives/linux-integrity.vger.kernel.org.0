Return-Path: <linux-integrity+bounces-4530-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94082A049DB
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2025 20:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB881887F91
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2025 19:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF7E1F1902;
	Tue,  7 Jan 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDJ85qzI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958BC18A6C0;
	Tue,  7 Jan 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276755; cv=none; b=cGsMsOw0OYCn0sWE50GVOeh5anWSrIUXGXrMSDUe3owdjMy6EvmZcfpWA6qnIu5U+ZRlnOe2pI/eoc+rlaoUwTa8pkGcRM0lZSmcP9ke71UkNWmrf2l132F4lvlbmdOXTvLEl4wMvo9UedzEACKomV5MmbOCQDbff39H1wfA1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276755; c=relaxed/simple;
	bh=Qc3NO8CVSvw801no+W/pjUNNIPSVxuMuFvfEKQJxY8M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=vACp2nydiavS8EFaohfr3Znbhi80BJ7D3/Ruu2sMjY5YH3XkiKVMnuWY8O9jobG8zYJz5fiVnU0xMG43aA5c+5wVsJ2IK2JY9NtFdivntCLIXoKkeMOxj9A4qvGI/k2Yefwcw2Jn5S+FgQp4CHnxR0X/AjYugSTyPxDiWZKwACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDJ85qzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49ACC4CED6;
	Tue,  7 Jan 2025 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736276755;
	bh=Qc3NO8CVSvw801no+W/pjUNNIPSVxuMuFvfEKQJxY8M=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=rDJ85qzIulykAe6NU1pJ0nCrtKixyTiFdD2sRkbQNzC2hjj83xr3wECSGQiAgvBVS
	 MpVZvAluhlx8fNZPqcse6wSy1d6DM5JgeokxFIobU+SjB+TNuZ1zOoZskrpc7sX1Su
	 JPi87yDVc7zhG0ArOXZ4PkFlJn6k+m/2WPNIXVrFpWl25HwVXLelaGcU8rAivos8Q4
	 sLgDsTZXVcLcd59jpZ8q1iA8VMqFFXqTEBGevoqW6sGfvodpsA8O0kQ/2FvKY2fwzI
	 KJ5IT895yVTE9pCsli1+Vdf/8yPgD8fxVMyDgTsMe51E59dbPr4XZBEKrU0V5DWDJu
	 zi34AiEHdMSVA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jan 2025 21:05:50 +0200
Message-Id: <D6W2QNTD1MB0.2NQ94GSL1TA7@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Gstir"
 <david@sigma-star.at>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "James Bottomley" <jejb@linux.ibm.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: dcp: fix improper sg use with
 CONFIG_VMAP_STACK=y
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241113212754.12758-1-david@sigma-star.at>
 <CA61EE6A-F2D5-4812-96D4-4B1AF3B8B3ED@sigma-star.at>
 <D6W2QCDWF7DN.UN4NFTJ0ESS5@kernel.org>
In-Reply-To: <D6W2QCDWF7DN.UN4NFTJ0ESS5@kernel.org>

On Tue Jan 7, 2025 at 9:05 PM EET, Jarkko Sakkinen wrote:
> On Tue Jan 7, 2025 at 2:56 PM EET, David Gstir wrote:
> >
> > > On 13.11.2024, at 22:27, David Gstir <david@sigma-star.at> wrote:
> > >=20
> > > With vmalloc stack addresses enabled (CONFIG_VMAP_STACK=3Dy) DCP trus=
ted
> > > keys can crash during en- and decryption of the blob encryption key v=
ia
> > > the DCP crypto driver. This is caused by improperly using sg_init_one=
()
> > > with vmalloc'd stack buffers (plain_key_blob).
> > >=20
> > > Fix this by always using kmalloc() for buffers we give to the DCP cry=
pto
> > > driver.
> > >=20
> > > Cc: stable@vger.kernel.org # v6.10+
> > > Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption=
 key")
> > > Signed-off-by: David Gstir <david@sigma-star.at>
> >
> > gentle ping.
>
> It's done, thanks for reminding, and don't hesitate to do it earlier
> if this ever happens again.

I.e. I applied and will put to my PR.

BR, Jarkko

