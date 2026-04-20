Return-Path: <linux-integrity+bounces-9247-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCjcCEQd5mkMsAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9247-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 14:34:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C543042ACA4
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 14:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7774A302FC06
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62EC387364;
	Mon, 20 Apr 2026 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAgiJBUU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05B39FCAD
	for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2026 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688363; cv=none; b=sUy/orzb6rYMbFkEaIWgb5Qcf5SwqrWBclThNduhoRWYT70FahoqbKSUzzcOwScaBwo9Mq6xKa1mQa3HUW8C936PXYbDhorydeP7Z2oJmxxPJ6aY8qGPhSqMhhRN/dRJcMFTPXgcQyLyix8iU/Z6xETJh7qVziH20RpCWorOCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688363; c=relaxed/simple;
	bh=mrnF/Wym7mp2XvioGnhhOSe51/kl7uiND0mhtfL/BcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEgSrKn9uKJuVuh2VAdm71dL5AuGau69pWt8pQE7m46ktshUGd+tJwi7lHkcb76fFXUnYn+UcVg1y9E4ABnSo5hdeW/c22AFA+lrp6vw7+gaC9UpGoa3RnT9GzCms1UR0wiVwqCVX725eWG5WsGvc+/yjfyIbeYjWcg++VViZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SAgiJBUU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so83965e9.1
        for <linux-integrity@vger.kernel.org>; Mon, 20 Apr 2026 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776688359; x=1777293159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99fgHE25P8Rf1g7JLxo27iNfMt0M4KYBWTaNW36OxW8=;
        b=SAgiJBUUGXgwB+3a5up3IW2VP2NXd1fi9bO2QlKPHqemJJooqhLcsCgZxYaT1HdxJy
         dasxz1tis+xZ00tpNhW5/OWMOgIq5NJU3w/Zl/iihWvi+BbyatXYIERe5BcwbPKm/+6H
         jm3HdRrxwxgsI1uwsDVEGdFzoXy9bEHGKZjnsr+P05AEEFnPoVrcIMEGaWmkAsE5ugHL
         ZYrdNAGxeWt5nt3SfHwprvL29TV3RUjK4iF4XXynjuoxjV74S91/5Myhfeyzsx5HJHW6
         W+2enlCY+GYFA7uyKUkpn9SUSjdE+5NCR5VRDeOHDI1uZ4onR+69xmQ0RTg+D9Oz/IjO
         NoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776688359; x=1777293159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99fgHE25P8Rf1g7JLxo27iNfMt0M4KYBWTaNW36OxW8=;
        b=ri/cxFqJdhhzq8cYhQaLhDF2rw3qUjF49/KU91ZQVfDefVpXMxYEj0dc8iOF3LV2Hv
         LSrKcbL8NH4KYfNsqZ42wmlED+N453OQhnXRkdZxwRYI4it/Cd3Kf0eU9ASo6Z7jz3uO
         Quk3w6NxRjw60hPi5AwvEdEb+2FjXzlLqHNKyBlf5u2dVzuevUgc2SqMYmzhBTbo8KLN
         DdrKaeAUJY7sF2oI3FcD4NSvF1blwzhVg8jRIaoQ7ffCqMpT0uasO6A6D1pIIc00F+Ak
         3hsQYY7rZW3c/L29KDFm5im9W8JM+qtlz22v2Gq9sjSgCLwp29o9ikIWQvDzbjKQmG/h
         vFeg==
X-Forwarded-Encrypted: i=1; AFNElJ/qdvXWI56a6JxKWrEqz3SSVQy+yxm+OrDLmRSNyuhONzd2CAsXuYmpO7RbYWruP+Vx4NSripNb3kr+1QsW8Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWDXZhtiyRA7K7XBF+eBR9WtS1AluiSSMdB1A6sg6vL1JygVq3
	+LESAO448TrCD0C1/0u8dxnn8zlMOmRlSM2EsCi7oKF9wLEVOAwCLhB33ksLKrRGwq57mOMyV3G
	7h5iLZE1K
