Return-Path: <linux-integrity+bounces-9721-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB3aMRlAHmraiAkAu9opvQ
	(envelope-from <linux-integrity+bounces-9721-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 04:29:45 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC8E6273AE
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 04:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 955283001A7F
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 02:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8A360ECE;
	Tue,  2 Jun 2026 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHDepwWR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75B2E06E4;
	Tue,  2 Jun 2026 02:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367380; cv=none; b=fWge6qwgrtqmWfXN4ocT2RcLomNN5t0RoLbsYgIE0ZFBLXcpIe/k2r9bW8fzRLnXZCPUo73oKlN8v7e5sbn4B7lwm2KBoqb2b0LhNfvulGDe7v3tKjAkx9Lv1e6w9j7qkPstecomsN6W5P2FcQlau3lDCiHseXifgW+3RnsPR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367380; c=relaxed/simple;
	bh=2bYOjmMnM1KJCF+54LeR9e6MEQXh2776Q/3uxsWYPn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufQb1euRHLxkg7wqRhSOfDj3eO9Wcaxq3j6DARr542tjX1T7UqkTJUVkEpFuEKqexr4Lbe6pdTGlBmp5LPwHCL65Jo7tcogjGeuIbO4NwJpjgDUzyXa0Nq/PtmzPwWG0NED6/1QdAdSZLmV3jqRQetCASnd0axb3woTzK7zZr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHDepwWR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3C63D1F00893;
	Tue,  2 Jun 2026 02:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367378;
	bh=/WGDfTGTOMOX+M3x1B0dBF/gAft7vbHy9l3PRqdaEGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PHDepwWRn0mGz6fYTluWxOs0GRHHhT0CFFNYkwIje3KXE+Q1CZl/e8G299J/8LRVK
	 AEYgcE1VmNSBO9EXRzAqE5CHCHAWXR1SO5DdU0FqKk8NznDb3v/8H0L/LHacd8/yxM
	 cGxqdZr/YeFAN0hkv1BuncUU8/Z+0JFTbtzW8tfRq+VneWcUGire67FQJj9U7s7wri
	 pHyL92Oyiaawa7pz9aiv4bGwYvnxFzb5g9bN3kbP8fWWKDgR8kaJBtJjF5E1EofwBl
	 k3AUak19MVj4hKnPHO6CMLXxEp3vUbO682MwPatq8ywmYfvWfZiSX7xgjaJp0SM8Yc
	 rRduzCGcWYR9Q==
Date: Tue, 2 Jun 2026 05:29:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 4/4] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <ah5AD69RNBdE1BvO@kernel.org>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
 <20260601142749.3379697-5-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601142749.3379697-5-yeoreum.yun@arm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-9721-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BFC8E6273AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 03:27:49PM +0100, Yeoreum Yun wrote:
> commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> 
> However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> initialises IMA at the late_initcall_sync level, so this change is no
> longer required.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  drivers/char/tpm/tpm_crb_ffa.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> index 99f1c1e5644b..025c4d4b17ca 100644
> --- a/drivers/char/tpm/tpm_crb_ffa.c
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -177,23 +177,13 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
>   */
>  int tpm_crb_ffa_init(void)
>  {
> -	int ret = 0;
> -
> -	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
> -		ret = ffa_register(&tpm_crb_ffa_driver);
> -		if (ret) {
> -			tpm_crb_ffa = ERR_PTR(-ENODEV);
> -			return ret;
> -		}
> -	}
> -
>  	if (!tpm_crb_ffa)
> -		ret = -ENOENT;
> +		return -ENOENT;
>  
>  	if (IS_ERR_VALUE(tpm_crb_ffa))
> -		ret = -ENODEV;
> +		return -ENODEV;
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
>  
> @@ -405,9 +395,7 @@ static struct ffa_driver tpm_crb_ffa_driver = {
>  	.id_table = tpm_crb_ffa_device_id,
>  };
>  
> -#ifdef MODULE
>  module_ffa_driver(tpm_crb_ffa_driver);
> -#endif
>  
>  MODULE_AUTHOR("Arm");
>  MODULE_DESCRIPTION("TPM CRB FFA driver");
> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

BR, Jarkko

