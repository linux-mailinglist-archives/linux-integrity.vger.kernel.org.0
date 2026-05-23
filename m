Return-Path: <linux-integrity+bounces-9641-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L5QD87wEGo+fwYAu9opvQ
	(envelope-from <linux-integrity+bounces-9641-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2026 02:11:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA945BBB26
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2026 02:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 788413001FE0
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2026 00:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7EB2233A;
	Sat, 23 May 2026 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfQZM2qZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA2EEBB;
	Sat, 23 May 2026 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495114; cv=none; b=kCTOAKmw+1Rb+avNcLFitXVAn1grBmzbulAHyRj9HrtQR0obaCsgPiYhvu1Vxila0IQmPuYKQDZ64ToLy5S8qooOq5XstOtdBx1lPe9so35EheYBndsB36EBWH7kfdrfEo8LHbziV+h/ATPs55C1M3sNmDs/OUuLqjDQJkT901g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495114; c=relaxed/simple;
	bh=4gyir+4v/cozik3PIc8+RTGqZfUKwoEQ7fgVVJgADsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFCj3u8FgrSpuw4u2fX/GIKEBIwaFxSuXziLZCRcLluxySI7GLQ0fvZy9s1zqEDXnt61XTUdYiCU39V8n4NRk57RqX4fRLUDVcUlD31ONw30CHNnkmVW82DtTTYhEqG0kOxjbJEqj/bMUVgZfdrLlNlyzjRApWSLO80ObDjBw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfQZM2qZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D45F1F000E9;
	Sat, 23 May 2026 00:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495113;
	bh=UOdjcdrieoIVhDjSmGmUc8dVnOKSpLVQHovlfDmXAb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QfQZM2qZToodXI72EM2dRbFKuAXhioJ6ijpdSXMpkvZbzz8PQPYBYLax+Z8+Pn9H8
	 B8LN5btyBUxe/KdCJZtqNnyccSPo8SXTGk7JhaiV7unVL9vO4pNsKGH9UQJYZm9MZv
	 GNbJiWozXu3o+djzKrAa0nuO6ROYrHeGyn49ZxyYZhW9j67RCwr0HjD14c9TblisKT
	 v++jtLxD4fuxf3NPQjUleVqlXUklC2odqo+kEi7mVQ0GtS7CtSO3vXXSkuYL0w6YMt
	 7AZPriv2QJ6YfznX+yej7YTtSlB1u2T735aKrmNhnFk5d9YyLTvCM4Kkhf0HAo5h0p
	 k0b2g5+g+t/Tw==
Date: Fri, 22 May 2026 17:11:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 2/4] firmware: arm_ffa: Register core as a platform driver
Message-ID: <20260523001148.GA1319283@ax162>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
 <20260508-b4-ffa_plat_dev-v1-2-c5a30f8cf7b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508-b4-ffa_plat_dev-v1-2-c5a30f8cf7b8@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9641-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CBA945BBB26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sudeep,

On Fri, May 08, 2026 at 06:54:16PM +0100, Sudeep Holla wrote:
> Move the FF-A core bring-up and teardown paths into platform driver
> probe and remove callbacks, and register a synthetic arm-ffa platform
> device to bind the driver.
> 
> This makes the FF-A core lifetime follow the driver model while keeping
> the device creation internal to the FF-A core. Use normal platform driver
> registration so the probe path has standard driver-core semantics.
> 
> The synthetic platform device is a temporary bridge until ACPI and
> devicetree describe the FF-A core device or object. Once those firmware
> description paths are defined, the internal platform device creation can
> be dropped and the driver can bind to the firmware-described device
> directly.
> 
> Since the transport selection now happens from the platform probe path,
> drop the __init annotation from ffa_transport_init().
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>

I am seeing

  arm-ffa arm-ffa: probe with driver arm-ffa failed with error -95

on my two arm64 test machines after this change landed in -next as
commit e659fc8e537c ("firmware: arm_ffa: Register core as a platform
driver"), is this expected? If so, perhaps it should be silenced?

Cheers,
Nathan

# bad: [c1ecb239fa3456529a32255359fc78b69eb9d847] Add linux-next specific files for 20260522
# good: [6779b50faa562e6cca1aa6a4649a4d764c6c7e28] Merge tag 'pci-v7.1-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect start 'c1ecb239fa3456529a32255359fc78b69eb9d847' '6779b50faa562e6cca1aa6a4649a4d764c6c7e28'
# bad: [c09bb0d7c56d56daed51e374409472c3fece9931] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
git bisect bad c09bb0d7c56d56daed51e374409472c3fece9931
# bad: [42b0664d6f7b3d04f961e0709811280e52d4d39c] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
git bisect bad 42b0664d6f7b3d04f961e0709811280e52d4d39c
# good: [63775c4b77cf7ac5863ae0e76f8626b80d217562] Merge branch 'mm-nonmm-unstable' of https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 63775c4b77cf7ac5863ae0e76f8626b80d217562
# good: [f437936af5c74fddfdfcd2388a5f1eec2f9a105b] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
git bisect good f437936af5c74fddfdfcd2388a5f1eec2f9a105b
# good: [01bf3f256f1ed15fa3884e4893e5a9d78fdfb2d6] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
git bisect good 01bf3f256f1ed15fa3884e4893e5a9d78fdfb2d6
# bad: [bee649097c8de82d9dccd3660c41163a6507e3d4] Merge branch 'next' of https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git
git bisect bad bee649097c8de82d9dccd3660c41163a6507e3d4
# bad: [82ccfdd8dd1e29229a3ed7c95a76578706fc4a1d] Merge branch 'for-next' of https://github.com/sophgo/linux.git
git bisect bad 82ccfdd8dd1e29229a3ed7c95a76578706fc4a1d
# good: [32bc5496b48174dbca1f187f710955ee4d9527a1] firmware: arm_scmi: Validate SENSOR_UPDATE payload size
git bisect good 32bc5496b48174dbca1f187f710955ee4d9527a1
# bad: [64251369d33884b431a52b89c60fabf466f3913c] Merge branches 'for-next/scmi/updates' and 'for-next/ffa/updates' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linux-next
git bisect bad 64251369d33884b431a52b89c60fabf466f3913c
# bad: [70492cfce2a4d41e87bf46989028a90f4bc6b38f] firmware: smccc: Fix Arm SMCCC SOC_ID name call
git bisect bad 70492cfce2a4d41e87bf46989028a90f4bc6b38f
# bad: [7fe2ec9fb8e9a78dad8d6b1e551cb4d126e36f1e] firmware: arm_ffa: Set the core device as FF-A device parent
git bisect bad 7fe2ec9fb8e9a78dad8d6b1e551cb4d126e36f1e
# bad: [e659fc8e537c7a21d5d693d6f30d8852f2fa8d91] firmware: arm_ffa: Register core as a platform driver
git bisect bad e659fc8e537c7a21d5d693d6f30d8852f2fa8d91
# good: [cc7e8f21b9f0c229d68cf19a837cba82b5ac2d87] Revert "firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall"
git bisect good cc7e8f21b9f0c229d68cf19a837cba82b5ac2d87
# first bad commit: [e659fc8e537c7a21d5d693d6f30d8852f2fa8d91] firmware: arm_ffa: Register core as a platform driver

