Return-Path: <linux-integrity+bounces-9673-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEJsE6qMFWrUWQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9673-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 14:06:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7F5D547D
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885773044B91
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3CC3F7ABE;
	Tue, 26 May 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VA0Jqz6j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DA3F7AAB
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796720; cv=none; b=PDQBQjq7PHiaV90QQI+xuVz4ol1wWglNj9NPogm4GfHyHX0cOSrxe59JRAZp1M+DFEf55OFBCORRqnFj9GG9Q8UR/HCgMfokmWmBojsAYRXKjZGq4waLSrsEkm+Vwh/jectZk/N58qa+V1eVBZk7VB6S5mmZR1X7YdFVYJUOsqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796720; c=relaxed/simple;
	bh=5W28sDVkarRvqQjMAW82poEsdm8er4gFoT6JmY4x6m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luBH7CQvYa7s6Y8Zb1Fg6RJWvMjc8WUR7XdRTj9AnYmDmddFYhL49/VIs10skpFlcbW8tSDaGJFhsiRk0rHtTsbStmZ7KZ7KtzMkfkbjJdr/Q4KveU9SedftNeMExjPhVM+FyB7oW2z1DqshwyZnVOmVPrDs13XwLFhYQSlNEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VA0Jqz6j; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d734223e4so6637764f8f.0
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779796711; x=1780401511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcvYzWTe1Y/hmlEUR12/Xq71LkSjxZ5X+aWQvNFuVk4=;
        b=VA0Jqz6jVFQ3yG6JwjGmfh7ff1Fgh1ZUasbed4oLwSnhPy7hmDa+VJXhPlslsr2lf3
         dCfGJ/BlvpK1djedBbs/RsSwK5sU6gfpJx8y7ghea+Iex1zA1kt4/BJ1gJrVVakaU4uW
         3eykLx+EnyHxFFSbLmeIbeX83v8kggpomupg3YRCqE80PBMwgzB+a6ZAKXoX5sh9fJdZ
         0yplQBP9f+MfgOhTiS5MqoerJ7SFFfLvBkmvNjcQWynCwIsp0xAQczN02eM+05m7iAnS
         adXc25rRVCCaBiYcu+s0zDLRDRgYRepTcPicuWltRB26Bf8Zx40bV1/0tKp1NQ5Nttxq
         x78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796711; x=1780401511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcvYzWTe1Y/hmlEUR12/Xq71LkSjxZ5X+aWQvNFuVk4=;
        b=nHJm8pPPsoBFExL3Dfga55geCXerao0gxyqKUZTA/NxrrWpWR/aZwSe06eweIT0KDr
         HkFAdp+hz9nEIVaLp2ByQ85dSTHm0OC1enqQVj4br4ZhXuo34j3PI5wgldi+vJ0u41Y1
         tu2iLTv1VdZ/Z6PgBqAitYsbI7s8s9QfrJmzBtoR5Dk6rZTqvwhu7xKjuZdsIHde2GP9
         oanrqAMvGAeRkqF/eSx7o6pP2W6QMH5TekkdF1gYGtOkSKs8IxEyFiRGErQ4kABs6xpi
         zOh8gqC41qtv/Es+Neb/yC5t2I7LEwW1kvkImcMRdYj2OWut+Pc5H7TcZ+8pM0n7oGs9
         iHog==
X-Forwarded-Encrypted: i=1; AFNElJ8aGNAGnilx8LA/isoFVgDOK5jolrXPS2Osnxn9WtpCMfYLW/mgIz60zlBb8UV3fz5B3zH4IU3terN+HQ17GRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkV3m8xg8riqJ23/KIGJszlyWWwUgHaod64+AwTYTUvuKTvVl
	PvHrtL2A+bXoTMne0yzS/L2SGSBNTY1FtN6+t7ARid7AANNYzdpZaN00gjETX0KVK20=
X-Gm-Gg: Acq92OEQjcYdtnBFPs1pANGMcx5DlakUTabbhfBB4JvtUFyz9mw7ZYb1uWBQ5nBAcRr
	QcpW4cuVE5vB0cugWZ+bjrg6X/R67P/s3TVPf9rtj41eIri74mKbLBfOviPtNRRja6cgqp+7QX1
	32DN5TCV4QmTzJa2VzKh87nJK4wDQHVr37Ir8Sz2Gr0tndTRBIaXh0fKdbLx+7DoJ4hCggCTYC2
	n2jQZQoRGmLdhXeHwC8i7IRsmeyR2AJdz5cRrV+3igBC3Vpmyr0NO+We+m2z8y0B/c1S/sWscVL
	2kVXHNzVftAYFnMgmiLZ8xfVlu8ocL3GVVUSF21MPmtlT9RoGHRmc4IdE7nafA9vNTz0ZLGivKh
	b3UOYg9cD7+AOeGrWtltD/eUmN8C1UihcFanYA4tOoh5/vJogwPILx6LtNOcgX4HIriJHCHzOlx
	ZQRjD7pdfBxg8wMuuFNBxn/hLa1taX60mzW6JtO9s0YF/Zo4lUDYrrc5Aqc000jucpAaFHov8eP
	dKzecsUNUne7oGK/0Jg0dAIxvZkSLtNJ6azybZN+7mFXrMYDG9T7w+EjPsFFNHS+AEGmA==
