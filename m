Return-Path: <linux-integrity+bounces-5663-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CEA7FDFF
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 13:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F993B6662
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5773268C5C;
	Tue,  8 Apr 2025 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AYWx5KYo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA1267B65;
	Tue,  8 Apr 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110052; cv=none; b=QljEL9t23x6QGHDTx3gAn3rngTHEzIbtnA19gyyFUgKEAj00GD+JRqoWiTMRH7aGVwhPoQ5TH405/c+4I/tQho2CgGN5bx9yoVT885HFzO8+OKs8c43kCFl5/bcl7Q9VJ2Fh9x1I/7zi9e65oFBIjUSGbmnrmg1GYuJq7SO1l3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110052; c=relaxed/simple;
	bh=wZtNChfV7QOu2QO2ElEUsUzkKu9O7qNQsyFXu5NwBt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3AfvFBekx84uqtDVExtNUdHIWqAmMNBpxnvdP10BDmZ7ew7cooMm/gwwhISJrQfrRwUqXGNRdmntSOO6S8VRGb357DHqraszVN6LaQEodPPWz2bl60D7dcmMo5iJpIS3yEuPIEUmsGD7IbDoyoSC/vATsURjopt4Oqxxc4zXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AYWx5KYo; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0BFF540E021D;
	Tue,  8 Apr 2025 11:00:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C04Qe2trqGVA; Tue,  8 Apr 2025 11:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744110036; bh=Mlgg2ceV8x70fyOMoJlodD+LImFBfrga3myZ0BJHFP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYWx5KYooH1CNy5l+82g+0TpOtccqXgbsnaSOlS6QxwRuc7lAxOmdvddOs+XsQ5TN
	 Q4fhtfXZapd4hWT3AwQeLUHxlkBc8fQLf0T+1rae/iYtuJPrSJ2RCNfQTW99J5YtpN
	 LqSXEVaI8bGy2E+ejeXObcTWszDzvDMm7zE095lE+cow8DyS9+Ol3e6Q6NIC3K4yED
	 q7Bwg0vehlrtsagcaFHQ0v3ZE41egIOndgIia4yFkKv7wabNUrKP17yKYkMlMF6L5o
	 huPMbm6smqvTpflQj+SlgIotT2B+TJUXSBGh2fW7lsO44ymx9iaVF4GSwX9DaV7AlA
	 MbmUBqeCnMJmPDammwCdU+CsXXU75DAJIgovdI1DUHL/STC+UiLDISf/f2uNIUx8Ux
	 EojYTLu954qpZMbsbjRBAdNKC8v5EQAEuKPjdnbgmM74lSN6zqAt3bjcApupRtvIVz
	 RMxDAHCXGqeWWKJBT9DKDsOvz/5Pe5cBFdTcwkhpz8IYzpjCdIzkN2GoKU2FfvL5Vy
	 z1s07mL0GM9wtnda5x2VxeIGgAArkM5YBwaxkbw2BWP4Ac6NXPCH4fagbiDDo7o0bB
	 TLHCCE4lLGOE7qBDmxetDidmM0XKv9TnOagCsP9vD4HRNXREyBfd7IY30I87H1s3q5
	 1+Pz7bilGO1pZMPI+KpaMeTM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0A9740E019F;
	Tue,  8 Apr 2025 11:00:18 +0000 (UTC)
Date: Tue, 8 Apr 2025 13:00:12 +0200
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
Message-ID: <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-5-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403100943.120738-5-sgarzare@redhat.com>

On Thu, Apr 03, 2025 at 12:09:42PM +0200, Stefano Garzarella wrote:
> @@ -2697,6 +2702,9 @@ static int __init snp_init_platform_device(void)
>  	if (platform_device_register(&sev_guest_device))
>  		return -ENODEV;
>  
> +	if (platform_device_register(&tpm_svsm_device))
> +		return -ENODEV;

So I don't understand the design here:

You've exported the probe function - snp_svsm_vtpm_probe() - and you're
calling it in tpm_svsm_probe().

So why aren't you registering the platform device there too but are doing this
unconditional strange thing here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

