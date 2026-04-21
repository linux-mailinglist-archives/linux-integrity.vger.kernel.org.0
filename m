Return-Path: <linux-integrity+bounces-9268-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPP+NXSG52m+9gEAu9opvQ
	(envelope-from <linux-integrity+bounces-9268-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 16:15:16 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D3A43BDB8
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 16:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 934023025927
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E03D75C6;
	Tue, 21 Apr 2026 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Aqpn6Rs6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9F3D7D71;
	Tue, 21 Apr 2026 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780572; cv=none; b=gMn82zFd8E4qtnrkRAtYqzkthH6kxsJskjhxfGTMkSzST6bjZo0XU7xWaVQUJsU+C7WsoohI/jRsAz0XtIUX8r+fsOuZyB3FoU3oLA5x6J0uU6qAHrwYhHUMlYbVA9fKAsDuitfV3D/QnhyQHX3uJeZdaRgSY64uPNJ3dmwzbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780572; c=relaxed/simple;
	bh=PM0r4vU3njSbwOSpmk+txAaJg1BVbJV8LhO5dpZzTXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVdY4yIiKvmxT85igZ9m05RnVdwRvSymGUwtZDQNAyRf11+9+CjuhU3wbbacOa2A6UzrMLQb7w3VIKeacDIv0VX2U9LuGUtvQKwwnp16enLl/CdxeeqA6bKavDqjSR9upOQ/EiS4jXl6oYyHCFyLljlwxjnTXGG8SW8fpQkhLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Aqpn6Rs6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9411D25DC;
	Tue, 21 Apr 2026 07:09:23 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE3763F915;
	Tue, 21 Apr 2026 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776780568; bh=PM0r4vU3njSbwOSpmk+txAaJg1BVbJV8LhO5dpZzTXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aqpn6Rs6HdmexG8FiKGSHBbrKhhKVxm72mZiGAWnCbVyf1d+em6YjunDAfB22s/bS
	 QQkYCu8FBISjfN4/0nJ/dGmsJsEA5WNXPJ/KK2n0K4lAWF96MweAYDOhli6QHxz8Lc
	 MmQMD2rltRpMnrYoMqAktVh7FekpLbELIu7MJ2w0=
Date: Tue, 21 Apr 2026 15:09:23 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, peterhuewe@gmx.de, jarkko@kernel.org,
	jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org,
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 1/4] security: ima: move ima_init into
 late_initcall_sync
Message-ID: <aeeFE18HFBN/qDoU@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-2-yeoreum.yun@arm.com>
 <a6a0e15286c983d720de227c6827adbe976c5b9b.camel@linux.ibm.com>
 <aedyh61iTnQRyzMv@e129823.arm.com>
 <d6bcc9ef98a1e86887c5a79ff2822e70b5534343.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6bcc9ef98a1e86887c5a79ff2822e70b5534343.camel@linux.ibm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,gmx.de,kernel.org,ziepe.ca,arm.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	TAGGED_FROM(0.00)[bounces-9268-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 58D3A43BDB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mimi,

> On Tue, 2026-04-21 at 13:50 +0100, Yeoreum Yun wrote:
> > Hi Mimi,
> >
> > > On Fri, 2026-04-17 at 18:57 +0100, Yeoreum Yun wrote:
> > > > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
> > > > the TPM driver must be built as built-in and
> > > > must be probed before the IMA subsystem is initialized.
> > > >
> > > > However, when the TPM device operates over the FF-A protocol using
> > > > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > > > the tpm_crb_ffa device — an FF-A device that provides the communication
> > > > interface to the tpm_crb driver — has not yet been probed.
> > > >
> > > > To ensure the TPM device operating over the FF-A protocol with
> > > > the CRB interface is probed before IMA initialization,
> > > > the following conditions must be met:
> > > >
> > > >    1. The corresponding ffa_device must be registered,
> > > >       which is done via ffa_init().
> > > >
> > > >    2. The tpm_crb_driver must successfully probe this device via
> > > >       tpm_crb_ffa_init().
> > > >
> > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > >       be probed successfully. (See crb_acpi_add() and
> > > >       tpm_crb_ffa_init() for reference.)
> > > >
> > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > > > all registered with device_initcall, which means crb_acpi_driver_init() may
> > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > > >
> > > > When this occurs, probing the TPM device is deferred.
> > > > However, the deferred probe can happen after the IMA subsystem
> > > > has already been initialized, since IMA initialization is performed
> > > > during late_initcall, and deferred_probe_initcall() is performed
> > > > at the same level.
> > > >
> > > > To resolve this, move ima_init() into late_inicall_sync level
> > > > so that let IMA not miss TPM PCR value when generating boot_aggregate
> > > > log though TPM device presents in the system.
> > > >
> > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > >
> > > IMA should be initialized as early as possible. I'm really hesitant to defer
> > > ima_init() to late_initcall_sync() for systems that the TPM is currently
> > > initialized in time. For these systems, continue initializing IMA at
> > > late_initcall(). As a compromise for those systems that the TPM isn't properly
> > > initialized in time, define and instantiate the late_initcall_sync().
> > >
> > > ima_init() would need to differentiate between the late_initcall and
> > > late_initcall_sync.  On late_initcall(), instead of saying "No TPM chip found,
> > > activating TPM-bypass!",  it should say "No TPM chip found, deferring to
> > > late_initcall_sync" or something similar.
> >
> > But can we really move those initialisations to be called again?
> >
> > I am referring to functions such as ima_init_crypto(),
> > ima_add_boot_aggregate(), and ima_measure_critical_data() in ima_init()—
> > first without TPM, and then a second time once TPM becomes available.
> > I don’t think that approach would work.
> >
> > In other words, unless tpm_default_chip() can differentiate between a TPM
> > device that is deferred and one that does not exist, we cannot distinguish
> > between the “defer” case and “-EEXIST”.
> >
> > It might be possible if the TPM core tracked the state when a driver returns
> > -EPROBE_DEFER, but I am not sure that is the right approach.
> > For deferred probe cases, the “device initialised in time” check should
> > likely be done at late_initcall_sync, rather than late_initcall.
> >
> > This implies that any such check performed before late_initcall_sync
> > does not reflect a valid state, as it cannot distinguish between “not
> > present” and “deferred”.
> >
> > Therefore, I think the TPM check in IMA should be performed at
> > late_initcall_sync.
> >
> >
> > Am I missing something?
>
> In ima_init() you short circuit out, when called by late_initcall(), if the TPM
> hasn't been initialized.  So the rest of the ima_init() isn't called.  Roughly
> something like this (needs some cleanup):
>
> int __init ima_init(void)
> {
>         static int first = 1;
>         int rc;
>
>         if (ima_tpm_chip)
>                 return 0;
>
>         ima_tpm_chip = tpm_default_chip();
>         if (!ima_tpm_chip && first) {
>                 pr_info("No TPM chip found, deferring te late_initcall_sync()\n");
>                 first = 0;
>                 return 0;
>         }

I see. then I'll respin in v2.

Thanks!

--
Sincerely,
Yeoreum Yun

