Return-Path: <linux-integrity+bounces-3787-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEFD99A8D6
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634771C214A6
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D347198E7F;
	Fri, 11 Oct 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgzqtYBg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19916F27E;
	Fri, 11 Oct 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663918; cv=none; b=pTRQZdFmu4ErS/Zh+pdwzfb0lG+KyDrZ6UvNmKr5SSkWO6Yx139kji6djcdScZJ088yRo0dfnxy/svM3fxu192JLgMWOM60DIoNL/KNGJL5CAlQT4VWO5+qCVbRrmBDuOO/WflkC8jjGiSNTb8qpZW/X1kshQb4O7Lzq/WXVPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663918; c=relaxed/simple;
	bh=PSowsYUnEt8+Zd9X4kz6lE7OQ9d02XdVzPB5TaT8Kj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtMWwDFgI3X4OCwg2GJ/5ge6CgKMTEsOgPzu28nRgLyRLnySWW1eiFvgHxYKOPoohcaaKh7J2H5lUXM0tqOPMSz/fcou9Q+vRSJGx+y+xiIg3sWFOl9AbJYMRwkoUJlpWBlNl2qlC5EgsHopAHPvbRfBbhgEacPMONYAb/CJyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgzqtYBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E82FC4CEC3;
	Fri, 11 Oct 2024 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728663917;
	bh=PSowsYUnEt8+Zd9X4kz6lE7OQ9d02XdVzPB5TaT8Kj8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LgzqtYBgasWt59fDu/K40e5tM4D/fzt8CsN2pPM6dr5Jk2wm+IGGuI3ab1WZLL8OJ
	 H8MOBsuNzcjlzodKEGS0yr7reh6g72uevIOcDcxqBSksLZqhc6axinjGTQYbNeb6qi
	 K34VrjuFgUTLalWxNrglsVhudBXnhbphq6LQEwJith0ayMIFVG3x8pEJJH90n2uWdA
	 gcyicBHMpvWOLX+vvxDjPh/eFLlqE1bt18qTqoGhmZWrg5b3QUIvs1ZH1RllKxQyW8
	 tG1TCaJocb/LGQwoB/lKzNe7TCxbzIgFfDSoAe57A39zbBS6oWszISviJiFdV9Guq4
	 r+/WzQG9WpmKw==
Message-ID: <a0068539450a81fdd363d078521cb3822c54608b.camel@kernel.org>
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
Date: Fri, 11 Oct 2024 19:25:13 +0300
In-Reply-To: <21b46f4882f0b9b12304d7786bd88f33a7ad2b97.camel@huaweicloud.com>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <f69e08167d8354db31013018edf064a2876f8d1c.camel@kernel.org>
	 <21b46f4882f0b9b12304d7786bd88f33a7ad2b97.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-11 at 18:10 +0200, Roberto Sassu wrote:
> Initially, I thought that maybe it would not be good to have an event
> log with unmodified and altered measurement entries. Then, I tried to
> think if we can really prevent an active interposer from injecting
> arbitrary PCR extends and pretending that those events actually
> happened.
>=20
> If I understood James's cover letter correctly, the kernel can detect
> whether a TPM reset occurred, but not that a PCR extend occurred
> (maybe
> with a shadow PCR?).

We can detect TPM reset indirectly. I.e. null seed re-randomizes
per reset.

>=20
> Second point, do we really want to take the responsibility to disable
> the protection on behalf of users? Maybe a better choice is to let
> them
> consciously disable HMAC protection.

So when IMA is not used already with these fixes we get good
results. And for tpm2_get_random() we can make the algorithm
smarter. All in all we have good path ongoing for "desktop
use case" that I would keep thing way there are or at least
postpone any major decisions just a bit.

For server/IMA use case I'll add a boot parameter it can be
either on or off by default, I will state that in the commit
message and we'll go from there.

>=20
> So, maybe we should keep the HMAC protection enabled, and if the
> number
> of PCR extends is above a certain threshold, we can print a warning
> message in the kernel log.
>=20
> Roberto

BR, Jarkko

