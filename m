Return-Path: <linux-integrity+bounces-2401-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12BD8C591F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 17:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52563B2283F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6D417EBAE;
	Tue, 14 May 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="DgnoW9Q7";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="DgnoW9Q7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D917EB87;
	Tue, 14 May 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702071; cv=none; b=D0JSduvci5Ezx+NZEJbYivn4eOM4WUCPnLMcGyYWASGEpx84pINeUbJWikzQ1hiVY3TVnGbtdEUPiynM7MT9gyI84/BTUm78lXssttfX3tu5eMQX9fB59wl2xPo+IjoSTJpeIK+PRq6GHmvUX/MZJoWFP5U+z7/z7gP0fyKi8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702071; c=relaxed/simple;
	bh=KNws679LRysr8jk1Zmb1/BwUO/NizgI+qJLVlNx5NaY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B7kgkzpsRxFEg3S1gd1er0c4nUSAe/0h1zdXaT6okyA1RKvWcsWqxnDJUi6XJBDeImTM04NQ64h3DVfC/C9Cfh9+EARoWbPtJcbnUWflqlVu83R6IEFzNuVOsUGgebLO9wH4cY8hFLVmVL8MjfxixyBaVkv/x8yoK2Q+QPtTy5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=DgnoW9Q7; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=DgnoW9Q7; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715702068;
	bh=KNws679LRysr8jk1Zmb1/BwUO/NizgI+qJLVlNx5NaY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=DgnoW9Q7iH3ySE/JVhSguSKX7/LxDsKLHMWl4jiW90F2CZQN0eNlz9BLdUeZj4ll/
	 3syv2ceHNoM+X0PmH4MthuBQbr1WWHn+MCyYDCdYBOJD3RapDvZNCAzjLsTVinQNfZ
	 CSdxPXFcKNd+svFXJK9uPZDCNSbaBpoLr6szD48E=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id DB7951286BFA;
	Tue, 14 May 2024 11:54:28 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 88j1_6gHYV9J; Tue, 14 May 2024 11:54:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715702068;
	bh=KNws679LRysr8jk1Zmb1/BwUO/NizgI+qJLVlNx5NaY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=DgnoW9Q7iH3ySE/JVhSguSKX7/LxDsKLHMWl4jiW90F2CZQN0eNlz9BLdUeZj4ll/
	 3syv2ceHNoM+X0PmH4MthuBQbr1WWHn+MCyYDCdYBOJD3RapDvZNCAzjLsTVinQNfZ
	 CSdxPXFcKNd+svFXJK9uPZDCNSbaBpoLr6szD48E=
Received: from [172.21.4.27] (unknown [50.204.89.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1194A1286A68;
	Tue, 14 May 2024 11:54:28 -0400 (EDT)
Message-ID: <c8b98d9fc2ac4062d6c010551244da184af1244d.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 0/2] TPM derived keys
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  serge@hallyn.com,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Date: Tue, 14 May 2024 09:54:26 -0600
In-Reply-To: <CALrw=nE-t6ZWCvPm=3XS_=-UM9D=mMaXL2GOw-QL5GOLtbcHmA@mail.gmail.com>
References: <20240503221634.44274-1-ignat@cloudflare.com>
	 <CALrw=nGhgRrhJ5mWWC6sV2WYWoijvD9WgFzMfOe6mHmqnza-Hw@mail.gmail.com>
	 <D18XXJ373C2V.2M6AOMKD1B89W@kernel.org>
	 <CALrw=nHGLN=dn3fbyAcXsBufw0tAWUT1PKVHDK5RZkHcdd3CUw@mail.gmail.com>
	 <D19CUF0H9Q3S.3L5Y5S9553S5@kernel.org>
	 <CALrw=nEZ07U9VhbGsnpchOYw1icUZCnuoHHXkJLzhFqSPe9_fQ@mail.gmail.com>
	 <3bfcacf38d4f5ab5c8008f2d7df539012940222e.camel@HansenPartnership.com>
	 <CALrw=nE-t6ZWCvPm=3XS_=-UM9D=mMaXL2GOw-QL5GOLtbcHmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-05-14 at 16:38 +0100, Ignat Korchagin wrote:
> On Tue, May 14, 2024 at 4:30 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Tue, 2024-05-14 at 14:11 +0100, Ignat Korchagin wrote:
> > >   * if someone steals one of the disks - we don't want them to
> > > see it has encrypted data (no LUKS header)
> > 
> > What is the use case that makes this important?  In usual operation
> > over the network, the fact that we're setting up encryption is
> > easily identifiable to any packet sniffer (DHE key exchanges are
> > fairly easy to fingerprint), but security relies on the fact that
> > even knowing that we're setting up encryption, the attacker can't
> > gain access to it.  The fact that we are setting up encryption
> > isn't seen as a useful thing to conceal, so why is it important for
> > your encrypted disk use case?
> 
> In some "jurisdictions" authorities can demand that you decrypt the
> data for them for "reasons". On the other hand if they can't prove
> there is a ciphertext in the first place - it makes their case
> harder.

Well, this isn't necessarily a good assumption: the way to detect an
encrypted disk is to look at the entropy of the device blocks.  If the
disk is encrypted, the entropy will be pretty much maximal unlike every
other use case.  The other thing is that if the authorities have your
TPM, they already have access to the disk in this derived key scenario.
If *you* still have access to your TPM, you can update the storage seed
to shred the data.

James


