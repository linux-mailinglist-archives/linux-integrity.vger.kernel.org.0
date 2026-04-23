Return-Path: <linux-integrity+bounces-9297-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBlVBNsS6mmytQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9297-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 14:38:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27745217C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 14:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A949E307FA1F
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 12:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9A73ED5BE;
	Thu, 23 Apr 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hpcyQWCe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EEC3E6DC4;
	Thu, 23 Apr 2026 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947662; cv=none; b=XVDhCbmUeUsLBvmrgBLVES0SISOV67d6aZvggqY8Wxe3iDVJHADYo6C09suCNOsU7YmTBbseumyCNNW6K9k5XOdG9k8GP4BM2o2XQ+DTJbRpbVAJCr/TFOSe7FQk4iuJlFs42oUBfsZcfq8lj7AMafqdB6/7Wd41dUzFaeN974E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947662; c=relaxed/simple;
	bh=t0e31yEIkhaU89vXVYCz+XFvgY/e04Ky3PJz4ZIM2Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZAqJSOHHFyJic4HbVYX/N6Lyfvwp3memFZtbZuD7qXBFAiT+AxPoV7T+S9Wjij6aegQwZmLnkFfvgGTQgGiDDuPe1cX90TGrXwtlmEmw6DKCZ8GJT74LKBPxzXyo0wyz/M7mFYo92Wl1yJYhhRNdzqEynR+5ms2ByP1eoxTGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hpcyQWCe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 081B11C25;
	Thu, 23 Apr 2026 05:34:14 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49A233F7B4;
	Thu, 23 Apr 2026 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776947659; bh=t0e31yEIkhaU89vXVYCz+XFvgY/e04Ky3PJz4ZIM2Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpcyQWCektGSUKXAdaPwQCCsm/9tqnEPUuSkf2M3HHF4JdLsJw/A6VwW4SqeqkCQo
	 H4SsKko+/C1paFJeuFvw2b6kED0VQfbIU+cibuRnBSxa/LmnpkvgfSXXCl29IGgGIj
	 Q21eE7a3sRxhLtUBmq+enmuKpeWc2krXpr6f/NIg=
Date: Thu, 23 Apr 2026 13:34:13 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
Message-ID: <aeoRxWPyOHGJd+Jh@e129823.arm.com>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
 <20260422162449.1814615-2-yeoreum.yun@arm.com>
 <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
 <aekXaU52fzvNYaUF@e129823.arm.com>
 <aekkVQwueKbFtG7C@e129823.arm.com>
 <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
 <aem0SSQuE1e3pGOS@e129823.arm.com>
 <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
 <aeoAlVEwzRUPrlVe@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeoAlVEwzRUPrlVe@e129823.arm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9297-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA27745217C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > On Thu, 2026-04-23 at 06:55 +0100, Yeoreum Yun wrote:
