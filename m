Return-Path: <linux-integrity+bounces-9588-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKkqIVyoCWrdjgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9588-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 17 May 2026 13:37:00 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09935560C0E
	for <lists+linux-integrity@lfdr.de>; Sun, 17 May 2026 13:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD6BD3009CD5
	for <lists+linux-integrity@lfdr.de>; Sun, 17 May 2026 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E9E358381;
	Sun, 17 May 2026 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqmvU2NL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9063344031;
	Sun, 17 May 2026 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017813; cv=none; b=JFsPfxIMEKpHHNhcdKyfKu93KLLVkByWod6x3aE8cWVMZDT0HF/hVDF4Ab18trFOpq6FwMHdtcwEJ4GGqRXaR6U+YEVkMys5Fy7JbdUDxPghJTFdaKsq6THskI2vByaYhuXs8ZyXlVtSgpFhn+RHC/TL/3VghDmL6kyK0k0c+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017813; c=relaxed/simple;
	bh=g6Apzn4u313EzukCA+wWP7lCh0YVZoSdF8h+35KQL/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVU86lxeRptd1h5iMRMTzcfXMM3O8Hji24iA1kChFdxx7DINMNd/uAee6xKFVna+RxIxNvDwRjEotIuGLiqbrDcDCtwkG4DGlmhfD6yuqViOVlWRei41JauwwrDBQhRWjVl4dpO8tGO3Q7CZoUSQhO1KmL8vi31s+mM/9iRfP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqmvU2NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A606C2BCB0;
	Sun, 17 May 2026 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779017813;
	bh=g6Apzn4u313EzukCA+wWP7lCh0YVZoSdF8h+35KQL/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqmvU2NL5Rp83xGHXR0ltA7kmyoAtvN3jP6pY5W/Uqq7vVWoh5XuydouURN7Q5qe/
	 NvVRcv+uYqCg4b82co8kQ3k93DYXsEOMASC8m89W6BKeBY5HZyd5AlovaqY3OW4lk8
	 18vNWOgYt16UTG6ykqdkkq1TwEIuBcDb+zwu30XMamoidgdQXHiOss1R1JtsaPqdkS
	 Mpyk8eZWj+3M8Sl3YgEgFkK/RpF2eQE87jLIwwLMuUzwlBgScV3rM60wzd3aNqorDD
	 zspTFaSIiZtXPo9e86Jyp0+6EvxkIuhItlPJ/1hKPTQ7CBL7dYts2b3HxhskW5bUgI
	 kCkViuACEXBVw==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 0/4] firmware: arm_ffa: Move core init to platform driver probe
Date: Sun, 17 May 2026 12:36:45 +0100
Message-ID: <177901775932.3835515.4484747964630642694.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 09935560C0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9588-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 08 May 2026 18:54:14 +0100, Sudeep Holla wrote:
> This series moves the Arm FF-A core initialisation into the driver model by
> converting the core bring-up path to a platform driver probe/remove flow.
> 
> The first patch reverts the earlier rootfs_initcall change. That initcall
> ordering workaround is not a proper solution and potentially conflicts with
> pKVM FF-A proxy requirement.
> 
> [...]

Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[1/4] Revert "firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall"
      https://git.kernel.org/sudeep.holla/c/1b4c1c4d75a8
[2/4] firmware: arm_ffa: Register core as a platform driver
      https://git.kernel.org/sudeep.holla/c/d10175dd517a
[3/4] firmware: arm_ffa: Set the core device as FF-A device parent
      https://git.kernel.org/sudeep.holla/c/8bdff2dda405
[4/4] firmware: arm_ffa: Defer probe until pKVM is initialized
      https://git.kernel.org/sudeep.holla/c/216d4772b411
--
Regards,
Sudeep


