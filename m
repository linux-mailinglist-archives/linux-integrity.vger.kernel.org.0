Return-Path: <linux-integrity+bounces-9255-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLf+AJ5j5mkKvwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9255-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 19:34:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A15EB431794
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26E8F348EA49
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE22332919;
	Mon, 20 Apr 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUpWpp2d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF633AD9C;
	Mon, 20 Apr 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700035; cv=none; b=j0gYzCzZrczNjHaDL/S6e9lWxGaUYbSvNP7P+291SZqIgBoFd3KHK5gUYgXwT/jgonwUL2+ccv5ZE59gN51Msh7UrQ73LfFYns3O72cUmEN0LdTo/2+uF6DPEOdbe6Z1PQI6z2ZYxEXrtuwZTpjvsooLS2wxGIxyOLjZSUKqB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700035; c=relaxed/simple;
	bh=gQYl0ouZNK7K2Ui1Jbhz83qYxErusxL0Qfr6kR5eiJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da+fNJCPgcM94xjfzD8qNereySSv46o37cNKZEkkSohvto5fiS7QmY2GHJearf42NiIgoUqeLmCHVjfMLgScDq4esRoOfP9gOsH1eS0lUdUHm8KWCaCxJ3bn0Z4xUZCuQfnWgxnff97QL9G5xgTkxAxbKMpkjjebnzxcTl5Y8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUpWpp2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A361CC2BCB4;
	Mon, 20 Apr 2026 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776700035;
	bh=gQYl0ouZNK7K2Ui1Jbhz83qYxErusxL0Qfr6kR5eiJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUpWpp2dE22qfn8HiAp791wTxLZ9qlUT4BUg+Zrh7Bb0L2jZBbSI2/8kVNDbInyFJ
	 vy3b1iQ2zB4sgMCqN7VKuNqYCUtgtwankXFfSQyv8uAOmriSRgoP/mYretVXs85GNP
	 WmaD4WMzEKrrOsiRGLFTUPSfBbHWfCvtXZ7XZm113B5OSsWL34P6Dz1tt7pjoUeOfz
	 EQfztFzs1SPkZnpD/MpIaG/uXX2UwErvh+g7EYUIs7x1nbk4NqAHKZsV7fD2/WtmX5
	 o2pt3rERhqFRNCKFFslVqiRtDQhA43tulNMsIvgTbgljB5wcvHjGFDD32Hp5vlZfsA
	 kjJh2kB8jYShw==
Date: Mon, 20 Apr 2026 16:47:06 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com,
	sebastianene@google.com
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <20260420-olivine-cobra-of-brotherhood-bfd4bd@sudeepholla>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
 <aeNeNjfO7i128TIP@e129823.arm.com>
 <87pl3vb5bm.wl-maz@kernel.org>
 <aeS4rAeVQ0yJIPYw@e129823.arm.com>
 <aeXp7WSqpXNytNPG@willie-the-truck>
 <aeXxCe4hdizdQbFD@e129823.arm.com>
 <aeYDMEgWdt8F9jWb@willie-the-truck>
 <aeYGeojpqcYAN5++@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeYGeojpqcYAN5++@e129823.arm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9255-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,ziepe.ca,arm.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A15EB431794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:56:58AM +0100, Yeoreum Yun wrote:
> Hi Will,
> 
> > [+Seb for the pKVM FFA bits]
> >
> > Ah sorry, I mixed up the ordering of 'module_init' vs 'rootfs_initcall'
> > and thought you wanted to probe the version earlier. But then I'm still
> > confused because, prior to 0e0546eabcd6 ("firmware: arm_ffa: Change
> > initcall level of ffa_init() to rootfs_initcall"), ffa_init() was a
> > 'device_initcall' which is still called earlier than finalize_pkvm().
> 
> Right, and this is what I missed when writing patch
> 0e0546eabcd6 ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall").
> and it still exists even if it's device call.
> 
> However, rather than changing ffa_init to rootfs_initcall, moving ima_init
> to late_initcall_sync is a better approach, as it also addresses similar
> issues for TPM devices that do not use FF-A. For this reason,
> the FF-A-related changes were reverted.
> 
> As a result, patch 4/4 addresses an issue that existed independently of
> 0e0546eabcd6, as you pointed out.
> 

I was not fully convinced by commit 0e0546eabcd6 ("firmware: arm_ffa: Change
initcall level of ffa_init() to rootfs_initcall"), and I had raised this
concern at the time. However, in the absence of a better alternative, we
proceeded with merging it.

My concern remains essentially the same. That change moved the initcall one
stage earlier, and now, by introducing `late_initcall_sync()`, we are
effectively shifting the dependency issue one stage later instead of resolving
it in a more fundamental way. From my perspective, this still relies on
adjusting initcall ordering as the primary means of making the dependency
work.

I do not think that is a robust or sustainable approach. Tweaking initcall
levels tends to be inherently fragile because it addresses the symptom through
sequencing rather than establishing a clear and explicit dependency model.

I also recall that `finalise_pkvm()` is itself at `device_initcall` level. If
that is correct, would this not introduce another ordering issue or at least
leave us exposed to similar dependency problems? That is exactly why I remain
uneasy about solving this by continuing to move initcalls backward or forward.

More broadly, the fact that we are revisiting the same class of issue again
after such a short time reinforces my concern that this direction is not
sufficiently stable. We may revisit it soon after we merge this approach.

-- 
Regards,
Sudeep

