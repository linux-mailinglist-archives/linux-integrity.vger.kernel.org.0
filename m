Return-Path: <linux-integrity+bounces-2335-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1A8BBCC3
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2024 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4BF1C208FF
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1A3CF63;
	Sat,  4 May 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1qYw7ln"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06E1EF15;
	Sat,  4 May 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836954; cv=none; b=BDhTaSr6Vj6khhJdwYXfClWN+03xpIyAhDV4e+GakU9XU22X0QTLeAhMJchgMbJsgCc598E4ghL0+bjx/TrZO41JzAroG/7WKWRanbLN4UfZgIexKKZarDsT3pd/R5x5i6uHtAzqltM/EXNXt7VQeJbE88gyB7mp2BBudscrJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836954; c=relaxed/simple;
	bh=Gk/mhS8TriKuywu+H3KzIpPCU/lc2/yHAJtYyq2QK8I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SoiHGIvWfCVEscy65jJvOuOncgwuhq3qsuwkHFyUF3mgkYRb5wMIAqmEw+avUUrbaQXKLsJEwEwUNeIE2pG4W24AeCLXTynxDGWfCs5/8v0PrAcneFOkz5hI+ttC1UxcWI6vc1hZVERPk2OwrOICqF1OhOUKLMLzrxj4Gpvnayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1qYw7ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394EAC072AA;
	Sat,  4 May 2024 15:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714836953;
	bh=Gk/mhS8TriKuywu+H3KzIpPCU/lc2/yHAJtYyq2QK8I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=E1qYw7lndcDJNl9XAEYLPpuwwU9h+88xGdsUPSOMQDie+h0nBD/Xn//eeyCZMYGGK
	 PcIt4ItYu2jjeJ13atj0aFNZepI8NxFpWC81rPT85e7H8txGnalBG5Vzix7LgCsyvi
	 WfMf8FvDdY5WFvS3SVOqN68TXF7L7ArFTHd519+X58BxpaFx9a3XIxtUT5aZbmi8HN
	 db8a0+QNk/EoEbP6w5iiSkHgnorbJ2//8oxjbeFJBvNDt9lJrzfLgu6UeW5+/oDzoL
	 3509B6PuGT2OFUbrS5XyFeZY5+qW1yAL1kYJ3ZJZdNFHVpCCcOjVaOpNeFM88/YIW/
	 HYO6RVrfNGBsw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 May 2024 18:35:48 +0300
Message-Id: <D10YYQKT9P1S.25CE053K7MQKI@kernel.org>
Cc: "Ignat Korchagin" <ignat@cloudflare.com>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ben Boeckel" <me@benboeckel.net>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <D10FIGJ84Q71.2VT5MH1VUDP0R@kernel.org> <ZjY-UU8pROnwlTuH@farprobe>
 <D10Y0V64JXG8.1F6S3OZDACCGF@kernel.org>
In-Reply-To: <D10Y0V64JXG8.1F6S3OZDACCGF@kernel.org>

On Sat May 4, 2024 at 5:51 PM EEST, Jarkko Sakkinen wrote:
> On Sat May 4, 2024 at 4:55 PM EEST, Ben Boeckel wrote:
> > On Sat, May 04, 2024 at 03:21:11 +0300, Jarkko Sakkinen wrote:
> > > I have no idea for what the key created with this is even used, which
> > > makes this impossible to review.
> >
> > Additionally, there is nothing in Documentation/ for how userspace migh=
t
> > use or create them. This includes things like their description format
> > and describing available options.
>
> The whole user story is plain out broken. Documenting a feature that has
> no provable use case won't fix that part.
>
> So it is better to start with the cover letter. With the *existing*
> knowledge of the *real* issue I don't think we need this tbh.

As for code I'd suggest the "Describe your changes" part from=20

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html

and most essentially how to split them properly.

My best bet could something along the lines that perhaps there is some
issue to be sorted out but I don't honestly believe that this will ever
be a solution for any possible problem that exist in this planet.

BR, Jarkko

