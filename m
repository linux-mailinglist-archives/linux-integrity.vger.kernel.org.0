Return-Path: <linux-integrity+bounces-9494-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABwTA2Au/mmengAAu9opvQ
	(envelope-from <linux-integrity+bounces-9494-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 20:41:36 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8394FAB32
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 20:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9F66301E983
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 18:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4723DA5B1;
	Fri,  8 May 2026 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cpYKBeK+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8F3D6664;
	Fri,  8 May 2026 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265691; cv=none; b=heo/daBwJIHyPvlbcj+qfTL46S2R/+soRvUBJ5meRVdnVRKzrPzOtGYk/yAKIFPiU/SypZG2XB4jjJ10iAT82LdlryPqwyFVEqzrCznJmVN8g6kHE0DUcpumY+Vlpno9xv+XVkUVmUF8BOK4DiUQ0aMwR8rIgAE8yH19MvJetGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265691; c=relaxed/simple;
	bh=XINvWQU6IfXvVeoD9TNizFxqoQoUcr+yFMhFtPgaEBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNmsvqif5zFnO+ApXd9nA17y63h36iTUD4KHGpw6JeppR0qgrQvcwUWhs2X9lIrodqxTQoXq5w7WwXpnbn2nEcTpC+UWAMXBFCVfu4BJ3PK/b5hNXvlRlPtL0POgn2fa5HMgImAxtEKyMNDc6w8tXwbskFmUQekXtW7mg3+kzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cpYKBeK+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 422F535C8;
	Fri,  8 May 2026 11:41:22 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94FC43F763;
	Fri,  8 May 2026 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778265687; bh=XINvWQU6IfXvVeoD9TNizFxqoQoUcr+yFMhFtPgaEBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cpYKBeK+DS0RckzMNtF9Lqq1DjRKQfJqWbJLtkY6jssxDukuQ937nkw5Ya1RnKs8z
	 MKc7FZXAtK7FBjQZQDWeuXhHpAZK/WwDkcFkGRd0DsxtqErOIWEL3FVpnxnOyGEwn2
	 V0i55eSmnbfMUvaCUFfSKmydISiQtVEnE8t1QN6Y=
Date: Fri, 8 May 2026 19:41:24 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 2/4] firmware: arm_ffa: Register core as a platform driver
Message-ID: <af4uVBqhJW+4vug6@e129823.arm.com>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
 <20260508-b4-ffa_plat_dev-v1-2-c5a30f8cf7b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-b4-ffa_plat_dev-v1-2-c5a30f8cf7b8@kernel.org>
X-Rspamd-Queue-Id: 3C8394FAB32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9494-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

LGTM.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

