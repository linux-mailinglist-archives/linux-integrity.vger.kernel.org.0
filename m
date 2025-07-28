Return-Path: <linux-integrity+bounces-6739-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E60B13847
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 11:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0960E16F071
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jul 2025 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E5246BAF;
	Mon, 28 Jul 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="FW4w3oht"
X-Original-To: linux-integrity@vger.kernel.org
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60AF21FF4C;
	Mon, 28 Jul 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696008; cv=none; b=Wu5xESX7ZuqpNKtux+Ld/uecw80Ai95tZwNGbauTpKbOCS4PbNwBzlSYlOmrEfm1eObH4Iy6mGFxvu8/KZfOU0Jy8bP8KXUGvB5N5VWlslc1Ow3WEQRMzvCQgJ58sgTw82fwc2Z2FrHTuYaC18N4DOffsVWebiPAtAWwI1yrTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696008; c=relaxed/simple;
	bh=ap1A3ZG2Uxw1/mXmF8V1l3PpgiGsVKi2OflAmTApKHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODInE0ln/RZqoYxp8WFPuD5Irkwk0FvRA3ehi7G3rxdep7rSY5zzyAkUI3YXaBg/uQQ5c4G1V9UaS9lB749K9Sf3fwpiCz5QqOI40o2TlCyDDTrJw/vNcyDveypMZaSiL24We5SzdI7QOOd05qQJwAwOpJVK+Ikbg+WkQwKI/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=FW4w3oht; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=39IcGzcaxrUmb8wY972RSdyTqj5ULsT7WNj3WB6/TpE=; b=FW4w3ohtMHt3xdtXXFT1elDkhP
	B+aT9HpVSIzBcucg0uVs+cHQmP6i8n4TT8cGsSvuVFNBiRPdth9/RMNQa1avG7g94jfCKUHs3e+1U
	jP9x7wQop4PUgrUHzc0r916fFXr5aLcpaEHaAY/okUYB4jq8ZriMURUbP6tK6eA63dAEV+0uLvhwx
	74YFcVyUBSUeGEw1qWXWumI+/UIpzbgPrt7EUwZYykrcOaWfUcxd8UDNGhcLEwYHItgRCTuyRO32s
	0ouAv5lQWkTBBXYTxQrG705IWDuvOYFYXZd9flVk7PBF374ih0pF1aBVewIuarfzrj7l/tWv9bavv
	0DWQUi0A==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:10324 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ugKRJ-0000000Ejp2-38WV;
	Mon, 28 Jul 2025 11:46:38 +0200
Date: Mon, 28 Jul 2025 11:46:33 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [RFC PATCH v2 31/34] ima,evm: move initcalls to the LSM framework
Message-ID: <st4eimc4lovdeqrtxfhwjpgcblyufzahec2hmtrxvkpp4woejw@iqeuzubt7afe>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-67-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721232142.77224-67-paul@paul-moore.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Paul,

With `CONFIG_INTEGRITY=y` but not `CONFIG_IMA=y` or `CONFIG_EVM=y` it
does not compile :

```
ld: vmlinux.o: in function `integrity_late_init':
security/integrity/initcalls.c:32:(.init.text+0x47f85): undefined reference to `init_ima'
ld: security/integrity/initcalls.c:36:(.init.text+0x47f96): undefined reference to `init_evm'
make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 1
make[1]: *** [Makefile:1236: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2
```

>  security/integrity/Makefile       |  2 +-
>  security/integrity/evm/evm_main.c |  6 ++---
>  security/integrity/iint.c         |  4 +--
>  security/integrity/ima/ima_main.c |  6 ++---
>  security/integrity/initcalls.c    | 41 +++++++++++++++++++++++++++++++
>  security/integrity/initcalls.h    | 13 ++++++++++
>  6 files changed, 63 insertions(+), 9 deletions(-)
>  create mode 100644 security/integrity/initcalls.c
>  create mode 100644 security/integrity/initcalls.h
> 
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index 92b63039c654..6ea330ea88b1 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -5,7 +5,7 @@
>  
>  obj-$(CONFIG_INTEGRITY) += integrity.o
>  
> -integrity-y := iint.o
> +integrity-y := iint.o initcalls.o
>  integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
>  integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
>  integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o

---

> diff --git a/security/integrity/initcalls.h b/security/integrity/initcalls.h
> new file mode 100644
> index 000000000000..5511c62f8166
> --- /dev/null
> +++ b/security/integrity/initcalls.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef PLATFORM_CERTS_INITCALLS_H
> +#define PLATFORM_CERTS_INITCALLS_H
> +
> +int integrity_fs_init(void);
> +
> +int init_ima(void);
> +int init_evm(void);
> +
> +int integrity_late_init(void);
> +
> +#endif
> -- 
> 2.50.1
> 

Nicolas

