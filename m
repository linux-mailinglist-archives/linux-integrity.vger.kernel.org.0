Return-Path: <linux-integrity+bounces-3653-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E866697DD55
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5484CB21572
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AB156653;
	Sat, 21 Sep 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV364ikF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C81DA4E;
	Sat, 21 Sep 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726924404; cv=none; b=u2pKvg+i6rY3EX5lIqnT+EVwXGVKDb3g6kb8ePkbIKvJctIkOZrQKuhzljTNuqbl3TYAcG4kSLV2FGKAVN5PIERTZfFU7zFosf35udKf/DsTUu2clmBoh6sNGJLoQyAwdWto/z2sklhkQ259PJs6Bat3xjDSY71V9Bee8NUM7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726924404; c=relaxed/simple;
	bh=HHCBvj1uCmVFDNlcGB8A2KIGEG+RLyVW0IWXIjS1/IM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ljedB1Xgcg6LLC9Ta/yWltTitszHWTEAMe2s5JEm873mflzTCj7Za/AjsPVp1cOgjf852nPl/BNuMDJUNuchIcrPTq2RUJh75PAGFNUjjybm+XmLeazXB4FKMf1QKZeLd6rAa1Mfq8mQ1hR01ildiFVdmcAk8L0VfPGtBvJuKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV364ikF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4ABC4CEC2;
	Sat, 21 Sep 2024 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726924403;
	bh=HHCBvj1uCmVFDNlcGB8A2KIGEG+RLyVW0IWXIjS1/IM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=XV364ikFS8m7cqdWYUdMPoyQO07U7SvZnM4dESXH4LqR3nHOYcKNRgVnTdfj5/+6I
	 r6dZk8iU1HL1uFMuEi/lvF4jLLc9o7qrNzRjJTckFyKvDf+tgBpdElDFJR5pEiD9d9
	 c4GaEi9MILn6QbWEFw6kkUpZa3mqp00uMAc3JuHkLnaui8HaKEfEXcrotoMIWwQom+
	 S0ztr1wTwafAdeavBtX4f32pXS1xxUxzwvbHQYBxboMFYMUVJgDJ1QTnJwY7OvB53S
	 e081QhdQAv2R4194xbgfySHD7nc33iGT3RpUQeKNs9Ys6plmHm/U9YmmP3S1lG8TRM
	 pvBI+6kkH3e+w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Sep 2024 16:13:19 +0300
Message-Id: <D4BZLX10S23R.8CQD7UTH7AM1@kernel.org>
Cc: <linux-integrity@vger.kernel.org>,
 <James.Bottomley@HansenPartnership.com>, <roberto.sassu@huawei.com>,
 <mapengyu@gmail.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "David Howells"
 <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <f9bbc8a7-4292-47a1-8987-b931284a7738@molgen.mpg.de>
In-Reply-To: <f9bbc8a7-4292-47a1-8987-b931284a7738@molgen.mpg.de>

On Sat Sep 21, 2024 at 3:36 PM EEST, Paul Menzel wrote:
> Dear Jarkko,
>
>
> Thank you for working on this and your patches.
>
> Am 21.09.24 um 14:08 schrieb Jarkko Sakkinen:
> > This patch set aims to fix:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229.
>
> If I am not mistaken this is about reducing the boot time, right? It=E2=
=80=99d=20
> be great if you documented the numbers in the commit messages.

So what you're asking is already documented by:

1. https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
2. Tested-by

I added lore link to the bugzilla bug, in order to address your comment.

I don't think my "QEMU numbers" will bring any value here tbh.

BR, Jarkko

