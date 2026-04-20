Return-Path: <linux-integrity+bounces-9245-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KWiLSAF5mkIqgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9245-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 12:51:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4184A4299C8
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 12:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94BD9301027D
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Apr 2026 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09D39B963;
	Mon, 20 Apr 2026 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="f1C8Kqc5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084E39A7F8;
	Mon, 20 Apr 2026 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682269; cv=none; b=bGzaZj2S6cIj6nTQ42xgKAV4e+4Ssqwa1epDUQXpDenSy5OXAYmjrxlcxONC8Vdp+ncABsM5aPjR08I2gmKN7A2zWbu0eijl5yMkPi1Em4RZ2c4RMw2PTbNzz5GlpPCPJDXLi5v4J5ZwYzIGYsHCzEanWg0yTXfugUUeVF0Y3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682269; c=relaxed/simple;
	bh=NwqoOHuPUUb5E/oPsvKJU0jzUq0093Wuhl3vd0QrYDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP5+Dt/B+U0/GFMoLAY69DoynMXcpFQR/LoMUlHIumQRXVKVVe1SBBQNxAHUY9Z8U98OUoQqg/CPdVJZMEK8fgwfQPidD42+grYPoWjkbFiimu6bZ37D68G7geLRy8rp3HWRLAPE843e7LUYP2xWltYVTbaSE5r6Bt/ibo5UpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=f1C8Kqc5; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=192fbMdGov5ra3CzttpWVsfsxwWZ2pH8LM+eCLO/yN4=; b=f1C8Kqc5RU5hnOVR3+GUpKke9a
	fij2Gr/6dtPqzAUplechdSze22hseaiHPeOITqSHyxIK14zh4x0e9UUKZV3X9/A3u7PG8uR6PknnV
	byys1CbYcn4rdkFiQdxCQMSkiHPzXyftqZGswLo6U6PNoNutChpIwe/S+XAEPjBM+NJZrFZuz/rAc
	5U+t+jPmdbMDwAg7eXbylZKnQi7ggyOnmiFWPdCg32zTm4uG4OwYFcb4t+ZsPWF/+TDZZmPTn6hf7
	xYcHWwApZ9EesabPH4NAiF7BsdamsqF2hgMQwalWm2iCbCwBfzQeRtAp5vnRuxNV37+kcTFpb4s1R
	qbh9nHBQ==;
Received: from noodles by the.earth.li with local (Exim 4.98.2)
	(envelope-from <noodles@earth.li>)
	id 1wElw0-0000000HLRV-2LBb;
	Mon, 20 Apr 2026 11:32:56 +0100
Date: Mon, 20 Apr 2026 11:32:56 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Yeoreum Yun <yeoreum.yun@arm.com>
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
Message-ID: <aeYA2Jf7esHsfY4M@earth.li>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417175759.3191279-2-yeoreum.yun@arm.com>
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[earth.li:s=the];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9245-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[earth.li];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,kernel.org,ziepe.ca,arm.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.633];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noodles@earth.li,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[earth.li:-];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4184A4299C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 06:57:56PM +0100, Yeoreum Yun wrote:
>To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
>the TPM driver must be built as built-in and
>must be probed before the IMA subsystem is initialized.
>
>However, when the TPM device operates over the FF-A protocol using
>the CRB interface, probing fails and returns -EPROBE_DEFER if
>the tpm_crb_ffa device — an FF-A device that provides the communication
>interface to the tpm_crb driver — has not yet been probed.
>
>To ensure the TPM device operating over the FF-A protocol with
>the CRB interface is probed before IMA initialization,
>the following conditions must be met:
>
>   1. The corresponding ffa_device must be registered,
>      which is done via ffa_init().
>
>   2. The tpm_crb_driver must successfully probe this device via
>      tpm_crb_ffa_init().
>
>   3. The tpm_crb driver using CRB over FF-A can then
>      be probed successfully. (See crb_acpi_add() and
>      tpm_crb_ffa_init() for reference.)
>
>Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
>all registered with device_initcall, which means crb_acpi_driver_init() may
>be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
>
>When this occurs, probing the TPM device is deferred.
>However, the deferred probe can happen after the IMA subsystem
>has already been initialized, since IMA initialization is performed
>during late_initcall, and deferred_probe_initcall() is performed
>at the same level.
>
>To resolve this, move ima_init() into late_inicall_sync level
>so that let IMA not miss TPM PCR value when generating boot_aggregate
>log though TPM device presents in the system.
>
>Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Awesome. This fixes the problems I saw with an SPI TPM on an NVIDIA 
GB200 system and reported in 

