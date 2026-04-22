Return-Path: <linux-integrity+bounces-9281-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD5mBnok6WmMUwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9281-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 21:41:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8344A3CF
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 21:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B97F3066692
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA893F1672;
	Wed, 22 Apr 2026 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ld27Ctu3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3094299929;
	Wed, 22 Apr 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886880; cv=none; b=gt2KwcU8KdSMkcAmE9y0ZtdlZOxM6mXYUbllQJsCHeXFGFVUqSSC2NSR+FjLoxp0W7+Mz/5Y+kxMYUQGt22twf83usOJiqOQ/Iwl9LF31aLyqcrfN/5LsTCHS2KARxK3eWZ0TPw6vfm+Fz+gM7vB2MkdYt7qVabzsTJjYChdEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886880; c=relaxed/simple;
	bh=tGo1tyalwnLC7Qix4mlWc2AAj2+tR6uJ/+3oGMxJUVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRpvvSqjx5H8+JoM9j2PqtzHhfgXhvNud/PypRuc5Gio8imoUO5GA23XYhyq4DA5Yd9gMbBH/BsUzoIeEY1SSCyDFYZYWJezPqmvK6mpX1eITPnRVH3twOV+1LiqMd23AUvVzCxFzU3SxZWBWQ5kYibKZPoEBFoPJ6axoeun9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ld27Ctu3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBCF22F;
	Wed, 22 Apr 2026 12:41:09 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE68F3F7B4;
	Wed, 22 Apr 2026 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776886875; bh=tGo1tyalwnLC7Qix4mlWc2AAj2+tR6uJ/+3oGMxJUVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ld27Ctu3LjLwz6nyJncF4IMY20+aIHT/e3N866KLdFOVkS2ybBAVb1fp0IiWooEF7
	 OTw5J2O+YHnNNRT/B23ikfOGGohqln1hPRtAbFlJWe7BNP2EwNp/Bo/HHtkP+eru/d
	 3PquYiSxL9s664PGxh/lDrWC43BpYpYW5dJMiK20=
Date: Wed, 22 Apr 2026 20:41:09 +0100
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
Message-ID: <aekkVQwueKbFtG7C@e129823.arm.com>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
 <20260422162449.1814615-2-yeoreum.yun@arm.com>
 <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
 <aekXaU52fzvNYaUF@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aekXaU52fzvNYaUF@e129823.arm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9281-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,arm.com:email]
X-Rspamd-Queue-Id: 85E8344A3CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Hi Mimi,
>
> > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
> > > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
> > > the TPM driver must be built as built-in and
> > > must be probed before the IMA subsystem is initialized.
> > >
> > > However, when the TPM device operates over the FF-A protocol using
> > > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > > the tpm_crb_ffa device — an FF-A device that provides the communication
> > > interface to the tpm_crb driver — has not yet been probed.
> > >
> > > To ensure the TPM device operating over the FF-A protocol with
> > > the CRB interface is probed before IMA initialization,
> > > the following conditions must be met:
> > >
> > >    1. The corresponding ffa_device must be registered,
> > >       which is done via ffa_init().
> > >
> > >    2. The tpm_crb_driver must successfully probe this device via
> > >       tpm_crb_ffa_init().
> > >
> > >    3. The tpm_crb driver using CRB over FF-A can then
> > >       be probed successfully. (See crb_acpi_add() and
> > >       tpm_crb_ffa_init() for reference.)
> > >
> > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > > all registered with device_initcall, which means crb_acpi_driver_init() may
> > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > >
> > > When this occurs, probing the TPM device is deferred.
> > > However, the deferred probe can happen after the IMA subsystem
> > > has already been initialized, since IMA initialization is performed
> > > during late_initcall, and deferred_probe_initcall() is performed
> > > at the same level.
> > >
> > > To resolve this, call ima_init() again at late_inicall_sync level
> > > so that let IMA not miss TPM PCR value when generating boot_aggregate
> > > log though TPM device presents in the system.
> > >
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> >
> > A lot of change for just detecting whether ima_init() is being called on
> > late_initcall or late_initcall_sync(), without any explanation for all the other
> > changes (e.g. ima_init_core).
> >
> > Please just limit the change to just calling ima_init() twice.
>
> My concern is that ima_update_policy_flags() will be called
> when ima_init() is deferred -- not initialised anything.
> though functionally, it might be okay however,
> I think ima_update_policy_flags() and notifier should work after ima_init()
> works logically.
>
> This change I think not much quite a lot. just wrapper ima_init() with
> ima_init_core() with some error handling.
>
> Am I missing something?

Also, if we handle in ima_init() only, but it failed with other reason,
we shouldn't call again ima_init() in the late_initcall_sync.

To handle this, It wouldn't do in the ima_init() but we need to handle
it by caller of ima_init().

--
Sincerely,
Yeoreum Yun

