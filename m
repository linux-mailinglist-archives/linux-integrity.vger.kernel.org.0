Return-Path: <linux-integrity+bounces-5198-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F06A59248
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 12:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78176188829C
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 11:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5F8223716;
	Mon, 10 Mar 2025 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j9RSy0HF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF81226D18;
	Mon, 10 Mar 2025 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604942; cv=none; b=mr3SiU9Mf0dKFt8bIrYMw7wA/NqU4eonC/v/7AWbfbbED9GLWxdsKzwYfUvgsJeHU1v15PtmzXxojv24Yblyd5tF0rj7+HGizsHxHDOuLmuTmvTHHb7OK3tWldlMkGDHa8KGs5ssgDNABekwlDuZpzrnEl3qBgvGe2Y3DXTG8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604942; c=relaxed/simple;
	bh=zyuUROdM8RYQHtdyR8GD86eCrfq6ILVcngJvYInm2Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un7AYdJc5uzj1ticRbQw7kaKLliaAHNnPspFwwMPEjwEhzjCorIhnons93XfHInCwA1AvtKjGXPSCB/5gDaXMicJkRlt438uySSKwqeIQ8uLla0uotSPDmJ3ElVl+Coq1QTSpGEDeAc9vBjGKoc7Vya2M8/gDuKfqPfScJOoBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j9RSy0HF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3F0F740E0176;
	Mon, 10 Mar 2025 11:08:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bKnyDEiQksym; Mon, 10 Mar 2025 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741604933; bh=YQAaINXv5w2Ci1rsU+w5Dx9VoI6ACjlMHpZFyp5XQpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9RSy0HFlqKlxAbOMr3YapFNwd0xktOUTfuUieUpH6MtW5IEpR6cR9MQsuVUA10MQ
	 BMkqTeprw9v+v8LpmvCbumr88U/SVTkkmsu2E5lHMU1CdRpsuUkXlILRbB2OxZIeuV
	 xh26yU0kKBjyI/L7h6KnpKFwzlol/RnsVKBN+RoRu32An/FUAwISUKOHfK91g3RsaR
	 nBeQ5LExjVwiyy7jsFwRRtehMnd65feMUitCSTix1X44V8AdXbYQqTt76GFDVVQj7A
	 XvlDAfm//Ue4dd7L8syXz0vrdEr84Ags/4ZpbvJYol1aoi6ZdcFA+rUfhlc/5C3JlL
	 b4AtwQiEOyYtpSQX/UUcwrdXqmO+7Cc3qkyorC/LiXr5ejYGnjynNeXHotd+V6G4mb
	 WXwZZxG1DGyfgmwN5Pa9Vca0pFQPEAJdacKCByyzddVzKozzf4+7DscdfUUL+ER9Ew
	 Quy8cd/rfSCsIjC41fSekVL3+7rKUkv87p8yQJ2FVgQNqkCGfXyzFZfx5UXjtVaGb4
	 LVtLYIJZ+5Js1Bf62nhwBSA4HPWDnKzVEhlFKSpHvpQXc1ViSeZf7koIP4JXmPnKal
	 weDhmzqF76Elfy/8XQC3C7254kuGX/6izP2uOk5inKJQ/UC1FDeNXzgnE8lpsr0xk9
	 VrlRgAi2vTCUMebcF4Q5Cb/k=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CFC640E015D;
	Mon, 10 Mar 2025 11:08:35 +0000 (UTC)
Date: Mon, 10 Mar 2025 12:08:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 1/6] x86/sev: add SVSM call macros for the vTPM
 protocol
Message-ID: <20250310110834.GEZ87IMgB_I86-3u3l@fat_crate.local>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228170720.144739-2-sgarzare@redhat.com>

On Fri, Feb 28, 2025 at 06:07:15PM +0100, Stefano Garzarella wrote:
> Add macros for SVSM_VTPM_QUERY and SVSM_VTPM_CMD calls as defined
> in the "Secure VM Service Module for SEV-SNP Guests"
> Publication # 58019 Revision: 1.00
> 
> Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf

Those URLs are unstable - simply naming the document properly in the commit
message so that a search engine can find it is enough.

> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  arch/x86/include/asm/sev.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 1581246491b5..f6ebf4492606 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -384,6 +384,10 @@ struct svsm_call {
>  #define SVSM_ATTEST_SERVICES		0
>  #define SVSM_ATTEST_SINGLE_SERVICE	1
>  
> +#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
> +#define SVSM_VTPM_QUERY			0
> +#define SVSM_VTPM_CMD			1
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  
>  extern u8 snp_vmpl;
> -- 

Merge this patch with the patch where those are used - no need for a separate
patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

