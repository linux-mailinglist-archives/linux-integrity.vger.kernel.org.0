Return-Path: <linux-integrity+bounces-9258-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIXcG4Bw5mmBwAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9258-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 20:29:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2577432D72
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 20:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E87D30EBC69
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EFC379980;
	Mon, 20 Apr 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wacy9S/Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D16A37AA65;
	Mon, 20 Apr 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704662; cv=none; b=QHLbIOFVZwlScEa1uhC5D1hQYjNq13Sbn2F6u4DtOaeThw3CxytyBvxRThESlePar5JNEzhHZ3MRsPcrW11xwASSCk2f4SWHo7yX8fyA9oEjVBNHx929nQBMXeKdZmnp50S6pktnEi5E3HkbbcoHAioqL4CP7aCwrcf1Fb1Qo+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704662; c=relaxed/simple;
	bh=yRc6tzbhIjqa28m1qmW4UX0qWCRaHh+34fkYVAyFgQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW1mIIVi3snIufcIgcu1nxjtpEPotr3zSSV8zgy48alExUyT5jyTq5yQ6rTyrppphZQWsQPpiTdUl4OYD7IMMFsd5+2z40DQ6dmutwsH20XGdeNSeHqCmJqzGn1znmjg81HOUWRcFxvqtWdciRw+JwKji0msZmyOjM5ZQ6pmXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wacy9S/Z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B54D01516;
	Mon, 20 Apr 2026 10:04:13 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50C183F915;
	Mon, 20 Apr 2026 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776704659; bh=yRc6tzbhIjqa28m1qmW4UX0qWCRaHh+34fkYVAyFgQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wacy9S/ZPt9Y7v/ct+Hb+QPydm3fjVRQplB9QxXGOsLTBekpTPqnsaMca0kamuoEW
	 SGQ6QONwRmBlO8d/cVwMwpP6TU7OmYw273xBR7Zj7hU5thdu5jlLJAp8INH5VzhLz9
	 ijzBSlASATvCse9gHcojqyT85ag+98biT096gBAc=
Date: Mon, 20 Apr 2026 18:04:12 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <aeZcjPaIiCHYVwfd@e129823.arm.com>
References: <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
 <aeNeNjfO7i128TIP@e129823.arm.com>
 <87pl3vb5bm.wl-maz@kernel.org>
 <aeS4rAeVQ0yJIPYw@e129823.arm.com>
 <aeXp7WSqpXNytNPG@willie-the-truck>
 <aeXxCe4hdizdQbFD@e129823.arm.com>
 <aeYDMEgWdt8F9jWb@willie-the-truck>
 <aeYGeojpqcYAN5++@e129823.arm.com>
 <20260420-olivine-cobra-of-brotherhood-bfd4bd@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-olivine-cobra-of-brotherhood-bfd4bd@sudeepholla>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,ziepe.ca,arm.com,google.com];
	TAGGED_FROM(0.00)[bounces-9258-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,e129823.arm.com:mid]
X-Rspamd-Queue-Id: E2577432D72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Mon, Apr 20, 2026 at 11:56:58AM +0100, Yeoreum Yun wrote:
> > Hi Will,
> >
> > > [+Seb for the pKVM FFA bits]
> > >
> > > Ah sorry, I mixed up the ordering of 'module_init' vs 'rootfs_initcall'
> > > and thought you wanted to probe the version earlier. But then I'm still
> > > confused because, prior to 0e0546eabcd6 ("firmware: arm_ffa: Change
> > > initcall level of ffa_init() to rootfs_initcall"), ffa_init() was a
> > > 'device_initcall' which is still called earlier than finalize_pkvm().
> >
> > Right, and this is what I missed when writing patch
> > 0e0546eabcd6 ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall").
> > and it still exists even if it's device call.
> >
> > However, rather than changing ffa_init to rootfs_initcall, moving ima_init
> > to late_initcall_sync is a better approach, as it also addresses similar
> > issues for TPM devices that do not use FF-A. For this reason,
> > the FF-A-related changes were reverted.
> >
> > As a result, patch 4/4 addresses an issue that existed independently of
> > 0e0546eabcd6, as you pointed out.
> >
>
> I was not fully convinced by commit 0e0546eabcd6 ("firmware: arm_ffa: Change
> initcall level of ffa_init() to rootfs_initcall"), and I had raised this
> concern at the time. However, in the absence of a better alternative, we
> proceeded with merging it.
>
> My concern remains essentially the same. That change moved the initcall one
> stage earlier, and now, by introducing `late_initcall_sync()`, we are
> effectively shifting the dependency issue one stage later instead of resolving
> it in a more fundamental way. From my perspective, this still relies on
> adjusting initcall ordering as the primary means of making the dependency
> work.
>
> I do not think that is a robust or sustainable approach. Tweaking initcall
> levels tends to be inherently fragile because it addresses the symptom through
> sequencing rather than establishing a clear and explicit dependency model.
>
> I also recall that `finalise_pkvm()` is itself at `device_initcall` level. If
> that is correct, would this not introduce another ordering issue or at least
> leave us exposed to similar dependency problems? That is exactly why I remain
> uneasy about solving this by continuing to move initcalls backward or forward.
>
> More broadly, the fact that we are revisiting the same class of issue again
> after such a short time reinforces my concern that this direction is not
> sufficiently stable. We may revisit it soon after we merge this approach.

I understand your concern about relying on initcall ordering.

However, I think there is an important difference in scope in this case.
This change primarily affects the IMA subsystem, and the impact is
largely confined to IMA (at least based on my current understanding).

Also, this is not just about FF-A. The issue arises when TPM devices are
deferred, and IMA does not handle such cases properly. From that
perspective, moving ima_init() to a later stage is not simply about
adjusting ordering, but about ensuring that IMA correctly handles its
dependency on TPM devices.

In other words, the goal here is not to align dependencies indirectly
via initcall levels, but to ensure that IMA is initialized only after
its required dependencies are ready.

Regarding pKVM, finalise_pkvm() runs at the device_initcall_sync level.
Because of this, the FF-A driver needs a reliable way to determine when
pKVM initialization has completed, rather than relying purely on
initcall ordering.

--
Sincerely,
Yeoreum Yun

