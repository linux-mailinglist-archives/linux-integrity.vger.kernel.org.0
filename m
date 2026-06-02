Return-Path: <linux-integrity+bounces-9741-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gfIWNZvTHmooVgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9741-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 14:59:07 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15662E3A0
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 14:59:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Nj4MlWI4;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9741-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9741-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAC6A302866F
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED93D6480;
	Tue,  2 Jun 2026 12:58:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C214D3BE17D;
	Tue,  2 Jun 2026 12:58:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405120; cv=none; b=V3uJRclyMZybqDDobmfTh+dMxEp5WDkNr4+Vfy+IZnvxvvVzEhMRC8aR6qT9uSOYUgrcPUGKMDxHHGH4oONGhKAGiPYTpuq7vgywIq4c84RHv5y7GUDv4z02AFqA/mCn1HhwHib8OI04EActnCj5WXQHLsv5lBgQH5xVqspOPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405120; c=relaxed/simple;
	bh=F7p8ao5jE718R9vbROoxBsUPw1FnHZPPqSTle3h2Xe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGh+v1pr7TjNkDoSn0O+6e17himTNhDTSbqGGhbSJvHKRSb7oWUYh94khRoHDVk5WrUZJ+vKX7QPdAw5H1ew1VxRVahjxZL2vqF5UKl5wLdicFTxhftlRFCEtt5SB9R4lmqEasvBvkEzRlHeVXdYUFbNlcHhbBPPEGPyWYGRqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Nj4MlWI4; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4917B169C;
	Tue,  2 Jun 2026 05:58:33 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 195FF3F632;
	Tue,  2 Jun 2026 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780405118; bh=F7p8ao5jE718R9vbROoxBsUPw1FnHZPPqSTle3h2Xe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nj4MlWI4zxpNAxzHR7HBAooeXlxIzszd1q8+O0FmqTcuCbLcI2R2fbDId+a6OTokb
	 CFwzlF/Tf3TaEqAhzkCnFrEOD4h7wFj8F5csOSP/nNwRDVQYUsm26QiUI+8/m/Gzra
	 2+5w5pBEqU033LwtVz0cqO1tu1f6Th3Ihzle+iNk=
Date: Tue, 2 Jun 2026 13:58:33 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	roberto.sassu@huaweicloud.com, noodles@earth.li, jarkko@kernel.org,
	sudeep.holla@kernel.org, jmorris@namei.org, serge@hallyn.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca,
	Jonathan McDowell <noodles@meta.com>
Subject: Re: [PATCH v5 3/4] security: ima: rename boot_aggregate when ima is
 initialised at late_sync
Message-ID: <ah7TeV7kSP8I2/hQ@e129823.arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
 <20260601142749.3379697-4-yeoreum.yun@arm.com>
 <5c52effb1b4723c025f478c1c902bf83a9a4d0ed.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c52effb1b4723c025f478c1c902bf83a9a4d0ed.camel@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9741-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,paul-moore.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zohar@linux.ibm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:noodles@meta.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:from_mime,arm.com:email,e129823.arm.com:mid,meta.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E15662E3A0

Hi Mimi,

> On Mon, 2026-06-01 at 15:27 +0100, Yeoreum Yun wrote:
> > From: Jonathan McDowell <noodles@meta.com>
> > 
> > The Linux IMA (Integrity Measurement Architecture) subsystem used for
> > secure boot, file integrity, or remote attestation cannot be a loadable
> > module for few reasons listed below:
> > 
> >  o Boot-Time Integrity: IMA’s main role is to measure and appraise files
> >    before they are used. This includes measuring critical system files
> >    during early boot (e.g., init, init scripts, login binaries). If IMA
> >    were a module, it would be loaded too late to cover those.
> > 
> >  o TPM Dependency: IMA integrates tightly with the TPM to record
> >    measurements into PCRs. The TPM must be initialized early (ideally
> >    before init_ima()), which aligns with IMA being built-in.
> > 
> >  o Security Model: IMA is part of a Trusted Computing Base (TCB). Making
> >    it a module would weaken the security model, as a potentially
> >    compromised system could delay or tamper with its initialization.
> > 
> > IMA must be built-in to ensure it starts measuring from the earliest
> > possible point in boot which inturn implies TPM must be initialised and
> > ready to use before IMA.
> > 
> > Unfortunately some TPM drivers (such as Arm FF-A, or SPI attached TPM
> > devices) are not reliably available during the initcall_late stage,
> > resulting in a log error:
> > 
> >   ima: No TPM chip found, activating TPM-bypass!
> > 
> > To address this issue, IMA_INIT_LATE_SYNC is introduced.
> > However, a remote attestation service cannot determine when IMA has been
> > initialized because the boot_aggregate measurement name remains unchanged,
> > even though IMA is initialized later at late_initcall_sync when
> > IMA_INIT_LATE_SYNC is enabled.
> > 
> > Therefore, use a distinct boot_aggregate name when IMA_INIT_LATE_SYNC
> > is enabled, allowing the remote attestation service to identify
> > when IMA has been initialized.
> > 
> > Signed-off-by: Jonathan McDowell <noodles@meta.com>
> > [yeoreum.yun@arm.com: modified to align with the IMA_INIT_LATE_SYNC change]
> 
> Thanks, Yeoreum. This version requires your Signed-off-by tag as well as
> Jonathan's.  Otherwise the patch looks good.

Thanks! I'll resend with my SOB again!

-- 
Sincerely,
Yeoreum Yun

