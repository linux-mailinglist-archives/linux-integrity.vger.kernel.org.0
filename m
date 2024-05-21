Return-Path: <linux-integrity+bounces-2514-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DCE8CB08D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8E01F21318
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA641422DE;
	Tue, 21 May 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjteVsoZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64C8770E3;
	Tue, 21 May 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302163; cv=none; b=YG48pXGZ69eIRp7hJtNcxjn2EtyYe64uxVnL0ts81vc0z6kpzLASERRBW110bV65osgym2G9OmkuXM8fyaQmoJWrFLu/jCNhnElseDgSH2NEtB1gG9rSg+NhHb39WNKUsmdY/F7tRhmJ56rH9l501AhDgJOWXC39992lPyTbPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302163; c=relaxed/simple;
	bh=RlmedU54B/pEtKxQ1cWw542mGW2hc1W+zR6UyQwC5ZU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Lzw9NrfRDxdLr4kovZV2QFr/fofFWwpCq+5UrypnX2YPp46d0SuHxnBpbkvRj4GXIccnHKmUO8IrPZPOA0c3SADTItHF+I3c+we9tHpdb+ljSn3SiPUCla51UzPEGZjI4gMsh4LHiXvaC8ppbreBI7PuE/jniByygemyHvlmUpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjteVsoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474EEC2BD11;
	Tue, 21 May 2024 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716302163;
	bh=RlmedU54B/pEtKxQ1cWw542mGW2hc1W+zR6UyQwC5ZU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=qjteVsoZFJcw241JzJH/c4XWJ/hgPp/Kis2rrniY5zEcRlQ+PUoAt9/ar6fu26XUh
	 Uefv0vC/HoFJ/d/mHMKwgYm9kg7bPEoDrjcFEgRVl1YOKqgmuC2iqYLyXjCgAl5zUJ
	 MB/kdF/Ck0qVmHE13SGCUYf7kAqgKcXLVOrCTOrHqinTyPt/o2yFRoY+XNF7uUFUGc
	 pdXEoRHMr/iCPOBFH4/Q/MRcj0T+D4U0yolkypMD66AUo1fOAy6DF/Sw89IayZXyU5
	 BvUwGoy/oUnoB7HZhs9MSCc3Dy37Y6cUSOJ+hFZ74AbJG2Xc61RhRBVblGRsPF6HDm
	 QajseZDX5Wetw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 17:35:58 +0300
Message-Id: <D1FEC6TB7660.2XD9X21W46X7V@kernel.org>
Subject: Re: [PATCH] tpm: enable HMAC encryption for only x86-64 and aarch64
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240521130921.15028-1-jarkko@kernel.org>
 <236606947b691049c650bdf82c37324084662147.camel@HansenPartnership.com>
 <D1FDMULT5YRK.GZOPJ9FZ325R@kernel.org>
 <854fa2e1634eb116b979dab499243e40917c637c.camel@HansenPartnership.com>
 <D1FE58VX0KL4.70F6U9Y6HPQC@kernel.org>
In-Reply-To: <D1FE58VX0KL4.70F6U9Y6HPQC@kernel.org>

On Tue May 21, 2024 at 5:26 PM EEST, Jarkko Sakkinen wrote:
> On Tue May 21, 2024 at 5:13 PM EEST, James Bottomley wrote:
> > On Tue, 2024-05-21 at 17:02 +0300, Jarkko Sakkinen wrote:
> > > Secondly, it also roots to the null key if a parent is not given. So
> > > it covers all the basic features of the HMAC patch set.
> >
> > I don't think that can work.  The key file would be wrapped to the
> > parent and the null seed (and hence the wrapping) changes with every
> > reboot.  If you want a permanent key, it has to be in one of the
> > accessible permanent hierarchies (storage ideally or endorsement).
>
> I'm fully aware that null seed is randomized per power cycle.
>
> The fallback was inherited from James Prestwood's original code and I
> decided to keep it as a testing feature, and also to test HMAC changes.
>
> If you look at the testing transcript in the cover letter, it should be
> obvious that a primary key is created in my basic test.

I think what could be done to it in v3 would be to return -EOPNOTSUPP
if parent is not defined. I.e. rationale here is that this way the
empty option is still usable for something in future kernel releases.

BR, Jarkko

