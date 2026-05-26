Return-Path: <linux-integrity+bounces-9684-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMMIFhj2FWqzfwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9684-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 21:35:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A50AF5DC08C
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 21:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B91593036434
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3583AA4E1;
	Tue, 26 May 2026 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI2hQmpE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52D3A4F47;
	Tue, 26 May 2026 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824148; cv=none; b=SXWIlyYJGemedllNnpIPr/gHsFz45wzokntt2tfU2DCwmopZSUYeReQeLx50iRsL6UWljuvmzZwseC4luX+fRtVz4ZDtu7YuwjPXRtE5TEgEvWjg31u3y5xJgBAd/wdp9/bIY+IzoqqabedbcFfxHifioVZ1Mi4z3yvO1geJOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824148; c=relaxed/simple;
	bh=fCt0NNLafq5Ulnhjmcnr3WsqilugN8RDFSIfiWZgBQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtUy0eytFPgt93WYTQm6Xr+X6N0WJ/j1hbSrbPxb/Ubms3Y+75qF44yOH1u9EixH5HzBlXD5dt8V+ktDwvmZcnzMd5Z7C864r/kG35N4EN5DZo2imF45W/CMxnUp8GOJ73xiDXLugv4sR6hzuzTcwHwkwJONA66T/e/C2gE/qc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI2hQmpE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2820A1F000E9;
	Tue, 26 May 2026 19:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779824147;
	bh=UqsXzG3EIwp1sqqf8YZYAAjA95+BZS9vLPguSQeo5Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NI2hQmpEQE/z2Z+7tSge10ATcMoE1mRlOv0DhD0ugjyRU8c2YkeTcET/dsexrEUuI
	 NxWxcN5OYV/eg8o9PKGj8IlOs6gyc+Thd8rGvEeP032p2tY+eC/tzPoned/ulilAO/
	 X2S+PGlRRo8VZASpofRBcHQTuJQPIqzh561oweaoJJ4Hi0nOEvLsLGSZBKcJaiF3Z6
	 CxEu+yj+o1BSaHDOci5WbBZn+7dp79waI68V8PVkUWse7BCiYkUbEFOa+huLp5dQ0H
	 /45bVYFa1BKQu1uvIiqFiSFstTPw2GPObKEIkixs/hj1fbmRAT3VOtlTschOIxgRw3
	 CeOXypizc93Sg==
Date: Tue, 26 May 2026 12:35:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH] firmware: arm_ffa: Treat missing FF-A feature on a
 platform as a probe miss
Message-ID: <20260526193543.GB2851089@ax162>
References: <20260526103649.5684-1-sudeep.holla@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526103649.5684-1-sudeep.holla@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9684-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A50AF5DC08C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:36:49AM +0100, Sudeep Holla wrote:
> When FF-A initialisation is driven from a platform device probe, systems
> that do not implement FF-A can return -EOPNOTSUPP from the early transport
> or version discovery paths. Driver core treats that as a matched probe
> failure and prints:
> 
>   |  arm-ffa arm-ffa: probe with driver arm-ffa failed with error -95
> 
> That is noisy for a firmware interface that can be absent on otherwise
> valid systems. Driver core already treats -ENODEV and -ENXIO as quiet
> rejected matches, so translate only the early unsupported discovery cases
> to -ENODEV. Keep later setup failures unchanged so real FF-A
> initialisation problems are still reported as probe failures.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20260523001148.GA1319283@ax162
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>

Appears to work for me.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/firmware/arm_ffa/driver.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 54984e1b9741..0f468362c288 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -2109,7 +2109,7 @@ static int ffa_probe(struct platform_device *pdev)
>  
>  	ret = ffa_transport_init(&invoke_ffa_fn);
>  	if (ret)
> -		return ret;
> +		return ret == -EOPNOTSUPP ? -ENODEV : ret;
>  
>  	drv_info = kzalloc_obj(*drv_info);
>  	if (!drv_info)
> @@ -2117,8 +2117,11 @@ static int ffa_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, drv_info);
>  
>  	ret = ffa_version_check(&drv_info->version);
> -	if (ret)
> +	if (ret) {
> +		if (ret == -EOPNOTSUPP)
> +			ret = -ENODEV;
>  		goto free_drv_info;
> +	}
>  
>  	if (ffa_id_get(&drv_info->vm_id)) {
>  		pr_err("failed to obtain VM id for self\n");
> -- 
> 2.43.0
> 

-- 
Cheers,
Nathan

