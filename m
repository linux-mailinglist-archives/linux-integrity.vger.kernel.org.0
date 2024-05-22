Return-Path: <linux-integrity+bounces-2551-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42AA8CC228
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 15:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C2C1C20B31
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D2D823CA;
	Wed, 22 May 2024 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSCrCvCF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E81E863;
	Wed, 22 May 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384685; cv=none; b=EXL9Pk2R+dGw4FxQY8S0PRlu3AoHqidtjkl6rdg4Nrdn0GGGiOvVFjln6lmU4ICcsCTP9lyZcDA6qVcoY4rGpkSdaiLq+3MhhHlvtxwOLCD18iqU6/BbGNgFsK114b379haw5GkEYl+hLmnxsL1rlKioCDqQQRXw3Xlah9hFr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384685; c=relaxed/simple;
	bh=1dqu49KIhHX03dY2eY4sz5bfwjB0DUIJyZNap3tF754=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNmWEmXO5zJPC4qvsvxTGN71j2r1VBWRkV4cXIeh+mNRd6PLdRKLFGH1IHzzgA0a9S5NjY42BivDEvhyGG95F+ZNX3TD+xhIDEiEqiAgNOxUB6jAQ2NP37I5lFECPz977yqoh+4RQTrZleFODcAXz1Tr3qlKl3cGw+IqU/xRjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSCrCvCF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4202cea98daso7639425e9.0;
        Wed, 22 May 2024 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716384682; x=1716989482; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1dqu49KIhHX03dY2eY4sz5bfwjB0DUIJyZNap3tF754=;
        b=DSCrCvCF4wZaXlGTORjaonaKLTxXwcZ6Xg4C1ZnqJ6M0c0Nba8cccbeIEJycSaJ8pQ
         LvqdEgPeyn6M5kC4ZyxspChXHwpu/3xS66Y/PWs83arTlazGsquXYAaxLeG5xQySJ149
         vofr23C/u5v0ctFZnXfKiHGQ7MSFinYl57ck0kZ1gR38gyoiu5REkWcOapU7puABSuon
         +knhzx2BqjUb5m6BuFKiD3Mg7KnIaftrW/ccuU1QwR1UXwCfe7ktdCnVoK4CYGQpr4ez
         PHlIhgeqriPOQp6XsH4OvdBCRmQF1hoBh+rCom+Y1p/EkOMcRDadCqFT/NiHKINsXik7
         HSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716384682; x=1716989482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dqu49KIhHX03dY2eY4sz5bfwjB0DUIJyZNap3tF754=;
        b=e/RykAo6H+CHROz1BYeucCjVG1TzPNJTdkj7tN2rNsa7uhPsRzcT4kP4O27ixxGrLH
         XUkZv59+gDkAGiTtnkMIOD0l4RFjXARyEEts+aCBUxwsDlgXNPBYbBmwptVEfy/URn/7
         R5W7oMR6Z8Uocb+FjKZimZFye1HCkYdZqVAA4EvHQrM+xOEkbltn/PikJRUCL5DpE0x+
         sj3HEkgPNMTOfwdoOaQKUrd2IADcaGNhnEtCeh9BIdA/fnrqy7qtCFVRPKC6ZgHra0Wn
         sRUJ1M6zBxmH+zHsBf5GlK9KLpoOX8LqcOOmlXhmCRykvsvOSzKLivWSkdXFceVVQtuI
         a1rg==
X-Forwarded-Encrypted: i=1; AJvYcCU5dgUk3SzZj+UqOGCfsDFIxmYd5b9ylCi/F9YBH/7r9yehZd9+1+At41s9us3lmEhbWzoHOstxCywN+B7dultrtazfGrm/MZ5udQnMFzt3qSctOUp6Wj45ILiPVAyGWWWT3aWaHldoT9OWIm4HzgKj1pKA/H5gIkYRodn5X7gWFEG+wbK7weICTn63sOxQUCvly3/N
X-Gm-Message-State: AOJu0YxChrKncCT8g2foW84HmEoSaMYCHlZ8wo+R3Nx74OqHWh5LlQjj
	LMBlzQ7SnoFjYSPXJuy7TgGCnI/kMK/38hYuV2pzXJ9wS4TJthy2
