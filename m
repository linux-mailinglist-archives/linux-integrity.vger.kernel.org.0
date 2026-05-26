Return-Path: <linux-integrity+bounces-9676-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBqhBEafFWr9WgcAu9opvQ
	(envelope-from <linux-integrity+bounces-9676-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 15:25:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A59CA5D6677
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 469FE3051D28
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784B3FA5C2;
	Tue, 26 May 2026 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WgInIwyk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684C3EBF07
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801294; cv=none; b=S44QpHvHiCc6EacWWQ895vuzNs8ULY+xpyl3qHpAxk45sPlqVoCRYY3NbBDz0eq1/u6rSEnf+N4OThcNqiD/DSIUC/0dGfl+W5C9QClgK8HNPz5gXnhSp8ufFCY8nMh9WPtsilM7dwKnef28s1MBVAyZ9vKRnw2mjgezxpUgZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801294; c=relaxed/simple;
	bh=/+TDbtQdoXZLR15lIobccDcb+fb9SD6eVXuxnbR2M98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bStz0Ta2Ns6FD7A7Sl4zi8XZkuvSXfWNrRcxRqbE1vWICIb6Wohlcnx5yM8GWfolQkIC/vda+AUA5h+MIjB7iAg7CBAp7Am6zpt8w67sPw9FM/bpNFzoepjm9za7QI422oPt/oA6ichJl2MLieyA/NY2IJZwMCaKq/6UuXiJXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WgInIwyk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48d146705b4so112022765e9.3
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779801290; x=1780406090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P15uXtg9HdllBQIu/ZsCrfbcDnCOaC1HB3obrbgjmNc=;
        b=WgInIwykVVoaGAUgaZcwBgPb2XaDQMvOOS2HFW9/o0cQ0HUO1ZApKEHQ8RW4TtLo7Q
         P0mg/PO6DDRxxTinG9zEP4hYMAMIYBNCHzD2gC9d4XHrk533aUfTsOUTxQ2cT77UpFzy
         7WI917lhsD43I1Zvr1pMY+XEkFOvYej7aY4h2sc1In8bxj5qJnjlQTbeSV+whjwcW8L3
         rl4d80CAUdQZmrA25YMNaSrUK3qshiAwA1BJCR4uxhTmL5xmDiKmWxnta6B6HjsCkV6Y
         nrrS/j/5mHD2Ug5dyQvXBvTz6pC9OMDa7i/iry8dzDHSmtWjgBoG+UCFGAFxHKmGuQV5
         K/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801290; x=1780406090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P15uXtg9HdllBQIu/ZsCrfbcDnCOaC1HB3obrbgjmNc=;
        b=Q6Fy4pFKsEo+iqYn5kpUFTj+nxP2Gq4mapFI2wMJ7xXdrYa9vTJikoMFYuE9WazvfT
         twpVTiMFn9AbS68dCm/XSB2lYnGRfASWNMWzi4L3bszEKNEyCuIl5PEcD4vGLz59NLa7
         UO5Q7BQixenzUkHiqDiyc8Si+Af3HRAbN7+gjTN9VYlr7M4dtWTlVsruOP8wdOADbnQU
         nCNfX+jrbiGcbMM/WkleRvCC2aNVvIQxrSZbPQ63AAqgHNaCylsemxeggyQlycEQnsbx
         yTDU2X1p82GAAVnmGecJ3lVwHAwK6AaYVOviibDqjGRQjkXURB5BmSpL0/ByRcdl2U9m
         ZcZA==
X-Forwarded-Encrypted: i=1; AFNElJ9blFcukdcHx9LSjM9pG+L6a/73oeiX9EhNA1zrbk1a7C+nQIkZdhEgyHWKvhsmaDl4X3y8+57urQ47nKq6R34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzo8zgqIzGs5Av+PqJ4oQCyKmjlKD17+KLl/jLleT370AY4sqB
	ajeYgD00bnIFDABkdidsDQqsRx70FWKK4nt4rMOsBOhgLrBle4szVKw1B81CPqzizLQ=
X-Gm-Gg: Acq92OH98ifw/s+o/A8vRICDvTOzoBmvprEK4Aqr0cXZe32FvYo/S4e7inYq36nHJMl
	iUGQVekng0VCXy71b7Tzt3y5C0/1GXXyjoHZTtosMZJG978CrYme1tD6xKiRIpgsQmZMr2k0ZrG
	OBtZ2ZFd1dkrOqBvoDYMfc+eqcSxUo84O7NzR3wqW4TQ6Weg9xScS4rK+c3YCfOp/qQYKNqVLsY
	MKdwXN5Wat+IBqhObYJmPY8Emzxkpzdi070/xVPef979LlPvDndad9+0vIUz2HF5+1vFjEu/6MT
	lmXJVd9UUbQLRFuAt4zUNPtKLRnQhqXrsZoTKNZBglh5lN7lzWmo1qgaP/Ed2Z3Vj04mY1bjBd2
	+1bqC5FuDBG1zwNoTsZG4Auqj/1O0sjKfIQfVxt2VOaVua11rExbD1FGcsFxY+tJvvkY0vFq6fe
	ihvIlM+41ML1EkNvUux0ApnOtxGVMdR+0KFeXOAKjnbGPZ
X-Received: by 2002:a05:600c:4f91:b0:490:6e12:5418 with SMTP id 5b1f17b1804b1-4906e12552emr91630705e9.23.1779801289895;
        Tue, 26 May 2026 06:14:49 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9f58dsm34868452f8f.5.2026.05.26.06.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:14:49 -0700 (PDT)
Message-ID: <a050130e-d354-411a-bfcd-afcfde4cafdc@suse.com>
Date: Tue, 26 May 2026 15:14:47 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/14] module: Prepare for additional module
 authentication mechanisms
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
 <20260505-module-hashes-v5-10-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-10-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,vger.kernel.org,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,lists.ozlabs.org,lists.debian.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-9676-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim,weissschuh.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A59CA5D6677
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> Reorganize the code to make it easier to add the new hash-based module
> authentication.
> 
> Also drop the now unnecessary stub for module_sig_check().
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

