Return-Path: <linux-integrity+bounces-9487-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONlzFogj/mmunAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9487-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:55:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE79F4FA448
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F97301C963
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D78E40FDB4;
	Fri,  8 May 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiixJSdo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E31274FDF;
	Fri,  8 May 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262889; cv=none; b=QrpR2/bPzF+jEVfGSxj/mkITkhn0VtOI8G7jdVhisgmC7bp7YTypyQwlMTFOT2qvyjfDSJTp2121O6swLUI++FS4fWJsbYmWa+07xXGPQDWYkqscZ3YN4NiblX42ULsTM8jcITfpHl4jcfAiUdlDrzz1VxYFurNNzmXp625aE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262889; c=relaxed/simple;
	bh=yRPbUiY7NO4VWGjDKq44pQG8J7mr3eoU1H3qLt4LCHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OEbPI6MtYic4aUATfC4pymKG7jBK/XXUQgyIFNxnEXUI1VjQdpqPPNsqCOMOgpkO78RPl3aPmcVZXnwyHSXChb6lCDOFfrLVN90YdOT2JzzKmZKDCS8hsXGU2Cdi1PNHSm7rgr9PkVB1WA1ZetG4mlJ2tyanUiqDDZgdw4pQHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiixJSdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2439C2BCB0;
	Fri,  8 May 2026 17:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262889;
	bh=yRPbUiY7NO4VWGjDKq44pQG8J7mr3eoU1H3qLt4LCHM=;
	h=From:Subject:Date:To:Cc:From;
	b=kiixJSdom0hyuy67zNkWduKDEZF3BtrSepA4rkjOLjC8lGFI+iCBhXtdr2ynKv5Jl
	 lMZsrtpEmbno0Qo9nS2GQQiJMB20JglbUcwl0QCC13bjI1TWHdbUzOrJXkg/UgcbYv
	 D8P3qNGLjIndUKx/6+J8SJfVFdcbG6lofyUZeUoJ/Rs54JPLPgUm6H7wDxcxy47VQ5
	 2V9jBexUhTX72LmYRed427S00G5zVut4YXnTqdmkq9QWY5PpTm4dg8DyYtgBeM5SXm
	 wiJebNvo2KzsfIhMhsCbnWQh2SpJ4/fu2baP7dFdcz5Q8Lg0NoT/UJ+1wZBXbX9MnO
	 0DvsQtF1vR3bA==
From: Sudeep Holla <sudeep.holla@kernel.org>
Subject: [PATCH 0/4] firmware: arm_ffa: Move core init to platform driver
 probe
Date: Fri, 08 May 2026 18:54:14 +0100
Message-Id: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEgj/mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwML3SQT3bS0xPiCnMSS+JTUMl1jyyRLi6Qkc8vEVEsloK6CotS0zAq
 widGxEH5xaVJWanIJyBil2loARIIKgXMAAAA=
X-Change-ID: 20260508-b4-ffa_plat_dev-39b98bb79ae9
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: BE79F4FA448
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9487-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series moves the Arm FF-A core initialisation into the driver model by
converting the core bring-up path to a platform driver probe/remove flow.

The first patch reverts the earlier rootfs_initcall change. That initcall
ordering workaround is not a proper solution and potentially conflicts with
pKVM FF-A proxy requirement.

The FF-A core is then registered as a platform driver. For now, the driver
creates a synthetic arm-ffa platform device internally to bind the driver.
This is intended as a temporary bridge until ACPI and devicetree describe
the FF-A core device or object directly, at which point the internal device
creation can be dropped.

The series also makes the synthetic core device the parent of enumerated
FF-A partition devices, keeping the FF-A device hierarchy anchored under the
core transport device.

Finally, when protected KVM is enabled, FF-A probing is deferred until pKVM
has completed initialisation. The kernel pKVM FF-A proxy must perform its
own FF-A version negotiation and setup before the normal FF-A driver starts
using the transport, so the platform driver probe path now allows the driver
core to retry once that dependency is ready.

Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
Sudeep Holla (3):
      firmware: arm_ffa: Register core as a platform driver
      firmware: arm_ffa: Set the core device as FF-A device parent
      firmware: arm_ffa: Defer probe until pKVM is initialized

Yeoreum Yun (1):
      Revert "firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall"

 drivers/firmware/arm_ffa/bus.c    |  3 +-
 drivers/firmware/arm_ffa/common.h |  4 +--
 drivers/firmware/arm_ffa/driver.c | 64 ++++++++++++++++++++++++++++++++++-----
 drivers/firmware/arm_ffa/smccc.c  |  2 +-
 include/linux/arm_ffa.h           |  4 +--
 5 files changed, 63 insertions(+), 14 deletions(-)
---
base-commit: 917719c412c48687d4a176965d1fa35320ec457c
change-id: 20260508-b4-ffa_plat_dev-39b98bb79ae9


-- 
Regards,
Sudeep


