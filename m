Return-Path: <linux-integrity+bounces-5684-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8812CA821EF
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 12:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6493F17483C
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C325D8FE;
	Wed,  9 Apr 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="S/m3II5g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F5725D210;
	Wed,  9 Apr 2025 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194113; cv=none; b=Hhq42Q1OcZj6uX86JjAph2IEw73sGVyU0KVfDnZRZgPvx6Ta6Lwj82egtKlqxgbwsjp0ZHCBXxpjP0myrNZ7wvbh17NIDJcMlyeSBv8gFTfetE0ou0ssdCj/REo9fiCboinnbr0sjtKwrv0l3c4rPCozE6DgybQsy6KST7F2GlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194113; c=relaxed/simple;
	bh=Eii+L39OXwFZmZOHe9jC/ClgXBjhy46H/MkyPmQzbOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhoE9JpmI78Bn2i3TNTJfQoGmxGsZVB9428pJECgYIcH5qYAtlpqqftiXABEkPm5b7lw1119kcvs5KfB7SUybJpA/RABO9QITyv2L9sekYMcoWODaAEuEQXe9wO+sC+z3OLdAtp4vU+NOHwa2Vg2gP6/k9YHbADY/V1wUHxJqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=S/m3II5g; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 840DC40E0169;
	Wed,  9 Apr 2025 10:21:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IdPe1oU2-Z7K; Wed,  9 Apr 2025 10:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744194104; bh=mUIFDVkMZzQeOD4l3VAvf4aBTKHL5pkr5q3kkCACSDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/m3II5gHDo+pe5jAUtq+YgJYveWg5OoefZTIjCsOFyYN2oKvEqOxmqmZvi/zMnRj
	 ChPyTzKud+GWhKDrwAEUd4toE4NqucDHjkg78iXxjbxJ1z2KxeMaqZTAMs3cJAaLDP
	 rfsIUFEJFE4Ib+fqbVVs+pod++Oy9n/0lA9TkfVwLbLl2/RnjbMb2Xvj5+SS53Fdwy
	 kOMljgsYTeiYJ+eXppPJUTIvqimNgUrDfY0Nyb4FnuhJkrnwK5ITRq56CnHK3uyHqn
	 hQqQterNo3WG7EUcxvWabjGrMNbYGinGAbM4tMPhB1SK6YnLIBBZG4iuPc/OSXGhF8
	 D5QR806GYC/CHnCOqAiCHnCs4JJisWaB7WBGjDRGaX6tIN1aT/0sNqqMhjgjvPvPEG
	 zLXkjTB+dre/Wk2WAn2ncXz17iWnfe6+Xz58jLOYcNxDckrECG6AwH52fXZfc8PfVE
	 DBLHKaZVpYG2J92HQzO6Q9avDWndOMG2sXDicM7bYhd7CykSuIKpwbWUYGTEFARSye
	 T7gVR4pR17zJCbsCpJG6Ab937qmef9HIeHGJcLJczZ31uxSflpyVunLm3LoFkCG64Y
	 7wg+Q9B7MkySq743hiMk0Z3J3U4+9bGA6W4rrdXNeHpUMNBqxov8cfWXgFC6vE+VJf
	 RquYuR4xhdjSJfEB2h9iX2UE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 740E440E01A3;
	Wed,  9 Apr 2025 10:21:26 +0000 (UTC)
Date: Wed, 9 Apr 2025 12:21:20 +0200
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
Message-ID: <20250409102120.GCZ_ZKIJw9WkXpTz4u@fat_crate.local>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-5-sgarzare@redhat.com>
 <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>
 <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
 <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local>
 <o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl>

On Tue, Apr 08, 2025 at 01:54:07PM +0200, Stefano Garzarella wrote:
> I see, so IIUC I can just apply the following change to this patch and avoid
> to export snp_svsm_vtpm_probe() at all, right?
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index acbd9bc526b1..fa83e6c7f990 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2702,8 +2702,10 @@ static int __init snp_init_platform_device(void)
>         if (platform_device_register(&sev_guest_device))
>                 return -ENODEV;
> -       if (platform_device_register(&tpm_svsm_device))
> -               return -ENODEV;
> +       if (snp_svsm_vtpm_probe()) {
> +               if (platform_device_register(&tpm_svsm_device))
> +                       return -ENODEV;
> +       }
>         pr_info("SNP guest platform device initialized.\n");
>         return 0;

No, this should go in tpm_svsm_probe().

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

