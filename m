Return-Path: <linux-integrity+bounces-5665-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2AA8018F
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 13:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D31168966
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C976E26AA8C;
	Tue,  8 Apr 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ibcQGZnE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347C26AA89;
	Tue,  8 Apr 2025 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111732; cv=none; b=Ur5W9TYaEJj5txbyilCw5DMrQxxID+uO9/G+hoEaOEXkYbDRexSHJocXLyYDnPOsQ1xxb9U0GpJFZqoR7l8kQMogkHwTJmmu74D6QTjL3sfgb/gXc2RCqQrt4SQDlV4mXca9VCyQK2JjuJt2dqdS5PUgxLErstfDoa5xDsRmfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111732; c=relaxed/simple;
	bh=6qJ6F7rz10p2KV/b2kiY1qq3waPBKfuy+Kem9IVn4aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3nHQ4Skqi/+Cg4triaVIuzOC6zzk4zo5Uut2Hh9LfasKzWlCp9at7NJWJl5XgFNQ4AW24z43xEer3qmK83A8Cd0T2ae9DLO7FWyG/+ytCRCjhcFtgxyzOJ217rhceLCLWSTezRM1R9DjEptOGPkJIV/qj5lQxjEzqITTiJbkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ibcQGZnE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A483B40E016D;
	Tue,  8 Apr 2025 11:28:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u-5FaaXPX64U; Tue,  8 Apr 2025 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744111725; bh=DzvfTbBLK3b9KeAyxUW3YDt5zgEi3cPlOHPmbIKE+KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibcQGZnEsOGVV9bGdao+uJ0Y6fx/DuJhWtrtaZf2dO8ExQ1/UakLopAZkxPVhNaB/
	 +OApIc91iwj5fojgX813g8TTWeyPP/xAfKR/Fq+Y5vY+uM9TlkjVLd0dlKWor77j+V
	 I/waRNPMY5MPp+c6cqix/EmPc+ByJed0m8ibvBn4U8lDAocYBIdkhiDneiopii4ZKk
	 c3dlUXmG0qcP+SURwFvLSjHaLwzq5Us4yAlTUG7RKc43H43y212+IRPrHNnP/v9qpM
	 S1xE4Ldu5YGdcL6Eqwn00KkDyf0UHT82geRImYwZGelMvSgA6bc628q23ZFDU7kJNE
	 YLl5yTuPeO+HEo5KMdxCUz713HYT/t90qWS8eyD1bQwMZZMcbXc/RFyymXsW94JIki
	 BtBTCxSdK5ArnJ5KdC0K4Zum9POKSuS57/9Upscs7d+nlEi0E3GT7caY65SHdVbHG1
	 /FzvLytumrJpa/LsGFbXLCvk8vGAc2YCTC7WcXZueRs0cltzgf/lkhayB0rLLMrVIh
	 a/ek6eglghNyrJgckud2JkMD3k71y7tDEdDWpny7Admpje7w5Ea1itPYwCQP1KK/Q4
	 sdK43PTOKhgLpj2tzfjhbuxG7OwA2HbN90qKRrayVWCFhIrlNtWEf5g4EENhNofZ26
	 Ldaq7b4PL20tXCy9BTFWFko0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DAFB340E019F;
	Tue,  8 Apr 2025 11:28:26 +0000 (UTC)
Date: Tue, 8 Apr 2025 13:28:20 +0200
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
Message-ID: <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-5-sgarzare@redhat.com>
 <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>
 <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>

On Tue, Apr 08, 2025 at 01:08:36PM +0200, Stefano Garzarella wrote:
> We discussed a bit on v3, but I'm open to change it:
> https://lore.kernel.org/linux-integrity/nrn4ur66lz2ocbkkjl2bgiex3xbp552szerfhalsaefunqxf7p@ki7xf66zrf6u/
> 
>  I tried to keep the logic of whether or not the driver is needed all in
> the tpm_svsm_probe()/snp_svsm_vtpm_probe() (where I check for SVSM).
>  If you prefer to move some pieces here, though, I'm open.

Yes please.

It doesn't make a whole lotta sense right now to register a TPM platform
driver at one place without even knowing you're running with an SVSM inside
the guest blob or not.

The usual approach is to register upon a successful detection.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

