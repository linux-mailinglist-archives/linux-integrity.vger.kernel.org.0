Return-Path: <linux-integrity+bounces-9263-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFNMM7w/52no5QEAu9opvQ
	(envelope-from <linux-integrity+bounces-9263-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 11:13:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF9438B14
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 402BE300A65D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0CF3A3E69;
	Tue, 21 Apr 2026 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OGniPLsi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7DB3A1680;
	Tue, 21 Apr 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762730; cv=none; b=oIqtZxThheTCHPDlELJQR9zo/QtLo1bsLF7CEWOhG0QgHh9YW4CuNwUfiQaNk5iYbJTkN/Ep5Qgh5d85n1V0WBjm6yc9vxr12Naj3HhoyHcw+Jq6/Geqv0VTk9Ke3ONFg8Ije/jvHEbCsXOM+hFc70eQZ3DQ0YYXlHOoh6U5II4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762730; c=relaxed/simple;
	bh=bUki7691gF6PAdgoVdG4YA6Jl/b0UXzAgcjElizpR2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0eKwx+3g8W+4a1wfs5IJnVZ8lyINbT9FCeI6NuudnSbDKEyjGuLwivlpYkPMBgHYpb/TecO44ejYKolE/A+7MLI+3EwFsLdZkeSYzn1XZDkxQycKon5uvxrjkGv6914osqmKHol/xHURwf4322zVSJqVqykW6qeMXYmx29LkzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OGniPLsi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB80625E0;
	Tue, 21 Apr 2026 02:12:02 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5C93F641;
	Tue, 21 Apr 2026 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776762728; bh=bUki7691gF6PAdgoVdG4YA6Jl/b0UXzAgcjElizpR2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGniPLsiAh0DSyvAQ5HMjlIYa15Nz9Y+R15H0PhXbZ+6i7lwFWMIo2fK1tBXZmc6c
	 CJDGh1w13rrXBujXV81XH+KUHfoFW8C30GmjcKXD7XDvf6xppKXyTPQ8qpdwEnv14Z
	 U33+LK267IvzFlZkJIbw7cpxCc+Ho2cIdtbjqz9o=
Date: Tue, 21 Apr 2026 10:12:01 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aec/YSxYO1bOhXhn@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <87se8sbozv.wl-maz@kernel.org>
 <aeNeNjfO7i128TIP@e129823.arm.com>
 <87pl3vb5bm.wl-maz@kernel.org>
 <aecf57rWloQwDh6v@e129823.arm.com>
 <20260421-married-liberal-ammonite-dffda8@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-married-liberal-ammonite-dffda8@sudeepholla>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,ziepe.ca,arm.com];
	TAGGED_FROM(0.00)[bounces-9263-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:dkim,e129823.arm.com:mid]
X-Rspamd-Queue-Id: C1FF9438B14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Tue, Apr 21, 2026 at 07:57:43AM +0100, Yeoreum Yun wrote:
>
> [...]
>
> >
> > Also, the FF-A initialization is not driven by a device probe, but rather
> > happens as part of the bus registration itself,
> > so it does not fit well with a device_link or probe deferral based approach.
> >
> > Instead, perhaps we could go with the idea I mentioned previously:
> > either introduce a notifier, or create a pseudo ffa_device
> > once pKVM initialization has completed, and
> > then let the ffa driver perform the additional initialization from there.
> >
> > Am I missing something?
> >
>
> In order to handle/cleanup some ugliness in interrupt management in the
> FF-A driver, we may introduce DT node eventually. But it will take sometime.

Unfortunately, I think this DT node wouldn't be helpful to solve
this situation for dependency with the kvm misc device...

IMHO, current situation, the notifier seems to good option. unless
we make the initcall to recongise this dependency.

--
Sincerely,
Yeoreum Yun

