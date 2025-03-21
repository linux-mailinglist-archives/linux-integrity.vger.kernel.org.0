Return-Path: <linux-integrity+bounces-5375-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A716A6C59E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 23:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0893B5A6A
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4332327A1;
	Fri, 21 Mar 2025 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jza1JHb9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AED22FE03;
	Fri, 21 Mar 2025 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594751; cv=none; b=eR/S9Pq8fbomAF6tcgXuiYVbRiyga548nxW2YMOQH4dJqPqhwm1fD4DhzO96QqSUz2yF7kDeYeQJfXF9M9aud/4J+pUqO6Wh5hXrQXL0xMQXbyc9AP8+QAGJixDLKI9GgX7AhhnUXVtRJiQJgHO9Fj9OL44YPKxZq7KCjatAS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594751; c=relaxed/simple;
	bh=WEX2UAORnGyCNiA5AsfINcksrrjPKnMloADTiuGN7f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEPIfEO0eliG7SA7bGxiDIrDNiA1Syya7HUIBb82crQ9mOOVZP/GVpetFWUJxNdjMbZO9OzpLbwz8uspWvHFPlTnCNcPIgzvp7Y7SKE3pm7CsWagRbr8wY03y8U8un6CxF7RR3ohELlK87JpTcH1r0HrXCVgOpC8ETN9BykvHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Jza1JHb9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA69140E0215;
	Fri, 21 Mar 2025 22:05:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y7T3YEG9j5Q1; Fri, 21 Mar 2025 22:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742594743; bh=C2LY7NQdB5HYRcH/kmFKQKhgmQluG/i4PkyOlfRE1lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jza1JHb9Cjp7zdR8P0j2sa4jQgK5CdQAVRh6fvJIeD3UeR5Fj5AIVRI7+uMrd7+xd
	 gRO8fzUKbiLrCj0dr13hFaEAWeXlTRB4X9wi6P92iyZzkLQKliJ/f26TAQSImYXZT/
	 xkcRPhJ6ycPI1m8IWoxzKIFBNWt9oXaBa+frCy6hFZdNDfHUDdcItrUfVFb0ulBfCi
	 X68h2lhWqZoWLS5qXE3apiy2EBbJ8U021+LfHSezwPfBXGbkZnc6r3fjyxtX6GR6KH
	 rhzENopKUcWAygzCPkz/treBRHiwfJWXKzEVmOfPv2wvPK/v1fM9gCYXBLRNXliro7
	 vvB/2RFTTJJvOz/y9utMYAKUw8PnSLx3TZxm4PsaYVjsnpMx6bRC33SGVAwR6phNN2
	 +u+lJPYj3X12cZwrjw+3UlLiMDpzUaRHBvHQQRvevUUmbybZqBkIoUMkaUqzXijD10
	 GrD33ZHBO24vhHTHVIgoREJLXae1puSNodcMNJ7UnA2TqFlNFx6F2N64WfjHOr0lKR
	 bX1MsdsE5mbRVhOZM1pW66vYTiHi9YXjB+/43e9//oUV3fUdWG9M/mRquBEdA9SnmM
	 cmQnrmOPtCn0+fOcx+WeCJP2Dy1tL6+RIzPK8gd9qdsTnN0gx+hSVch1FRlGQYmGYA
	 aeWBZsnMF0kqeEOeNHWgrbMg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1140E40E016E;
	Fri, 21 Mar 2025 22:05:25 +0000 (UTC)
Date: Fri, 21 Mar 2025 23:05:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
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
Message-ID: <20250321220520.GFZ93ioO0JtfhXCb1n@fat_crate.local>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
 <Z9glWp6U6vyEmKQa@kernel.org>
 <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
 <Z9wuLVeP726Cssqp@kernel.org>
 <20250320171619.GOZ9xNY4W54avW2a-u@fat_crate.local>
 <Z9xQw8QpRKk26G6R@kernel.org>
 <rspkz663fg7i7jomvg5ehv3ldr6ayehttb7vgwwzsfsxafzb5y@uhqcadvsmw6f>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rspkz663fg7i7jomvg5ehv3ldr6ayehttb7vgwwzsfsxafzb5y@uhqcadvsmw6f>

On Fri, Mar 21, 2025 at 10:01:17AM +0100, Stefano Garzarella wrote:
> Just a note, patch 2 adds `include/linux/svsm_vtpm.h`, that file is
> basically a translation of the AMD SVSM specification into structures and
> functions used to communicate with SVSM in the way it is defined by the
> specification.
> 
> I realized that the file does not fall under any section of MAINTAINERS.
> How do you suggest we proceed?
> 
> Should we create an SVSM section to maintain it, including the TPM driver
> and future other drivers,etc.?

This all belongs to the TPM drivers, right?

I.e., drivers/char/tpm/

So I guess add that header to the TPM DEVICE DRIVER section if the gents there
are fine with it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

