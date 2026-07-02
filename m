Return-Path: <linux-integrity+bounces-9877-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4+7sHMG/RmpQcgsAu9opvQ
	(envelope-from <linux-integrity+bounces-9877-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 21:45:05 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3376FC97E
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 21:45:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=FOgVA7ou;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9877-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9877-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 249573015E1F
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2026 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F20E38D3F0;
	Thu,  2 Jul 2026 19:42:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC3030C608;
	Thu,  2 Jul 2026 19:42:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021362; cv=none; b=FXF3R+f8L+rxdk1VVD00gDtD1sf0oAheAuOKOnz4gYaCr2BB8P+1qshFaJVkEGt30LNLhWhM7RfMWEApT+FJu19MFu/HsXARvsw+FjWBhnF0bvxvp5CSk+IU/bOxwn+HlYV7gNg+8O7ftKnlIrdXXm3WHAX5xrz6uchzirGZe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021362; c=relaxed/simple;
	bh=kT0tIHMWqxXgzZIfh9uQOG2m1Rut4BdoukkXoBlncog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klGkU6i5kcsqwRjm6EjxzBa/yqS6/p7Jndb69NWssT849Juwmi1YP7IFdiIqCLQfJUoabCbP7HHA9jHbOPoA40zGUD5sNjZWalLgY+v34UQ/0C3iizvue1VxdxhVffenlx3m0aaYvXUUiiV2YQgCFWs7MwsM/PYYnBN4zMDmWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FOgVA7ou; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9498235B7;
	Thu,  2 Jul 2026 12:42:33 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A2613F673;
	Thu,  2 Jul 2026 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783021357; bh=kT0tIHMWqxXgzZIfh9uQOG2m1Rut4BdoukkXoBlncog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOgVA7ouFZU5z7hl5mRbCT24IkkXAO3iUj2seTOlK0EdJ1eHCIfYCZfv+M9Mv+jKM
	 Zi5CoWU/9usEzMUiA35mrSpLUAMLM5Vc3mPPyof1tCXjWuiZs6RXIgvDC77tlRO1cq
	 iimWvkzShCktMP4kpotLa3OwMQ/c4/Ja25w6nouc=
Date: Thu, 2 Jul 2026 20:42:32 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	roberto.sassu@huaweicloud.com, noodles@earth.li, jarkko@kernel.org,
	sudeep.holla@kernel.org, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v6 1/4] security: lsm: allow LSMs to register for
 late_initcall_sync init
Message-ID: <aka_KCX4ogBy2Zuk@e129823.arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
 <20260605144325.434436-2-yeoreum.yun@arm.com>
 <CAHC9VhQXwXHjKcr0SRNQyzKZgCwG1RLPT6kWDLLwEKExfXzzOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQXwXHjKcr0SRNQyzKZgCwG1RLPT6kWDLLwEKExfXzzOw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9877-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:zohar@linux.ibm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:dkim,arm.com:email,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB3376FC97E

> On Fri, Jun 5, 2026 at 10:43 AM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > There are situations where LSMs have dependencies that might mean they
> > want to be initialised later in the boot process, to ensure those
> > dependencies are available. In particular there are some TPM setups (Arm
> > FF-A devices, SPI attached TPMs) required by IMA which are not
> > guaranteed to be initialised for regular initcall_late.
> >
> > Add an initcall_late_sync option that can be used in these situations.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  include/linux/lsm_hooks.h |  2 ++
> >  security/lsm_init.c       | 13 +++++++++++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> Looks good to me, thanks for working on sorting this out.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks!

> 
> -- 
> paul-moore.com

-- 
Sincerely,
Yeoreum Yun

