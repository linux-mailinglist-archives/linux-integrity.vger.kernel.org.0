Return-Path: <linux-integrity+bounces-3783-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D7999A5BF
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 16:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83B5B223DB
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBADC216A0D;
	Fri, 11 Oct 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWgs/6cU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E995D517;
	Fri, 11 Oct 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655617; cv=none; b=fif3VbSxriujuEM8zPmkjRB0Lu37+59wu7UyDEp/djx9g5BAng8ZqzLhg8nRtJO9vBr4iy3GTGsZAq16JiCPJXkUjyEjOXPnA9J5IdPl08Dsv4++ikR5a1QYyb1zr6/q46trFhgweuSFvoxs6aiTsrYHicj7yR74vMGkcem6b4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655617; c=relaxed/simple;
	bh=ncQFcfAlGgvWxjh5lD1Afh7FFx/abLXslVvenTx17aA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sXyRb/xHfyUljEyyGelZSZ3O/wyoRHuIB9MaYOOs5Ep1waHDzi93eCVXS9g17j44AxXxJz3Oi0t5sEbp0wAm21uCSBLJQGmLM5+M8kv/3PU79e7HpPt4Pi4H/6WDUbBo2zDz9JgQO0CEhXSBBRIHgQG0RlkGOOaAEOWDTwP1Go4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWgs/6cU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C162AC4CEC3;
	Fri, 11 Oct 2024 14:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728655617;
	bh=ncQFcfAlGgvWxjh5lD1Afh7FFx/abLXslVvenTx17aA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bWgs/6cUjeMqPRmlANu/UYQn00ttjfBmBmHXpxo9e7CekiOHot87xexizI1zN8Dwu
	 npNVZZrYdGOAIrlnsrJJn1/6E5mPhGDrMCDt/2qVg4uZ27JF5h5Qu1a4FZJn91rBND
	 jUmaWcZpPhpxtXsRlEG53X8ouGEYejBKDtxTOQAN/dZU4836iKtK/5jl9x7w8x7/ZO
	 NhK1WrE8CdmR8qptn3vU+Udkovfr716T4FZ508S0ysZSU6hnfk+Cb0CjIOm6FYoWjC
	 s3bTnZpCY0JQdRK0dWXLoRUM2cHHyhpFzUvIOZYVRr+ZoF+2dE0MLcoNb3FauT1Ft7
	 P/QCkFx/Cdurg==
Message-ID: <f69e08167d8354db31013018edf064a2876f8d1c.camel@kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com, 
 mapengyu@gmail.com, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe
 <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 keyrings@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 11 Oct 2024 17:06:53 +0300
In-Reply-To: <20240921120811.1264985-1-jarkko@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> This patch set aims to fix:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219229.
>=20
> The baseline for the series is the v6.11 tag.
>=20
> v4:
> https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@ke=
rnel.org/
> v3:
> https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@ke=
rnel.org/
> v2:
> https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko@k=
ernel.org/
> v1:
> https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko@k=
ernel.org/
>=20
> Jarkko Sakkinen (5):
> =C2=A0 tpm: Return on tpm2_create_null_primary() failure
> =C2=A0 tpm: Implement tpm2_load_null() rollback
> =C2=A0 tpm: flush the null key only when /dev/tpm0 is accessed
> =C2=A0 tpm: Allocate chip->auth in tpm2_start_auth_session()
> =C2=A0 tpm: flush the auth session only when /dev/tpm0 is open
>=20
> =C2=A0drivers/char/tpm/tpm-chip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 14 ++++
> =C2=A0drivers/char/tpm/tpm-dev-common.c |=C2=A0=C2=A0 8 +++
> =C2=A0drivers/char/tpm/tpm-interface.c=C2=A0 |=C2=A0 10 ++-
> =C2=A0drivers/char/tpm/tpm2-cmd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +
> =C2=A0drivers/char/tpm/tpm2-sessions.c=C2=A0 | 109 ++++++++++++++++++----=
------
> --
> =C2=A0include/linux/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A06 files changed, 102 insertions(+), 44 deletions(-)

The summarize some discussions:

1. I'll address Stefan's remarks.
2. We know that these patches address the desktop boot.
3. IMA is too slow =3D> add a boot option for IMA default off. I.e.
   IMA will not use the feature unless you specifically ask.
4. Random generation can be optimized a lot with or without
   encryption. Not sure if  I have time to do ths right now
   but I have already patch planned for this.

What is blocking me is the James' request to not include
functional fixes. The problem with that is that if comply
to that request I will have to postpone all the performacne
fixes and send a patch set with only functional fixes and
go all review rounds with that before moving forward.

This is just how priorities go in kernel and doing by the
book. Is that really necessary?

Since I've just started in a new job any patches can be
expected earliest next week. That's why I was rushing with
the patch set in the first place because I knew that there
will be otherwise a few week delay but we'll get there :-)

BR, Jarkko


