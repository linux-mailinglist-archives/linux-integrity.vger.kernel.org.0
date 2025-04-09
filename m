Return-Path: <linux-integrity+bounces-5694-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC2A82F36
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AAA166985
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6A27703C;
	Wed,  9 Apr 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P5nJCRX0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C71C5F25;
	Wed,  9 Apr 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224335; cv=none; b=KXlG4AuaYr7kaJn/CtkwE1rWlsJ/gP+ciIfsxlhYR6cDxAHWZBXl8vUXTvgujvPUsS6h2Jru8L09Fx6XT7LQxrLs9v4hTB4B9csJ16WGF+iYPyKA56/gAJRoaGHpB9XeWsHwYcfLQnY1xjC6VdoLiLCDa6lFSYvD82QRry83mkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224335; c=relaxed/simple;
	bh=/ZlVDpYIBpkIkscgi0Zebagev49/nValyxmXsDgheCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWROnk2cn6kTbma2Y+HOq2eMfQyokC3Uj2JwRS4IpIOT6wUbuEIFanFz1X6yC88mEq0pXJGc7QSE864sfB41fhYbRSMwQKhxloVdymU/Bfk6y4hZxR2wFSVHogGAyr1moyGsS+dYobltnOiHJBA/pWx7wfye4CMjgB6vL9h5ZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P5nJCRX0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 07B7340E0243;
	Wed,  9 Apr 2025 18:45:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JFxxW92qANam; Wed,  9 Apr 2025 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744224326; bh=HdVXctVtqz3LSAVj5XmOBaYDJycOSuDUr7WDPj+9VzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5nJCRX0qcS0/GkVh+4s2Gv6S0CMFZR1ihrDPFLNGTXrcLJOwVFpnxRHG7nMdhge3
	 iykXlVU6kLyaQVT6AeJfwhIu/GxD+Y9EmiUMxRiCVMg3BxGmUD7Yr+9AfqO4f+bDPV
	 eSsihhrI3GU+kTfqisXpaV1mnxSiQq6uDUE/6/bKKrU0euogAwMk17s09NMekHYmUo
	 LjKVX4zw3Rn3Q/mMf32Chrn12v7dA5sn8SJcpNTSPl3BuYLYJT6q9ctg18aSxAzbd3
	 ibeTD11wi6ewU7Rb5YhQQCxPZ3QjyoycT7lXvmUp3dHM8LuW0YIPGp5p7Bs63dy+w1
	 XvWcJ0mSY/zet0cZHL57A93coRf9IRrwGGjWjn7x5kwId0UIW1NCx7C8v4X1fv9sgn
	 +zcVmOomOx2Ih8u4gxuDHAD3gwcglDjmtqBzVDNbQAG6zZJ3uS1L6PDLoh6fREciOJ
	 W2hQgFzdMXjZzry1GG1rfV+nUOWFvFmlnTaFPDWZ5sKZFPyCELpsO7sy9ctMMlzmuP
	 xRCeEafNKBuGxmbLspMrvDXenxIE2sHjmL40n9cpd7rwgDORbUcQm8m1EbXYYjyAEP
	 2gnrimZ0jtXACTBVAopTLk4s1gIvm963dS7zzxZI6DAhxbX+OKsblRLjSZlV4yA+Ls
	 49SPox/Op4idhVd0qFaP9eHE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95F6340E0242;
	Wed,  9 Apr 2025 18:45:08 +0000 (UTC)
Date: Wed, 9 Apr 2025 20:45:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
	Dionna Glaze <dionnaglaze@google.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <20250409184507.GLZ_bAM8LCPXKn9xU1@fat_crate.local>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-5-sgarzare@redhat.com>
 <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>
 <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
 <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local>
 <o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl>
 <20250409102120.GCZ_ZKIJw9WkXpTz4u@fat_crate.local>
 <CAGxU2F7r_fWgr2YRmCvh2iQ1vPg30f-+W6FXyuidbakZkwhw2w@mail.gmail.com>
 <20250409113154.GGZ_ZaqgfRrrMij_Zm@fat_crate.local>
 <6e5bf479-ee95-a996-5845-1f76730e2488@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e5bf479-ee95-a996-5845-1f76730e2488@amd.com>

On Wed, Apr 09, 2025 at 11:07:49AM -0500, Tom Lendacky wrote:
> So the vTPM driver wouldn't change, just snp_init_platform_device():
> 
> 	if (snp_vmpl && platform_device_register(&tpm_svsm_device))

So this basically says that the SVSM is always sporting a vTPM emulation. But
you can build the cocont-svsm thing without it AFAICT.

So I'm guessing Stefano's suggestion here might make more sense:

https://lore.kernel.org/r/o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl

considering it all...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