X-Google-Smtp-Source: AGHT+IHvDjyB71F/5YoiFEt7yx1RM6sBzbPAZJyZJH6vwMhYIl3p7lksTQbf9pFsBUP4SzZArROpsQ==
X-Received: by 2002:a5d:6383:0:b0:34d:e598:b716 with SMTP id ffacd0b85a97d-354dababedbmr1388018f8f.67.1716384682226;
        Wed, 22 May 2024 06:31:22 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:597:127d:3af6:7529? ([2001:8a0:e622:f700:597:127d:3af6:7529])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbe43sm34226615f8f.99.2024.05.22.06.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:31:21 -0700 (PDT)
Message-ID: <9098d5912a87cbfaaf0de2fdd041d0c5ac1af1fa.camel@gmail.com>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: Vitor Soares <ivitro@gmail.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, James Bottomley
	 <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Wed, 22 May 2024 14:31:20 +0100
In-Reply-To: <56e52200bd9ede6bcdcc907d24bd4a3e0dddd24f.camel@gmail.com>
References: <20240519235122.3380-1-jarkko@kernel.org>
	 <20240519235122.3380-2-jarkko@kernel.org>
	 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
	 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
	 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
	 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
	 <D1G5O2Z86E4W.2DHG4QZE2W2JG@kernel.org>
	 <56e52200bd9ede6bcdcc907d24bd4a3e0dddd24f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 14:17 +0100, Vitor Soares wrote:
> On Wed, 2024-05-22 at 15:01 +0300, Jarkko Sakkinen wrote:
> > On Wed May 22, 2024 at 11:18 AM EEST, Vitor Soares wrote:
> > > On Tue, 2024-05-21 at 08:33 -0400, James Bottomley wrote:
> > > > On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > > > > This benchmark could be done in user space using /dev/tpm0.
> > > >=20
> > > > Let's actually try that.=C2=A0 If you have the ibmtss installed, th=
e command
> > > > to time primary key generation from userspace on your tpm is
> > > >=20
> > > > time tsscreateprimary -hi n -ecc nistp256
> > > >=20
> > > >=20
> > > > And just for chuckles and grins, try it in the owner hierarchy as w=
ell
> > > > (sometimes slow TPMs cache this)
> > > >=20
> > > > time tsscreateprimary -hi o -ecc nistp256
> > > >=20
> > > > And if you have tpm2 tools, the above commands should be:
> > > >=20
> > > > time tpm2_createprimary -C n -G ecc256
> > > > time tpm2_createprimary -C o -G ecc256
> > > >=20
> > > > James
> > > >=20
> > > >=20
> > >=20
> > > Testing on an arm64 platform I get the following results.
> >=20
> > OK, appreciate these results. I try to get mine this week, if I can
> > allocate some bandwidth but latest early next week. The Intel CPU
> > I'll be testing is Intel Celeron J4025:
> >=20
> > https://www.intel.com/content/www/us/en/products/sku/197307/intel-celer=
on-processor-j4025-4m-cache-up-to-2-90-ghz/specifications.html
> >=20
> > So if things work reasonably fast with this, then I think we can
> > enable the feature at least on X86_64 by default, and make it
> > opt-in for other arch's.
> >=20
> > I sent already this patch but holding with PR up until rc1 is
> > out so that there is some window to act:
> >=20
> > https://lore.kernel.org/linux-integrity/20240521130921.15028-1-jarkko@k=
ernel.org/
> >=20
> > If I need to send an updated patch ("default X86_64") and rip
> > transcrip from below results.
> >=20
> > But to do that correctly I'd need to know at least:
> >=20
> > 1. What is the aarch64 platform you are using?
>=20
> I was testing this on the Toradex Verdin iMX8MM SoM.
>=20
> > 2. What kind of TPM you are using and how is it connect?
>=20
> TPM device is the ATTPM20P connect through the SPI at speed of 36 MHz.
> The bus is shared with a CAN controller (MCP251xFD), so both mues work
> together.
>=20
> The dts looks like:
> tpm1: tpm@1 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "atmel,attpm20p=
", "tcg,tpm_tis-spi";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts-extended =3D <&gpio=
1 7 IRQ_TYPE_LEVEL_LOW>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pinctrl_can2_i=
nt>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <1>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi-max-frequency =3D <3600000=
0>;
> };
>=20
> Regards,
> Vitor Soares

For the sake of clarity, the timing tests were done without CAN enabled.

>=20
> >=20
> > Obviously if I make this decision, I'll put you as "Reported-by".
> >=20
> >=20
>=20


