Return-Path: <linux-integrity+bounces-9335-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pGNnKc9I7GkZXAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9335-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 06:53:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F5464F68
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 06:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990FD300DF42
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Apr 2026 04:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EADE5CDF1;
	Sat, 25 Apr 2026 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mpyx+TbM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F21C84BB;
	Sat, 25 Apr 2026 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777092810; cv=none; b=Us2ZyePlTvpvnSy/+tIw2AWdYcdoCa8za7Bj8X3Sxb2to8E2KsC9J6DJb4zhIW4fKKXa5HepoaoajUIAMGkjoVzZUHDsR1UrCt+6Dfj3dHAzbzE1I8FUzYNaeaIcmjYKw16cMKKDk2wiKDFoGT4p5mkZ2Fy3rP5A40pdZqssrMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777092810; c=relaxed/simple;
	bh=+9u7EK2Y/HhdgOEE30vcAjodDpWFlSP0b0+cZVFApXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7VaLvZiy9ztzQeZ9MeoW18asfod8t+p+DaiYdJb9G6DqW2R/Vkss8dHkbuJZ05h1BE4tRgggBakxIvagSSEW9zybOHiDwhGvpEVyda3mnmc40kFLnyDPYONZuYBxTZl10GmEeaATkJHvNpuWhc0OOaPI9e16kX6hHtN6X58ujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mpyx+TbM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F16E335AB;
	Fri, 24 Apr 2026 21:53:21 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597DE3F62B;
	Fri, 24 Apr 2026 21:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777092807; bh=+9u7EK2Y/HhdgOEE30vcAjodDpWFlSP0b0+cZVFApXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpyx+TbMIq+ior7LsPTIlyZk8u/VbsgXRov22WCh+KdsLt06ArcEHlBUHXOlw+5tP
	 zoH8OS46iFTYFpYFWcrsJrw3oFSPduaM14w1BBFJd/fUg7AujO/atqUP3oPa8LMf2A
	 NS6wirQcjTnwHLgYLDMgefazm5Gmke6C/JKNzV4w=
Date: Sat, 25 Apr 2026 05:53:20 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, roberto.sassu@huawei.com,
	Jonathan McDowell <noodles@earth.li>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
Message-ID: <aexIwJpno3iPIdRD@e129823.arm.com>
References: <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com>
 <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com>
 <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com>
 <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
 <aesGU8a3mbVzvteH@e129823.arm.com>
 <CAHC9VhSaT_quKYnpFjAfqvL07JNbWMgM6c4pB9F46NHawX3DCA@mail.gmail.com>
 <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <014cf39aa8d6a0bcfa1a95c069675977ac67b843.camel@linux.ibm.com>
X-Rspamd-Queue-Id: AC8F5464F68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[paul-moore.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9335-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,e129823.arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

[...]
> > I understand the need to ensure that the TPM is available, but if it
> > isn't safe to wait to initialize IMA at late_initcall_sync() then it
> > would seem like this is a bad option and we need another mechanism to
> > synchronize IMA with TPM devices.  If it is safe to initalize IMA in
> > late_initcall_sync(), just do that and be done with it.
>
> Within the same initcall level there is no way of ordering the initialization.
> Yeorum attempted to address the ordering issue in commit 0e0546eabcd6
> ("firmware: arm_ffa: Change initcall level of ffa_init() to rootfs_initcall"),
> which is being reverted in this patch set.
>
> Ordering within an initcall level needs to be fixed, but for now retrying at
> late_initcall_sync works for some, hopefully most, cases.

Ordering within an initcall level is not good idea.

Though it came to my mind first long ago,
It also goes against existing mechanisms like deferred probe, and
can cause the driver model’s dependency handling to harden
in the wrong direction. So this I think it wouldn't be an option.

--
Sincerely,
Yeoreum Yun

