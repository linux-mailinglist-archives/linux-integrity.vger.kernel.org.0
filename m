Return-Path: <linux-integrity+bounces-8207-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF90D084BB
	for <lists+linux-integrity@lfdr.de>; Fri, 09 Jan 2026 10:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 570AD300926D
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jan 2026 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079CB3328E4;
	Fri,  9 Jan 2026 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="C9cBmZre";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w7NtLStg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571731AF3B;
	Fri,  9 Jan 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951956; cv=none; b=kHFSSsxxehjFljvRWmOfXArmVZm0dY8aKM7s6yXJmNUTheMrt1Qjn5sFlfxaZzf0bL86vcfPOHEwwJtMyxEZk3UcqVYd5CtQBDlWGjoaXGpPemPevrlgLjUj/6uIr2j1+Rr7XGdnO9O64/jNjNte8HKaZ3mE1mAaAza8t1MPCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951956; c=relaxed/simple;
	bh=SsYD3QEytlHofVainY1hPLvxemAtvue2KCkzQisHHYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDopf0bYEUuai/HNaCxMVRU9h0d/4dHCumAyN+zr06Osjds/3shVBQBMURLpi4YrL6U+P5cujq2NVe7MWnn2xZQhHOLbsDXDYG118nmJ6+I9qPzpKmkmyDQCEs/y0SMqhZIYYEhVDf8jXrzmk8ITbN5/Zzhc4WePQQfs5vLNDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=C9cBmZre; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w7NtLStg; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DE077A016C;
	Fri,  9 Jan 2026 04:45:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Jan 2026 04:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767951954; x=1768038354; bh=XIphJwKG8O
	JfNJKxIfDOIqHkckpXgGk9iR++X16ez9I=; b=C9cBmZreQfHssqqoZEk9MF7Qf0
	fJV+cAFihILTrAhfDbMWXSfJ98aA2Q4mqXmu7WtvG6letUGXFYlbrgPm+s8EJ7Uj
	Y1lgPnew069TuEq7FhwOJzVPG+yqqH77R3TpbDHQ/bdwSYMZ8oPD8Wedv1KGptVd
	/bC43BIhxos8stabM4ChE5PjrjOTUmP5osR859fxVdF0Kt5oKk08h1AoUBXmoOcE
	G7tJv8a7o1xtUKe8cRi7neTF0LORnYvZ8Zf+EeJPPM+nhCopzsXW2OGgdc7J0/mK
	YnZonrZuhtyfE2qN9tbRM0UdFHXro3xQUNWpTWQyKsHxf58STBQ+++GaTBWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767951954; x=1768038354; bh=XIphJwKG8OJfNJKxIfDOIqHkckpXgGk9iR+
	+X16ez9I=; b=w7NtLStgBWtibQGVuGAzX1NGpN3hNj6dmisvK504cpD/+UAhAHw
	k5Y3hHEtXSJu7BFWeXdu4ShO3Cp4TLfSODI/FG4K5hlfkrJVz49Go8lCB8WlX2fB
	5v1m3wdKEClibUHTdDlh3yhCKUoE4k+QPart/bBGhriI5GenfsagPQSKlWRqbKNu
	BPEkWm1uUyI62bMGlLJRlVBdGtdmRGA1QUJiWKWe+xS7t9tWkRJdSbvG9ME0+Ncz
	vXvKXTTYypg4maACwUBqPaIdyDomNAN5nXjUWXW/2fB5HX3Av/f5vqsn6HU0uSAN
	pZkAb2tQmiKJ52ILbN/IIaQJoxeWzAxhWdQ==
X-ME-Sender: <xms:Uc5gacJMfYDJ1Sok6URJIe7TX6hO9-JjXa4D-jKklVTBLKLVowAHbw>
    <xme:Uc5gaeva23mjpY_PHyxYZyoZMJ6xM2d400U5SpiSdNTE4nlE3Lm8sqZX5Msssqmx_
    IrHz5sC7PqEIVGIbxFr7DIuvzRyO2z0BQZobFVaj5VMx2-cNw>
X-ME-Received: <xmr:Uc5gaQUtDYtCayh3qWQRRTL9J9-l0pVhgb3sJ52_Eh-ExVnGmGVmTYeT6_5gMikojODNLmdPsaPWNvGSJXNe_nduGZJ1VsmX9jM9Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjrghrkhhkoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnthgvghhrihht
    hiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnohhoughlvghssehmvg
    htrgdrtghomh
X-ME-Proxy: <xmx:Uc5gaZheN-_V02vYZEzjkszgxFjLttt7gUTMGeSJ6rdF_nKoNX_UpA>
    <xmx:Uc5gaYoGMB-W2ZvDIDEhiYVdljH2ECTd8SjI2of1miMuDo4EoaDy0g>
    <xmx:Uc5gafF6LDIkNrGBGZR2kRbazh-bS8BVSzIJdoJUbUdWvjO1KDCNzg>
    <xmx:Uc5gad7al3B1_XHi0zYFxdNuertTVwz442_Uj5wymLsVPrgIVh3YAw>
    <xmx:Us5gaV81lT3zYr5RFMxWROYDtnr1JuIrDOAMa4gAnn5ex8oZe-DJDNQ1>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 04:45:53 -0500 (EST)
Date: Fri, 9 Jan 2026 10:45:51 +0100
From: Greg KH <greg@kroah.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: stable@vger.kernel.org, linux-integrity@vger.kernel.org,
	Jonathan McDowell <noodles@meta.com>
Subject: Re: [PATCH] tpm2-sessions: Fix out of range indexing in name_size
Message-ID: <2026010931-cling-enjoyer-9ce6@gregkh>
References: <20260108123159.1008858-1-jarkko@kernel.org>
 <aV-kD5iKi9fwluU0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV-kD5iKi9fwluU0@kernel.org>

On Thu, Jan 08, 2026 at 02:33:19PM +0200, Jarkko Sakkinen wrote:
> On Thu, Jan 08, 2026 at 02:31:59PM +0200, Jarkko Sakkinen wrote:
> > [ Upstream commit 6e9722e9a7bfe1bbad649937c811076acf86e1fd ]
> > 
> > 'name_size' does not have any range checks, and it just directly indexes
> > with TPM_ALG_ID, which could lead into memory corruption at worst.
> > 
> > Address the issue by only processing known values and returning -EINVAL for
> > unrecognized values.
> > 
> > Make also 'tpm_buf_append_name' and 'tpm_buf_fill_hmac_session' fallible so
> > that errors are detected before causing any spurious TPM traffic.
> > 
> > End also the authorization session on failure in both of the functions, as
> > the session state would be then by definition corrupted.
> > 
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
> > Reviewed-by: Jonathan McDowell <noodles@meta.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> 
> This is for v6.12.

Does not apply anymore to the latest 6.12.y release, can you rebase and
resend?

thanks,

greg k-h

