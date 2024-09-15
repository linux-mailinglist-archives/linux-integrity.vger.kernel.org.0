Return-Path: <linux-integrity+bounces-3599-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9368E97975D
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5BB281EDD
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119B1C7B6F;
	Sun, 15 Sep 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="coxZQwUK";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NCmu1Fn3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCB17BBE;
	Sun, 15 Sep 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412453; cv=none; b=H1fk7NPwNFaXgyu6NpxT3pypwHrNrV2ygrlFkIMpNDDMK7s9DxHqVyfYuRso1VuhTqjiu/rTOqKj9D0CzVub/6BD5QxWFT8WQrsOd6N0xthyc5ZfquGf7oQwLIjK/wpi7/FaeguRPl6o98BpD27LbV8CHA6wmn+6nSNCAR+FMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412453; c=relaxed/simple;
	bh=OxYZeKXWYfy2hDNQyQLc2pdzSLg8TwfpyliHZjA/6Sg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXepZka8UCCzMsFu0xDlt2890rJtKmPIWoCkwvIMbUtKdSyW0v0e3w3qBFO5QtPJp06xEw/0PVaS5P/UQ4RQDQ1vRBiFiCVmrW3JtZo+OjBGYhaV3k58r2M/0rHg68GK1w8X1gKkLgsbe2s+/ZlkJB5awN9gzFPIPdKHCRq33go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=coxZQwUK; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=NCmu1Fn3; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726412451;
	bh=OxYZeKXWYfy2hDNQyQLc2pdzSLg8TwfpyliHZjA/6Sg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=coxZQwUKKHZVGsWk0Rjtw6j8JR8t1yO8iVM2QqGJU0c4TzTxhxJcpwWnfwsoLwy2R
	 wyI0UbtZ2njONwAWWS0HpsF2ZN1fy9U5rQan8t+6RooJN4aSdZqQ4CiJZFjSxtBBw3
	 q/joJFRc2mRTRI3qTAeYg8D1lT00HAjk725wicfc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 340531286CAB;
	Sun, 15 Sep 2024 11:00:51 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 8adY9g-s-nic; Sun, 15 Sep 2024 11:00:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726412450;
	bh=OxYZeKXWYfy2hDNQyQLc2pdzSLg8TwfpyliHZjA/6Sg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=NCmu1Fn3w1OqUWytf8eMVz+YI8ZL/5agEJ3W0fkxQSgTNfhWbud6gJFuw3qSD/sIM
	 J9bsDJPCFalCbbBRfJs9H59ZU9mvx9pTTcAyjnh2fPBpqT13efm3lUkZzkQKsUT1RF
	 Ranryhh64ha8YjQuEUFYKQaB8/3c6Jp4xtBfdles=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3387612867FA;
	Sun, 15 Sep 2024 11:00:50 -0400 (EDT)
Message-ID: <7586c7e6e6028a734a8cac3d4b1a8504e6cd4b21.camel@HansenPartnership.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Roberto Sassu
	 <roberto.sassu@huaweicloud.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Sun, 15 Sep 2024 11:00:48 -0400
In-Reply-To: <D46XX6HNU686.50X57ZWI2GUX@kernel.org>
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
	 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
	 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
	 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
	 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
	 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
	 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
	 <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
	 <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>
	 <D46RE2BWMGJ4.25VA7IVYTJ8MO@kernel.org>
	 <D46RWPQ211ZS.12EYKZY053BH@kernel.org>
	 <0b22c2c4b4a998fb44bb08be60a359acb9ecb8da.camel@HansenPartnership.com>
	 <D46XX6HNU686.50X57ZWI2GUX@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-09-15 at 17:50 +0300, Jarkko Sakkinen wrote:
> On Sun Sep 15, 2024 at 4:59 PM EEST, James Bottomley wrote:
> > On Sun, 2024-09-15 at 13:07 +0300, Jarkko Sakkinen wrote:
> > > On Sun Sep 15, 2024 at 12:43 PM EEST, Jarkko Sakkinen wrote:
> > > > When it comes to boot we should aim for one single
> > > > start_auth_session during boot, i.e. different phases would
> > > > leave that session open so that we don't have to load the
> > > > context every single time.  I think it should be doable.
> > > 
> > > The best possible idea how to improve performance here would be
> > > to transfer the cost from time to space. This can be achieved by
> > > keeping null key permanently in the TPM memory during power
> > > cycle.
> > 
> > No it's not at all.  If you look at it, the NULL key is only used
> > to encrypt the salt for the start session and that's the operating
> > taking a lot of time.  That's why the cleanest mitigation would be
> > to save and restore the session.  Unfortunately the timings you
> > already complain about still show this would be about 10x longer
> > than a no-hmac extend so I'm still waiting to see if IMA people
> > consider that an acceptable tradeoff.
> 
> The bug report does not say anything about IMA issues. Please read
> the bug reports before commenting ;-) I will ignore your comment
> because it is plain misleading information.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=219229

Well, given that the kernel does no measured boot extends after the EFI
boot stub (which isn't session protected) finishes, what's your theory
for the root cause?

James


