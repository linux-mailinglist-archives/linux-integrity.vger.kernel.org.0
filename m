Return-Path: <linux-integrity+bounces-9495-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGklL4su/mmvngAAu9opvQ
	(envelope-from <linux-integrity+bounces-9495-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 20:42:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAF74FAB60
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 20:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6744A3008C0E
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 18:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70D03ECBD9;
	Fri,  8 May 2026 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ljqHJYSw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180AC3DCD9F;
	Fri,  8 May 2026 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778265735; cv=none; b=XTSrzIE03Ngf05/9h/VQCxt8xB9qL+odji3lOP3FneFPmiopk4JEta8i3zD0p62ywdejY6NSC6QyzUhW0PXo9Qcpyy3uWnupbBUN6iD0k2MvPgHVhSi2Af5SVkN3eeQrJTIa3R1nm23uIs1tOT62f8NKVp0pKMwEewppnmv282M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778265735; c=relaxed/simple;
	bh=2R0fPqfrjruSXC8XwdopLbeaSYMX4IVp2H58vn6VBkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEkkpnFG8vaqF7zfB8slqgWgTcqVWB2321rrHwEHfYXBoSYX7eJ3IUXO1zjCE4iBs24hsF0FIATOAT0owXJ6IuK17meTBStHATYun1bfAek1xNU2D60ePOR2Wh8OmaJN01JKrVHfXI4U9UX7JSaZE8wE8aGU0Gy4+9cbNFZDZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ljqHJYSw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 253951682;
	Fri,  8 May 2026 11:42:08 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 423B93F763;
	Fri,  8 May 2026 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778265733; bh=2R0fPqfrjruSXC8XwdopLbeaSYMX4IVp2H58vn6VBkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljqHJYSwdfOAM9rsQ3vQWOk0Wfhf5MM+bUcBFdFcJy6Q1x3r87sztE2yx/X9kQUC9
	 HX0JUX7MXxXpnL6rx2HVsMpRrbFBHtZj7EOMvygfG+UtEr0VozxhWkA7iGbCPg+j3r
	 cBTr5HIPEBgl/ANtHs2AGesYPhri1sRhgzoWcWHA=
Date: Fri, 8 May 2026 19:42:09 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 3/4] firmware: arm_ffa: Set the core device as FF-A
 device parent
Message-ID: <af4ugdkfaO3m2Ile@e129823.arm.com>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
 <20260508-b4-ffa_plat_dev-v1-3-c5a30f8cf7b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-b4-ffa_plat_dev-v1-3-c5a30f8cf7b8@kernel.org>
X-Rspamd-Queue-Id: 5EAF74FAB60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9495-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,arm.com:dkim,e129823.arm.com:mid,buf.id:url]
X-Rspamd-Action: no action

LGTM.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

> Pass a parent device into ffa_device_register() and use the synthetic
> arm-ffa platform device as the parent for each registered FF-A device.
> 
> This keeps the enumerated FF-A partition devices anchored below the FF-A
> core device in the driver model, matching the platform-driver conversion
> of the core transport.
> 
> Suggested-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>  drivers/firmware/arm_ffa/bus.c    | 3 ++-
>  drivers/firmware/arm_ffa/driver.c | 5 +++--
>  include/linux/arm_ffa.h           | 4 ++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
> index 9576862d89c4..e05fe0b6049c 100644
> --- a/drivers/firmware/arm_ffa/bus.c
> +++ b/drivers/firmware/arm_ffa/bus.c
> @@ -190,7 +190,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
>  
>  struct ffa_device *
>  ffa_device_register(const struct ffa_partition_info *part_info,
> -		    const struct ffa_ops *ops)
> +		    const struct ffa_ops *ops, struct device *parent)
>  {
>  	int id, ret;
>  	struct device *dev;
> @@ -210,6 +210,7 @@ ffa_device_register(const struct ffa_partition_info *part_info,
>  	}
>  
>  	dev = &ffa_dev->dev;
> +	dev->parent = parent;
>  	dev->bus = &ffa_bus_type;
>  	dev->release = ffa_release_device;
>  	dev->dma_mask = &dev->coherent_dma_mask;
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 97ecdb5dac09..e9d7dc71c06d 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -1688,7 +1688,7 @@ static int ffa_setup_host_partition(int vm_id)
>  	int ret;
>  
>  	buf.id = vm_id;
> -	ffa_dev = ffa_device_register(&buf, &ffa_drv_ops);
> +	ffa_dev = ffa_device_register(&buf, &ffa_drv_ops, &ffa_pdev->dev);
>  	if (!ffa_dev) {
>  		pr_err("%s: failed to register host partition ID 0x%x\n",
>  		       __func__, vm_id);
> @@ -1758,7 +1758,8 @@ static int ffa_setup_partitions(void)
>  		 * provides UUID here for each partition as part of the
>  		 * discovery API and the same is passed.
>  		 */
> -		ffa_dev = ffa_device_register(tpbuf, &ffa_drv_ops);
> +		ffa_dev = ffa_device_register(tpbuf, &ffa_drv_ops,
> +					      &ffa_pdev->dev);
>  		if (!ffa_dev) {
>  			pr_err("%s: failed to register partition ID 0x%x\n",
>  			       __func__, tpbuf->id);
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 81e603839c4a..17eca3dfc59e 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -173,7 +173,7 @@ struct ffa_partition_info;
>  #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
>  struct ffa_device *
>  ffa_device_register(const struct ffa_partition_info *part_info,
> -		    const struct ffa_ops *ops);
> +		    const struct ffa_ops *ops, struct device *parent);
>  void ffa_device_unregister(struct ffa_device *ffa_dev);
>  int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
>  			const char *mod_name);
> @@ -184,7 +184,7 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev);
>  #else
>  static inline struct ffa_device *
>  ffa_device_register(const struct ffa_partition_info *part_info,
> -		    const struct ffa_ops *ops)
> +		    const struct ffa_ops *ops, struct device *parent)
>  {
>  	return NULL;
>  }
> 
> -- 
> 2.43.0
> 

-- 
Sincerely,
Yeoreum Yun

