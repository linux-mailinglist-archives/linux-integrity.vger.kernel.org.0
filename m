Return-Path: <linux-integrity+bounces-8359-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILATCMVze2mMEgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8359-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 15:50:45 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75642B12A4
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 15:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 844BB308C233
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42FC30F94E;
	Thu, 29 Jan 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/IlH4hS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC487305E2E
	for <linux-integrity@vger.kernel.org>; Thu, 29 Jan 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697876; cv=none; b=URNx75a0ADpfER3cA+0YrKOHi43lg6MPZtKlS+xP9mYa/MLsHehVe6tbPLC8lIZqohJDXvshHMefYJnsiw1pHDbqYUhIzKXieH5L0dVK6N/CWdPkOOJ/Lkqdjo3fkEMROq1gP//oHlcDBBzxxMbPxRiyNats6rInQZ5A/QByzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697876; c=relaxed/simple;
	bh=0cfpgEZxAtHlg92XqcFn2b1AgT2Rux9sr9odOOPM6rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omc941qAI1NAVEy7qwScYrjwlrTomtN85CAD4qT4wtwg7v3yNoD6HUO7kkEpx61ZfxgsdAjBPi6oqcnYd93/+6fS2LFAhQ89E4RaxB2/cM6HPx+1/RjA3kigbCSPHeFN3zMjbCs2YKapGd4YarRDu7rG5jUUJQfkAGA+6LGGUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/IlH4hS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so8924155e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jan 2026 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769697873; x=1770302673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aP9REXm6r045bgV7SMsbpSrPiKfypwCy9eB8rfdPdvU=;
        b=b/IlH4hSx+B+6rP5XO+ZCDrdqIqZNwRvFmk3IzNbmVeUc+S3/VL/Q5SYN5ja/Dqh6j
         COyyMc4qNfR93w8mVZzfHB7aPkwrvmsmYNZuatgAFU7PZ2Syv7MPZbndco7ydj7+30D2
         vz0NOGBbj8GqWuNQ2UvQHk5mPn2LY46vylYlbMpdeXXyplDvYLNjggXVxcnfYaanAvTr
         H/yw+UBIWwHlvJKPzSyIWnhBaaXYm7/MQznVaP1yJsh7ut1ecphrx6aHukIyBbKQW1ix
         2ppFJr3Rk2uWM22v+p/ag9GslNOlj7dExRrweweudR+1g0BnHFHKuA30BEcjkLT1ZrSu
         YSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769697873; x=1770302673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP9REXm6r045bgV7SMsbpSrPiKfypwCy9eB8rfdPdvU=;
        b=ZcwK8pgzPwVd9NtLZqVYBSYKgqj0jx7PHFpgGRkTJZypbJhoOFr0q93CsFK8lF+yMU
         idP8VoozGHWNnBRWU7jL20uQYf/i/mAw0NyZ9MT/psKoQxb2zsMEedWz6i3rB/42JU0j
         DWkQpTeFrx5gH5hZAvWqd/ThZeO9KH6IuZ3WrKq3K8WhqbdtHJ/Z44aR1wqRoRlmDeoq
         /emYxyNHPnd5IJ959virIqnT1EzZRrB9b2F7ec8EXKjv280GQY5L25+akiGwLNHThJkR
         IW1Je67La8s5COwx/sxODdvQxz5AxCVnfXNLS6nh6FaL+UtVuez6xXJaqVcnfujtHx2y
         bnug==
X-Forwarded-Encrypted: i=1; AJvYcCWNLGoTBc2khwb+vut24ayP7mG/gC+yf7QdkCRZV2Qxqhjd7rLChp63HwdXp7HM8yT/q+mN2oGG1Y0tZw+e+8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJyDHGfyaKNIS+QBMcTUG00RuNaTceYmDuEZbEWCggfQsFFd/
	5DI0TpvK8X51NEaUfwQ821O4wYCoCJFmF4I4W5zyav/u2exzJnvKWYA9+uZulwFbm28=
X-Gm-Gg: AZuq6aLKfGI7u4PiM2IV8RQs6IgjitSzczSo0Vx4m576dP1IXP7audDye4uAZb4QnWQ
	oViiA1SCYqDRFnLohRzNN9ZVbQa7VviVla0XGgmlAPQyK4WQjOJl4shX5dnI8lmSJT/icLlzjuQ
	tMgc/Tm7vXKaCrsHP36C4psEd0Qwi210L8Y0Pf2yjTYLeEtaFnOt8fPnFB7O62FvdTIi5VemjC7
	OOvDg2KZ/a/0UqdcPrK82ANcaLEleJ0FvOKHR6uAGkkwOyq1unm0rwbfuuKfxc9nxpQ1t//FD4B
	vCy8wqo+zi1UyV6KuLwwsFLgKktoLNfyUFfQU2loGhmBxB6c2IGUEl6dNQdGqlXa0iycbSDEufv
	mNI9C3x71wNc+iR7t7aU0xTct5alfJYDWUzh0kfSwtqYVIzZgUa+Bt22dgh232W/Yewg9GPa83t
	PbD8xBWy7oNHI2YIAxJwZASZgOyLAS2w==
X-Received: by 2002:a05:600c:c8d:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-480828ad89emr46795915e9.11.1769697873050;
        Thu, 29 Jan 2026 06:44:33 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm166871115e9.5.2026.01.29.06.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:44:32 -0800 (PST)
Message-ID: <fd19f9d3-b01c-4cc8-9fd5-642350e7b36b@suse.com>
Date: Thu, 29 Jan 2026 15:44:31 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/17] module: Report signature type to users
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-8359-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75642B12A4
X-Rspamd-Action: no action

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> The upcoming CONFIG_MODULE_HASHES will introduce a signature type.
> This needs to be handled by callers differently than PKCS7 signatures.
> 
> Report the signature type to the caller and let them verify it.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d65bc300a78c..2a28a0ece809 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3348,19 +3348,24 @@ static int module_integrity_check(struct load_info *info, int flags)
>  {
>  	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
>  				       MODULE_INIT_IGNORE_VERMAGIC);
> +	enum pkey_id_type sig_type;
>  	size_t sig_len;
>  	const u8 *sig;
>  	int err = 0;
>  
>  	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
>  		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> -				    &sig_len, &sig, "module");
> +				    &sig_type, &sig_len, &sig, "module");
>  		if (err)
>  			return err;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_MODULE_SIG))
> +	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
>  		err = module_sig_check(info, sig, sig_len);
> +	} else {
> +		pr_err("module: not signed with expected PKCS#7 message\n");
> +		err = -ENOPKG;
> +	}

The new else branch means that if the user chooses not to configure any
module integrity policy, they will no longer be able to load any
modules. I think this entire if-else part should be moved under the
IS_ENABLED(CONFIG_MODULE_SIG_POLICY) block above, as I'm mentioning on
patch #12.

-- 
Thanks,
Petr

