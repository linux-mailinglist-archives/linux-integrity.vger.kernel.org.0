Return-Path: <linux-integrity+bounces-9299-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBFeKgwX6mlHtwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9299-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 14:56:44 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C945261C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C504301CAB4
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C73EE1F3;
	Thu, 23 Apr 2026 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="Et1flc8r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4A3EDAD7;
	Thu, 23 Apr 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948809; cv=none; b=UUuLZAITLlDEtNBrdiWo3ItEE2bECHhqewZkBmCKMXCARLPDz8otLhwIRiWRG//jwOA0VsX2M7G44cJyQtu5+jyearWt0ZnPIFFC7Fhio3IYR+u8F8S2/vPKQBkdUz38y6ghQNq+EHU2YeyohE5rtoViivtnhcP3CG5iI7qxFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948809; c=relaxed/simple;
	bh=2ynVpgM9wuOXwZ4cSqkvAE1dk6QvFrKlejwlOgx1AMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOeh0zmwbMpbzK/Tz8pl6xSfdFWDP1ceNdAQUnK8cCmL/54/wIG/mi6NdsJxoCmKKdSaY5WJ8VViJb3m/0tiEGyMMT0wvsIZXl/9+Vx3R8rXnSyMtpgemA922UQrNAzES8BwQ6zx9dSfZFgpH14rK3i1RGAvQuVx3BsZY9tFY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=Et1flc8r; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XEF+/jXay+IMyuutvQr1EZM2FTpKREN0v3Akij4o870=; b=Et1flc8rm38GNZe51K2DFsXkkU
	pRV5LuPtYTqhsFkTs369DbwsQ+OyGad71QGSvYdE4cM4sCBMiWdVF8ZVBSiqdVk5L0xJsRQU6oBmS
	tvlfofHSB7kPDEc2kcF7luk/WcRUxuK7Y4SD/hBCl1vDxdWisEHvOlpvZrNgLpndZuo6noSSt8fLz
	vq6qeW3p1ylHkLOeg/iDGQhCtP5PAgMKr5hfdSwfszeR8vuqpkzeYuOTcV6u6V0BXCJbUQuft/gCB
	xNCBxwGzFSjg7KKmOFiXVjFOfRoj2lZkMJqDfOgtqZmBI9ibPQcyXRLsV/O8IjVppK7Hy8Gav2oJj
	cAVzZCsA==;
Received: from noodles by the.earth.li with local (Exim 4.98.2)
	(envelope-from <noodles@earth.li>)
	id 1wFtYR-00000003T2y-26Md;
	Thu, 23 Apr 2026 13:53:15 +0100
