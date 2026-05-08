Return-Path: <linux-integrity+bounces-9496-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMWQC08v/mmvngAAu9opvQ
	(envelope-from <linux-integrity+bounces-9496-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 20:45:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACE4FABF0
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 20:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE8BF300AD4E
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE31376BE2;
	Fri,  8 May 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uTmdZouw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D683644BD;
	Fri,  8 May 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265925; cv=none; b=okkfJlVTizWB22JnaTIzquowgNCy9qg5tj11xYICZfMlfL9q8MHTGp52RtAv4ZrQeKZ1ZFN4I3IIZAb+RrLxn4Uj+i62POFSBfX88NEwvdS7/Pfvus5W70Cj7/sxlSRepkDBgXbR/8oLyl9UNmyPKrI76n2jg1R4zoPL9NgQXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265925; c=relaxed/simple;
	bh=Um9WPFqN7H2ySkHiR2sGQgTz8RH4w81WnNll++kO0KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZpWgF9hwlo6Q/MsZ34uk7sNnTQM0HIq/UMkkeOT2CQffhQNjOwp4zvFZEqpCWYTET8XXdQUPiK/K3QN9/6RN877mlsIdUllF6S9AsIXKB3S5DwB2Y1Dg3gGrOimT4kjhEL0PXZTUO+hKR0zZ6QgYbg1DGkGXY3gry7IpurwOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uTmdZouw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E21E35C8;
	Fri,  8 May 2026 11:45:17 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDF5D3F763;
	Fri,  8 May 2026 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778265922; bh=Um9WPFqN7H2ySkHiR2sGQgTz8RH4w81WnNll++kO0KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTmdZouwo9E6t00HxpLFDySDpfjnNQYivZlR7bZalwSAXnoqbqYhjPvhASnVaTCdp
	 c/ZkWgRYxg9hxDM47Ti/paOahAhtcGINq//R1N/fEcFhDwNnLr/2NNnQ2ZM37aqDxo
	 o07keQreCRyqmvemlEU1mqlyhUq0Bs/VVc178Upg=
Date: Fri, 8 May 2026 19:45:19 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 4/4] firmware: arm_ffa: Defer probe until pKVM is
 initialized
Message-ID: <af4vPxsKXpJlX8Ds@e129823.arm.com>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
 <20260508-b4-ffa_plat_dev-v1-4-c5a30f8cf7b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-b4-ffa_plat_dev-v1-4-c5a30f8cf7b8@kernel.org>
X-Rspamd-Queue-Id: 19ACE4FABF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9496-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[e129823.arm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:email,arm.com:dkim]
X-Rspamd-Action: no action

Look good to me.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

> When protected KVM is enabled, the kernel includes a pKVM FF-A proxy
> that sits in front of the normal FF-A driver. The proxy has to perform
> its own FF-A version negotiation and setup first, so that it can mediate
> subsequent FF-A traffic correctly.
> 
> Defer FF-A core probing until pKVM has completed initialization. This
> keeps the normal driver from negotiating the FF-A version or performing
> other transport setup before the pKVM proxy is ready, and lets the
> driver model retry probing once the protected KVM state required by the
> FF-A transport is available.
> 
> Suggested-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>  drivers/firmware/arm_ffa/driver.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index e9d7dc71c06d..1fba064c2aba 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -43,6 +43,8 @@
>  #include <linux/uuid.h>
>  #include <linux/xarray.h>
>  
> +#include <asm/virt.h>
> +
>  #include "common.h"
>  
>  #define FFA_DRIVER_VERSION	FFA_VERSION_1_2
> @@ -2039,6 +2041,10 @@ static int ffa_probe(struct platform_device *pdev)
>  	u32 buf_sz;
>  	size_t rxtx_bufsz = SZ_4K;
>  
> +	if (IS_BUILTIN(CONFIG_ARM_FFA_TRANSPORT) &&
> +	    is_protected_kvm_enabled() && !is_pkvm_initialized())
> +		return -EPROBE_DEFER;
> +
>  	ret = ffa_transport_init(&invoke_ffa_fn);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.43.0
> 

-- 
Sincerely,
Yeoreum Yun

