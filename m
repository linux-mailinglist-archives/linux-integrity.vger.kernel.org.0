Return-Path: <linux-integrity+bounces-2413-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031968C5E2B
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 01:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B01B210C1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 23:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B95182C9F;
	Tue, 14 May 2024 23:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQYFAMtV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8F1E491;
	Tue, 14 May 2024 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715730248; cv=none; b=Cxh5RS5kIgH2SQD+WdBQWX7hB0D1Ya1VSz94vt86C3DkMfiGY/IOAfCbl94hc3SOlZhd8e2DyH9H4f6Qruom6y8nt/gEHVlxHbogsKpKDXY+rGQW8Ry+Sfo2W2uyDw4aYdI4ommjdMsCMX8hzrK9tIFKnuS0xQqWJ1A/np3RKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715730248; c=relaxed/simple;
	bh=zaif6LgrwelbYbMvOV0avkZGQgzBBS+ZGgSOPvFv5Go=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mE32Eg5Km5y6AaPAxYRjY2PeQF+X+BGlnVffy8jE9MRdz4NqmlRhJyMoO2rvXG2kRsDC02lvrxSyWA9nxFA3eKS7rte7CswZZcZUkLhJSjTsZ6ybh4WPdFghZc0snsDyKU8VoqwWCH1plPzqLPT5OjtMcwI8RlWoPVk/cdSEA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQYFAMtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C09C32781;
	Tue, 14 May 2024 23:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715730247;
	bh=zaif6LgrwelbYbMvOV0avkZGQgzBBS+ZGgSOPvFv5Go=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kQYFAMtVoFBQcgm7IkENwgGBRxVdWKIhGeFSGFl6UKu7wczxZE1jxhzMqIyHL19TM
	 i/OWOc1hNF+hDC/o/V55qJYX3Qffab3Wd4RzgX/gTKKyJ362r1fALXVduScAKMOgkA
	 CU8V3Xpi/irPUnfOQJPqEZ26qzosvmC8WCYGKANNKFa3zjevIYi2BqBMosI39BShME
	 vfy38t9sV3aW3EMTKwwh188eVhghphvzDEqdJ/h2uqzWvSjphVhmBxMkjX9twe9J4I
	 bzM/M1a+9dxX4mS4SmvJAFAlv2Oc4/l1wdiMqZ3wo6qj/CRkBJYX15RixOJgzPVCFv
	 eTw/uW5Ln7AEA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 May 2024 02:44:03 +0300
Message-Id: <D19RM0OV7YUW.1ZEI72XQUREMQ@kernel.org>
Cc: <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 2/2] KEYS: implement derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ignat Korchagin"
 <ignat@cloudflare.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <20240503221634.44274-3-ignat@cloudflare.com>
 <D19QW70177QG.2YC9XL0FT7VME@kernel.org>
In-Reply-To: <D19QW70177QG.2YC9XL0FT7VME@kernel.org>

On Wed May 15, 2024 at 2:10 AM EEST, Jarkko Sakkinen wrote:
> On Sat May 4, 2024 at 1:16 AM EEST, Ignat Korchagin wrote:
> > Derived keys are similar to user keys, but their payload is derived fro=
m the
> > primary TPM seed and some metadata of the requesting process. This way =
every
>
> What is exactly "some metadata"?
>
> > application can get a unique secret/key, which is cryptographically bou=
nd to
>
> What is "cryptographically bound". Please go straight to the point and
> cut out *all* white paper'ish phrases. We do not need it and will make
> painful to backtrack this commit once in the mainline.
>
> > the TPM without the need to provide the key material externally (unlike=
 trusted
> > keys). Also, the whole key derivation process is deterministic, so as l=
ong as
>
> Why trusted keys is inside braces. It is not important for the point
> you are trying to make here?
>
> > the TPM is available, applications can always recover their keys, which=
 may
> > allow for easier key management on stateless systems.
>
> Please drop "stateless system" unless you provide a rigid definition
> what it is. I have no idea what you mean by it. Probably not that
> important, right?
>
> >
> > In this implementation the following factors will be used as a key deri=
vation
> > factor:
> >   * requested key length
> >   * requesting process effective user id
> >   * either the application executable path or the application integrity
> >     metadata (if available)
>
> NAK for path for any possible key derivation. They are racy and
> and ambiguous.
>
> This should have been in the beginning instead of "some data". What
> other implementations exist. For me "this implementation" implies
> that this one competing alternative to multiple implementations
> of the same thing.
>
> I do not like this science/white paper style at all. Just express
> short, open code everything right at start when you need and cut
> extras like "stateless system" unless you can provide exact, sound
> and unambiguous definiton of it.
>
> Just want to underline how this really needs a complete rewrite with
> clear and concise explanation :-) This won't ever work.
>
> >
> > Key length is used so requests for keys with different sizes result in =
keys
> > with different cryptographic material.
>
> What is "key length"? Please refer the exact attribute.
>
> >
> > User id is mixed, so different users get different keys even when execu=
ting the
>
> First of all it would be more clear to just s/User id/UID/
>
> And make obvious whether we are talking about ruid or euid and how
> this interacts with GIDs.
>
> I'll look at the code change next round if the commit message starts
> making any sense.

Right and neither UIDs and GIDs are applicable for key derivation for
quite obvious reasons. So NAK for that too.

You can make them point out unlimited different identities...

BR, Jarkko

