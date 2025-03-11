Return-Path: <linux-integrity+bounces-5221-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2ABA5BCF1
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B2D1890D9D
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF2222B8D9;
	Tue, 11 Mar 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsXAyr05"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB81E2606;
	Tue, 11 Mar 2025 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686987; cv=none; b=m3K3YZBip0FJp2+AS+svi0N5GU42dq6QMF/1a5jnheGuJi2BLET+w/QpzCzoIXPkXFRh1PWCAuqNJtCMrZb9PzOcZTfZQvKCI5qbNRNTY4WSa+lPfQ/8Ikm9ez3tIM9iSKsjeb+gdpeOTvKrfNMVOtwRq2Bg4IFErP7nKrlt7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686987; c=relaxed/simple;
	bh=cGlSSXVSEuK01WXgLlK5ZZp0Gub8yc9YqoK75j3+P/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC52bu8WFk+8AzNlL9cQvgyyTwSy9YgYiaOBw7BgIqH5IEmE/NVSSoxzVm9n6RjTwMK20+uzewhncXj75oe7yLNepYA0ylnkbVjkLhXVH5IpCGQyF6e4KfV4wL8Y6JEgQHluABaXFt/6hNqTkeuZtXzD7shKPu/VCTNFEOU/3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsXAyr05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB64C4CEED;
	Tue, 11 Mar 2025 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741686986;
	bh=cGlSSXVSEuK01WXgLlK5ZZp0Gub8yc9YqoK75j3+P/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsXAyr05H54DpYqK/bZh1TYBhvU9Vwt3WryKG118xyz1w28zF4KIqT8EFm6d+BOjE
	 NHNY4vuQZp69Xi8YKqdBV0dXdYK1ocNLqADDZnYin3lxGeQ1cG9S/Fw03HzV33AW/F
	 OZI3J8MtGU4i9puQyn0/v9fG4azMSY/YaS/UadMKy5hHb8SHWYPcKeMcEeH/R6G+7H
	 mC3I9Z+y3YMjM2czQxPnlWFmkHDJzGfkhf6hdR882nVNaBGd3GHSTETeRwvB5Ik49m
	 UDCQejNw5YHXko61uQQGa3ve1v5AwTB0O3W1ZgEdlR+zvAM7RCwXr/ltdDeS9vM0wH
	 JAkEEJrSO8lcQ==
Date: Tue, 11 Mar 2025 11:56:23 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Tom Lendacky <thomas.lendacky@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
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
Message-ID: <Z9AIx9kFKWcHB_WK@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311094225.35129-2-sgarzare@redhat.com>

On Tue, Mar 11, 2025 at 10:42:22AM +0100, Stefano Garzarella wrote:
> Add two new functions to probe and send commands to the SVSM vTPM.
> They leverage the two calls defined by the AMD SVSM specification [1]
> for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
> 
> Expose these functions to be used by other modules such as a tpm
> driver.
> 
> [1] "Secure VM Service Module for SEV-SNP Guests"
>     Publication # 58019 Revision: 1.00
> 
> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
> - removed link to the spec because those URLs are unstable [Borislav]
> - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
>   in this one [Borislav]
> - slimmed down snp_svsm_vtpm_probe() [Borislav]
> - removed features check and any print related [Tom]
> ---
>  arch/x86/include/asm/sev.h |  7 +++++++
>  arch/x86/coco/sev/core.c   | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ba7999f66abe..09471d058ce5 100644
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
> @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
>  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
>  			   struct snp_guest_request_ioctl *rio);
>  
> +bool snp_svsm_vtpm_probe(void);
> +int snp_svsm_vtpm_send_command(u8 *buffer);
> +
>  void __init snp_secure_tsc_prepare(void);
>  void __init snp_secure_tsc_init(void);
>  
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 96c7bc698e6b..2166bdff88b7 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2628,6 +2628,37 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
>  	return ret;
>  }
>  

Since this is an exported symbol, it'd be a good practice document
snp_svsm_vtpm_probe().

> +bool snp_svsm_vtpm_probe(void)
> +{
> +	struct svsm_call call = {};
> +
> +	/* The vTPM device is available only if a SVSM is present */
> +	if (!snp_vmpl)
> +		return false;
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);

I supposed CAA is some kind of shared memory area for host and VM?

> +
> +	if (svsm_perform_call_protocol(&call))
> +		return false;
> +
> +	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
> +	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
> +}
> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
> +

Ditto.

> +int snp_svsm_vtpm_send_command(u8 *buffer)
> +{
> +	struct svsm_call call = {};
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
> +	call.rcx = __pa(buffer);
> +
> +	return svsm_perform_call_protocol(&call);
> +}
> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
> +
>  static struct platform_device sev_guest_device = {
>  	.name		= "sev-guest",
>  	.id		= -1,
> -- 
> 2.48.1
> 

That said, these are rather self-documenting (i.e, nice and clean).

BR, Jarkko

