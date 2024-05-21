Return-Path: <linux-integrity+bounces-2501-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278DE8CA87F
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 09:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2F91F2253D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9021A4AEE5;
	Tue, 21 May 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpWBGTXV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC17F;
	Tue, 21 May 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275445; cv=none; b=K5nsMzWwaaH/+HjujHqR3n7gWqAFS0Fc+C0GjFO+l3FLDLVyUpBehd0u40TgPnlDqooOesLjzwSfZb4SEFQDizQBlsky3CeZ1bFK7eQLw5sh60SIbOPc1tuivnVGMPeNdoDu88Wo9alb3xQpXrzaAvFkotav9v1aX8zDTUNC+gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275445; c=relaxed/simple;
	bh=g6jdq9Eo2tX9QZqCluaga06jjI3BOxeso2ueEO1aims=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=g+P6I2ZPqVxSdh/XdJN5m7DLWQJO+piiCxrLqadNLx5i6vaS8z7aCd8vDbWe44x5wWF/Aw8HdB+u+m6iJDVqW8fdjwV2J0jHu0mSBBA5sUyyg0p2EdaPuyUjSYS5ynPMKh4ui67ZqivYRig6MMld8L9O0cE9zCPYv1OPFK2UTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpWBGTXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4759CC2BD11;
	Tue, 21 May 2024 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716275444;
	bh=g6jdq9Eo2tX9QZqCluaga06jjI3BOxeso2ueEO1aims=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tpWBGTXV1vLaw5vPfplS928SwDv8FHJ98ii8MQ15vQYYhjBTcWOTQQ269FmbhMiCK
	 wOMAbIoZbAhs9ne9LdGUHcTymNi6+kRAz4G05CcvMkz4/a0ZY7RMvVmbpp2uqLFMuH
	 f3HU8nl6BU2xp+CY/pgQgBynrKizqau/AMD7pWfxfPTBoitilyqPHWiordxGL03W8i
	 ZiXXMqO+gwld2z5EwIKba1lAcrkD3aaSSNpEgyB3exmEmGyHu3icGaaAi9gyyMaTeB
	 Ad6UpOG0yBpU6vP3HRLFSQMbPeJeoEw698tXFt57+jETx/FizONubK+uGrpqS7Cn7q
	 cTjbkCkU/7z3A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 10:10:40 +0300
Message-Id: <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
Cc: <keyrings@vger.kernel.org>, <James.Bottomley@HansenPartnership.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <linux-kernel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Vitor Soares" <ivitro@gmail.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
In-Reply-To: <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>

On Tue May 21, 2024 at 10:03 AM EEST, Vitor Soares wrote:
> Hi Jarkko,
>
> On Mon, 2024-05-20 at 02:51 +0300, Jarkko Sakkinen wrote:
> > Causes performance drop in initialization so needs to be opt-in.
> > Distributors are capable of opt-in enabling this. Could be also handled=
 by
> > kernel-command line in the future.
> >=20
> > Reported-by: Vitor Soares <ivitro@gmail.com>
> > Closes:
> > https://lore.kernel.org/linux-integrity/bf67346ef623ff3c452c4f968b7d900=
911e250c3.camel@gmail.com/#t
> > Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > =C2=A0drivers/char/tpm/Kconfig | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index e63a6a17793c..db41301e63f2 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -29,7 +29,7 @@ if TCG_TPM
> > =C2=A0
> > =C2=A0config TCG_TPM2_HMAC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Use HMAC and encr=
ypted transactions on the TPM bus"
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default n
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_ECDH
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_LIB_AESCF=
B
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_LIB_SHA25=
6
>
> I did the test on my side, and with TCG_TPM2_HMAC set to "n" the time to =
probe
> tpm_tis_spi driver has reduced to:
> real    0m2.009s
> user    0m0.001s
> sys     0m0.019s
>
> Thanks for your help.
>
> Best regards,
> Vitor Soares

Yeah, well overall benefits still weight a lot. Primary keys are
obviously essential for any use of TPM, so better idea might then
just disable the whole TPM if this does not scale.

But as James pointed out in some other response it is not objectively
clear where performance hit is. I guess it would make sense to analyze
how much hmac vs w/o hmac in the pipe costs for TPM commands.

This benchmark could be done in user space using /dev/tpm0.

Anyway, I did not include this to my PR, which I already sent to Linus.
If anyone wants to make kernel command-line option for hmac, I'm willing
to review that (no bandwidth to do it myself).

BR, Jarkko

