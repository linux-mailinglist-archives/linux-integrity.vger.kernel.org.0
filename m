Return-Path: <linux-integrity+bounces-2412-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694A8C5E06
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 01:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE671F21C73
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB840181B94;
	Tue, 14 May 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQDA8/Zs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07E1DDEE;
	Tue, 14 May 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715728224; cv=none; b=scz7l09t9l7a5FwcSB3GLj82mjt28shW/aUhRFMP4hWyZIEeQ6v1ZWfN73DP7uHMLml1LLy0bB9HGGG21ECHXHeATa09CTJsmbgmNljEwLrNpIsvfNjS9tNscJhlCF2f5J7FZmQ284goOdam5av7UnmJ/naxOQ8RAizMpXQ7loc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715728224; c=relaxed/simple;
	bh=D/cY4/XbS/Gool4w6CPg7AhPqK6uncMDJQWq++gYBZI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Lkk0FNp+4TdBJjy7v6IRAwKW64Mp2ckMGaRdXU8k/snQALsw9NqU/5hmqn2WdxKG6AmH5wMRTWD3D4a1TEAV6nM4YVWewf9dPLZupRzrQAioC6SblNpJmLf4niJ5Js3IGCFjlv5Cp7kNRaikm/kAnDzNvIsVXeXTKjrx3/djZ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQDA8/Zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3916C2BD10;
	Tue, 14 May 2024 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715728224;
	bh=D/cY4/XbS/Gool4w6CPg7AhPqK6uncMDJQWq++gYBZI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DQDA8/Zs1l2N0KyoH/6T8OqqTpdEWgfXbmVFtiXIG6FGkCepcsyERX5BJIoVWGEAx
	 AzKwdG0T6mNhqiolmErcRbWjd6Oz1YYUDeNA8p34GvRTW/DbH8pSeHo9h5RZw7e5dE
	 S9LF0poXwcZCPBFq6CE8fsWd4B3fWU9GJcQpN7BrMQDT7LYvruwLdLz1SBm+tcIYHU
	 3y4WvmqSC4UvU0QgDmYxuUjIYDN3wSsWyJNPSfBavJ4A82xg3G2+JHmEKzS9i74RG8
	 9aGLJswAXskNoMSYV4sJHQ9JDwlPRwrF3ROOtqrIiKeYALArDRQFQ0suX+aero6S9q
	 s2eVI9aDJVG6g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 May 2024 02:10:19 +0300
Message-Id: <D19QW70177QG.2YC9XL0FT7VME@kernel.org>
Cc: <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 2/2] KEYS: implement derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ignat Korchagin" <ignat@cloudflare.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <20240503221634.44274-3-ignat@cloudflare.com>
In-Reply-To: <20240503221634.44274-3-ignat@cloudflare.com>

On Sat May 4, 2024 at 1:16 AM EEST, Ignat Korchagin wrote:
> Derived keys are similar to user keys, but their payload is derived from =
the
> primary TPM seed and some metadata of the requesting process. This way ev=
ery

What is exactly "some metadata"?

> application can get a unique secret/key, which is cryptographically bound=
 to

What is "cryptographically bound". Please go straight to the point and
cut out *all* white paper'ish phrases. We do not need it and will make
painful to backtrack this commit once in the mainline.

> the TPM without the need to provide the key material externally (unlike t=
rusted
> keys). Also, the whole key derivation process is deterministic, so as lon=
g as

Why trusted keys is inside braces. It is not important for the point
you are trying to make here?

> the TPM is available, applications can always recover their keys, which m=
ay
> allow for easier key management on stateless systems.

Please drop "stateless system" unless you provide a rigid definition
what it is. I have no idea what you mean by it. Probably not that
important, right?

>
> In this implementation the following factors will be used as a key deriva=
tion
> factor:
>   * requested key length
>   * requesting process effective user id
>   * either the application executable path or the application integrity
>     metadata (if available)

NAK for path for any possible key derivation. They are racy and
and ambiguous.

This should have been in the beginning instead of "some data". What
other implementations exist. For me "this implementation" implies
that this one competing alternative to multiple implementations
of the same thing.

I do not like this science/white paper style at all. Just express
short, open code everything right at start when you need and cut
extras like "stateless system" unless you can provide exact, sound
and unambiguous definiton of it.

Just want to underline how this really needs a complete rewrite with
clear and concise explanation :-) This won't ever work.

>
> Key length is used so requests for keys with different sizes result in ke=
ys
> with different cryptographic material.

What is "key length"? Please refer the exact attribute.

>
> User id is mixed, so different users get different keys even when executi=
ng the

First of all it would be more clear to just s/User id/UID/

And make obvious whether we are talking about ruid or euid and how
this interacts with GIDs.

I'll look at the code change next round if the commit message starts
making any sense.

BR, Jarkko


