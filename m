Return-Path: <linux-integrity+bounces-5643-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C97A7E014
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACA51886EF5
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501513FB0E;
	Mon,  7 Apr 2025 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UPPvKkJH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9C149C51;
	Mon,  7 Apr 2025 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033639; cv=none; b=LEv1hxLwN62xPS8cP/tj9JwooRQXVqGsECJNqtVBdQ3a4MWf3qN6KrY7SnKPIZ3xXw1zFXTCDiAOXrr/Ll+8ARVmHVOEfkaFJRO8OljUDwEZ92NmFtkcHIF0ngJHXiBIbv6lnBiEdLys0OdNlUbCNCki1vt/NcGEkkjb3cLcASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033639; c=relaxed/simple;
	bh=vNWTMdv+jOoNEEp8FYoMLcDNadO7j1Y3ZibXpl+7a4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aolPimi2pgKvY8+9L0aD0lOqyU8hax8y0B4cFy5fG4xp23EdfWlnajBZRpiZ9iqXi3r2lRKtPeBDMutWyim5apMeGwkbZcInzZuaZkubeOWLwZL1eHyLha6fc/tqd91+CJLx20d+vPd0gbqWPFhDQpOAkPc+W/s+3UWmh73sRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UPPvKkJH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7FE1140E0214;
	Mon,  7 Apr 2025 13:47:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W35ScQmYY_sJ; Mon,  7 Apr 2025 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744033628; bh=C+DuWs1QJWCyb+Jz2U+p7g01q+x5MgKJ0a73l6qpKdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPPvKkJHieclp2Wt2o8CsohsLi3oXKOkbYBOMOVZy2+2Emp0LA4cwUhQoXZWyQfnw
	 Eut9e3ssiA4hn94EdNU/GTsJnc7IrjZcG5bJlf+shsvMScRocDQ7/rPjVLMb8rok5m
	 2UbOaq/Kt2pt5W/BPkeEvGA9KZNhYyo8SQb9vBA8czHS7cv806Ofv5m2CZR7V8BWJ0
	 8fYPdV9mZ74FrJQFWsQY0Aiw7Lmzyou2ACMhtHiy0Q9ajJOTvUvkZiZAhbXr7AM8/O
	 dw6GfjdH4M0nZJR35pfv3F0C+R7jf7P84EUemW0apmj2J7DXbFgcca1rLjCxcqLeDr
	 jM3ZsKXxYaBMgDtB1VTibFZKd234cmDpAybbLFBsbEBnUpjB1A72rIJ6N1UsBRfgdB
	 Q7IQzP7HiuFwhTs3gsxjLlS94itJ8D0y9SMJ5OiM4FAQihU4JLNQEpkzLrC1el3K8A
	 wU3TxSj3OCJN1lFCdR+a8TFPGbOYoosqkn4OwEn7GiHeHWtB0Ig9s/ac1i9Smmkqe5
	 ihhUiRUoEch+K9UgDXopkStgG+vFQwZ0rxqYG18W9yEQX/rkkMyjJGWRFpOycNlr+f
	 FK4JLIsQKZ1jU4G1VSvLvRV5GCeMwO6H9DHrbPLjT1uE0zE/G0sel+BTsiEL1GQ7i0
	 Xkve7DdzMvtEYcCCG1toS5fc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 138D640E019F;
	Mon,  7 Apr 2025 13:46:50 +0000 (UTC)
Date: Mon, 7 Apr 2025 15:46:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH v6 0/4] Enlightened vTPM support for SVSM on SEV-SNP
Message-ID: <20250407134643.GDZ_PXQ0OlzcMjiGgp@fat_crate.local>
References: <20250403100943.120738-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403100943.120738-1-sgarzare@redhat.com>

On Thu, Apr 03, 2025 at 12:09:38PM +0200, Stefano Garzarella wrote:
> Stefano Garzarella (4):
>   x86/sev: add SVSM vTPM probe/send_command functions
>   svsm: add header with SVSM_VTPM_CMD helpers
>   tpm: add SNP SVSM vTPM driver
>   x86/sev: register tpm-svsm platform device
> 
>  arch/x86/include/asm/sev.h  |   9 +++
>  include/linux/tpm_svsm.h    | 149 ++++++++++++++++++++++++++++++++++++
>  arch/x86/coco/sev/core.c    |  67 ++++++++++++++++
>  drivers/char/tpm/tpm_svsm.c | 128 +++++++++++++++++++++++++++++++
>  drivers/char/tpm/Kconfig    |  10 +++
>  drivers/char/tpm/Makefile   |   1 +
>  6 files changed, 364 insertions(+)
>  create mode 100644 include/linux/tpm_svsm.h
>  create mode 100644 drivers/char/tpm/tpm_svsm.c

Jarrko,

should I take the whole bunch through the tip tree?

No point in splitting between two trees...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

