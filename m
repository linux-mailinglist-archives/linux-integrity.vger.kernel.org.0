Return-Path: <linux-integrity+bounces-6303-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF6AC2656
	for <lists+linux-integrity@lfdr.de>; Fri, 23 May 2025 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC4016FA82
	for <lists+linux-integrity@lfdr.de>; Fri, 23 May 2025 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C919F40B;
	Fri, 23 May 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tZKa++8W"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101D625
	for <linux-integrity@vger.kernel.org>; Fri, 23 May 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013757; cv=none; b=Z8VzrjCPNvWlnKywyWhsRrk6i8b9cV76gf/sV51cpoI0gVG0l7+1S11jUVB5vEBiAPP9WPoTdtZy0G9ihfYmW8PLMUJmaAP4Rsy2kwvOSS/yBuHrYp/SeWRlJv96ePGo9vCHeOM1a1JAHV7lAuDojMH823/RhYgz47UG52pd+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013757; c=relaxed/simple;
	bh=/risWNAAjXHnZt9pBR+HC0sDA65mhFzk1akHq90jFzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkBHtJbMUaiGIjFtpP7EI6qCCZbkFiWLf+zEB4fUsp8Zx1FjnF2vOrO4YobFKMBXkw2oA5plKwcMoGoRpyvzOUjpZZ8PkgUjbA8Z0+xrXaecwc1MtnH138kBb4+rCvvZrum70EZzmN8pgNJYgnRoZRSSKh3SOkICTz5v6tZPl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tZKa++8W; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748013752; bh=4HVWjRRb6Ff99hfhbrGOTxK+uJxVKOu/9OyHH0IBjCE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tZKa++8WGNf8X/Z2YVtUObZxgQTx+qIIMuoxCdSV1gQ+x1FgkRVaZAJ/rTYgJNT9/CeyiCaBc84jT4qZZoVSNf06NHDPDX1oC8T8JY+AOOiWvTXTNK2mpzsd19Fk4/JzzCLgRnjJOI7Z40PkHJbWFp453LJzr/LU2oID12qUUbWcjjVWqXfGNLm1Qe95WPHEjaoDXtGNZoKUMONp2SlJSWjpuXeEOGbK54tSkhw065km54tCnGej3b/zGRCJp7OsEhiVB+04dLSg6DSDiOpYPFGRnMURDYntsrGK2rgclx8tbrpOtbDrGRl4Khjuc0/bReivcjo9yF1aY6YvYYoHIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748013752; bh=DgD3t6mBd0jm/fWhczVJPva+cSPWleRpss7X1/cleZz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=B9YZ9h7G5sED+8XZaN+GQifJ1jZLn7XPqc7Vm5cizgLo9sag+CY1MMF+k1uqDyB7A4IkwhyG7rJq2/W4oEQ9zw2xxfNJO5CAO4j0ZUFbCdepDbWlF7xV+kuYRuzxTsQfGty6kaVql5CfkSJUpdp1e1bE12qXxHZYvTH1me6FSIlyJ35qlOmBxuqmX/nkr0mPZtbP+hYbExYeSLauxNnaKdLwBmu9AaWsuZe3+6/qRiUSoIAi9ejrEbbiHhA6pP39sLTprp/BlbS6Xze8QiWsbhmoFS+cUnl0DKa6jBfDA9dTLj0S1m9zfcvcQkF4dwo+7VYls6pfFb4FaCY+95LwNg==
