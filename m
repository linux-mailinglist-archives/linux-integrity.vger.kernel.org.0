Return-Path: <linux-integrity+bounces-9264-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJeYLXBF52ls6AEAu9opvQ
	(envelope-from <linux-integrity+bounces-9264-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 11:37:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE5438F07
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 11:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6723006B78
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7013A63EC;
	Tue, 21 Apr 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ibDvPcRa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35383A2579;
	Tue, 21 Apr 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764260; cv=none; b=PhPhYd3RuAq7181jAMG50COp+cwVC/yaUyWY2wmQMOL77ub80R2VKe9lrHT7gQLrWQnkvjnu75ch1PRouA+ECNAFuBh0HLfn/MMZJAU8WIyXbCz8SJj2rtdNjUCSkoIFyMLIitBEshM8Z0Ggfpu/ATm0K4cac8jV2BJOtALDPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764260; c=relaxed/simple;
	bh=rZx2NuFqw+HMY4ITLik4Kx4QKHWVqXkaV8x4xuSaQjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNyts6G1Qx24Z1x09U0I9UyzM+LMbYwTJOAhyXS7kdysdhYhiI4HxU2secFNVewT4x1m4llowleVRbuAu3xhICNJWizKVieJTHHbP+hiz/p4hX5ZqDjk2+BOF8MPs3PHvRGOpXlN7mcs9hJpuFm4Zd8kxFPIwYWiG8wVLUvAaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ibDvPcRa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76E2425E4;
	Tue, 21 Apr 2026 02:37:32 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C9673F641;
	Tue, 21 Apr 2026 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776764258; bh=rZx2NuFqw+HMY4ITLik4Kx4QKHWVqXkaV8x4xuSaQjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibDvPcRaq03rQ6JOZQZykMlumpppwk3iXlffiEfTjVYngL7Gif5qXWERA0ggrZMKc
	 9EXOVgrN1mrh1XnDnqOGAv/Fdcp/jza73TQXvAvEBhliVRnJa6njo8HOzVqbkOp3cw
	 m9z/6XcBTftg5rY1THI/9WjhAp7mEDG277HZMdIM=
Date: Tue, 21 Apr 2026 10:37:32 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 1/4] security: ima: move ima_init into
 late_initcall_sync
Message-ID: <aedFXFlPATqtBm/J@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-2-yeoreum.yun@arm.com>
 <aeYA2Jf7esHsfY4M@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeYA2Jf7esHsfY4M@earth.li>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,kernel.org,ziepe.ca,arm.com];
	TAGGED_FROM(0.00)[bounces-9264-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,e129823.arm.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 61DE5438F07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:32:56AM +0100, Jonathan McDowell wrote:
> On Fri, Apr 17, 2026 at 06:57:56PM +0100, Yeoreum Yun wrote:
> > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
> > the TPM driver must be built as built-in and
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
> >   1. The corresponding ffa_device must be registered,
> >      which is done via ffa_init().
> >
> >   2. The tpm_crb_driver must successfully probe this device via
> >      tpm_crb_ffa_init().
> >
> >   3. The tpm_crb driver using CRB over FF-A can then
> >      be probed successfully. (See crb_acpi_add() and
> >      tpm_crb_ffa_init() for reference.)
> >
> > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > all registered with device_initcall, which means crb_acpi_driver_init() may
> > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> >
> > When this occurs, probing the TPM device is deferred.
> > However, the deferred probe can happen after the IMA subsystem
> > has already been initialized, since IMA initialization is performed
> > during late_initcall, and deferred_probe_initcall() is performed
> > at the same level.
> >
> > To resolve this, move ima_init() into late_inicall_sync level
> > so that let IMA not miss TPM PCR value when generating boot_aggregate
> > log though TPM device presents in the system.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>
> Awesome. This fixes the problems I saw with an SPI TPM on an NVIDIA GB200
> system and reported in
>
> https://lore.kernel.org/linux-integrity/aYXEepLhUouN5f99@earth.li/
>
> Reviewed-by: Jonathan McDowell <noodles@meta.com>
> Tested-by: Jonathan McDowell <noodles@meta.com>

Thanks!

>
> > ---
> > include/linux/lsm_hooks.h         |  2 ++
> > security/integrity/ima/ima_main.c |  2 +-
> > security/lsm_init.c               | 13 +++++++++++--
> > 3 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index d48bf0ad26f4..88fe105b7f00 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -166,6 +166,7 @@ enum lsm_order {
> >  * @initcall_fs: LSM callback for fs_initcall setup, optional
> >  * @initcall_device: LSM callback for device_initcall() setup, optional
> >  * @initcall_late: LSM callback for late_initcall() setup, optional
> > + * @initcall_late_sync: LSM callback for late_initcall_sync() setup, optional
> >  */
> > struct lsm_info {
> > 	const struct lsm_id *id;
> > @@ -181,6 +182,7 @@ struct lsm_info {
> > 	int (*initcall_fs)(void);
> > 	int (*initcall_device)(void);
> > 	int (*initcall_late)(void);
> > +	int (*initcall_late_sync)(void);
> > };
> >
> > #define DEFINE_LSM(lsm)							\
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 1d6229b156fb..ace280fa3212 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -1320,5 +1320,5 @@ DEFINE_LSM(ima) = {
> > 	.order = LSM_ORDER_LAST,
> > 	.blobs = &ima_blob_sizes,
> > 	/* Start IMA after the TPM is available */
> > -	.initcall_late = init_ima,
> > +	.initcall_late_sync = init_ima,
> > };
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 573e2a7250c4..4e5c59beb82a 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -547,13 +547,22 @@ device_initcall(security_initcall_device);
> >  * security_initcall_late - Run the LSM late initcalls
> >  */
> > static int __init security_initcall_late(void)
> > +{
> > +	return lsm_initcall(late);
> > +}
> > +late_initcall(security_initcall_late);
> > +
> > +/**
> > + * security_initcall_late_sync - Run the LSM late initcalls sync
> > + */
> > +static int __init security_initcall_late_sync(void)
> > {
> > 	int rc;
> >
> > -	rc = lsm_initcall(late);
> > +	rc = lsm_initcall(late_sync);
> > 	lsm_pr_dbg("all enabled LSMs fully activated\n");
> > 	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
> >
> > 	return rc;
> > }
> > -late_initcall(security_initcall_late);
> > +late_initcall_sync(security_initcall_late_sync);
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> >
> >
>
> J.
>
> --
> ] https://www.earth.li/~noodles/ []  "Do I scare you?" "No." "Do you   [
> ]  PGP/GPG Key @ the.earth.li    []   want me to?" -- Wayne's World.   [
> ] via keyserver, web or email.   []                                    [
> ] RSA: 4096/0x94FA372B2DA8B985   []                                    [

--
Sincerely,
Yeoreum Yun