X-Gm-Gg: AeBDieuMIUrf10tBPYmeHGjV8FQvyJm6AE/3I7vSKNyqEaNOvE0eHPxQwvjhau1jHS/
	IcQRz1gl5PePnUFOtSPbYiRVvBm5h64tW1vUBtxb/0+xXEVNMWQacBCR4hf0R52UeUQnQ9IL2M2
	g6wjzcCKqzWRIM/zB11YBpwAnkFI/Y/tONc/e6dYeepoiaE41OjSS8tKSm39A0c2lHKtlrFgC7V
	cLgG+lDaJfNcqFh0qrC+TfnzNxu+gZm+aTL53wvH7I7rqCxOG58ee2owoV4fLDRw02FDIR7J3yI
	zxVeQwU5SBcjT85xUhOnTYl1/Dd2DaExJyKdjgTZG573ptT7003p8TImNfF+h3+kT+ZfkcxAACM
	0ds0viO6yZQfZgIwj0QzA1zjI9AQ5LzuD2b/EJGOM4ORN7PycB2+tLB7ELv9jLbiVYgl99NObUc
	I7QweCMpaNLqAgzQFxxqhhQEycUH6/wwb87NV4gG1MIvknVYQw0J42SHyyXbKBHQxdp/WhAl0lL
	ZT/MT5+m/OlAerjUEc=
X-Received: by 2002:a05:600d:848c:20b0:485:4133:4021 with SMTP id 5b1f17b1804b1-489013bd634mr1545925e9.7.1776688358586;
        Mon, 20 Apr 2026 05:32:38 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm26265240f8f.14.2026.04.20.05.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:32:38 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:32:32 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aeYbdmshGZJ4GhXd@google.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417175759.3191279-5-yeoreum.yun@arm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,kernel.org,ziepe.ca,arm.com];
	TAGGED_FROM(0.00)[bounces-9247-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C543042ACA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 06:57:59PM +0100, Yeoreum Yun wrote:

Hello Yeoreum,


> When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> Otherwise, pKVM cannot negotiate the FF-A version or
> obtain RX/TX buffer information, leading to failures in FF-A calls.

At the moment this already happens after you move back ffa_init() to
device_initcall().

> 
> During FF-A driver initialization, check whether pKVM has been initialized.
> If not, defer probing of the FF-A driver.
> 

I don't think you need to add this dependency. pKVM is
installed through KVM's module_init() which ends up calling hyp_ffa_init() to
do the proxy initialization. The ARM-FFA driver comes after it (since
pKVM is arch specific code). We don't have to call finalize_pkvm(..) to
be able to handle smc(FF-A) calls in the hyp-proxy.

> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/kvm/arm.c              |  1 +
>  drivers/firmware/arm_ffa/driver.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 410ffd41fd73..0f517b1c05cd 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -119,6 +119,7 @@ bool is_kvm_arm_initialised(void)
>  {
>  	return kvm_arm_initialised;
>  }
> +EXPORT_SYMBOL(is_kvm_arm_initialised);
> 
>  int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>  {
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 02c76ac1570b..2647d6554afd 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -42,6 +42,8 @@
>  #include <linux/uuid.h>
>  #include <linux/xarray.h>
> 
> +#include <asm/virt.h>
> +
>  #include "common.h"
> 
>  #define FFA_DRIVER_VERSION	FFA_VERSION_1_2
> @@ -2035,6 +2037,16 @@ static int __init ffa_init(void)
>  	u32 buf_sz;
>  	size_t rxtx_bufsz = SZ_4K;
> 
> +	/*
> +	 * When pKVM is enabled, the FF-A driver must be initialized
> +	 * after pKVM initialization. Otherwise, pKVM cannot negotiate
> +	 * the FF-A version or obtain RX/TX buffer information,
> +	 * which leads to failures in FF-A calls.
> +	 */
> +	if (IS_ENABLED(CONFIG_KVM) && is_protected_kvm_enabled() &&
> +	    !is_kvm_arm_initialised())
> +		return -EPROBE_DEFER;
> +
>  	ret = ffa_transport_init(&invoke_ffa_fn);
>  	if (ret)
>  		return ret;
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

Thanks,
Sebastian