X-YMail-OSG: cfL.K00VM1npLfFIdXVtAM0G4LSquzuRLfVHVNzPfH13hsr1_0h3ZivWAFioLYU
 YskmXGYigLJMPdhlXkaCJoyk3wXOGVZ1qil5sWxSUw0bcYcVXWdfsd8mrznLCO7oiG43LcBjuSPZ
 dmzueEXhTYON6tR_XuiPVyEduQHIDpl1OhQNplu8oTZp7jjvuQD8RJYOp66nNwCoeq1VPoaEctLo
 SfAzsq0UoNtpiAiIU3aOVO_7.H4EX.8UjkC3wWNs1HzbuPfUjqyqMqpj_CR2d7lsM78Ei.5MqW5p
 mqkOryG1zTV1AqXvHRDA7gp1PZn1HwzXPCw93cERTddlLbuEwG5OF0l2kITyGly4Wd_ICScSyp48
 wMi5neXmU919fORIQP03qskXUCKCIXp0r7p7gaJPkynnLtOto4WNdxGm8WPCdWKVH1MTMYrQR5Hs
 VvSV8ALP1kX72aJcziBEUybwjAPEXujzVIGUuA8WQPyFiT9BQXoBb5PBPkFDeYMf1tVrBM6PPonf
 EzEIbFuAgCMPRlUVauG4X6OdV1Lg9z4y3UQ05r8ngBRC30zeneLACs5T2Pbo6SPy53z2KNisCCrJ
 nccfSHcDZpUnx8hqK9Xoe3xSlwkZtCc6YaxGb2yxlOQjCs3MhqGWpnz._RdpkSnEcRPCSlp5CeLR
 qA6c_kRjK1ug4AJ_D38eZ_oHV.YowIw4aAsNqoj7SmodV0z907vtPtOMtKsQDvD4i3nYar4mV8IK
 hLJzirhk4p.HSsC88_3jH0OOn5HHcO5yq6yLMPKaSo1FaVPRx7GjXEJ7ALLZE.lu6KdX6pDlYO8J
 YaXCJQyoZ7VHF_qFHApLFZU5.NZaUwTc9Lu0YWVZ2lGqsmtFX74uMiFaPqqEyOIyyNpWxcR9C87z
 e2RZm3Yuq1C3DECXQi1Hhkuc.jAco9dHYYc3WwqBYJPOFd_sqP83kg3XHnQW7MUgTeHTacgkAbqN
 0hznlvU23QygQOYIqKitMUW3OI28pMB0NF6VjH6OTDtEwIqZTdKCnUW.lQBOiINSefEumY4xD6b_
 IkI46nq3uaicRX_WKg4gk8Q.oBDkI8tRRock5dYL4fgcl20LvWmbtQ7UDRnpbEolAbWoj2b93SPW
 Cnstf839trf1cnu2MdU9jVBkefh2LYnRFdwuEZHrrzgoNJK2iTTGUxFyJv_wwf_s7s0yMCLx.vju
 upie28iVn9x2gIcvuD86MoDQnLpW2KX8CxsepRY92pcWJMYkJjfaTI5A4SsHj42hL14vUEx0oQYB
 ADQMhZv6_fYIYb3bU4oqjcoPwkIG8nEBD8.KYnzdWqAgmk7kSpcDV4NrXPvDK2nSNuLeuqdYfgHI
 nxMicuBWRkuU3BVE3nJUHBTZ6Z9PZilWyVDjq4zwhglPpSvzwS5ntlayy0lAOUHdC4ne1cwaVIks
 6ye_xX.nIbkXQXRq6BznTknqHf0dNyBsZ7NdplfSrLr87YA8XE._dyysWwDXALswRKjlURDj7Meh
 bKx48tVDTDN_WgP.a453bA.vXd7BsGyZ37yk1JcbSFdH0ZO3y0vNb20JqgtqyGpMQ63lWWOfChrC
 iA1x8BuoKQk6Ve2Sh0Hnxe9J8uNhApeC_RyurqFdnAxN6RQCd2u59iD6.VrALawepuTBnNSDJ8Vt
 4r3hZI81Qt0A9uIMXI1O50c.Z7e8pMASELxbOEC21ZklEuA3Fgu.CqEkRHlfaSYtbt9KtOU2jBVw
 V..1OZeIaxrojMWDMnZvFFhNn2rBd7gahEDORmdJZwM1qOj91B1pQyjCs7EWPAKpcka8vtKIj6_i
 vRwOO18Dy8tadHgG0ya85DsgmC7NGT3Z8XwhN_ja8lA7APWV3lOGi46yNA3x1x3dVYc8iqaEsgL0
 PxWhQUHHW_.DUJWmICndF2fHXIWhjbnfFuEzu5EJZsUDOhdaQGStUpPR1cAdVa1L3x1uN4t77MHm
 ajRzzuUiFa6pq5g5ZfqB6HhKHlzlNaSuupR7kb5rKzLixEtpwdNppYO0KLJu8F2AFgrJpIeSu_Jy
 arLx9STph2.ALel2rVT8VVJlI_tLWO84W2aaeUMJRAiJ8t81RybsgwY1Ck.icZ_AzQZAbj2bNabh
 t_ozePLmg00Ff6kZhf08jRa_efg_MUyBVKQnaGiczO6oHN5NflTc8f5xhWqDCn202NUvrQOwbG2d
 kiv9YhIwCtFafocmaomWetW7TvbpLFvE6ytE1ufD0KlAjUcsz.lLRHviWNNlnX6VfIAG0TRfgg4p
 AZp6O4lQZuSzUG.wLITWT93d_6C2Wx.ItY4T.V_zE1fDK3W47AXxm.vyNk57Fe1swGlK0jL1Uzzz
 AU0wi7NZAd7vnizywgWE3YxSsI7u7TAbR
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6b57845a-04ce-4e17-bd11-8dfebefae4d1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 23 May 2025 15:22:32 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a39aea7c941d6c30469ee55f79b6563c;
          Fri, 23 May 2025 15:12:23 +0000 (UTC)
