Return-Path: <linux-integrity+bounces-2550-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B68CC1EF
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47506281EAC
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF951140369;
	Wed, 22 May 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akaDO4fE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19F13E3F8;
	Wed, 22 May 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383865; cv=none; b=apY/d8DpAJWyqiN9r4bi3BoicDabK4vHLD61yDeDLkKF/Xd4wSs7vUBMwfwXlTovJ1WZp4TxryOV8MgYNjBAfOwImoOz6eSqqDDImyk5WfkegOaCMY4lPydJYjvvniMXsMOISPrl58+bJKOq0VOgr2sa48olGYvt6CHFTvJhqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383865; c=relaxed/simple;
	bh=9rx/Wn4VOE+1payj9isIocDtoq5yGhktRnKyobnWEAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UmJRouTYVbpkMBgEzTvSCzCXygjsMwlmS8Kh3wfQV8gabJrDBQptps0ixRrOwMfu7niWXUrWgtlvfjxHgtw0k1UuDVq0fey1Fe+KZviT/zqTaYQjL6+dXWkltE0Tkm7H+djPD7l/KsgKWU8BvY+1vVpsA97LiX5l4NTO09uUuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akaDO4fE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34dc129accaso761326f8f.0;
        Wed, 22 May 2024 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716383862; x=1716988662; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMZ6at3dgVeGEzsmhwoW+d+af3DEcrgxoTrw2oK+PHY=;
        b=akaDO4fEDxp/upnZTn1sJRppy8BNHNKSE8op+CIjW+Z7uFKmtLp06ByCLT+dW8DezE
         FqgOBTVk6LCQM/yp5HlhU8iPzzUPKWZWvsHnRLoSFCA54ZsTVv4RTQNk6uGu381lFKxb
         kee5mfiql8Y2XjgtMlhWBCrjRbo9L40Y7SDoa4DmcDosSI4/OX2I9STK0OI7dZHUKzPh
         Ab42z7t0XXs8Y+jQhYRrz11CDqNoon1mX4GME++zu+R0EM/4VUTGyjbu0UH1bSkQ3r6o
         KxU7cQ/O30NWTCghasss9In1uj9oJGl2GEz5F4F/O30Farii7c563shz4j9nHr9n+osa
         HrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716383862; x=1716988662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMZ6at3dgVeGEzsmhwoW+d+af3DEcrgxoTrw2oK+PHY=;
        b=ReZt+CLM6eXKeIOpbglMWOlZ/La6L3IyCobi3cARo7jeuSWl3NJPnji0LygR8cN4GQ
         uOqoc9o22gDUUnunmsiLVLKr6lOaDOFYK4nisOfQ5lgm5NqFPtVhPDmXsD/3Nkbo9pEK
         m+hOQN/+bc9ZISJ+o6qy6HWSzSAOLFYxwcgtH5SY/sPD9MGtbTsT6WOTxP8spiVrJB4G
         UyhSbQI/zIG+He+mr8jL1hGVVP0guIIEL8Bz4YrSVVX/zGK7q6/X+keLPtwVX1nC8AA7
         o6IcoxAcp4hZXu27rxMvJClbNWrbcAbL+6Sy39deLPnPTPvOQwlP/KFOZDmzCx4C8KpQ
         +nZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJA9wQ4rSuL6oNjqMMr+6mqI+RJXSLr5bW/M3nSCQA20sQyWN7+0Bwqfjq6XUWK1saBW5XyQzTpzWL9WQxl1hnv1H05Lu2Fhugl5M21sti4yEAkd3sblsj9XoETURsB8i6B323rc7nrz8vtZpb/JA3GAAPrf7ICGOGnJCkdfa6HuzrTRt7VadSXTN3LKW1xdbesS5Z
X-Gm-Message-State: AOJu0YyA3z0gL0WCtsZyhBfaBcxfnvqVVMpXuEJ5p8uIMTPQpSurXE2T
	63Als1QBb+AURW6n3pjy90AihRoqoATZRfdy/D8ls68MqCUMJyoaGa5rCw==
