Return-Path: <linux-integrity+bounces-8467-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JRJJBCxhWkRFAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8467-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 10:14:56 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA7FBE4A
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 10:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A8B43055D49
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Feb 2026 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA6F355815;
	Fri,  6 Feb 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7b5R4g+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3F34676F;
	Fri,  6 Feb 2026 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368967; cv=none; b=c0msk9u8Q/i1Vf1t7ZSioHW1sSnFvfGWE+2GZhSmXLsMnzDrOawxEokNjeYXTQEQzi7b77IU818wTy5iz7fp8EJUtYkHEvxayNulUIUhXD53VNHnz5cjPT7KJyX8Szahcr6XC55oX9mVSdnL0znaChaf7BYKpL4QcyPFITHVrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368967; c=relaxed/simple;
	bh=bvTRKg2OrjlQepO6LzKrASGvcExrTa3Qk/kDeFWK0eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5PLwotbFLNZMHmHwrI6/E3FYf1Vf8wkMqrMURCOGWatJrwDC7KbbMYb4Vtt/5wWUt/ggxnXhdVq0/YYMtwvOeBrcu+yhyTRx6OiSjdA+AvebGCWYO7mbf8Np/+4V05jT+iqX0LSB2IBVFJ/evCseuprrmDf4FIk2pLy1nzCC44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7b5R4g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F419C19424;
	Fri,  6 Feb 2026 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770368966;
	bh=bvTRKg2OrjlQepO6LzKrASGvcExrTa3Qk/kDeFWK0eo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A7b5R4g+TJRZZXAGk3SKg4fQ3mkmVtOPSQE3PlMgcjr8O7xXRq8Jpvzam3nXZDYkv
	 +Zt/AyrCiKCKpfi7gnSR9NFYDSVjEGCpWHk4FZP+WiFnQZfUXeM7cQTX4redKYkLxE
	 SkUEzKlZAB7RCls0Cup2EA5fL2Rkiau4oR11peZpB8UrzPue5/OwWqCIcfEKih2UTc
	 SHqqzHb5+r3Y/36OucldM9ggEkUtRbQnUpiSNaWQ/3WeggSRDyg4WZ0dxyoZZH2R8r
	 VeC3+V5ktY4F36b70LLeQRYzciPk4iK6jmsb98kDxftqNPhRqhC5jD3XrxSF+cmqrO
	 r0A1HSU1NbsQA==
Message-ID: <ffdafd21-fe7a-44a2-86ec-0e0c2ad4238c@kernel.org>
Date: Fri, 6 Feb 2026 10:09:12 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/17] module: Switch load_info::len to size_t
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
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
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8467-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[weissschuh.net,kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,gmail.com,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33EA7FBE4A
X-Rspamd-Action: no action



Le 13/01/2026 à 13:28, Thomas Weißschuh a écrit :
> Switching the types will make some later changes cleaner.
> size_t is also the semantically correct type for this field.
> 
> As both 'size_t' and 'unsigned int' are always the same size, this
> should be risk-free.

Are you sure ?

Some architectures have size_t as 'unsigned int', some have 'unsigned 
long', some have 'unsigned long long'

https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/s390/include/uapi/asm/posix_types.h#L16
https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/sparc/include/uapi/asm/posix_types.h#L35
https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/xtensa/include/uapi/asm/posix_types.h#L26
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/uapi/asm-generic/posix_types.h#L68
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/uapi/asm-generic/posix_types.h#L72
https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/sparc/include/uapi/asm/posix_types.h#L23
https://elixir.bootlin.com/linux/v6.19-rc5/source/arch/x86/include/uapi/asm/posix_types_x32.h#L15
https://elixir.bootlin.com/linux/v6.19-rc5/source/include/uapi/asm-generic/posix_types.h#L16

Christophe

