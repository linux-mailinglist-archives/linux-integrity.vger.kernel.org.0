Return-Path: <linux-integrity+bounces-9308-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKKmNZdR6mkhxgIAu9opvQ
	(envelope-from <linux-integrity+bounces-9308-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 19:06:31 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05302455537
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 19:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B62630B3C76
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116E338644D;
	Thu, 23 Apr 2026 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="TyOt5i9t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4934887E;
	Thu, 23 Apr 2026 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963784; cv=none; b=Spm91FeWy7+mugt/jfw9obq6cK2iKYDcvo6hyvgT6bRObOrSu2JKCzquMr+z8JgbFYsTyTPWSTfUMionWixt7v8qL6ShV4Bz+4+h2BCmAf6BL5LopASk/1bdgStYIR20Qkwrn+MOvohykPzf4XAH5vDww8lJEQqVKvEZGa8bbJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963784; c=relaxed/simple;
	bh=0HWbMIhjf0IMqfOIYqpJr8UhwRK25lhdxVQ/1SWrGqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruQeP+a+nGuHc3ZSS7t8JgYv5NijtsS6KOMwo9zqcCnjTA/+7VkB4FPuV8PagR6K/IRa8l9+5TXV2x2BtL87+WSCofQsSI/6t2r1C26TIZ2o2DTLCqdjw373K9vN4RGRZAvIYqR4WvET2q1cjT9Bg/FC+2Z2wJs8lWX5yWNfSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=TyOt5i9t; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IkLoHCZH8VzAlYsRondojeIEhJMsI0qFpo2wtNvKgWI=; b=TyOt5i9tYthd4G0i8dKTDJi3Vb
	PHcYR+ZbkNiRyxhIeVaov+eGq9F6VBp9q87xmDxR06u0R9kBM+RMcQh4+OcF1ck2cYB96EtJAccUa
	8wFCT8V+yW+MCR9gIXkgV48PPdMtuvhC8/kxfe/wPFvLwGWUZ3HYl13tuRwIIdwmHUmesQBOjwLL4
	AcWa94J7ZH0C2qjoshpv/oeiopSMAETDlKCTyC2EaKo5wA8EEwWbiHpo8UbJGoF4Tg+E65whq4rEF
	KnnXZ5TuJ9mardaFWxy62xhM9N77HTb8Ml3fRKXZ9SnUdgVuToqO1pTphVgQQS0/rCNicG1Tgm186
	eIX49kXg==;
Received: from noodles by the.earth.li with local (Exim 4.98.2)
	(envelope-from <noodles@earth.li>)
	id 1wFxS5-00000003kgC-1z1T;
	Thu, 23 Apr 2026 18:02:57 +0100
Date: Thu, 23 Apr 2026 18:02:57 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <aepQwcY523aukAvw@earth.li>
References: <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
 <aem0SSQuE1e3pGOS@e129823.arm.com>
 <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
 <aeoAlVEwzRUPrlVe@e129823.arm.com>
 <aeoRxWPyOHGJd+Jh@e129823.arm.com>
 <aeoWO2Cwo04YYu2l@earth.li>
 <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
 <aeokwrC86WI7uT+K@e129823.arm.com>
 <aeomlp3I0eVE5mce@earth.li>
 <2866f7679fe6933de667ce74ae68bd4ea9198e2a.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2866f7679fe6933de667ce74ae68bd4ea9198e2a.camel@linux.ibm.com>
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[earth.li:s=the];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9308-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[earth.li];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noodles@earth.li,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[earth.li:-];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,earth.li:mid]
X-Rspamd-Queue-Id: 05302455537
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 10:48:49AM -0400, Mimi Zohar wrote:
>On Thu, 2026-04-23 at 15:03 +0100, Jonathan McDowell wrote:
>> On Thu, Apr 23, 2026 at 02:55:14PM +0100, Yeoreum Yun wrote:
>> > > On Thu, 2026-04-23 at 13:53 +0100, Jonathan McDowell wrote:
>> > > > On Thu, Apr 23, 2026 at 01:34:13PM +0100, Yeoreum Yun wrote:
>> > > > > > > On Thu, 2026-04-23 at 06:55 +0100, Yeoreum Yun wrote:
>> > > > > > > > > On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
>> > > > > > > > > > > Hi Mimi,
>> > > > > > > > > > >
>> > > > > > > > > > > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
>> > > > > > > > > > > > > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
>> > > > > > > > > > > > > the TPM driver must be built as built-in and
>> > > > > > > > > > > > > must be probed before the IMA subsystem is initialized.
>> > > > > > > > > > > > >
>> > > > > > > > > > > > > However, when the TPM device operates over the FF-A protocol using
>> > > > > > > > > > > > > the CRB interface, probing fails and returns -EPROBE_DEFER if
>> > > > > > > > > > > > > the tpm_crb_ffa device — an FF-A device that provides the communication
>> > > > > > > > > > > > > interface to the tpm_crb driver — has not yet been probed.
>> > > > > > > > > > > > >
>> > > > > > > > > > > > > To ensure the TPM device operating over the FF-A protocol with
>> > > > > > > > > > > > > the CRB interface is probed before IMA initialization,
>> > > > > > > > > > > > > the following conditions must be met:
>> > > > > > > > > > > > >
>> > > > > > > > > > > > >    1. The corresponding ffa_device must be registered,
>> > > > > > > > > > > > >       which is done via ffa_init().
>> > > > > > > > > > > > >
>> > > > > > > > > > > > >    2. The tpm_crb_driver must successfully probe this device via
>> > > > > > > > > > > > >       tpm_crb_ffa_init().
>> > > > > > > > > > > > >
>> > > > > > > > > > > > >    3. The tpm_crb driver using CRB over FF-A can then
>> > > > > > > > > > > > >       be probed successfully. (See crb_acpi_add() and
>> > > > > > > > > > > > >       tpm_crb_ffa_init() for reference.)
>> > > > > > > > > > > > >
>> > > > > > > > > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
>> > > > > > > > > > > > > all registered with device_initcall, which means crb_acpi_driver_init() may
>> > > > > > > > > > > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
>> > > > > > > > > > > > >
>> > > > > > > > > > > > > When this occurs, probing the TPM device is deferred.
>> > > > > > > > > > > > > However, the deferred probe can happen after the IMA subsystem
>> > > > > > > > > > > > > has already been initialized, since IMA initialization is performed
>> > > > > > > > > > > > > during late_initcall, and deferred_probe_initcall() is performed
>> > > > > > > > > > > > > at the same level.
>> > > > > > > > > > > > >
>> > > > > > > > > > > > > To resolve this, call ima_init() again at late_inicall_sync level
>> > > > > > > > > > > > > so that let IMA not miss TPM PCR value when generating boot_aggregate
>> > > > > > > > > > > > > log though TPM device presents in the system.
>> > > > > > > > > > > > >
>> > > > > > > > > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>> > > > > > > > > > > >
>> > > > > > > > > > > > A lot of change for just detecting whether ima_init() is being called on
>> > > > > > > > > > > > late_initcall or late_initcall_sync(), without any explanation for all the other
>> > > > > > > > > > > > changes (e.g. ima_init_core).
>> > > > > > > > > > > >
>> > > > > > > > > > > > Please just limit the change to just calling ima_init() twice.
>> > > > > > > > > > >
>> > > > > > > > > > > My concern is that ima_update_policy_flags() will be called
>> > > > > > > > > > > when ima_init() is deferred -- not initialised anything.
>> > > > > > > > > > > though functionally, it might be okay however,
>> > > > > > > > > > > I think ima_update_policy_flags() and notifier should work after ima_init()
>> > > > > > > > > > > works logically.
>> > > > > > > > > > >
>> > > > > > > > > > > This change I think not much quite a lot. just wrapper ima_init() with
>> > > > > > > > > > > ima_init_core() with some error handling.
>> > > > > > > > > > >
>> > > > > > > > > > > Am I missing something?
>> > > > > > > > > >
>> > > > > > > > > > Also, if we handle in ima_init() only, but it failed with other reason,
>> > > > > > > > > > we shouldn't call again ima_init() in the late_initcall_sync.
>> > > > > > > > > >
>> > > > > > > > > > To handle this, It wouldn't do in the ima_init() but we need to handle
>> > > > > > > > > > it by caller of ima_init().
>> > > > > > > > >
>> > > > > > > > > Only tpm_default_chip() is being called to set the ima_tpm_chip.  On failure,
>> > > > > > > > > instead of going into TPM-bypass mode, return immediately.  There are no calls
>> > > > > > > > > to anything else.  Just call ima_init() a second time.
>> > > > > > > >
>> > > > > > > > I’m not fully convinced this is sufficient.
>> > > > > > > >
>> > > > > > > > What I meant is the case where ima_init() fails due to other
>> > > > > > > > initialisation steps, not only tpm_default_chip() (e.g. ima_fs_init()).
>> > > > > > >
>> > > > > > > The purpose of THIS patch is to add late_initcall_sync, when the TPM is not
>> > > > > > > available at late_initcall.  This would be classified as a bug fix and would be
>> > > > > > > backported.  No other changes should be included in this patch.
>> > > > > >
>> > > > > > Okay.
>> > > > > >
>> > > > > > > >
>> > > > > > > > I’d also like to ask again whether it is fine to call
>> > > > > > > > ima_update_policy_flags() and keep the notifier registered in the
>> > > > > > > > deferred TPM case. While this may be functionally acceptable, it seems
>> > > > > > > > logically questionable to do so when ima_init() has not completed.
>> > > > > > >
>> > > > > > > Other than extending the TPM, IMA should behave exactly the same whether there
>> > > > > > > is a TPM or goes into TPM-bypass mode.
>> > > > > > >
>> > > > > > > >
>> > > > > > > > There is also a possibility that a deferred case ultimately fails (e.g.
>> > > > > > > > deferred at late_initcall, but then failing at late_initcall_sync
>> > > > > > > > for another reason, even while entering TPM bypass mode). In that case,
>> > > > > > > > it seems more appropriate to handle this state in the caller of
>> > > > > > > > ima_init(), rather than inside ima_init() itself.
>> > > > > > >
>> > > > > > > If the TPM isn't found at late_initcall_sync(), then IMA should go into TPM-
>> > > > > > > bypass mode.  Please don't make any other changes to the existing IMA behavior
>> > > > > > > and hide it here behind the late_initcall_sync change.
>> > > > > >
>> > > > > > Okay. you're talking called ima_update_policy_flags() at late_initcall
>> > > > > > wouldn't be not a problem even in case of late_initcall_sync's ima_init()
>> > > > > > get failed with "TPM-bypass mode".
>> > > > > >
>> > > > > > I see then, I'll make a patch simpler then.
>> > > > >
>> > > > > But I think in case of below situation:
>> > > > >  - late_initcall's first ima_init() is deferred.
>> > > > >  - late_initcall_sync try again but failed and try again with
>> > > > >    CONFIG_IMA_DEFAULT_HASH.
>> > > > >
>> > > > > I would like to sustain init_ima_core to reduce the same code repeat
>> > > > > in late_initcall_sync.
>> > > >
>> > > > I think what Mimi's proposing is:
>> > > >
>> > > > If we're in late_initcall, and the TPM isn't available, return
>> > > > immediately with an error (the EPROBE_DEFER?), don't do any init.
>> > > >
>> > > > If we're in late_initcall_sync, either we're already initialised, so do
>> > > > return and nothing, or run through the entire flow, even if the TPM
>> > > > isn't unavailable.
>> > > >
>> > > > So ima_init() just needs to know a) if it's in the sync or non-sync mode
>> > > > and b) for the sync mode, if we've already done the init at
>> > > > non-sync.
>> > >
>> > > Thanks, Jonathan.  That is exactly what I'm suggesting.  Any other changes
>> > > should not be included in this patch.  Since Yeoreum is not hearing me, feel
>> > > free to post a patch.
>> >
>> > I see. so what you need to is this only
>> > If it looks good to you. I'll send it at v3.
>>
>> FWIW, I pulled the tpm_default_chip check out a level to account for the
>> extra init you mentioned, and have the following (completely untested or
>> compiled, but gives the approach):
>
>Thanks, Jonathan!  It looks good.  Similarly untested/compiled.

FWIW, it does compile.

>Emitting a message on failure to initialize IMA at late_initcall is good, but
>the attestation service won't know.  Could you somehow differentiate between the
>late_initcall and late_initcall_sync boot_aggregate records?

Are you thinking "boot_aggregate" and "boot_aggregate_late" or similar 
as the "filename" on the entries, just so it's clear when we did the 
init in the log, or something else?

J.

-- 
/-\                             | 101 things you can't have too much
|@/  Debian GNU/Linux Developer |      of : 39 - silver bullets.
\-                              |