https://lore.kernel.org/linux-integrity/aYXEepLhUouN5f99@earth.li/

Reviewed-by: Jonathan McDowell <noodles@meta.com>
Tested-by: Jonathan McDowell <noodles@meta.com>

>---
> include/linux/lsm_hooks.h         |  2 ++
> security/integrity/ima/ima_main.c |  2 +-
> security/lsm_init.c               | 13 +++++++++++--
> 3 files changed, 14 insertions(+), 3 deletions(-)
>
>diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>index d48bf0ad26f4..88fe105b7f00 100644
>--- a/include/linux/lsm_hooks.h
>+++ b/include/linux/lsm_hooks.h
>@@ -166,6 +166,7 @@ enum lsm_order {
>  * @initcall_fs: LSM callback for fs_initcall setup, optional
>  * @initcall_device: LSM callback for device_initcall() setup, optional
>  * @initcall_late: LSM callback for late_initcall() setup, optional
>+ * @initcall_late_sync: LSM callback for late_initcall_sync() setup, optional
>  */
> struct lsm_info {
> 	const struct lsm_id *id;
>@@ -181,6 +182,7 @@ struct lsm_info {
> 	int (*initcall_fs)(void);
> 	int (*initcall_device)(void);
> 	int (*initcall_late)(void);
>+	int (*initcall_late_sync)(void);
> };
>
> #define DEFINE_LSM(lsm)							\
>diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>index 1d6229b156fb..ace280fa3212 100644
>--- a/security/integrity/ima/ima_main.c
>+++ b/security/integrity/ima/ima_main.c
>@@ -1320,5 +1320,5 @@ DEFINE_LSM(ima) = {
> 	.order = LSM_ORDER_LAST,
> 	.blobs = &ima_blob_sizes,
> 	/* Start IMA after the TPM is available */
>-	.initcall_late = init_ima,
>+	.initcall_late_sync = init_ima,
> };
>diff --git a/security/lsm_init.c b/security/lsm_init.c
>index 573e2a7250c4..4e5c59beb82a 100644
>--- a/security/lsm_init.c
>+++ b/security/lsm_init.c
>@@ -547,13 +547,22 @@ device_initcall(security_initcall_device);
>  * security_initcall_late - Run the LSM late initcalls
>  */
> static int __init security_initcall_late(void)
>+{
>+	return lsm_initcall(late);
>+}
>+late_initcall(security_initcall_late);
>+
>+/**
>+ * security_initcall_late_sync - Run the LSM late initcalls sync
>+ */
>+static int __init security_initcall_late_sync(void)
> {
> 	int rc;
>
>-	rc = lsm_initcall(late);
>+	rc = lsm_initcall(late_sync);
> 	lsm_pr_dbg("all enabled LSMs fully activated\n");
> 	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
>
> 	return rc;
> }
>-late_initcall(security_initcall_late);
>+late_initcall_sync(security_initcall_late_sync);
>--
>LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>
>

J.

-- 
] https://www.earth.li/~noodles/ []  "Do I scare you?" "No." "Do you   [
]  PGP/GPG Key @ the.earth.li    []   want me to?" -- Wayne's World.   [
] via keyserver, web or email.   []                                    [
] RSA: 4096/0x94FA372B2DA8B985   []                                    [