X-Google-Smtp-Source: AGHT+IENxQSgsueJCIdoh6/60K9lkZe+Ckbv5QZ3Xm1QIXAdgndehIS5n+V1FenSAOC7iLXAJWh7BA==
X-Received: by 2002:adf:f7cf:0:b0:34d:12b4:a4b0 with SMTP id ffacd0b85a97d-354d8db6efamr1324361f8f.70.1716383862042;
        Wed, 22 May 2024 06:17:42 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:597:127d:3af6:7529? ([2001:8a0:e622:f700:597:127d:3af6:7529])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacf52sm34671010f8f.87.2024.05.22.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:17:41 -0700 (PDT)
Message-ID: <56e52200bd9ede6bcdcc907d24bd4a3e0dddd24f.camel@gmail.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: Vitor Soares <ivitro@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, James Bottomley
	 <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Wed, 22 May 2024 14:17:39 +0100
In-Reply-To: <D1G5O2Z86E4W.2DHG4QZE2W2JG@kernel.org>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
	 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
	 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
	 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
	 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
	 <D1G5O2Z86E4W.2DHG4QZE2W2JG@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 15:01 +0300, Jarkko Sakkinen wrote:
> On Wed May 22, 2024 at 11:18 AM EEST, Vitor Soares wrote:
> > On Tue, 2024-05-21 at 08:33 -0400, James Bottomley wrote:
> > > On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > > > This benchmark could be done in user space using /dev/tpm0.
> > >=20
> > > Let's actually try that.=C2=A0 If you have the ibmtss installed, the =
command
> > > to time primary key generation from userspace on your tpm is
> > >=20
> > > time tsscreateprimary -hi n -ecc nistp256
> > >=20
> > >=20
> > > And just for chuckles and grins, try it in the owner hierarchy as wel=
l
> > > (sometimes slow TPMs cache this)
> > >=20
> > > time tsscreateprimary -hi o -ecc nistp256
> > >=20
> > > And if you have tpm2 tools, the above commands should be:
> > >=20
> > > time tpm2_createprimary -C n -G ecc256
> > > time tpm2_createprimary -C o -G ecc256
> > >=20
> > > James
> > >=20
> > >=20
> >=20
> > Testing on an arm64 platform I get the following results.
>=20
> OK, appreciate these results. I try to get mine this week, if I can
> allocate some bandwidth but latest early next week. The Intel CPU
> I'll be testing is Intel Celeron J4025:
>=20
> https://www.intel.com/content/www/us/en/products/sku/197307/intel-celeron=
-processor-j4025-4m-cache-up-to-2-90-ghz/specifications.html
>=20
> So if things work reasonably fast with this, then I think we can
> enable the feature at least on X86_64 by default, and make it
> opt-in for other arch's.
>=20
> I sent already this patch but holding with PR up until rc1 is
> out so that there is some window to act:
>=20
> https://lore.kernel.org/linux-integrity/20240521130921.15028-1-jarkko@ker=
nel.org/
>=20
> If I need to send an updated patch ("default X86_64") and rip
> transcrip from below results.
>=20
> But to do that correctly I'd need to know at least:
>=20
> 1. What is the aarch64 platform you are using?

I was testing this on the Toradex Verdin iMX8MM SoM.

> 2. What kind of TPM you are using and how is it connect?

TPM device is the ATTPM20P connect through the SPI at speed of 36 MHz.
The bus is shared with a CAN controller (MCP251xFD), so both mues work toge=
ther.

The dts looks like:
tpm1: tpm@1 {
        compatible =3D "atmel,attpm20p", "tcg,tpm_tis-spi";
        interrupts-extended =3D <&gpio1 7 IRQ_TYPE_LEVEL_LOW>;
        pinctrl-0 =3D <&pinctrl_can2_int>;
        pinctrl-names =3D "default";
        reg =3D <1>;
        spi-max-frequency =3D <36000000>;
};

Regards,
Vitor Soares

>=20
> Obviously if I make this decision, I'll put you as "Reported-by".
>=20
>=20