Message-ID: <e3387a97-df0c-4b48-beab-9c3fd03050e1@schaufler-ca.com>
Date: Fri, 23 May 2025 08:12:22 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/29] selinux: move initcalls to the LSM framework
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-57-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250409185019.238841-57-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23884 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/9/2025 11:50 AM, Paul Moore wrote:
> SELinux currently has a number of initcalls so we've created a new
> function, selinux_initcall(), which wraps all of these initcalls so
> that we have a single initcall function that can be registered with the
> LSM framework.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/Makefile            |  2 +-
>  security/selinux/hooks.c             |  9 +++--
>  security/selinux/ibpkey.c            |  5 ++-
>  security/selinux/include/audit.h     |  5 +++
>  security/selinux/include/initcalls.h | 19 +++++++++++
>  security/selinux/initcalls.c         | 50 ++++++++++++++++++++++++++++
>  security/selinux/netif.c             |  5 ++-
>  security/selinux/netlink.c           |  5 ++-
>  security/selinux/netnode.c           |  5 ++-
>  security/selinux/netport.c           |  5 ++-
>  security/selinux/selinuxfs.c         |  5 ++-
>  security/selinux/ss/services.c       | 26 ++++-----------
>  12 files changed, 101 insertions(+), 40 deletions(-)
>  create mode 100644 security/selinux/include/initcalls.h
>  create mode 100644 security/selinux/initcalls.c
>
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index 66e56e9011df..72d3baf7900c 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -15,7 +15,7 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
>  ccflags-$(CONFIG_SECURITY_SELINUX_DEBUG) += -DDEBUG
>  
>  selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
> -	     netnode.o netport.o status.o \
> +	     netnode.o netport.o status.o initcalls.o \
>  	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
>  	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f28a12a0a1c8..95b2399b1f4d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -95,6 +95,7 @@
>  #include <linux/io_uring/cmd.h>
>  #include <uapi/linux/lsm.h>
>  
> +#include "initcalls.h"
>  #include "avc.h"
>  #include "objsec.h"
>  #include "netif.h"
> @@ -7535,6 +7536,10 @@ static __init int selinux_init(void)
>  	if (avc_add_callback(selinux_lsm_notifier_avc_callback, AVC_CALLBACK_RESET))
>  		panic("SELinux: Unable to register AVC LSM notifier callback\n");
>  
> +	if (avc_add_callback(selinux_audit_rule_avc_callback,
> +			     AVC_CALLBACK_RESET))
> +		panic("SELinux: Unable to register AVC audit callback\n");
> +
>  	if (selinux_enforcing_boot)
>  		pr_debug("SELinux:  Starting in enforcing mode\n");
>  	else
> @@ -7567,6 +7572,7 @@ DEFINE_LSM(selinux) = {
>  	.enabled = &selinux_enabled_boot,
>  	.blobs = &selinux_blob_sizes,
>  	.init = selinux_init,
> +	.initcall_device = selinux_initcall,
>  };
>  
>  #if defined(CONFIG_NETFILTER)
> @@ -7628,7 +7634,7 @@ static struct pernet_operations selinux_net_ops = {
>  	.exit = selinux_nf_unregister,
>  };
>  
> -static int __init selinux_nf_ip_init(void)
> +int __init selinux_nf_ip_init(void)
>  {
>  	int err;
>  
> @@ -7643,5 +7649,4 @@ static int __init selinux_nf_ip_init(void)
>  
>  	return 0;
>  }
> -__initcall(selinux_nf_ip_init);
>  #endif /* CONFIG_NETFILTER */
> diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
> index 48f537b41c58..2609913f338a 100644
> --- a/security/selinux/ibpkey.c
> +++ b/security/selinux/ibpkey.c
> @@ -23,6 +23,7 @@
>  #include <linux/list.h>
>  #include <linux/spinlock.h>
>  
> +#include "initcalls.h"
>  #include "ibpkey.h"
>  #include "objsec.h"
>  
> @@ -219,7 +220,7 @@ void sel_ib_pkey_flush(void)
>  	spin_unlock_irqrestore(&sel_ib_pkey_lock, flags);
>  }
>  
> -static __init int sel_ib_pkey_init(void)
> +int __init sel_ib_pkey_init(void)

