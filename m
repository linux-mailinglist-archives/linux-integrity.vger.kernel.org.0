Return-Path: <linux-integrity+bounces-2591-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523B8CD921
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DB61C213D6
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0753F41C92;
	Thu, 23 May 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty0u1J3e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB041CFBE;
	Thu, 23 May 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485050; cv=none; b=tWuLHshgP6ZtvUNnavWo1EnDy11Fmaw6B+y1vuyi8auYHLYCoXSKXSCLSVJuTM0GNtBPnHjHML3LEkvGehrSNzlYLu3g21GIoP5QgvSLyXg5uMKVI1YjmQENKar/++OoNk+DIdSn0XgxNx82DpkxHuEvVfD+DRoye5GQPNd2dvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485050; c=relaxed/simple;
	bh=/CGFc+blNV0486kFVxY2jABx+nPgrejqbf4p3JDqyQA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=o3F3x9mEsSgTqXvdnNfpqWbadvc9lYJALFUYU7s7bKuqdAerM2vnbhSJdFvhoJzUW9Uz6zuRuAZ7/UiSff8DVEJwddbWo3tI+J04ngyjVx+KjFlYSbbCHpQUrCIgXommL051W5DGJfQ5xb5uXfhyLlfgFNdVdpLD/GWerBiTq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty0u1J3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133C2C2BD10;
	Thu, 23 May 2024 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716485050;
	bh=/CGFc+blNV0486kFVxY2jABx+nPgrejqbf4p3JDqyQA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Ty0u1J3eEheCXO8OBuK9DmM1ZmA0o6JkNgNnsm/kz6lSqYAYqeA6NCqJ1a7W1lRPy
	 hO4gyLSCLLF/3/ZUOpMertLE9jAd0VDSOwgagho0WYkYmApOX+yeP9uFf8zsbFkFDR
	 q9QW3UuwmTJo0S/eC4T/P5hqnd+4Ac8dKYKtCHOIQ+lXlMMZ1pVXzsMLFCXNWiYIId
	 hUb0qFmWd2FlArY28dhu+FvmOh5VwT7efq9S5S9c1uylrte9ONgvEZrc7e7n1wCBVb
	 wnsVPizoGTy0OYYe6U7a6OsKN/CtHm+MDopoZJARDRFiYInNeM5cDZnvENi8ovDgPX
	 QzTDAg0nGRbVA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 20:24:04 +0300
Message-Id: <D1H75ZOA69LC.3OO4RAW8JBNHY@kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH RESEND] KEYS: trusted: Use ASN.1 encoded OID
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240523131931.22350-1-jarkko@kernel.org>
 <9c96f39ed2161dd7f0c3a7964cba2de3169fae3b.camel@HansenPartnership.com>
 <D1H2P674GFY0.3O8WYK2P1GZ2K@kernel.org>
 <9dfeb6e3d568452ab1227484405b1fc221bd25c1.camel@HansenPartnership.com>
 <cb7510433c13aaaa9bc64d624331f1a3a958fcf3.camel@HansenPartnership.com>
In-Reply-To: <cb7510433c13aaaa9bc64d624331f1a3a958fcf3.camel@HansenPartnership.com>

On Thu May 23, 2024 at 8:08 PM EEST, James Bottomley wrote:
> On Thu, 2024-05-23 at 11:30 -0400, James Bottomley wrote:
> > On Thu, 2024-05-23 at 16:54 +0300, Jarkko Sakkinen wrote:
> > > On Thu May 23, 2024 at 4:38 PM EEST, James Bottomley wrote:
> > > > On Thu, 2024-05-23 at 16:19 +0300, Jarkko Sakkinen wrote:
> > > > > There's no reason to encode OID_TPMSealedData at run-time, as
> > > > > it
> > > > > never changes.
> > > > >=20
> > > > > Replace it with the encoded version, which has exactly the same
> > > > > size:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A067 81 05 0A 01 05
> > > > >=20
> > > > > Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue
> > > > > so
> > > > > that the OID can be simply copied to the blob.
> > > >=20
> > > > This is true, but if we're going to do this, we should expand the
> > > > OID
> > > > registry functions (in lib/oid_registry.c) to do something like
> > > > encode_OID.=C2=A0 The registry already contains the hex above minus
> > > > the
> > > > two
> > > > prefixes (which are easy to add).
> > >=20
> > > Yes, I do agree with this idea, and I named variable the I named
> > > it to make it obvious that generation is possible.
> > >=20
> > > It would be best to have a single source, which could be just
> > > a CSV file with entries like:
> > >=20
> > > <Name>,<OID number>
> > >=20
> > > And then in scripts/ there should be a script that takes this
> > > source and generates oid_registry.gen.{h,c}. The existing
> > > oid_registry.h should really just include oid_registry.gen.h
> > > then to make this transparent change.
> > >=20
> > > And then in the series where OID's are encoded per-subsystem
> > > patch that takes pre-encoded OID into use.
> > >=20
> > > Happy to review such patch set if it is pushed forward.
> >=20
> > Heh, OK, since I'm the one who thinks it's quite easy, I'll give it a
> > go.
>
> Turns out it's actually really simple.  This would go as three patches:
> adding the feature to lib/oid_registry.c using it in trusted keys and
> removing the now unused OID encode from lib/asn1_encode.c but I'm
> attaching here (minus the removal) to give an idea.

This looks pretty good to me at least in this level. I could repeal
and replace the patch I did today with this if it plays out well.

BR, Jarkko