On Fri, May 08, 2026 at 06:54:16PM +0100, Sudeep Holla wrote:
> Move the FF-A core bring-up and teardown paths into platform driver
> probe and remove callbacks, and register a synthetic arm-ffa platform
> device to bind the driver.
> 
> This makes the FF-A core lifetime follow the driver model while keeping
> the device creation internal to the FF-A core. Use normal platform driver
> registration so the probe path has standard driver-core semantics.
> 
> The synthetic platform device is a temporary bridge until ACPI and
> devicetree describe the FF-A core device or object. Once those firmware
> description paths are defined, the internal platform device creation can
> be dropped and the driver can bind to the firmware-described device
> directly.
> 
> Since the transport selection now happens from the platform probe path,
> drop the __init annotation from ffa_transport_init().
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>  drivers/firmware/arm_ffa/common.h |  4 +--
>  drivers/firmware/arm_ffa/driver.c | 53 ++++++++++++++++++++++++++++++++++-----
>  drivers/firmware/arm_ffa/smccc.c  |  2 +-
>  3 files changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/common.h b/drivers/firmware/arm_ffa/common.h
> index 9c6425a81d0d..5cdf4bd222c6 100644
> --- a/drivers/firmware/arm_ffa/common.h
> +++ b/drivers/firmware/arm_ffa/common.h
> @@ -18,9 +18,9 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev);
>  void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid);
>  
>  #ifdef CONFIG_ARM_FFA_SMCCC
> -int __init ffa_transport_init(ffa_fn **invoke_ffa_fn);
> +int ffa_transport_init(ffa_fn **invoke_ffa_fn);
>  #else
> -static inline int __init ffa_transport_init(ffa_fn **invoke_ffa_fn)
> +static inline int ffa_transport_init(ffa_fn **invoke_ffa_fn)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 6efb85787e6e..97ecdb5dac09 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -36,6 +36,7 @@
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/of_irq.h>
> +#include <linux/platform_device.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/smp.h>
> @@ -46,6 +47,7 @@
>  
>  #define FFA_DRIVER_VERSION	FFA_VERSION_1_2
>  #define FFA_MIN_VERSION		FFA_VERSION_1_0
> +#define FFA_PLATFORM_NAME	"arm-ffa"
>  
>  #define SENDER_ID_MASK		GENMASK(31, 16)
>  #define RECEIVER_ID_MASK	GENMASK(15, 0)
> @@ -114,6 +116,7 @@ struct ffa_drv_info {
>  };
>  
>  static struct ffa_drv_info *drv_info;
> +static struct platform_device *ffa_pdev;
>  
>  /*
>   * The driver must be able to support all the versions from the earliest
> @@ -2029,7 +2032,7 @@ static void ffa_notifications_setup(void)
>  	ffa_notifications_cleanup();
>  }
>  
> -static int __init ffa_init(void)
> +static int ffa_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	u32 buf_sz;
> @@ -2042,6 +2045,7 @@ static int __init ffa_init(void)
>  	drv_info = kzalloc_obj(*drv_info);
>  	if (!drv_info)
>  		return -ENOMEM;
> +	platform_set_drvdata(pdev, drv_info);
>  
>  	ret = ffa_version_check(&drv_info->version);
>  	if (ret)
> @@ -2103,19 +2107,56 @@ static int __init ffa_init(void)
>  		free_pages_exact(drv_info->tx_buffer, rxtx_bufsz);
>  	free_pages_exact(drv_info->rx_buffer, rxtx_bufsz);
>  free_drv_info:
> +	platform_set_drvdata(pdev, NULL);
>  	kfree(drv_info);
> +	drv_info = NULL;
>  	return ret;
>  }
> -module_init(ffa_init);
>  
> -static void __exit ffa_exit(void)
> +static void ffa_remove(struct platform_device *pdev)
>  {
> +	struct ffa_drv_info *info = platform_get_drvdata(pdev);
> +
>  	ffa_notifications_cleanup();
>  	ffa_partitions_cleanup();
>  	ffa_rxtx_unmap();
> -	free_pages_exact(drv_info->tx_buffer, drv_info->rxtx_bufsz);
> -	free_pages_exact(drv_info->rx_buffer, drv_info->rxtx_bufsz);
> -	kfree(drv_info);
> +	free_pages_exact(info->tx_buffer, info->rxtx_bufsz);
> +	free_pages_exact(info->rx_buffer, info->rxtx_bufsz);
> +	kfree(info);
> +	platform_set_drvdata(pdev, NULL);
> +	drv_info = NULL;
> +}
> +
> +static struct platform_driver ffa_driver = {
> +	.probe = ffa_probe,
> +	.remove = ffa_remove,
> +	.driver = {
> +		.name = FFA_PLATFORM_NAME,
> +	},
> +};
> +
> +static int __init ffa_init(void)
> +{
> +	int ret;
> +
> +	ffa_pdev = platform_device_register_simple(FFA_PLATFORM_NAME,
> +						   PLATFORM_DEVID_NONE,
> +						   NULL, 0);
> +	if (IS_ERR(ffa_pdev))
> +		return PTR_ERR(ffa_pdev);
> +
> +	ret = platform_driver_register(&ffa_driver);
> +	if (ret)
> +		platform_device_unregister(ffa_pdev);
> +
> +	return ret;
> +}
> +module_init(ffa_init);
> +
> +static void __exit ffa_exit(void)
> +{
> +	platform_device_unregister(ffa_pdev);
> +	platform_driver_unregister(&ffa_driver);
>  }
>  module_exit(ffa_exit);
>  
> diff --git a/drivers/firmware/arm_ffa/smccc.c b/drivers/firmware/arm_ffa/smccc.c
> index 4d85bfff0a4e..e6125dd9f58f 100644
> --- a/drivers/firmware/arm_ffa/smccc.c
> +++ b/drivers/firmware/arm_ffa/smccc.c
> @@ -17,7 +17,7 @@ static void __arm_ffa_fn_hvc(ffa_value_t args, ffa_value_t *res)
>  	arm_smccc_1_2_hvc(&args, res);
>  }
>  
> -int __init ffa_transport_init(ffa_fn **invoke_ffa_fn)
> +int ffa_transport_init(ffa_fn **invoke_ffa_fn)
>  {
>  	enum arm_smccc_conduit conduit;
>  
> 
> -- 
> 2.43.0
> 

-- 
Sincerely,
Yeoreum Yun