> > > > On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
> > > > > > Hi Mimi,
> > > > > >
> > > > > > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
> > > > > > > > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
> > > > > > > > the TPM driver must be built as built-in and
> > > > > > > > must be probed before the IMA subsystem is initialized.
> > > > > > > >
> > > > > > > > However, when the TPM device operates over the FF-A protocol using
> > > > > > > > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > > > > > > > the tpm_crb_ffa device — an FF-A device that provides the communication
> > > > > > > > interface to the tpm_crb driver — has not yet been probed.
> > > > > > > >
> > > > > > > > To ensure the TPM device operating over the FF-A protocol with
> > > > > > > > the CRB interface is probed before IMA initialization,
> > > > > > > > the following conditions must be met:
> > > > > > > >
> > > > > > > >    1. The corresponding ffa_device must be registered,
> > > > > > > >       which is done via ffa_init().
> > > > > > > >
> > > > > > > >    2. The tpm_crb_driver must successfully probe this device via
> > > > > > > >       tpm_crb_ffa_init().
> > > > > > > >
> > > > > > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > > > > > >       be probed successfully. (See crb_acpi_add() and
> > > > > > > >       tpm_crb_ffa_init() for reference.)
> > > > > > > >
> > > > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > > > > > > > all registered with device_initcall, which means crb_acpi_driver_init() may
> > > > > > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > > > > > > >
> > > > > > > > When this occurs, probing the TPM device is deferred.
> > > > > > > > However, the deferred probe can happen after the IMA subsystem
> > > > > > > > has already been initialized, since IMA initialization is performed
> > > > > > > > during late_initcall, and deferred_probe_initcall() is performed
> > > > > > > > at the same level.
> > > > > > > >
> > > > > > > > To resolve this, call ima_init() again at late_inicall_sync level
> > > > > > > > so that let IMA not miss TPM PCR value when generating boot_aggregate
> > > > > > > > log though TPM device presents in the system.
> > > > > > > >
> > > > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > > > >
> > > > > > > A lot of change for just detecting whether ima_init() is being called on
> > > > > > > late_initcall or late_initcall_sync(), without any explanation for all the other
> > > > > > > changes (e.g. ima_init_core).
> > > > > > >
> > > > > > > Please just limit the change to just calling ima_init() twice.
> > > > > >
> > > > > > My concern is that ima_update_policy_flags() will be called
> > > > > > when ima_init() is deferred -- not initialised anything.
> > > > > > though functionally, it might be okay however,
> > > > > > I think ima_update_policy_flags() and notifier should work after ima_init()
> > > > > > works logically.
> > > > > >
> > > > > > This change I think not much quite a lot. just wrapper ima_init() with
> > > > > > ima_init_core() with some error handling.
> > > > > >
> > > > > > Am I missing something?
> > > > >
> > > > > Also, if we handle in ima_init() only, but it failed with other reason,
> > > > > we shouldn't call again ima_init() in the late_initcall_sync.
> > > > >
> > > > > To handle this, It wouldn't do in the ima_init() but we need to handle
> > > > > it by caller of ima_init().
> > > >
> > > > Only tpm_default_chip() is being called to set the ima_tpm_chip.  On failure,
> > > > instead of going into TPM-bypass mode, return immediately.  There are no calls
> > > > to anything else.  Just call ima_init() a second time.
> > >
> > > I’m not fully convinced this is sufficient.
> > >
> > > What I meant is the case where ima_init() fails due to other
> > > initialisation steps, not only tpm_default_chip() (e.g. ima_fs_init()).
> >
> > The purpose of THIS patch is to add late_initcall_sync, when the TPM is not
> > available at late_initcall.  This would be classified as a bug fix and would be
> > backported.  No other changes should be included in this patch.
>
> Okay.
>
> > >
> > > I’d also like to ask again whether it is fine to call
> > > ima_update_policy_flags() and keep the notifier registered in the
> > > deferred TPM case. While this may be functionally acceptable, it seems
> > > logically questionable to do so when ima_init() has not completed.
> >
> > Other than extending the TPM, IMA should behave exactly the same whether there
> > is a TPM or goes into TPM-bypass mode.
> >
> > >
> > > There is also a possibility that a deferred case ultimately fails (e.g.
> > > deferred at late_initcall, but then failing at late_initcall_sync
> > > for another reason, even while entering TPM bypass mode). In that case,
> > > it seems more appropriate to handle this state in the caller of
> > > ima_init(), rather than inside ima_init() itself.
> >
> > If the TPM isn't found at late_initcall_sync(), then IMA should go into TPM-
> > bypass mode.  Please don't make any other changes to the existing IMA behavior
> > and hide it here behind the late_initcall_sync change.
>
> Okay. you're talking called ima_update_policy_flags() at late_initcall
> wouldn't be not a problem even in case of late_initcall_sync's ima_init()
> get failed with "TPM-bypass mode".
>
> I see then, I'll make a patch simpler then.

But I think in case of below situation:
  - late_initcall's first ima_init() is deferred.
  - late_initcall_sync try again but failed and try again with
    CONFIG_IMA_DEFAULT_HASH.

I would like to sustain init_ima_core to reduce the same code repeat
in late_initcall_sync.

--
Sincerely,
Yeoreum Yun

