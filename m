Return-Path: <linux-integrity+bounces-9314-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO05EWcG62kFHgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9314-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 07:57:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808F345A18A
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 07:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBA96300B568
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 05:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0CC345731;
	Fri, 24 Apr 2026 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oe+6nX2B"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB8347BD9;
	Fri, 24 Apr 2026 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777010268; cv=none; b=V8+Zo052Dr4m56/z0l4F8Xo9A/QXhu+ZKGuIAiZg7O4jw6jkVxiOnPGtHqjmJnGaJ/LpRCPXcEeXQhHCpYtRZMIrG6A4o9RQDZQPE4LyoretlfF68/c5mKPAYpCOHHLbE1dqEDxpRT0Cd5y5T/v/rnY0MN/MWf3xSQme5R6s3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777010268; c=relaxed/simple;
	bh=dTNza0KEYrjBEa6YZ5hzfCt/Ar2RAGWr/4ZMUagfrm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thSuGWgvZfWBM+lz7DJoTCQNABkRnKMTK7FFTP9lRK56551ua/JcFI32ZkhywpKL9ROwjrKiPNSuZo/2R8knFDgHw9Pa78CLRwchEs3+hWbNIhXqgYtZKKjpfG2C/TzI4r4KdeY4jHhRdOBQpfNzh1j/b8MTAwyeZjOCMVs7pc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oe+6nX2B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D25411BC0;
	Thu, 23 Apr 2026 22:57:39 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F173F23F;
	Thu, 23 Apr 2026 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777010265; bh=dTNza0KEYrjBEa6YZ5hzfCt/Ar2RAGWr/4ZMUagfrm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oe+6nX2Bl77VP10ARS83jN4HK85wFcLCFAXYd40mLXLBqZV1OIDDgfS6b4AgRW/ak
	 NOdIClJEzKWOV1JwA4VBULgTUCmX1/R+SQ8NsifWR2plQ4uq32gw42eErrQl74oPqa
	 2DoOsoRSS8V5lkMdL0CiZGa6C23BZC52Dc5zDwww=
Date: Fri, 24 Apr 2026 06:57:39 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
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
Message-ID: <aesGU8a3mbVzvteH@e129823.arm.com>
References: <aeoAlVEwzRUPrlVe@e129823.arm.com>
 <aeoRxWPyOHGJd+Jh@e129823.arm.com>
 <aeoWO2Cwo04YYu2l@earth.li>
 <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com>
 <aeomlp3I0eVE5mce@earth.li>
 <aeotq8nPVu4wvEx5@e129823.arm.com>
 <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
 <aephL3MzYoqFGaT5@e129823.arm.com>
 <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRQWHEWQ5NzOPiu8jtYv6UsRm8WVS4fd74AbkOcAd4y_g@mail.gmail.com>
X-Rspamd-Queue-Id: 808F345A18A
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
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9314-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,e129823.arm.com:mid]

Hi Paul,

> On Thu, Apr 23, 2026 at 2:13 PM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > Sounds good. Once the patch is posted, I’ll review it as well.
> > Sorry again for the noise, and thanks for your patience ;)
>
> My apologies for not getting a chance to look at this patchset sooner.
>
> This seems like an obvious, perhaps even stupid, question, but I have
> to ask: if IMA can be properly initialized via late_initcall_sync(),
> why not simply do the initialization in late_initcall_sync() and drop
> the late_initcall() initialization?
>
> Does any IMA functionality suffer if initialization waits until
> late_initcall_sync()?  If so, it seems non-critical if waiting until
> _sync() is acceptable, as it appears in these patches/comments.

This is the way first patch did, and here is some discussion for this
(Might you have seen, but in case of you missed):
  - https://lore.kernel.org/all/a6a0e15286c983d720de227c6827adbe976c5b9b.camel@linux.ibm.com/

Thanks.

--
Sincerely,
Yeoreum Yun

