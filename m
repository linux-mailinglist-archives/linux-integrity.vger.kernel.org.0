Return-Path: <linux-integrity+bounces-5349-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4309A6ABD4
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD75189B8A2
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D4223706;
	Thu, 20 Mar 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TsxTULWT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405931E0E08;
	Thu, 20 Mar 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491015; cv=none; b=a1yQ5dve2AIP7LSz7zH5nSz6MVHVX1t5scn9ogaGFfbm06CLkYiGzD+pu+92J+D5msIBgY31EfjXM2O5n6BlDbg5gIeInpUWKuCcjaOjfFlxACgalZVyjMkVRsVAQS1opnukKJE4lf8pNn93QPF86NfYsXNFM18UJesLGCx13uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491015; c=relaxed/simple;
	bh=2+zF9JSMTTKB7jjaAmiAbYmNUkZlNhBzwX2nmylCYQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNJBWqftnEoClvfNPwlQZAG7ZT5b7QKqRf1yNLg6+41EmhOlJ4wzK0Ynzunav0XUMZ8fx+4cZvrSdWcuUZb8CfKJE+t68zjud1jmggIKvUaTrz1XDKYFoFO8Lg8SF9ROvF9y+DKupQqbOVFwtnkVRHHOA63x5BZc/xzwMBwoCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TsxTULWT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A9CBA40E021E;
	Thu, 20 Mar 2025 17:16:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oeP7k1CnRtfj; Thu, 20 Mar 2025 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742491004; bh=cJQFO1VNrfOpHwJY6BeGXeUqNOzW7ZP9buAm5cjoRV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsxTULWTOWVId98q64L7Q0ooRm1ZyVRWxTmugnN1O4qsodAXsPWcbwfRYU//SU3xz
	 oCeEx0V0oW6CyjJPO5smRgPsaNcViIZV5eJC4LvjNJrEQyJfmE6dH+jfovFZsYYx1k
	 buWsYyx/csmHYv0kvYfIoxvmdoLUKSruT6Qni16pqwU6XitFU6WGf2gBLbaqCtCP8P
	 1zB7WuxnO6ykMeOyklFSqLX/lxrNO80epLgcznHjeEJeIrKN62XIYmJ0+AB80g6PVj
	 akRHqY8Bh4d9OgAuoUJr0xz+m/CGqQ8QAVyGxXU9XvzjynoGrsmPM0yiTksFovJrS3
	 PQh43Q9j3ELE+cQTnBskiD42dk0WF6jRNGW5il68e3weHI/wOeTu1Px5VpDXH+JIjY
	 L7Bz/OHZXGQsjBNscRVzhqk1yD3w/RpNvUKZHHN7YBR9ZSUonFZAz9uonsIG6ru/pz
	 3QJUmS5liB53iKZE7ucRw+HoJh6UG+TvDD8RXrEuIiUfsK6qa+yIBIW+8g2s+QMlPq
	 z44QBb/2BYaGt2RRL/hFnTOozfQtwFqJjNp4a6wFwxj4dfrqXoOPR2gYEXKHWKDm3I
	 8FZYeWBvHQRuJVdXmEqRr6sGxGpsway+BzMHyyLqt01AtmOeYmRLSYTJdEMDtl01xE
	 v1KPq74r3sqCIvjTPniR/8bY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2994340E01AC;
	Thu, 20 Mar 2025 17:16:26 +0000 (UTC)
Date: Thu, 20 Mar 2025 18:16:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <20250320171619.GOZ9xNY4W54avW2a-u@fat_crate.local>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
 <Z9glWp6U6vyEmKQa@kernel.org>
 <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
 <Z9wuLVeP726Cssqp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9wuLVeP726Cssqp@kernel.org>

On Thu, Mar 20, 2025 at 05:03:09PM +0200, Jarkko Sakkinen wrote:
> > I can do that, I slightly prefer BIT_ULL() macro, but I don't have a strong
> > opinion on my side.
> > @Borislav since you suggested it, WDYT?
> 
> Either goes for me. Sorry for nitpicking that :-) The first comment
> stil applies.

Bit 8 is a lot better than 0x100.

Let's give a better example:

0x0000000008000000

or

BIT_ULL(27)

:-)

While I'm here: I'm guessing I'll route patches 1 and 4 through tip once
they're ready to go and give Jarkko an immutable branch he can base the other
two ontop.

Agreed?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

