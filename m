Return-Path: <linux-integrity+bounces-5168-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24982A5617F
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 08:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DFA1897841
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5591A2381;
	Fri,  7 Mar 2025 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnRSXatN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D942176FB0;
	Fri,  7 Mar 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331230; cv=none; b=dqOW8TxGrjOud8SclhAa0fjrk62Bn9JJb7aw1XUzo+Lag5i9pTcpvRIxjrrKUkh+yFzqCmo+Lnp7ZIZ2Tgwk6WLDyD+TEBG656XiYFn3y22NAFiPrHIG3Pgr/HFw3rkKlqZED8K4I6qLlf/Y5ug6C7n9jV5h8W0blIadlLdRxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331230; c=relaxed/simple;
	bh=NfUCXLX47qnl3g7ntvt7VcFk3/TMUuqaEmjkzg006yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lzf1lMDE5TL2VsoS9TNmvlgPDVkpzRGDiKBkXQfbkb8ZNMPggZWIf3qUy5G/6Rn/vHXL/ZAKoImwVcqZD1zj4wQ6nRiJYg+Fc6BugKxfRk52rzZSUcXSRSuR0UgmQSvXUQilbOpnySVwjnRHzYipaaDqKwQbuAeSUqoOsE9APkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnRSXatN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3853C4CEE2;
	Fri,  7 Mar 2025 07:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741331229;
	bh=NfUCXLX47qnl3g7ntvt7VcFk3/TMUuqaEmjkzg006yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnRSXatNyhfeQym42Mwoaq7lXelXEckosZP/mDV2JsO53Q/pdmGwCVIxA4HMR3gXi
	 a80cDvOig0TFhlfN9ill252VOAEoJ93bhhUPi0Ep8OEbEuFLuK4sMFGTI+CZZ4PV7I
	 6v0zPTnQEmi3kfiDq2fr+8IBi57gDTkX1FZTw54+d5Uu2RPcSveKf/3iwqZ1vXvsTC
	 RENa8d/Vwk9Es8Ro7RKoOHs6i+TBVf1yGBK89hiID6vLXWim/BANWKGV/Nhnyfe8Mb
	 Vxgz5W0wuTTUq+i33pEb4Ox+O9+zqan+JmGiMty1H0pQpL+KT4wqxwtg9L4rrxRrYe
	 tml2ZPM3hvkyA==
Date: Fri, 7 Mar 2025 09:07:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 15/19] tpm, tpm_tis: Address positive localities in
 tpm_tis_request_locality()
Message-ID: <Z8qbGZwi0yFyus0J@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-16-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-16-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:12AM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> Validate that the input locality is within the correct range, as specified
> by TCG standards, and increase the locality count also for the positive
> localities.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index c58f360fb4a4..c86100ad743a 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -234,10 +234,13 @@ static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int ret = 0;
>  
> +	if (l < 0 || l > TPM_MAX_LOCALITY)
> +		return -EINVAL;

I would mind if we put do dev_warn() here because it is unexpected
condition or even perhaps dev_err(). Or am I missing something?

> +
>  	mutex_lock(&priv->locality_count_mutex);
>  	if (priv->locality_count == 0)
>  		ret = __tpm_tis_request_locality(chip, l);
> -	if (!ret)
> +	if (ret >= 0)
>  		priv->locality_count++;
>  	mutex_unlock(&priv->locality_count_mutex);
>  	return ret;
> -- 
> 2.39.3
> 

I agree with this now.

BR, Jarkko

