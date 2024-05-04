Return-Path: <linux-integrity+bounces-2334-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA68BBC86
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2024 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1366E1C20BEE
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2024 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684EF3BBE5;
	Sat,  4 May 2024 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFTIeU2M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36058381AF;
	Sat,  4 May 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714834300; cv=none; b=obd49fLwRO3rZR0U4HLNwmE0WTXIqv1waePpgFZH708r1d69pLHbRdg0FiQRZq4Et3apG5IN8BoTH3FGpZIm604tjJ1aFBVcJBL7fGK/W9/SCnecdbN53pzJjEv8dAuMv+fkrFMEwSudaBGPniTewBeqKnEmgmSpgQugvl5J2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714834300; c=relaxed/simple;
	bh=aPJA8cLtuHwQ++7MGOOb5vV8YMm+YCTpLz9ofx2QDTY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=bQxzHdLeJtoy50ckAuMYcdzSWf6NTVc1gkWVfNK9dmIrv2BYLPy7qC3/caBNSzXmx4+uvWYV5g7nXqYxETqi3OoanpTqMt6Vqb+DRDIfRMkS+Fi5MsUQg0CWpV9WkOty5ijHCCap+x0BrAOcL0ER4WFQkyyzX7sG5hBdGWpb6/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFTIeU2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73187C072AA;
	Sat,  4 May 2024 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714834299;
	bh=aPJA8cLtuHwQ++7MGOOb5vV8YMm+YCTpLz9ofx2QDTY=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=DFTIeU2M/aA4EhAyhmcPJ28IRkmUiEFIIRzYRzza8DpNK0UEVRf1BvGdpD4aT32rc
	 cj6hVVmfORvzICN5WqrqYXKVa7o6S6PkWNJniFQT3cKwIx51qejRa8zGQk+o6w45na
	 PRU++DSR11RYTzxb0TfQcPpwuDguZ+cYaJueHNUMI2jx/hEnV/WCrkN2W9CA1rZJfV
	 2CvIqYh7FlW2FSlunM3SqNlWjhxs0Arrf5caPdPi8lOInEzpdd8AzYlqAIXstAh8o/
	 RT90wlHWyD3aLRM98/E9kEww/IJ/WestJtSNSREfuyI04clwwWhbqugYCb3/OSfULG
	 4sySUVX7BdDCA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 May 2024 17:51:33 +0300
Message-Id: <D10Y0V64JXG8.1F6S3OZDACCGF@kernel.org>
To: "Ben Boeckel" <me@benboeckel.net>
Cc: "Ignat Korchagin" <ignat@cloudflare.com>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <D10FIGJ84Q71.2VT5MH1VUDP0R@kernel.org> <ZjY-UU8pROnwlTuH@farprobe>
In-Reply-To: <ZjY-UU8pROnwlTuH@farprobe>

On Sat May 4, 2024 at 4:55 PM EEST, Ben Boeckel wrote:
> On Sat, May 04, 2024 at 03:21:11 +0300, Jarkko Sakkinen wrote:
> > I have no idea for what the key created with this is even used, which
> > makes this impossible to review.
>
> Additionally, there is nothing in Documentation/ for how userspace might
> use or create them. This includes things like their description format
> and describing available options.

The whole user story is plain out broken. Documenting a feature that has
no provable use case won't fix that part.

So it is better to start with the cover letter. With the *existing*
knowledge of the *real* issue I don't think we need this tbh.

BR, Jarkko

