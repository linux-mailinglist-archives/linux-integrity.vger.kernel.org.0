Return-Path: <linux-integrity+bounces-9589-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF43Kz2qCWq/kAQAu9opvQ
	(envelope-from <linux-integrity+bounces-9589-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 17 May 2026 13:45:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85C560CBC
	for <lists+linux-integrity@lfdr.de>; Sun, 17 May 2026 13:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B11B300EFBA
	for <lists+linux-integrity@lfdr.de>; Sun, 17 May 2026 11:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB9361667;
	Sun, 17 May 2026 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5m0F391"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E135DA79;
	Sun, 17 May 2026 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018276; cv=none; b=mpV+mUY346VtLt8GSbTST8VzvtiwvgGl2M9Ag5LUkTNkgqc3mm2Ym2nWDVFFTJUNvHn3skNuIGPWSI/Vswy8VKf84mnWNINkcCs6qHlMcImGeFT7nqBaJZ1eIADv6EeZLEEDQoJA7sheZccTT8IyY3CcCoV/F4YNjeJQZOTfaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018276; c=relaxed/simple;
	bh=uYW3m1pYFVOwcAv+n1jUSpIUtmgXX1A0uFCJX0t8J0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7vylsrvUsns6OKSIiZHrom+5DrYKegUh2eLTRKPNfM4vgU2ERXv1PjBSHZIEwZ15VitkbCdUvhYZrzfn7elkWpHmTnte1vM068k0zH0u5VTBz/0mlXr8b/QihLtdEKV/lkGxhFXCaRSkRw1isEemTg+aP+/wOK7Q8wKsqJqDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5m0F391; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27369C2BCB8;
	Sun, 17 May 2026 11:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779018276;
	bh=uYW3m1pYFVOwcAv+n1jUSpIUtmgXX1A0uFCJX0t8J0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5m0F391jDBmZqnZ1pp6HOAagISHQ8qvchEHXTj5tr8OvRXBSFWb3QR1LyiDxlnU1
	 g8TgRFmb25zNBN59091G4Y4Pn3FgJSWLo7C50xUwgWh8fdrwerwwtWlG0aHXeOK+cG
	 BOew/QBWGgq8HAqBXRnVV+fYp4E1MsmZf3bKTCxpuog6sD/COBJ3gTuf1XoRNHjVOc
	 Y9bTwv5tZsep34ireJiT2GxIEKrEV+b8d956oFNvwyrzv1vmcy56LvAeBuRpMHo+fS
	 Jv5iM0d0jfvM+5J+uL9XHXJ2pShN1j8OSQweUtIqxRvs7xCZRvod0Neu+tHDzyEHg0
	 sYApvuVEM3A4w==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 0/4] firmware: arm_ffa: Move core init to platform driver probe
Date: Sun, 17 May 2026 12:44:30 +0100
Message-ID: <177901821586.3837863.815146764281043637.b4-ty@b4>
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
X-Rspamd-Queue-Id: 3F85C560CBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9589-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
      https://git.kernel.org/sudeep.holla/c/cc7e8f21b9f0
[2/4] firmware: arm_ffa: Register core as a platform driver
      https://git.kernel.org/sudeep.holla/c/e659fc8e537c
[3/4] firmware: arm_ffa: Set the core device as FF-A device parent
      https://git.kernel.org/sudeep.holla/c/7fe2ec9fb8e9
[4/4] firmware: arm_ffa: Defer probe until pKVM is initialized
      https://git.kernel.org/sudeep.holla/c/3acc80a78e45
--
Regards,
Sudeep


