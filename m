Return-Path: <linux-integrity+bounces-9674-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIKDGdaRFWovWgcAu9opvQ
	(envelope-from <linux-integrity+bounces-9674-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 14:28:06 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C6E5D588C
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 187A830358B1
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953F3F99E5;
	Tue, 26 May 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="0PaXCVkX";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="qAvsEodf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4223F88AA;
	Tue, 26 May 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798465; cv=none; b=YrrxGG847tfeWEhARZvj2WgDQzIP/cuyCX3vyZZDj58TQEiKdRsfMv+/9BxvT+vgidhq3rRiZkcwTkhstP1c15MH8u+fVIaSChBuf09N+X4UirgDqcUxJosEqg/j2Lh4YajfBG86xrOkhGL55qBsd/9YS6H8FpsD03M7jq6WHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798465; c=relaxed/simple;
	bh=vDlPE3WlLowbB4twTPNt5oAOKEs7T3k99UMNQRP9CcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCQW2HGgXmqu9gcuiGCD/CLzy0bCeTJK8X/zHnOm37PBQlPvY2+/WJnv4jS4zRjvj43EQEsIQ/NnYzdUkPyxzxVplVbxqBOByCPuzrrYgjTO3FanAvAPciw3azCc6O15uIc70GTZIfqrQULf0h1qAiErGfKntR3WXEAQLLYiw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=0PaXCVkX; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=qAvsEodf; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <2d93a9e4-0c36-4bc7-8e94-b15f69ebda79@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1779798460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DumjHkMnQiUKEXczcFzbHTJ12Og3qEh2uESbAgSH9Z0=;
	b=0PaXCVkXBjwxgV57Gtk9GND9h+M3olt9dDZsAZSMh69khuwz+7omoquMv7bxY+X2NwBvDs
	7cJghWP+kfKXxa/Mzj4ItNhRylLxtHEbXT2U/CdXfxlLvJjJ5rkSidgc2aBrQrTiI+CPaf
	ofc7Q62sZXcpwYR2fUFCbVV0KYA5RBkUnwqkS7dvPSc8p+xrEimxO3yvUJhT2LR8N394lG
	zKL5TDaB8eCxpGZRhxbfjUn9RFNKl2xluA2p7u5kkai+avEVgv9hwAOtKMW2EVgYqK2xAn
	EZYIc0WKVZAH1Nb4ZDiz1NIO/snRu/iHOKTOeHm8VeRYVTieMy8yWHVg8nfo1l/UbnU8Tv
	k5Yk3bdm2ZtFa0+WU70NGuYxJOHWvVeBaFwICiatUOh8gM6R/WS3IFlU9YbXwjVzymwuFc
	XKuulQ5BeoNzGUlr/QrMDgw1cdIvgtAwKofD4IsvIOGsRR1yNR3JjzQoMvKvrQPONqF6JZ
	OMMNLxAhP1LGiCUgH2GoiCYXngwwZmE2ZcjLiIEAmlhKl2r0JyV2gMJn4Uke4zTOViHDJQ
	/gJXPKLMTm5lh6Zjv6J183nbfZ/UIz4eehTUQeqX6uRy6jBru/K/rs1ICZHdgd/GSKMS+z
	nP5SILf6vZKcsnA0+D/43BN50nXByYlhjDbPB2kBPA+oekNoiga84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1779798460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DumjHkMnQiUKEXczcFzbHTJ12Og3qEh2uESbAgSH9Z0=;
	b=qAvsEodfYN9Au3PfLWPaXQEfyjbOcwD3RqWnSlsvTSJQ3NP8ZX9wWEW0wqValvrgMDgl0u
	ST8XcV+dvsfuSMCQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=kpcyrd smtp.mailfrom=kpcyrd@archlinux.org
Date: Tue, 26 May 2026 14:27:36 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 07/14] module: Make module authentication usable
 without MODULE_SIG
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Petr Pavlu <petr.pavlu@suse.com>
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
 Mattia Rizzolo <mattia@mapreri.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
 debian-kernel@lists.debian.org,
 Holger Levsen <holger@reproducible-builds.org>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-7-e174a5a49fce@weissschuh.net>
 <0a0736a4-2cdd-49f2-9062-e2f18d769fc0@suse.com>
 <4ee3c775-1fbf-45e1-8b77-5f9034f45125@t-8ch.de>
Content-Language: de-DE, en-US
From: kpcyrd <kpcyrd@archlinux.org>
In-Reply-To: <4ee3c775-1fbf-45e1-8b77-5f9034f45125@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[archlinux.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[archlinux.org:s=dkim-rsa,archlinux.org:s=dkim-ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,vger.kernel.org,proxmox.com,bzzt.net,mapreri.org,heusel.eu,linutronix.de,lists.ozlabs.org,lists.debian.org,reproducible-builds.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-9674-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[archlinux.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpcyrd@archlinux.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 27C6E5D588C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 1:38 PM, Thomas Weißschuh wrote:
> On 2026-05-26 12:53:22+0200, Petr Pavlu wrote:
>> Should MODULE_SIG_FORCE be renamed to MODULE_AUTH_FORCE, along with
>> renaming the sig_enforce functionality in kernel/module/auth.c to
>> auth_enforce?
> 
> Given that it is a user-visible symbol we'll need to be a bit careful
> not to break existing configurations.
> I'll try to use the new "transitional" kconfig attribute.
A slightly softer worded alternative (yet semantically equivalent) name could be 
MODULE_AUTH_REQUIRE. No strong opinion though, I think MODULE_AUTH_* does make 
sense.

I initially shared the concern about renaming well established config options, 
but the transitional feature does seem to be a good fit for this.

Sincerely,
kpcyrd

