Return-Path: <linux-integrity+bounces-9668-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD1pHEJ8FWpEVwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9668-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 12:56:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E04085D4775
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 12:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F9E303CE97
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A3C3DDDA1;
	Tue, 26 May 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k6YMIO2N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF573DCDBE;
	Tue, 26 May 2026 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792688; cv=none; b=R3Y0KtBV++ZpQYVzyLi6WVMuOSSPAZkPvOUrq9RVBRww0CU6fjJKoq+mo/3+q2q3oyEj+SxSY2p+0GLQV+uCVKIFKZjEGBVhwifBOiGDrMXDvNt9BOhleOqUw8tufFEf84p5wCpa4g3j3c4+CZwkiLxNB6lK4o4kaACXGycLnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792688; c=relaxed/simple;
	bh=ZxOUuceS2mxmDx2oNv6hCdsGaOdZS8PVj3M7iP62dbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQt4AN4azB8uZbeztntdfCnfNgERZ1V2dZQUdIh1rvaHr2BrGnJxHCZ7v/MH/W3ZGm0+Bw416dFfFkLPDsoN1PZ80ZBjI4XEkW0GQQgueyPYMvTVhKLu56r3eis1aPN9XM8ON9VIXoGE2VeZkhZkxn4z4/bWzvGBGSwbvZLfZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k6YMIO2N; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92FEF169C;
	Tue, 26 May 2026 03:51:19 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82C123F7B4;
	Tue, 26 May 2026 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779792684; bh=ZxOUuceS2mxmDx2oNv6hCdsGaOdZS8PVj3M7iP62dbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6YMIO2N360Dwl1uu4plqdmpqgjBNP0wS6JklC5B/aLtkqSKVBxg+93v6VC+gfM9F
	 83lPoSShTY2rg6E4cxYx0Jjm3O0crKYxqOAVmcFUpEdpkhILGxQWRTQmfjCmzhkyER
	 WVd8dkNQ/SFUheW/uFNM62wiyfAfoakRFQhOrdhs=
Date: Tue, 26 May 2026 11:51:21 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] firmware: arm_ffa: Treat missing FF-A feature on a
 platform as a probe miss
Message-ID: <ahV7KVX2jPhGELwF@e129823.arm.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9668-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email,arm.com:dkim]
X-Rspamd-Queue-Id: E04085D4775
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

LGTM.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

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
Sincerely,
Yeoreum Yun

