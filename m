Return-Path: <linux-integrity+bounces-9450-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NwjH9cI+mkEIgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9450-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 17:12:23 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0954D0064
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 288913090A76
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC24480DC9;
	Tue,  5 May 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f+iBoUGk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4902F34677D;
	Tue,  5 May 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993620; cv=none; b=jg9eJupvNd2xNYORMSzbavfYw9+9oDgwi403fsAG6omAEr9l5hLRUXyL/HWmm6MFKyibfwInyp9QOtR+hnBLL2CSFDr3SMsrlU2wN+C4u9B0a+PeKiL+3SnY71h0dQvCke53oJqXBMAjRrLe6s8rtMExzw8u9II0Zx/cttgfW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993620; c=relaxed/simple;
	bh=BeYuC+U+TvY87kCGVgh7iHS9dj+g7bI/fKs9BPIiGBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUOi7i0KwTDqCqCaZ5RW7jMN1v5HmoZ+s5XX/rxGIlPgPetfEimW4ObjXoaJkOEwl0WHtOjeItAQLQILN/ENy259OYt4fY5Aw6HDxWeXMz46cuP/m2s7xiwjqtW3mdVfledIZ9s1cRMVg3N3wB4+tWcKIOSfLJDYUNPhrtMB8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f+iBoUGk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9BB165C;
	Tue,  5 May 2026 08:06:52 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02F83F836;
	Tue,  5 May 2026 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777993617; bh=BeYuC+U+TvY87kCGVgh7iHS9dj+g7bI/fKs9BPIiGBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+iBoUGk8BmoZc0I83YuzJUwdRjjsapp0YmhbwVraS05rC5e8/lAxTo6QaBJzO/uz
	 XxwMCmGis1kvV3x3mcD/LXf1oAs+ephfkejwE3zO0tuJLrO6BlpAgIdVC8KOKKS1z0
	 5hKCdG2Glgkt/8ZNFa4lo3kv0SNaawo/o2/95uAI=
Date: Tue, 5 May 2026 16:06:51 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 2/3] firmware: arm_ffa: initialise ff-a after
 finalising pKVM initialisation
Message-ID: <afoHizU8NgFWzvYW@e129823.arm.com>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-3-yeoreum.yun@arm.com>
 <20260505-super-gecko-of-argument-655030@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-super-gecko-of-argument-655030@sudeepholla>
X-Rspamd-Queue-Id: 3D0954D0064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	TAGGED_FROM(0.00)[bounces-9450-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,e129823.arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Sudeep,

> On Tue, May 05, 2026 at 10:54:08AM +0100, Yeoreum Yun wrote:
> > When pKVM is enabled, the FF-A driver must be initialised after pKVM.
> > Otherwise, pKVM cannot negotiate the FF-A version or obtain the RX/TX
> > buffer information, leading to failures in FF-A calls.
> > 
> > Currently, pKVM initialisation completes at device_initcall_sync,
> > while ffa_init() runs at the device_initcall level.
> > 
> > So far, linker deployes kvm_arm_init() before ffa_init(), and SMCs can
> > still be trapped even before finalise_pkvm() is invoked.
> > As a result, this issue has not been observed.
> > 
> > However, relying on above stuff is fragile.
> > Therefore, when pKVM is enabled, the FF-A infrastructure should be
> > initialised only after pKVM initialisation has been fully finalised.
> > 
> > To achieve this, introduce an ffa_root_dev ("arm-ffa") and
> > a corresponding driver to defer initialisation of the FF-A infrastructure
> > until pKVM initialisation is complete, and to defer probing of all FF-A devices until then
> > when pKVM is enabled.
> > 
> 
> I don't like this whole ffa root device design.
> Two question for now:
> 1. Can FF-A be a module on systems with pKVM which removes the need for all
>    this dance done here ?

But this means we reduce the other feature e.x) IMA with TPM over
FF-A and pKVM feature. Since IMA must be a built-in, we couldn't avoid
to build FF-A driver with built-in.

> 2. If it is a requirement to have this built-in, I prefer to add a probe
>    and defer it instead of this root ffa device.

But, How? anyway all of FF-A device & driver couldn't be probed unless
FF-A initialisation is finished and How can we trigger FF-A initailise
after pKVM finish its initialisation?

The problem is ff-a intiailisation happens before pKVM finish its
initailasation and to do defer probe, it should use dd-model and
As we discussed in other thread, notifier couldn't be a soluation.

Could you let me share other way I'm missing?

Thanks!

> -- 
> Regards,
> Sudeep

-- 
Sincerely,
Yeoreum Yun

