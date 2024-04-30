Return-Path: <linux-integrity+bounces-2298-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8958B82AF
	for <lists+linux-integrity@lfdr.de>; Wed,  1 May 2024 00:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578D01F2107F
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 22:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E465D518;
	Tue, 30 Apr 2024 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="u4nsC30c";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="u4nsC30c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E71FB4;
	Tue, 30 Apr 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714516309; cv=none; b=KbQejqf6BPPg4Vx3B1ua7lULqJNfKbmg1t6T8SfxRfzayxwDX9xHKhTPBKYff8IKSIGkaJje6SYx0AW2UFqhg6mzRt6Ae7RDjqL89nwX7W/9kS5teB4zABroVYXawlh6596r5wrXgl440UEQV+1OaLNr2j/pouhD4AMz57cU/gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714516309; c=relaxed/simple;
	bh=Ppw16zG5pR4Gka+D4E649+Ols6Bj2H0l6Hq8sgBmvkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CNiu9AkrZazchu7etr5ueD9gJAZZKDGWDvkrj6bRrJMI+XIRVCahOd9XElFfUhEidmTzZNhxt/9vlP5KZni5hQoBCPZhtv5ZNHXnDQbNt5i1W6cFwFDXhqgWQa5RJdRYYpdku5Ok7ig6gGAmVZt3kTECCgrG70lrESqsaPMrKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=u4nsC30c; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=u4nsC30c; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714516306;
	bh=Ppw16zG5pR4Gka+D4E649+Ols6Bj2H0l6Hq8sgBmvkI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=u4nsC30ce1piGFpmt3sEI7Jov8sKpNvA6tWppXsGuFxh2P3wBv0Khiy5GuhUFrOiy
	 Rjq1hVZTdbv9mVnWoMOfHU4DSZvBI6QfPGHgCWb+RmYHmftYqU35l1yv2ZSOu5q1Nr
	 97DOtjnre6u9sFTPyKn/R5S0bM9d6NONupXSJT7w=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 841AF1286DC1;
	Tue, 30 Apr 2024 18:31:46 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id LK7q0aYDV8vg; Tue, 30 Apr 2024 18:31:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714516306;
	bh=Ppw16zG5pR4Gka+D4E649+Ols6Bj2H0l6Hq8sgBmvkI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=u4nsC30ce1piGFpmt3sEI7Jov8sKpNvA6tWppXsGuFxh2P3wBv0Khiy5GuhUFrOiy
	 Rjq1hVZTdbv9mVnWoMOfHU4DSZvBI6QfPGHgCWb+RmYHmftYqU35l1yv2ZSOu5q1Nr
	 97DOtjnre6u9sFTPyKn/R5S0bM9d6NONupXSJT7w=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C274F1286DBE;
	Tue, 30 Apr 2024 18:31:45 -0400 (EDT)
Message-ID: <c175a43a1c33a9513e3319e7b29e3985a140b4da.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 00/22] add integrity and security to TPM2 transactions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 30 Apr 2024 18:31:43 -0400
In-Reply-To: <D0XSE6G33OHS.1B4OFPN0NCEIM@kernel.org>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
	 <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>
	 <eef3292f4680c22b817021f973a34a1657b82c86.camel@HansenPartnership.com>
	 <D0XSE6G33OHS.1B4OFPN0NCEIM@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2024-05-01 at 00:48 +0300, Jarkko Sakkinen wrote:
> On Tue Apr 30, 2024 at 10:23 PM EEST, James Bottomley wrote:
> > On Tue, 2024-04-30 at 01:22 +0300, Jarkko Sakkinen wrote:
[...]
> > > Since I could not find the email subthread I neither have the
> > > patch nor do know the baseline. So if you could help with these
> > > details then we can move forward.
> > > 
> > > I can also work with QEMU Git fork if you have one and point out
> > > QEMU_OVERRIDE_SRCDIR to the clone.
> > 
> > I only have the patches in a local git repository, but I could push
> > qemu up onto kernel.org if it would help?
> 
> That definitely does help. I can point out my build to that
> repository, (or actually clone of it).

OK, it's the mssim branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/qemu.git/log/?h=mssim

It's based on qemu head, but it works for me.

James