Build failure if CONFIG_SECURITY_INFINIBAND is not set.

>  {
>  	int iter;
>  
> @@ -233,5 +234,3 @@ static __init int sel_ib_pkey_init(void)
>  
>  	return 0;
>  }
> -
> -subsys_initcall(sel_ib_pkey_init);
> diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
> index d5b0425055e4..5989f8dd1e86 100644
> --- a/security/selinux/include/audit.h
> +++ b/security/selinux/include/audit.h
> @@ -15,6 +15,11 @@
>  #include <linux/audit.h>
>  #include <linux/types.h>
>  
> +/**
> + * XXX
> + */
> +int selinux_audit_rule_avc_callback(u32 event);
> +
>  /**
>   * selinux_audit_rule_init - alloc/init an selinux audit rule structure.
>   * @field: the field this rule refers to
> diff --git a/security/selinux/include/initcalls.h b/security/selinux/include/initcalls.h
> new file mode 100644
> index 000000000000..6674cf489473
> --- /dev/null
> +++ b/security/selinux/include/initcalls.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SELinux initcalls
> + */
> +
> +#ifndef _SELINUX_INITCALLS_H
> +#define _SELINUX_INITCALLS_H
> +
> +int init_sel_fs(void);
> +int sel_netport_init(void);
> +int sel_netnode_init(void);
> +int sel_netif_init(void);
> +int sel_netlink_init(void);
> +int sel_ib_pkey_init(void);
> +int selinux_nf_ip_init(void);
> +
> +int selinux_initcall(void);
> +
> +#endif
> diff --git a/security/selinux/initcalls.c b/security/selinux/initcalls.c
> new file mode 100644
> index 000000000000..81f01f8ad215
> --- /dev/null
> +++ b/security/selinux/initcalls.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SELinux initcalls
> + */
> +
> +#include <linux/init.h>
> +
> +#include "initcalls.h"
> +
> +/**
> + * selinux_initcall - Perform the SELinux initcalls
> + *
> + * Used as a device initcall in the SELinux LSM definition.
> + */
> +int __init selinux_initcall(void)
> +{
> +	int rc = 0, rc_tmp = 0;
> +
> +	rc_tmp = init_sel_fs();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +	rc_tmp = sel_netport_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +	rc_tmp = sel_netnode_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +	rc_tmp = sel_netif_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +	rc_tmp = sel_netlink_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +	rc_tmp = sel_ib_pkey_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +
> +#if defined(CONFIG_NETFILTER)
> +	rc_tmp = selinux_nf_ip_init();
> +	if (!rc && rc_tmp)
> +		rc = rc_tmp;
> +#endif
> +
> +	return rc;
> +}
> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index 43a0d3594b72..69f660721dc8 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -22,6 +22,7 @@
>  #include <linux/rcupdate.h>
>  #include <net/net_namespace.h>
>  
> +#include "initcalls.h"
>  #include "security.h"
>  #include "objsec.h"
>  #include "netif.h"
> @@ -261,7 +262,7 @@ static struct notifier_block sel_netif_netdev_notifier = {
>  	.notifier_call = sel_netif_netdev_notifier_handler,
>  };
>  
> -static __init int sel_netif_init(void)
> +int __init sel_netif_init(void)
>  {
>  	int i;
>  
> @@ -276,5 +277,3 @@ static __init int sel_netif_init(void)
>  	return 0;
>  }
>  
> -__initcall(sel_netif_init);
> -
> diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
> index 1760aee712fd..eb40e4603475 100644
> --- a/security/selinux/netlink.c
> +++ b/security/selinux/netlink.c
> @@ -17,6 +17,7 @@
>  #include <net/net_namespace.h>
>  #include <net/netlink.h>
>  
> +#include "initcalls.h"
>  #include "security.h"
>  
>  static struct sock *selnl __ro_after_init;
> @@ -105,7 +106,7 @@ void selnl_notify_policyload(u32 seqno)
>  	selnl_notify(SELNL_MSG_POLICYLOAD, &seqno);
>  }
>  
> -static int __init selnl_init(void)
> +int __init sel_netlink_init(void)
>  {
>  	struct netlink_kernel_cfg cfg = {
>  		.groups	= SELNLGRP_MAX,
> @@ -117,5 +118,3 @@ static int __init selnl_init(void)
>  		panic("SELinux:  Cannot create netlink socket.");
>  	return 0;
>  }
> -
> -__initcall(selnl_init);
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 5c8c77e50aad..11b5eac30641 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -30,6 +30,7 @@
>  #include <net/ip.h>
>  #include <net/ipv6.h>
>  
> +#include "initcalls.h"
>  #include "netnode.h"
>  #include "objsec.h"
>  
> @@ -287,7 +288,7 @@ void sel_netnode_flush(void)
>  	spin_unlock_bh(&sel_netnode_lock);
>  }
>  
> -static __init int sel_netnode_init(void)
> +int __init sel_netnode_init(void)
>  {
>  	int iter;
>  
> @@ -301,5 +302,3 @@ static __init int sel_netnode_init(void)
>  
>  	return 0;
>  }
> -
> -__initcall(sel_netnode_init);
> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 2e22ad9c2bd0..d1c12f58a628 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -29,6 +29,7 @@
>  #include <net/ip.h>
>  #include <net/ipv6.h>
>  
> +#include "initcalls.h"
>  #include "netport.h"
>  #include "objsec.h"
>  
> @@ -220,7 +221,7 @@ void sel_netport_flush(void)
>  	spin_unlock_bh(&sel_netport_lock);
>  }
>  
> -static __init int sel_netport_init(void)
> +int __init sel_netport_init(void)
>  {
>  	int iter;
>  
> @@ -234,5 +235,3 @@ static __init int sel_netport_init(void)
>  
>  	return 0;
>  }
> -
> -__initcall(sel_netport_init);
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 47480eb2189b..88d16c1dbb5a 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -35,6 +35,7 @@
>  /* selinuxfs pseudo filesystem for exporting the security policy API.
>     Based on the proc code and the fs/nfsd/nfsctl.c code. */
>  
> +#include "initcalls.h"
>  #include "flask.h"
>  #include "avc.h"
>  #include "avc_ss.h"
> @@ -2131,7 +2132,7 @@ static struct file_system_type sel_fs_type = {
>  
>  struct path selinux_null __ro_after_init;
>  
> -static int __init init_sel_fs(void)
> +int __init init_sel_fs(void)
>  {
>  	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
>  					  sizeof(NULL_FILE_NAME)-1);
> @@ -2175,5 +2176,3 @@ static int __init init_sel_fs(void)
>  
>  	return err;
>  }
> -
> -__initcall(init_sel_fs);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e431772c6168..d84a496e5f7f 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3534,6 +3534,13 @@ struct selinux_audit_rule {
>  	struct context au_ctxt;
>  };
>  
> +int selinux_audit_rule_avc_callback(u32 event)
> +{
> +	if (event == AVC_CALLBACK_RESET)
> +		return audit_update_lsm_rules();
> +	return 0;
> +}
> +
>  void selinux_audit_rule_free(void *vrule)
>  {
>  	struct selinux_audit_rule *rule = vrule;
> @@ -3784,25 +3791,6 @@ int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vru
>  	return match;
>  }
>  
> -static int aurule_avc_callback(u32 event)
> -{
> -	if (event == AVC_CALLBACK_RESET)
> -		return audit_update_lsm_rules();
> -	return 0;
> -}
> -
> -static int __init aurule_init(void)
> -{
> -	int err;
> -
> -	err = avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET);
> -	if (err)
> -		panic("avc_add_callback() failed, error %d\n", err);
> -
> -	return err;
> -}
> -__initcall(aurule_init);
> -
>  #ifdef CONFIG_NETLABEL
>  /**
>   * security_netlbl_cache_add - Add an entry to the NetLabel cache