X-Received: by 2002:a05:6000:2888:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-45eb30de822mr28814928f8f.5.1779796711490;
        Tue, 26 May 2026 04:58:31 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4741bsm36462739f8f.22.2026.05.26.04.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:58:31 -0700 (PDT)
Message-ID: <885a7940-3fcd-4fc4-b80e-cd82a817defd@suse.com>
Date: Tue, 26 May 2026 13:58:29 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/14] module: Move authentication logic into dedicated
 new file
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?=
 <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>,
 Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
 Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?=
 <mcaju95@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
 debian-kernel@lists.debian.org
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-8-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-8-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,vger.kernel.org,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,lists.ozlabs.org,lists.debian.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9673-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E9D7F5D547D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> The module authentication functionality will also be used by the
> hash-based module authentication. To make it usable even if
> CONFIG_MODULE_SIG is disabled, move it to a new file.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/auth.c b/kernel/module/auth.c
> index 956ac63d9d33..831a13eb0c9b 100644
> --- a/kernel/module/auth.c
> +++ b/kernel/module/auth.c
> @@ -5,10 +5,16 @@
>   * Written by David Howells (dhowells@redhat.com)
>   */
>  
> +#include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> +#include <linux/module_signature.h>
>  #include <linux/moduleparam.h>
> +#include <linux/security.h>
> +#include <linux/string.h>
>  #include <linux/types.h>
> +#include <uapi/linux/module.h>
> +#include "internal.h"
>  
>  #undef MODULE_PARAM_PREFIX
>  #define MODULE_PARAM_PREFIX "module."
> @@ -30,3 +36,82 @@ void set_module_sig_enforced(void)
>  {
>  	sig_enforce = true;
>  }
> +
> +static int mod_verify_sig(const void *mod, struct load_info *info)
> +{
> +	struct module_signature ms;
> +	size_t sig_len, modlen = info->len;
> +	int ret;
> +
> +	if (modlen <= sizeof(ms))
> +		return -EBADMSG;
> +
> +	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
> +
> +	ret = mod_check_sig(&ms, modlen, "module");
> +	if (ret)
> +		return ret;
> +
> +	sig_len = be32_to_cpu(ms.sig_len);
> +	modlen -= sig_len + sizeof(ms);
> +	info->len = modlen;
> +
> +	return module_sig_check(mod, modlen, mod + modlen, sig_len);
> +}
> +
> +int module_auth_check(struct load_info *info, int flags)
> +{
> +	int err = -ENODATA;
> +	const unsigned long markerlen = sizeof(MODULE_SIGNATURE_MARKER) - 1;
> +	const char *reason;
> +	const void *mod = info->hdr;
> +	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> +				       MODULE_INIT_IGNORE_VERMAGIC);
> +	/*
> +	 * Do not allow mangled modules as a module with version information
> +	 * removed is no longer the module that was signed.
> +	 */
> +	if (!mangled_module &&
> +	    info->len > markerlen &&
> +	    memcmp(mod + info->len - markerlen, MODULE_SIGNATURE_MARKER, markerlen) == 0) {
> +		/* We truncate the module to discard the signature */
> +		info->len -= markerlen;
> +		err = mod_verify_sig(mod, info);
> +		if (!err) {
> +			info->auth_ok = true;
> +			return 0;
> +		}
> +	}
> +
> +	/*
> +	 * We don't permit modules to be loaded into the trusted kernels
> +	 * without a valid signature on them, but if we're not enforcing,
> +	 * certain errors are non-fatal.
> +	 */
> +	switch (err) {
> +	case -ENODATA:
> +		reason = "unsigned module";
> +		break;
> +	case -ENOPKG:
> +		reason = "module with unsupported crypto";
> +		break;
> +	case -ENOKEY:
> +		reason = "module with unavailable key";
> +		break;
> +
> +	default:
> +		/*
> +		 * All other errors are fatal, including lack of memory,
> +		 * unparseable signatures, and signature check failures --
> +		 * even if signatures aren't required.
> +		 */
> +		return err;
> +	}
> +
> +	if (is_module_sig_enforced()) {
> +		pr_notice("Loading of %s is rejected\n", reason);
> +		return -EKEYREJECTED;
> +	}
> +
> +	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
> +}

The resulting call chain of the module authentication/signature
functions is as follows:

ima_read_modsig() -----------------------------,
                                               v
module_auth_check() -> mod_verify_sig() -> mod_check_sig()
                             |
                             |-> module_sig_check()
                             '-> module_hash_check()

I think this logic is quite hard to follow because mod_verify_sig(),
mod_check_sig() and module_sig_check() have very similar names.

The naming of module_auth_check(), module_sig_check() and
module_hash_check() looks good to me, but I would prefer to rename
mod_check_sig() and mod_verify_sig(). Perhaps mod_check_sig() could be
renamed to mod_check_sig_header(), and mod_verify_sig() to
mod_dispatch_auth_check()?

Otherwise, the patch looks ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

