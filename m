Return-Path: <linux-integrity+bounces-3283-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDD3946B11
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 21:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296B6B21128
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 19:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C2B1B94F;
	Sat,  3 Aug 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJi+O1yT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6DD1865B
	for <linux-integrity@vger.kernel.org>; Sat,  3 Aug 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722713473; cv=none; b=G5RWMR/1xM7OjaT4gLQ0NGr2GVjD3mcXdthnrRxPDnO4jhEJFCeWzxdqmY5V5wE/0AMpl0NhWZeUJ/XRxRwv5zN41hREBCDnjLb5DPr/SD1bATwHKOJYjH7wPq3YAV+HdaSfppwS3YqQxb4ml5As1ngb/zAK4lBC1HD0BVIIUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722713473; c=relaxed/simple;
	bh=onF1rUla5YjN7zAzFjmvOPIAYrAEzS7V6T3zWfAPrA0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ksuQ8pQXCxSHUBWEnd2isKZBTDzM/NG/SqCweuXnOZFwIwp3jWD0V2TY0tFWBQhS5DbNP4acfVGlDUMWfiusRNiXcCuHs0gOIy7S2+5EgRWbBXU+y9Hy39scyBTswvEOVjOTL0/lliMsbCXLRiV5tpm0TDPKHnu+f2blxPgMbsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJi+O1yT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF13C116B1;
	Sat,  3 Aug 2024 19:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722713472;
	bh=onF1rUla5YjN7zAzFjmvOPIAYrAEzS7V6T3zWfAPrA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJi+O1yTW5LN38u6ggJp0MqXDmG1HpFdtPc1VYTlHztDXUKtiq23LPBaO5p6+QopY
	 +olenVAqJCNRdNxNR9dtxiITiPtRhNK2uBbGfEQBnqgx0hnjB5yCVEhBliH+AvSR1e
	 WqTp/XfKaSiMWJ1FavFrKsYL7WqHJIoZiQJPiiCQ2arzXPSwh7J0VrABt3Z+3lFSMl
	 iva1P+Lvqeeq2wSKHHMh8Q8w4eYCWNEulJhvF4yqd9wmUMDWiWh5A7TnPkxsW2OBJV
	 Yc8tjlK5H7d4FZbyF34jCajYG0Hhc655Efj6bSdJsMxKPoG2CcvNu0Jq9xKrXV76Ha
	 XKdU4WiRAMGYw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Aug 2024 22:31:08 +0300
Message-Id: <D36IYI5ZD4VK.2GC6CG6GIUWK9@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Jarkko
 Sakkinen" <jarkko.sakkinen@iki.fi>, <openssl-tpm2-engine@groups.io>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 1/8] tss: Fix handling of TPM_RH_NULL in intel-tss
X-Mailer: aerc 0.18.0
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
 <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
 <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
 <53a91b9ebbc500e928eadf2112d3ecb5631c56c1.camel@HansenPartnership.com>
In-Reply-To: <53a91b9ebbc500e928eadf2112d3ecb5631c56c1.camel@HansenPartnership.com>

On Sat Aug 3, 2024 at 8:51 PM EEST, James Bottomley wrote:
> On Sat, 2024-08-03 at 20:08 +0300, Jarkko Sakkinen wrote:
> > On Fri Aug 2, 2024 at 11:25 PM EEST, James Bottomley wrote:
> > > Now that we're going to be using the NULL primary to salt sessions,
> > > the Intel TSS shim needs fixing to cope with this.=C2=A0 In the Intel
> > > TSS, there are two internal handles representing NULL: ESYS_TR_NONE
> > > and ESYS_TR_RH_NULL.=C2=A0 We translate TPM_RH_NULL to ESYS_TR_NONE
> > > because
> >=20
> > Can you split this into two paragraphs.
> >=20
> > I'm lost why it has two representations.
>
> Well, I actually have no idea why the Intel TSS has two representations
> for *every* handle: an internal one (specific to the TSS) and an
> external one that everyone uses, like 81000001 or 40000007. As far as I
> can see it just adds pointless complexity to the coding.  The IBM TSS
> only has one, so for code which works with both, the shim has to
> transform between internal and external handle representations before
> sending the command onward to the Intel TSS.

Is it possible to address this complexity and move into a single
representation? I.e. use external presentation all the way.

>
> Even more mysteriously the Intel TSS has three representations for the
> NULL handle: an internal one, an external one (40000007) and one you
> use for an empty session (ESYS_TR_NONE).  The IBM TSS uses TPM_RH_NULL
> for all three so you can't just translate from external to internal you
> have to know if you're using the handle for a session or a hierarchy as
> well.

Same question applies to this too.

> James

I'm doing my own TPM2 stack with Rust, which just re-implements the
functionality of my old tpm2-scripts and tpm2.py module as nice small
app called tpm2-cli.

It will be more use case based interface than than protocol spec as
a software interface. Main goal for now is to get this whole flow
into it (with varying parameters for the key) as single function:

tpm2_createprimary --hierarchy o -G ecc -c owner.txt
tpm2_evictcontrol -c owner.txt 0x81000001
openssl ecparam -name prime256v1 -genkey -noout -out private.pem
tpm2_import -C 0x81000001 -G ecc -i private.pem -u key.pub -r key.priv
tpm2_encodeobject -C 0x81000001 -u key.pub -r key.priv -o key.priv.pem
openssl asn1parse -inform pem -in key.priv.pem -noout -out key.priv.der

BR, Jarkko

