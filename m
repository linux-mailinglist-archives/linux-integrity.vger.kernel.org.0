Return-Path: <linux-integrity+bounces-2511-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06AE8CAFE9
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DA41F242F9
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 14:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1747C6C1;
	Tue, 21 May 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmdET+5t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA576C76;
	Tue, 21 May 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300177; cv=none; b=W8vL9R1C/6O/9LOWq/8AHpAasuKYjF331Ly0ZY2dOWGDMsVofC4c7mvXEF001bVjHWILkbq6u1h1TV+3oBQpucy5csqYzDjso5v/rCP9qWk2VxZ9RTbs4E/ZMHHdlRXlOlvHW09anjx5OHcVnLzFaNCSqnHVHxUuBDj5LhUCqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300177; c=relaxed/simple;
	bh=aWRjRYyj0oV0kFPv0quzlPGQfHQz7Cu3X7PZU1DVrCU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OTVynAdSMkhVMLPD4UAWjAv6thU8VHEuUfxe61ryhOfh9B2NJ4Ti9HwvJT9sALh7gcyAPw1o526IpRuKPUVKx1EqJIoXSxiTwrFcj3THNB38hPgfAAs/Vwt4T6k6SqtypTnX+suFDKH/a4KOj7MK995C/JqKAmSnxD40s5iQzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmdET+5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7869DC32786;
	Tue, 21 May 2024 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716300177;
	bh=aWRjRYyj0oV0kFPv0quzlPGQfHQz7Cu3X7PZU1DVrCU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dmdET+5t3uPnYJ/vwIWRFi2gqCTEs5nScXgJ5gWgc6ZfZtLeRpGSmhJ9T2NXVbe+i
	 H/pDPK817DPj2UJfvIO7/LR4YyALUC0tuIW/CdLZIHKYIuiu8V6ymYI41tHnGvjxNn
	 MiRPXYHBFgoDSg00gLYkc0YSl/Bq+9VjSaqTbMcjpkL70QBiZlAL1FMbWAWToN/e/o
	 /+vYi3kfMwEjebG3O2rUvdqz24aNiNwWSxqDO9Kqona50jnaglOhH4funreJVnbZqw
	 TAnm/cs5Tg2e0OeOi4OeSmwqu95pHdUZFvD1LTIbja1Mptm3wcYdSadZLZVxAHuY8e
	 HXZIklXCZagxw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 17:02:52 +0300
Message-Id: <D1FDMULT5YRK.GZOPJ9FZ325R@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: enable HMAC encryption for only x86-64 and aarch64
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240521130921.15028-1-jarkko@kernel.org>
 <236606947b691049c650bdf82c37324084662147.camel@HansenPartnership.com>
In-Reply-To: <236606947b691049c650bdf82c37324084662147.camel@HansenPartnership.com>

On Tue May 21, 2024 at 4:26 PM EEST, James Bottomley wrote:
> On Tue, 2024-05-21 at 16:09 +0300, Jarkko Sakkinen wrote:
> > Let's be more conservative and enable HMAC by default only for the
> > platforms where it immediately makes sense, i.e. x86-64 and aarch64.
> > This can be relaxed later on, and obviously the kconfig option can be
> > set even if not default on a particular arch.
> >=20
> > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> > Closes:
> > https://lore.kernel.org/linux-integrity/D1FCAPJSYLTS.R9VC1CXDCIHH@kerne=
l.org/
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > =C2=A0drivers/char/tpm/Kconfig | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index e63a6a17793c..19e61dcfcbbe 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -29,7 +29,7 @@ if TCG_TPM
> > =C2=A0
> > =C2=A0config TCG_TPM2_HMAC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Use HMAC and encr=
ypted transactions on the TPM bus"
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default X86_64 || ARM64
>
> My first instinct is to say that devices in hostile environments (like
> IoT) are likely in the most need of this.  However, it is an
> experimental feature, so I would like to debug it first in the
> environments where it's expected to work, which is desktop and laptop,
> so I'm happy with this:
>
> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Thanks! And agreed but usually for IoT device you probably end up
anyway creating somewhat tuned kconfig. In desktop default on makes
most sense for the moment. I'm also willling to consider relaxing
this later on.

Asymmetric key patch set that I wrapped up together over the weekend
was also pretty extensive test. First, it uses HMAC encryption for
communication to make sure that private key is not eavesdropped.

Secondly, it also roots to the null key if a parent is not given. So
it covers all the basic features of the HMAC patch set.

The only actual bug was a non-critical memory leak from v5.13, which
consumes some dozens of bytes per power cycle in a common use case
for trusted keys (PR already sent to Linus).

BR, Jarkko

