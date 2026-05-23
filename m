Return-Path: <linux-integrity+bounces-9642-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFTFDRQyEWpFigYAu9opvQ
	(envelope-from <linux-integrity+bounces-9642-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2026 06:50:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17C5BD24B
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2026 06:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5E643004D3C
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2026 04:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A619B25B0A9;
	Sat, 23 May 2026 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bzHVuZt+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF3A22579E;
	Sat, 23 May 2026 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779511822; cv=none; b=Pi+TwYyLixbShmRqgrnp2mQXaiPAZI1LP057fy9DIBalvyRu46DxiNF+wK5X8aVETnG929wRaU5/4xnlKH72xnsOQZYKXX77Egn8dus0F4jnH8re80upSboC++CW9U5FqZJbZYjbfiCCf8+8v4iyPKPbWcz0uHX0PvM5CfLS1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779511822; c=relaxed/simple;
	bh=XmvhcCMIyo6mbxY7y8SuJFHc01ftQ4EjSoIcMDfl8vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEqsUN+y6NFFseoLvgwStEEEMME2yIlNEEHwn4Msje//ktspQc86NqdrjZj1C/osgAWubS1X897eQKpaqxNdPhIzfEvaWSCbUJjtSq6WzIY0fy6T3A2X5ikFI7iElAVjSAvYO5s/Kv/kHqc5guKlkTnht0wbx3OLgo7ke3Iu3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bzHVuZt+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BCF81D15;
	Fri, 22 May 2026 21:50:13 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 138B63F85F;
	Fri, 22 May 2026 21:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779511818; bh=XmvhcCMIyo6mbxY7y8SuJFHc01ftQ4EjSoIcMDfl8vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bzHVuZt+7Gx0IxrA/jJUyXVmCQt7cfSi6k2mMPe8nHd4sfRjVlGTNBoGM5H52rIVN
	 8A3HtdwyDPKY8sMi+Ut8F8j3d40pXrL7n/BBO3SK1gqNrdHDwjIAKUICsChx131qDp
	 QSk/Uav64ygKlsTZaSAwXeNfEvYNn4lDNK2r43uk=
Date: Sat, 23 May 2026 05:50:14 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, yeoreum.yun@arm.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 2/4] firmware: arm_ffa: Register core as a platform driver
Message-ID: <ahEyBrZGSVbdQxDJ@e129823.arm.com>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
 <20260508-b4-ffa_plat_dev-v1-2-c5a30f8cf7b8@kernel.org>
 <20260523001148.GA1319283@ax162>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523001148.GA1319283@ax162>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9642-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F17C5BD24B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Nathan,

> Hi Sudeep,
> 
> On Fri, May 08, 2026 at 06:54:16PM +0100, Sudeep Holla wrote:
> > Move the FF-A core bring-up and teardown paths into platform driver
> > probe and remove callbacks, and register a synthetic arm-ffa platform
> > device to bind the driver.
> > 
> > This makes the FF-A core lifetime follow the driver model while keeping
> > the device creation internal to the FF-A core. Use normal platform driver
> > registration so the probe path has standard driver-core semantics.
> > 
> > The synthetic platform device is a temporary bridge until ACPI and
> > devicetree describe the FF-A core device or object. Once those firmware
> > description paths are defined, the internal platform device creation can
> > be dropped and the driver can bind to the firmware-described device
> > directly.
> > 
> > Since the transport selection now happens from the platform probe path,
> > drop the __init annotation from ffa_transport_init().
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> 
> I am seeing
> 
>   arm-ffa arm-ffa: probe with driver arm-ffa failed with error -95
> 
> on my two arm64 test machines after this change landed in -next as
> commit e659fc8e537c ("firmware: arm_ffa: Register core as a platform
> driver"), is this expected? If so, perhaps it should be silenced?
> 
> Cheers,
> Nathan
>

Could you share the .config file you used for this?

Thanks!

[...]

-- 
Sincerely,
Yeoreum Yun

