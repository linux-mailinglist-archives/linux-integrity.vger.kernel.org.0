Return-Path: <linux-integrity+bounces-9781-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VD4gFln1J2pY6QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9781-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 13:13:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D28A65F5E8
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 13:13:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=AKirKuQg;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9781-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9781-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A36143001B58
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2026 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F7371D00;
	Tue,  9 Jun 2026 11:13:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA493FA5FC;
	Tue,  9 Jun 2026 11:13:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003597; cv=none; b=n+KxnVi3Yn7V3lMgfFQCxWhavB1Qs/9drIXYtjeSHxsq1ObM4fhxsAGiRdo22VQth0dDA5VUuHcU24YkViPvxMUU4eVxV7aSEKEcoxYZHJNCWDZjOK7AR6i2FETwXIwpj9tsRAh6e+RxDp6+ahHA2/RUt7IuQun54l2s6PQc9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003597; c=relaxed/simple;
	bh=Vjz2+iFZYdlo2OYyffu2Q1yRZUsz6tff/8vuVOxBg14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naoWyMqsdqU3yyJeQfA36WuM9dJEGu9BEhEUHFvlbzGpDBfhZw9oQMVTn8T0yQxmhRr6LJN61DrA6Sy4xOQqrm0ha1kvKznFPpmbdF5sr+61dgAfa+snyDWXSWbMWIUvMxPkbZSeWtC6/b/Ioak/Th8N1HY4D8TEK9gbDKzolmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AKirKuQg; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C4CE1691;
	Tue,  9 Jun 2026 04:13:09 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1103FE53;
	Tue,  9 Jun 2026 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781003593; bh=Vjz2+iFZYdlo2OYyffu2Q1yRZUsz6tff/8vuVOxBg14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKirKuQgdFr2TWO3EGe38IPJQWWhQwgKDsDT5waP46HdEFeZxvWm/3mPWayiVNvgn
	 WIrRlZ8R088NMQWpF7Aw1HRnsL/usY+KOOZxPZO+YNYsfK5HfjjTIr9T5bmMWOfNEc
	 y9tn9JiDfqt+XlWokvVE0QudlT1b8csFhyWYBgho=
Date: Tue, 9 Jun 2026 12:13:09 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	roberto.sassu@huaweicloud.com, noodles@earth.li, jarkko@kernel.org,
	sudeep.holla@kernel.org, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v6 2/4] security: ima: introduce IMA_INIT_LATE_SYNC option
Message-ID: <aif1RaFsRvipxEDr@e129823.arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
 <20260605144325.434436-3-yeoreum.yun@arm.com>
 <f135eab04611432040e4ba66cef2786424af8cc8.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f135eab04611432040e4ba66cef2786424af8cc8.camel@linux.ibm.com>
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
	TAGGED_FROM(0.00)[bounces-9781-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,paul-moore.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zohar@linux.ibm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,e129823.arm.com:mid,arm.com:dkim,arm.com:email,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D28A65F5E8

On Mon, Jun 08, 2026 at 01:40:00PM -0400, Mimi Zohar wrote:
> On Fri, 2026-06-05 at 15:43 +0100, Yeoreum Yun wrote:
> > To generate the boot_aggregate log in the IMA subsystem with
> > TPM PCR values, the TPM driver must be built as built-in and
> > must be probed before the IMA subsystem is initialized.
> > 
> > However, when the TPM device operates over the FF-A protocol using
> > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > the tpm_crb_ffa device — an FF-A device that provides the communication
> > interface to the tpm_crb driver — has not yet been probed.
> > 
> > To ensure the TPM device operating over the FF-A protocol with
> > the CRB interface is probed before IMA initialization,
> > the following conditions must be met:
> > 
> > 1. The corresponding ffa_device must be registered,
> >    which is done via ffa_init().
> > 
> > 2. The tpm_crb_driver must successfully probe this device via
> >    tpm_crb_ffa_init().
> > 
> > 3. The tpm_crb driver using CRB over FF-A can then
> >    be probed successfully. (See crb_acpi_add() and
> >    tpm_crb_ffa_init() for reference.)
> > 
> > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init()
> > are all registered with device_initcall, which means
> > crb_acpi_driver_init() may be invoked before ffa_init() and
> > tpm_crb_ffa_init() are completed.
> > 
> > When this occurs, probing the TPM device is deferred.
> > However, the deferred probe can happen after the IMA subsystem
> > has already been initialized, since IMA initialization is performed
> > during late_initcall, and deferred_probe_initcall() is performed
> > at the same level.
> > 
> > And the similar situation is reported on TPM devices attached on SPI
> > bus[0].
> > 
> > To resolve this, introduce IMA_INIT_LATE_SYNC option to initialise
> > IMA at late_inicall_sync so that IMA is initialized with the TPM
> > device probed deferred.
> > 
> > When this option is enabled, modules that access files in the
> > initramfs through usermode helper calls such as request_module()
> > during initcall must not be built-in. Otherwise, IMA may miss
> > measuring those files [1].
> > 
> > Link: https://lore.kernel.org/all/aYXEepLhUouN5f99@earth.li/ [0]
> > Link: https://lore.kernel.org/all/2b3782398cc17ce9d355490a0c42ebce9120a9ae.camel@linux.ibm.com/ [1]
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  security/integrity/ima/Kconfig    | 10 ++++++++++
> >  security/integrity/ima/ima_main.c |  4 ++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> > index 862fbee2b174..75f71401fba3 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -332,4 +332,14 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
> >  	  If set to the default value of 0, an extra half page of memory for those
> >  	  additional measurements will be allocated.
> >  
> > +config IMA_INIT_LATE_SYNC
> > +	bool "Initialise IMA at late_initcall_sync"
> > +	default n
> > +	help
> > +	  This option initialises IMA at late_initcall_sync for platforms
> > +	  where TPM device probing is deferred.
> > +	  When this option is enabled, modules that access files in the
> > +	  initramfs through usermode helper calls such as request_module()
> > +	  during initcall must not be built-in. Otherwise, IMA may miss
> > +	  file measurements for them.
> >  endif
> 
> I fixed the merge conflict with the "ima: Exporting and deleting IMA measurement
> records from kernel memory" patch set.  These patches are now queued in next-
> integrity-testing awaiting Paul's Ack.

Thanks!

[...]

-- 
Sincerely,
Yeoreum Yun

