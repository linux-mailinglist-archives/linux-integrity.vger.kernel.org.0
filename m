Return-Path: <linux-integrity+bounces-3796-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C74299B32A
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Oct 2024 12:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65867284701
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Oct 2024 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609DA1547ED;
	Sat, 12 Oct 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS87PGIk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B626136330;
	Sat, 12 Oct 2024 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728730572; cv=none; b=qJMjc4gi5ask7ZS2Xoa/Rs0GQXPKP3w0iE+fAlFHx/FXe4P38kiDCPBNQs86nLSRMZZzQ3XYNWxHRnQQtBg3FDQeixNxImiMZ7jypg6Y+b1VsQBhALPDLQzViYigXa7acpSxUof38ZK3BHDIFIJPenA6Lmkxmhrk/WIIBCzGc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728730572; c=relaxed/simple;
	bh=zszbQppB/+KNbhCJ4wgFW64onx8DPG8wPG1jytjeIgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fXin4Axh+3SA1HZt/ZHD9W4rANtjWTWIXk7aa38dp5LtAUHO+cM2ApfPZxX8xHaIkfgcGvu1hm7s/SzCLFZsg/D1Z65ZTY8xxbK0RYTEbpJNzCsQLhup5c4PPGmOaJTvMlOcWozJmzGiCyR7sqNoPKJHfc3WWfLcRaBN/JBEMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS87PGIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE0BC4CEC6;
	Sat, 12 Oct 2024 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728730571;
	bh=zszbQppB/+KNbhCJ4wgFW64onx8DPG8wPG1jytjeIgw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nS87PGIkc5IhYumerFajBV4hZKRaSXPoRKJ7W1fGupvQ6Cb3O0dh7/qkvmgja1Ijz
	 QXaVyVUOQecLadb3lk6x78vzejD+swZ5RTU5QkVa8gRhXekjKxCIgDzsthZpjxmrF1
	 /fxACYTT/flIlgofC2P27jC5TMOINGXFHd7BncuZTry2wHtlSKAt+UEsMqBZA51kXm
	 YyP40gipIWvz0tKZ+lkZO82xIBquTgAyLdRgO5Cfz8ohWumYXE7EwfEkUNu1mCcpu4
	 OcsEH9FYvDA655B4uLGyyOAwhwElEY27Y4JC5HRAhHrekh2PrwDika2qRBUat/wAgb
	 W/a/jQRnShjDA==
Message-ID: <e70c55c6edea2a5be7786ee04a85778193237444.camel@kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com, 
 mapengyu@gmail.com, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe
 <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 keyrings@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 12 Oct 2024 13:56:07 +0300
In-Reply-To: <a0068539450a81fdd363d078521cb3822c54608b.camel@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <f69e08167d8354db31013018edf064a2876f8d1c.camel@kernel.org>
	 <21b46f4882f0b9b12304d7786bd88f33a7ad2b97.camel@huaweicloud.com>
	 <a0068539450a81fdd363d078521cb3822c54608b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-11 at 19:25 +0300, Jarkko Sakkinen wrote:
> On Fri, 2024-10-11 at 18:10 +0200, Roberto Sassu wrote:
> > Initially, I thought that maybe it would not be good to have an
> > event
> > log with unmodified and altered measurement entries. Then, I tried
> > to
> > think if we can really prevent an active interposer from injecting
> > arbitrary PCR extends and pretending that those events actually
> > happened.
> >=20
> > If I understood James's cover letter correctly, the kernel can
> > detect
> > whether a TPM reset occurred, but not that a PCR extend occurred
> > (maybe
> > with a shadow PCR?).
>=20
> We can detect TPM reset indirectly. I.e. null seed re-randomizes
> per reset.
>=20
> >=20
> > Second point, do we really want to take the responsibility to
> > disable
> > the protection on behalf of users? Maybe a better choice is to let
> > them
> > consciously disable HMAC protection.
>=20
> So when IMA is not used already with these fixes we get good
> results. And for tpm2_get_random() we can make the algorithm
> smarter. All in all we have good path ongoing for "desktop
> use case" that I would keep thing way there are or at least
> postpone any major decisions just a bit.
>=20
> For server/IMA use case I'll add a boot parameter it can be
> either on or off by default, I will state that in the commit
> message and we'll go from there.

Up until legit fixes are place distributors can easily disable
the feature. It would be worse if TCG_TPM2_HMAC did not exist.

So I think it is better to focus on doing right things right,
since the feature itself is useful objectively, and make sure
that those fixes bring the wanted results.

BR, Jarkko

