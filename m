Return-Path: <linux-integrity+bounces-2995-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B4C927008
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 08:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB512844F9
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2024 06:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3191A0AE1;
	Thu,  4 Jul 2024 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWXH+V1t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FB51A08D3;
	Thu,  4 Jul 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076026; cv=none; b=D1ZLYkF19MUOfLm9clupd3LMNCuukDatEu71AD2D7leo3zhHiirItDXt3dvRN3SbCMCBe92Vpl7AwKH+vVtsGWrZG32JgaFiRcEf5/85Sjv7KkIUN4AR5KMCus0F4cZYszf79F41PWTfcGjXPIcPaI6U9nZLXUa9MMIp9gYkJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076026; c=relaxed/simple;
	bh=XpBKHREWWrOpAVmrr3cqwhW8eNYjs451N1BNIUwh8YU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tDzsifMCj+EANZJTPEmI1UnP8YhCDkKAOS0wuAfy/bD2r5nldf78CxCSFqKSVHui1YTmEO6/iBTcB2guatk0p/CJAnVjmObAkh4MQfwq5mPD310WG5Wj79fwtVuFeBR7Jj2Zf/X2rQVLDwu355W3QUXINYdKPTIGelgxM1KHxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWXH+V1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D89AC3277B;
	Thu,  4 Jul 2024 06:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720076025;
	bh=XpBKHREWWrOpAVmrr3cqwhW8eNYjs451N1BNIUwh8YU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hWXH+V1tdGCGnN4DgKdjCeM9e0YJA1R0ng/htnVdsG8xll7rxBCIdOak2G8X8yi0b
	 CMyNXGqDxbtHyCzxWQpcZTYUJ7MuE1Zs82XKDlKtQO6H3wIHSY16NKDvb7YuhulteS
	 WSwY/Nm7Ocrzp6kTvWVNB7ZBs98khoMo/09ZxWxyTXkf1/DM6I5dQ5/tERbXp/iwSL
	 pATwz3S1tiXyiykumhHwEvyZ+EddLWch2p0bxD+NUsWZbMMQu2QTfjTqaf/gI12+cU
	 i3L+9+K9/uJfLYGO75OPIesYF8DutZQRocLXgI0wqCvo/uhTQe9k1u7NtHUpdgusgx
	 Um4mb9sOheKIA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 09:53:40 +0300
Message-Id: <D2GK2755HE3O.2IGY7W4280Z90@kernel.org>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, <stable@vger.kernel.org>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Mario Limonciello"
 <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] tpm: Address !chip->auth in
 tpm_buf_append_name()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240703182453.1580888-1-jarkko@kernel.org>
 <20240703182453.1580888-3-jarkko@kernel.org>
 <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
In-Reply-To: <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>

On Wed Jul 3, 2024 at 11:11 PM EEST, James Bottomley wrote:
> On Wed, 2024-07-03 at 21:24 +0300, Jarkko Sakkinen wrote:
> [...]
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index 21a67dc9efe8..2844fea4a12a 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -211,8 +211,8 @@ struct tpm_chip {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 null_key_name[TPM2_N=
AME_SIZE];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 null_ec_key_x[EC_PT_=
SZ];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 null_ec_key_y[EC_PT_=
SZ];
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm2_auth *auth;
> > =C2=A0#endif
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm2_auth *auth;
> > =C2=A0};
>
> Since auth should only be present if CONFIG_TCG_TPM2_HMAC this is
> clearly an undesirable thing to do.  I think you did it because in a
> later patch you want to collapse the hmac sessions to use a single
> routine, but you can make that check with the preprocessor __and
> function defined in kconfig.h:
>
> if (__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth))
>
> Which will become 0 if the config is not enabled and chip->auth if it
> is, thus eliminating the code in the former case while not causing the
> compiler to complain about chip->auth not being defined even if it's
> under the config parameter.

I did not know about '__and()'. Thanks I'll use this!

>
> James

BR, Jarkko