Date: Thu, 23 Apr 2026 13:53:15 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
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
Message-ID: <aeoWO2Cwo04YYu2l@earth.li>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
 <20260422162449.1814615-2-yeoreum.yun@arm.com>
 <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
 <aekXaU52fzvNYaUF@e129823.arm.com>
 <aekkVQwueKbFtG7C@e129823.arm.com>
 <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
 <aem0SSQuE1e3pGOS@e129823.arm.com>
 <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
 <aeoAlVEwzRUPrlVe@e129823.arm.com>
 <aeoRxWPyOHGJd+Jh@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeoRxWPyOHGJd+Jh@e129823.arm.com>
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[earth.li:s=the];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9299-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[earth.li];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noodles@earth.li,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[earth.li:-];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:email,earth.li:mid]
X-Rspamd-Queue-Id: 7F1C945261C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 01:34:13PM +0100, Yeoreum Yun wrote:
>> > On Thu, 2026-04-23 at 06:55 +0100, Yeoreum Yun wrote:
>> > > > On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
>> > > > > > Hi Mimi,
>> > > > > >
>> > > > > > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
>> > > > > > > > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
>> > > > > > > > the TPM driver must be built as built-in and
>> > > > > > > > must be probed before the IMA subsystem is initialized.
>> > > > > > > >
>> > > > > > > > However, when the TPM device operates over the FF-A protocol using
>> > > > > > > > the CRB interface, probing fails and returns -EPROBE_DEFER if
>> > > > > > > > the tpm_crb_ffa device — an FF-A device that provides the communication
>> > > > > > > > interface to the tpm_crb driver — has not yet been probed.
>> > > > > > > >
>> > > > > > > > To ensure the TPM device operating over the FF-A protocol with
>> > > > > > > > the CRB interface is probed before IMA initialization,
>> > > > > > > > the following conditions must be met:
>> > > > > > > >
>> > > > > > > >    1. The corresponding ffa_device must be registered,
>> > > > > > > >       which is done via ffa_init().
>> > > > > > > >
>> > > > > > > >    2. The tpm_crb_driver must successfully probe this device via
>> > > > > > > >       tpm_crb_ffa_init().
>> > > > > > > >
>> > > > > > > >    3. The tpm_crb driver using CRB over FF-A can then
>> > > > > > > >       be probed successfully. (See crb_acpi_add() and
>> > > > > > > >       tpm_crb_ffa_init() for reference.)
>> > > > > > > >
>> > > > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
>> > > > > > > > all registered with device_initcall, which means crb_acpi_driver_init() may
>> > > > > > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
>> > > > > > > >
>> > > > > > > > When this occurs, probing the TPM device is deferred.
>> > > > > > > > However, the deferred probe can happen after the IMA subsystem
>> > > > > > > > has already been initialized, since IMA initialization is performed
>> > > > > > > > during late_initcall, and deferred_probe_initcall() is performed
>> > > > > > > > at the same level.
>> > > > > > > >
>> > > > > > > > To resolve this, call ima_init() again at late_inicall_sync level
>> > > > > > > > so that let IMA not miss TPM PCR value when generating boot_aggregate
>> > > > > > > > log though TPM device presents in the system.
>> > > > > > > >
>> > > > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>> > > > > > >
>> > > > > > > A lot of change for just detecting whether ima_init() is being called on
>> > > > > > > late_initcall or late_initcall_sync(), without any explanation for all the other
>> > > > > > > changes (e.g. ima_init_core).
>> > > > > > >
>> > > > > > > Please just limit the change to just calling ima_init() twice.
>> > > > > >
>> > > > > > My concern is that ima_update_policy_flags() will be called
>> > > > > > when ima_init() is deferred -- not initialised anything.
>> > > > > > though functionally, it might be okay however,
>> > > > > > I think ima_update_policy_flags() and notifier should work after ima_init()
>> > > > > > works logically.
>> > > > > >
>> > > > > > This change I think not much quite a lot. just wrapper ima_init() with
>> > > > > > ima_init_core() with some error handling.
>> > > > > >
>> > > > > > Am I missing something?
>> > > > >
>> > > > > Also, if we handle in ima_init() only, but it failed with other reason,
>> > > > > we shouldn't call again ima_init() in the late_initcall_sync.
>> > > > >
>> > > > > To handle this, It wouldn't do in the ima_init() but we need to handle
>> > > > > it by caller of ima_init().
>> > > >
>> > > > Only tpm_default_chip() is being called to set the ima_tpm_chip.  On failure,
>> > > > instead of going into TPM-bypass mode, return immediately.  There are no calls
>> > > > to anything else.  Just call ima_init() a second time.
>> > >
>> > > I’m not fully convinced this is sufficient.
>> > >
>> > > What I meant is the case where ima_init() fails due to other
>> > > initialisation steps, not only tpm_default_chip() (e.g. ima_fs_init()).
>> >
>> > The purpose of THIS patch is to add late_initcall_sync, when the TPM is not
>> > available at late_initcall.  This would be classified as a bug fix and would be
>> > backported.  No other changes should be included in this patch.
>>
>> Okay.
>>
>> > >
>> > > I’d also like to ask again whether it is fine to call
>> > > ima_update_policy_flags() and keep the notifier registered in the
>> > > deferred TPM case. While this may be functionally acceptable, it seems
>> > > logically questionable to do so when ima_init() has not completed.
>> >
>> > Other than extending the TPM, IMA should behave exactly the same whether there
>> > is a TPM or goes into TPM-bypass mode.
>> >
>> > >
>> > > There is also a possibility that a deferred case ultimately fails (e.g.
>> > > deferred at late_initcall, but then failing at late_initcall_sync
>> > > for another reason, even while entering TPM bypass mode). In that case,
>> > > it seems more appropriate to handle this state in the caller of
>> > > ima_init(), rather than inside ima_init() itself.
>> >
>> > If the TPM isn't found at late_initcall_sync(), then IMA should go into TPM-
>> > bypass mode.  Please don't make any other changes to the existing IMA behavior
>> > and hide it here behind the late_initcall_sync change.
>>
>> Okay. you're talking called ima_update_policy_flags() at late_initcall
>> wouldn't be not a problem even in case of late_initcall_sync's ima_init()
>> get failed with "TPM-bypass mode".
>>
>> I see then, I'll make a patch simpler then.
>
>But I think in case of below situation:
>  - late_initcall's first ima_init() is deferred.
>  - late_initcall_sync try again but failed and try again with
>    CONFIG_IMA_DEFAULT_HASH.
>
>I would like to sustain init_ima_core to reduce the same code repeat
>in late_initcall_sync.

I think what Mimi's proposing is:

If we're in late_initcall, and the TPM isn't available, return 
immediately with an error (the EPROBE_DEFER?), don't do any init.

If we're in late_initcall_sync, either we're already initialised, so do 
return and nothing, or run through the entire flow, even if the TPM 
isn't unavailable.

So ima_init() just needs to know a) if it's in the sync or non-sync mode 
and b) for the sync mode, if we've already done the init at
non-sync.

J.

-- 
... I'm not popular enough to be different.

