Return-Path: <linux-integrity+bounces-9675-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAaVLKaaFWrnWgcAu9opvQ
	(envelope-from <linux-integrity+bounces-9675-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 15:05:42 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D545D6057
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 15:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09588302C901
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D6B3B5851;
	Tue, 26 May 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EKza7bFe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151E352C34
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800626; cv=none; b=i/TAbnRuP02Dk4Z76o9MzWI5UbWoTf1aaVXfO8ief4Pjrd22o5vihwsE7hKkZ5iw4ZwuEo+rsynVvIDAyqUGy4hkZMxOXLlwSA4ndp1inzNThDBFIhKLQVNMsyPftltBTq/l3FufH2BxKnEvI1AGCGgs3blL5CkoD2Oz4Hmhkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800626; c=relaxed/simple;
	bh=cIV7eVLFj1WSRdO8UJfWGAKcQ4RL3tgfGuH1jAdS3kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jtfs+4LGxGk24R+WVrrXG6H3m+u+XYlCmzE/yxujGD97PsZcNJ9JE5aCw730xLpPUSUZGboAEcoJJX5F1C5Fi/7CkuyYXFgJsq5+IyIgv4WWnXYKLUhmfPjgY3pTh5UZ6Lw5M3Fx3KTPC1JgK2p8krdoYB2aSQa1DKsm47paxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EKza7bFe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e5624c053so6329988f8f.2
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779800623; x=1780405423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=EKza7bFeRfOQx4baBBdJSdVBzM2bve8Vku8qcuHTL1cYVJoQa2hWXbtAPm6EKv+KnF
         IterkP4Vdog+meaG7Vze1zOImzDCFf+4VYTp7uhiBNH9SWeHBhz67Egxfm1Y+vIwLZkq
         iXkupGSTgn20E5+tdlHJ3VTYvJ9nWNOMRCMpxNamsJCwQ3jmAF7d/A4FhvgNh/dKB1k4
         jIdjIY35h4zCtboEngwh4wP1MQ8ujcO+wcL0uxiix57Hu9LdhlaJfHiWyzZZd8DrRvr4
         dWlyVvqCuyLlokSTAwAvFB6yTdsoOhP0YVuxsM1t5zz8rNsgqshkwHrtovjbfmMBXRwA
         jZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779800623; x=1780405423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=orosGy6Hje5aR4zcuiidsrBRGhZG/73dgbITmHEzijJsR+rxlh0ihNG7fDih06a+zl
         N+WTdlD9WXgtOzL1mjqE182JR3MVUr5pkC6Qxz/02XlUO+EVasrGr5+QQSeH+gNpa453
         bHGZSnAYZ4EfpLNTHCrkbew90D9S0ikhCIhiMm0FQ4dYlUuOdYMlPRCBTO3ZT4WAEnqM
         WXAvevF/4xf2+Dluz5xbId+xeQp6L0qtIDN0UVvsYUqZzmKkBo8n7wsEhNzguJdNcNvk
         HOxnDAsoMEXFmwYjWAhwu7FUOX1TkOWFsw44+a05zlfUVsVmJ9MEtD78DeEVUfjiO8C+
         Dn6g==
X-Forwarded-Encrypted: i=1; AFNElJ+mf/1EeyIoX6BVQBKn6BpPRUTCW2k/CTrv2LCWthbHepDTjCFcIaFBJNmN6iscvg64mbmRrGPvKrSajzeR4zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCIIc1LGpfI9jAoEFQ4b9zIguOXNFL5bDciCS662/nuPG5EX3
	ntBlumNwVJKDyJvGjyHnQ9cdoImRb3qT2vjg+lPFs5TDo/nAX3gN3md4+VDazghsqGo=
X-Gm-Gg: Acq92OEFrDV2LmZtjPULMSdKBO7pq2ZIdd23PANGh7yedRM2Jr98+ss/H7Mer487prv
	sBio+PKYNOXjYUtOHyiD057824t5QrQ55DsUc6rqgwe4+QPmPI3f9Hu/CeeucpOMl/6tFSQIBPT
	k0aZoCTtNxGDa6rAyXWromzaViB3qyhtM3Zsvfqt2BHMj7XrRbbVSGsC+hgoMD7uJK5+AikOBHs
	WfGsgG90JH8jV0d14zSZlUGam0jTI8c0RY+R6HB9peu2r6a9aEgTbDcJGvvsz2d/1z0wmznd195
	ot30U+JmYKjW9bdH3hWW8pK8hRvyv+VQeBp+PF+JQ/BW/T8VuVnOCJoqmaYIsKDYpEQ7oRXY9XT
	zGR7P/Ov4tLwwJtwhWUoZEq6gmCfQRC8nxfKgjKolzQZiajN5X9vpnFDcwUI4NQ/QL6MZ0QINtX
	VpQJz0rO+pu4ibKhPl7xMHSUNXUQlPVwV8KzsHSt3b4Q3A
X-Received: by 2002:a05:600c:45ce:b0:490:52c0:73f1 with SMTP id 5b1f17b1804b1-49052c07823mr223327865e9.9.1779800622880;
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a198sm318501285e9.10.2026.05.26.06.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Message-ID: <635fed3c-4e39-4357-acd1-13f1653f9e3d@suse.com>
Date: Tue, 26 May 2026 15:03:39 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/14] module: Move signature type check out of
 mod_check_sig()
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
 <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,vger.kernel.org,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,lists.ozlabs.org,lists.debian.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-9675-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim,weissschuh.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54D545D6057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> Additional signature types are about to be added.
> As each caller of mod_check_sig() can have different support for these,
> move the type validation into the callers.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

