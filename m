Return-Path: <linux-integrity+bounces-5686-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A41A8239E
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 13:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97A03A6521
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582C2561C8;
	Wed,  9 Apr 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IIqwh7nN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D822E3F7;
	Wed,  9 Apr 2025 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198341; cv=none; b=XMwZUHy+wDHg52UrmaNlPObvbZK1OItxEeapnajLWp3NH4Rivw4DCZ+P4izNR8AXETNG1FJJCy2EgGypWLl0xkLwTHug9Kh9ws4HViZX0tthWZsdsArMi90EtFurHF+62eGVOorAKaGqnFRVBaM/L34SbPYW02sEOXJ4uiWFyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198341; c=relaxed/simple;
	bh=uJ2A4eJ9gw+1+DX8cROf0E6YMpexW4oBimv3nz/BFW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmlY+ZoazHj+/7yTA3Z/c1Xa3ozU0443RfLYz3Sy5xqYxt1RLBgNvUFtGxo+xry74zYbiF46tOo+KsIe9PRLfABd7LYjGMtw28V6lPVK1B7BYeoe24LQw/lh9CxXZqmFFXg8RHefPEsx1RVAh7tO1CiiKD2Wam5RMgpyKMhn+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IIqwh7nN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 075BF40E019F;
	Wed,  9 Apr 2025 11:32:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gUu-ArE3mT14; Wed,  9 Apr 2025 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744198334; bh=Kd1dq6qO7Pm6ZvRiE64SfOl2sLEG/m2bPzR2xytbWHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIqwh7nNBt2x+2yj2qdpDHb2uNH4WmLAfAawqK2p//IrzduhQ8PFg+DomGP5FYLQK
	 kcj2PVRNQboa/SNhYSO0QtRTu2tdzUrLsOwH+aw4CcSOnV/vh7z0nPDetHKCIMVR3v
	 nsMDU9KzwVsc5asqWYjKK857/gsJ9XU1qxafO0NA8Kp1azysr7ZnwTM1m85Hv3QP7i
	 ylLJTkcDpcPfao2bkxgX86prmHPuNDcK538rmjQd86silLCGZg1/xjm+iKOYcFRb5c
	 C/AsxZ4+QOaI7PNAPe0vjDdP+8w3HR5IthiN2ssiRegxMs++Dp6nCiI/4PaQyl5gE8
	 k6udHOGVHPt4wPRxnbiIivvwSvFLb7zf6myK6NBMecifVosboSyiDPUMoOhwuXYuy6
	 k2Gww+0LV0Kfv9dpscT6gsjw3sr57CQgHJlWANL9ZG3Pka1IiGaD3t3o0tmTnvqmr0
	 1T4ExnmlBKn1rNr3i/cOoS6ACrqmO+LL8gODtBGu6BJObEa/vxvcZtArQjzVgvFdpE
	 cmQSiNlZsHSh/FsBECEPl06lteBMug5JKseiqqxhDFaktM75TbzQKI11+Q9DTg1xYZ
	 aK6AhhdgaKw/1ILedOANYASvDjLa2KVbvPLwP4d+wfgL7iQWfaQ457O+EaFXYQHjs9
	 YZ2cPK7xkIT8mZD0iRkn/1go=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCF4C40E01A3;
	Wed,  9 Apr 2025 11:31:55 +0000 (UTC)
Date: Wed, 9 Apr 2025 13:31:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Dionna Glaze <dionnaglaze@google.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <20250409113154.GGZ_ZaqgfRrrMij_Zm@fat_crate.local>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-5-sgarzare@redhat.com>
 <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>
 <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
 <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local>
 <o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl>
 <20250409102120.GCZ_ZKIJw9WkXpTz4u@fat_crate.local>
 <CAGxU2F7r_fWgr2YRmCvh2iQ1vPg30f-+W6FXyuidbakZkwhw2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGxU2F7r_fWgr2YRmCvh2iQ1vPg30f-+W6FXyuidbakZkwhw2w@mail.gmail.com>

On Wed, Apr 09, 2025 at 12:43:01PM +0200, Stefano Garzarella wrote:
> Sorry, maybe I missed something.
> 
> tpm_svsm.c registers the driver with module_platform_driver_probe().
> 
> Someone (the platform I guess) has to register the device by calling
> platform_device_register(), as we already do for example for
> sev_guest.

Maybe that platform device thing is the wrong approach. Why does the core code
need to register some dummy platform device in the first place? Why can't
drivers/char/tpm/tpm_svsm.c probe and init without it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

