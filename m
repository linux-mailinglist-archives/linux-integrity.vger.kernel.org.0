Return-Path: <linux-integrity+bounces-5586-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E20EA7AC3A
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 21:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9314178C59
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C91426A0E2;
	Thu,  3 Apr 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjyQtAk5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE526A0D5;
	Thu,  3 Apr 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707180; cv=none; b=CBfgCKUe5u+bHXSSreOWyv+f4KidGzCUjdyYmZUcAdRzbiug2XZDMeb4Dq+U9QE58VO1BjuvaG+kmVZmcUUJsHMNq9Dqfq4bJEQFVGZRQf1B14H1XkB/jWKdlndOMtLoEsOvxmS1aKVjtfb4g/9Vmj9PgbLND3uKzr0LCuEtnSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707180; c=relaxed/simple;
	bh=oNNjA8EC+8Tze8+EjqGh3HwWCcanNkzZDN6YsmK0UfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLZsd52AaE3T4lxeNFqMMSA3Y0bIB3Kh5qnibtXeeI1hnu9PpDeofy+hNlAue54VZe1n+q3QhcVXeA3Cyi0+5bA/5cUEdn9SlPO11VkNIF0dyG4bjwVt3nrzqHe0GWSvENASYsB7o4mz5lin7CgkN2AFiRh5kyHxppfJl9IQbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjyQtAk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E1BC4CEE8;
	Thu,  3 Apr 2025 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707180;
	bh=oNNjA8EC+8Tze8+EjqGh3HwWCcanNkzZDN6YsmK0UfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjyQtAk5SiQP0qmcsCbTK/1US2OVDIxOkxm4hOmOfP+0OKZNpm5TO04oiD6fEUo9m
	 OkUMjeL+GrFSvLDWIy2N372ogBwF4dZJ3AI/jIun8Yb4gdKlhOoyKjP7Wh0CBjRVEy
	 M5KsJuWXiIksRZBeVoB4P2HgGDk30tM0c7rzsvfnN1hn2agZgNHXGfsd21PUa8ChX7
	 J9RZ+eH1bo5nKmsEwzh72UNKPE96x1aBUBduolDOQ+vFdrq+1Kegyv2RKHlom7Cxgq
	 eU5wZdzgmQJxnzJM5bR5HEENjggrvE6KIT1ObuHMsZWvXO3HCstHt13Gx3vG+FTB93
	 4pZrzh1E3TELw==
Date: Thu, 3 Apr 2025 22:06:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Dionna Glaze <dionnaglaze@google.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <Z-7cJyB1LXi75Z0F@kernel.org>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-5-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403100943.120738-5-sgarzare@redhat.com>

On Thu, Apr 03, 2025 at 12:09:42PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> SNP platform can provide a vTPM device emulated by SVSM.
> 
> The "tpm-svsm" device can be handled by the platform driver added
> by the previous commit in drivers/char/tpm/tpm_svsm.c
> 
> Register the device unconditionally. The support check (e.g. SVSM, cmd)
> is in snp_svsm_vtpm_probe(), keeping all logic in one place.
> This function is called during the driver's probe along with other
> setup tasks like memory allocation.
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v6:
> - added Tom's R-b
> v4:
> - explained better why we register it anyway in the commit message
> ---
>  arch/x86/coco/sev/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index efb43c9d3d30..acbd9bc526b1 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2689,6 +2689,11 @@ static struct platform_device sev_guest_device = {
>  	.id		= -1,
>  };
>  
> +static struct platform_device tpm_svsm_device = {
> +	.name		= "tpm-svsm",
> +	.id		= -1,
> +};
> +
>  static int __init snp_init_platform_device(void)
>  {
>  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> @@ -2697,6 +2702,9 @@ static int __init snp_init_platform_device(void)
>  	if (platform_device_register(&sev_guest_device))
>  		return -ENODEV;
>  
> +	if (platform_device_register(&tpm_svsm_device))
> +		return -ENODEV;
> +
>  	pr_info("SNP guest platform device initialized.\n");
>  	return 0;
>  }
> -- 
> 2.49.0
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

