Return-Path: <linux-integrity+bounces-9887-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VWgWBGZnTGodkAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9887-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 04:41:42 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A036716E1F
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 04:41:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="KW/PfXAz";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9887-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9887-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 327F03023504
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 02:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7C2375ACF;
	Tue,  7 Jul 2026 02:41:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A113B293;
	Tue,  7 Jul 2026 02:41:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392085; cv=none; b=FnQCmzvXSHsm3YK3uM9H+5z9XL8ibgtUnIBcC0FvKD0lvQLrGrfmI2Sud6ljOgLdddl+byoli1XatKL02G1OwMEgNvgg8rLI8wRz2kf27PpPrehWHZZZYEwlz4wnz4jVoOsM9ejaqFVorv89aaA2uq9E3ZYv1TemFtmt5hkTNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392085; c=relaxed/simple;
	bh=u/VsOTHHq7IiQbuG0qT+dMj27MDcfSzImQdo8zFfAeI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fuUQPg5xLf4MfIcc/Cz+/RuoLYOrzrSEXp81cSHtUTHqdN32cU1V4YwJW00I28nySxJG/FgU6IG/ZfBRr28R8/VYUOWGllm0/tO6q6FFeITaKf5H+40H+pB2W1vtsj6NjVJ6PMTQ343QNnlPV8g3ZR8OjKjRPQDkig1iPMTjnkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW/PfXAz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3691F000E9;
	Tue,  7 Jul 2026 02:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783392083;
	bh=/LkxGxrdfXAMwbooc2xbIL9hEUlDluU32Qi7rBGIEBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KW/PfXAzjfuVQFay9ui4hKELGG1lw0/4l4GoFzm2QSezH7FybLAl+cHM2uRDrcGnt
	 GgrjeHYAZ40xpO9/aUQlS0hVvTGlwEWiWQrkSY1KELoOa61c2dibu//cbuarZ9ICEx
	 eco01BJhNcwfyCh7vPtJV0IjqiC4i9n8rlDkG/iMQfA4MC23DUGiJ+a3HoQA1rcPHT
	 g+4pZ9yalFzLMuyl8eHTJ28jP9fXh8/Bg/CshR5zfj1vad0hQplXU37hbWyw/MfNbc
	 uoIqw1lisMrPVYFKFBUNhmYdRyXABqngQxpvqFEa8q8LvGHb4XblTPm/CnK4ULRsj2
	 2Y1aY+MTG8Dng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D03925F7B;
	Tue,  7 Jul 2026 02:41:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] riscv: Prevent NULL pointer dereference in
 machine_kexec_prepare
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178339206389.1302215.10769604011679543705.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 02:41:03 +0000
References: <20260703111530.91285-2-ltao@redhat.com>
In-Reply-To: <20260703111530.91285-2-ltao@redhat.com>
To: Tao Liu <ltao@redhat.com>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, bhe@redhat.com, zohar@linux.ibm.com,
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
 pratyush@kernel.org, Markus.Elfring@web.de, kernel-janitors@vger.kernel.org,
 jarkko@kernel.org, stable@vger.kernel.org, nutty.liu@hotmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,web.de,hotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9887-lists,linux-integrity=lfdr.de,linux-riscv];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ltao@redhat.com,m:linux-riscv@lists.infradead.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-kernel@vger.kernel.org,m:kexec@lists.infradead.org,m:bhe@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:linux-integrity@vger.kernel.org,m:pratyush@kernel.org,m:Markus.Elfring@web.de,m:kernel-janitors@vger.kernel.org,m:jarkko@kernel.org,m:stable@vger.kernel.org,m:nutty.liu@hotmail.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A036716E1F

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Fri,  3 Jul 2026 23:15:31 +1200 you wrote:
> A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare(),
> where image->segment[i].buf might be NULL and copied unchecked.
> 
> The NULL buf comes from ima_add_kexec_buffer(), where kbuf is added by
> kexec_add_buffer(), but kbuf.buffer is NULL, then it is copied without
> a check in machine_kexec_prepare().
> 
> [...]

Here is the summary with links:
  - [v4] riscv: Prevent NULL pointer dereference in machine_kexec_prepare
    https://git.kernel.org/riscv/c/60d607dc599a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



