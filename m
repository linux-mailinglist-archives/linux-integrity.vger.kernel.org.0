Return-Path: <linux-integrity+bounces-9468-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI4cOrwG+2njVQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9468-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 11:15:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE34D8716
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 11:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9565A3040465
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29063C2779;
	Wed,  6 May 2026 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CsTwWJ0A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1FC3DC4A2;
	Wed,  6 May 2026 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058675; cv=none; b=HpQoS3dvYQELbo11rakaKw3LWw92NUCf4QiKan87IYMKRJUA/uvvDyZNkzujAg82xhMrHhUlzYJ2pG8yrpYBQuevaBkCa61mdtsBhQgYT9QaHlAcLzfE5xE5h2lmuWxMmIQvDJ0Aj+Gxh/vRwUP9Mxz6uHQNNAE16cKPL2Ljf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058675; c=relaxed/simple;
	bh=HO76+zQCwHgJCUOGF5XXmyDSoLr/oFxHSDY84DqGHls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0yK/t5aZlf6hqj3y19KkMbZwBPGvhLjF6hmMV+he3Js9jqF3Wl9rLrz6J4SiyjOE+JS0TkU83OlCOkvqYRFOrtDd+2gMRZ5l2Jvl+QjXf4Qq9Y6nSkyQdUBysSxN/gDiG6gD54Sx9w6fSb+X/u3rZbxNwmGe9in1n+vYLVtUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CsTwWJ0A; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2194B1A9A;
	Wed,  6 May 2026 02:11:08 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00C03F7B4;
	Wed,  6 May 2026 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778058673; bh=HO76+zQCwHgJCUOGF5XXmyDSoLr/oFxHSDY84DqGHls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsTwWJ0ACYXeSYc7xaXyDHSqjet1qFe3bZg4/NBz3mTbZ3oGeSe1So3ZaYw4uaKXI
	 HSMopLyoyFrG5aE8fQ3+D8bfss4v+ZfmB64xV5FjhmDRS6tgdnsRMOahzXqsG1BIab
	 C1vLPbSKAx/PbvASLuAVRFDjJh81EDwS61uSQI7k=
Date: Wed, 6 May 2026 10:11:08 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	jarkko@kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 2/3] firmware: arm_ffa: initialise ff-a after
 finalising pKVM initialisation
Message-ID: <afsFrCrL/w1ehteD@e129823.arm.com>
References: <20260505095409.1948371-1-yeoreum.yun@arm.com>
 <20260505095409.1948371-3-yeoreum.yun@arm.com>
 <20260505-super-gecko-of-argument-655030@sudeepholla>
 <afoHizU8NgFWzvYW@e129823.arm.com>
 <20260505-adaptable-mussel-of-virtuosity-2751db@sudeepholla>
 <afohuFhVBIyUFEMT@e129823.arm.com>
 <20260506-warm-deer-of-energy-522bfa@sudeepholla>
 <afrygFx4OoCbbr+a@e129823.arm.com>
 <20260506-colossal-bee-of-discussion-08ac76@sudeepholla>
 <afsCs56KfpoMhPH9@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afsCs56KfpoMhPH9@e129823.arm.com>
X-Rspamd-Queue-Id: 4CBE34D8716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,arm.com];
	TAGGED_FROM(0.00)[bounces-9468-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,e129823.arm.com:mid]

On Wed, May 06, 2026 at 09:58:27AM +0100, Yeoreum Yun wrote:
> > On Wed, May 06, 2026 at 08:49:20AM +0100, Yeoreum Yun wrote:
> > > Hi,
> > > 
> > > I mean like DT node, it seems to add some "FF-A" device for this.
> > > Anyway, right now as your suggestion, let me respin with platform device
> > > again.
> > > 
> > 
> > Please check my branch ffa_plat_dev [1] as I noted in the last email.
> > 
> > -- 
> > Regards,
> > Sudeep
> > 
> > [1] https://git.kernel.org/sudeep.holla/l/ffa_plat_dev
> 
> Sorry, I've seen this email after I sent former mail.
> 
> And since platform_driver_probe() prevents deferred probe.
> I think it need to change jsut platform_driver_register()
> for ffa_driver.
> 
> Thanks!

With above change, everything is good.

Thanks again!

-- 
Sincerely,
Yeoreum Yun

