Return-Path: <linux-integrity+bounces-9645-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 88ZqAu9IEWr8jQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9645-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2026 08:27:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5885A5BD6E9
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2026 08:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 349C03018283
	for <lists+linux-integrity@lfdr.de>; Sat, 23 May 2026 06:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3C318EE7;
	Sat, 23 May 2026 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uIQJFM/c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D5126290;
	Sat, 23 May 2026 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779517674; cv=none; b=hTNXJ35CMtJOtHwiktWd+ar8zwIX86F14gg+poZRdEam6p2xooGBFqxjWhHKM1cTmQzbO3/wqysr08mg8YnVSe/YTlFIFZJKJcB8U2IKsgGhO3CiMLkcHPvVkSjNKKfOMZke4Nwdx8FVALmoaVJ2SHfRC0pPJ2sKNcvh5+IGzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779517674; c=relaxed/simple;
	bh=JEVR6CkLj/c0gaMD1sZUS4SWLivaFbisW4FMLpwuuDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhx1HGyK4M836d9C91b0kSMalI/chcj4R+05WVJwPgs3EZ6tLMuIZjI8WUyhF5MtoPIo27rRocsfzarEQ3JHDQEssQa/XZ4yXj28TjxBQ7gjwN9DogE/NIgw4rHS5uMowBH0o9+dcRp2UP1VmOZXRBV2fO1FZ05K1Ci2htyCdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uIQJFM/c; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A2C21F02;
	Fri, 22 May 2026 23:27:46 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211CB3F7B4;
	Fri, 22 May 2026 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779517671; bh=JEVR6CkLj/c0gaMD1sZUS4SWLivaFbisW4FMLpwuuDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uIQJFM/cEmjlN4stENbpOIKjt/iyaSbTyh5hLaLGIXxF5+qBDVQp/OE3m2CxHVp/O
	 sWtBL7579DfUCAmc8WHI8dr0MQGjw0iVJjBYEegAij/WaCFEgrX6P4bNO4EZyU8DAI
	 8mOq6ipz1yrieS4cv9bsHmMFlxHkSofGAUYfjwE4=
Date: Sat, 23 May 2026 07:27:47 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 2/4] firmware: arm_ffa: Register core as a platform driver
Message-ID: <ahFI43hT9eoktFlU@e129823.arm.com>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
 <20260508-b4-ffa_plat_dev-v1-2-c5a30f8cf7b8@kernel.org>
 <20260523001148.GA1319283@ax162>
 <ahEyBrZGSVbdQxDJ@e129823.arm.com>
 <20260523050555.GA1121518@ax162>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260523050555.GA1121518@ax162>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9645-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,e129823.arm.com:mid]
X-Rspamd-Queue-Id: 5885A5BD6E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 10:05:55PM -0700, Nathan Chancellor wrote:
> On Sat, May 23, 2026 at 05:50:14AM +0100, Yeoreum Yun wrote:
> > Hi Nathan,
> > 
> > > Hi Sudeep,
> > > 
> > > On Fri, May 08, 2026 at 06:54:16PM +0100, Sudeep Holla wrote:
> > > > Move the FF-A core bring-up and teardown paths into platform driver
> > > > probe and remove callbacks, and register a synthetic arm-ffa platform
> > > > device to bind the driver.
> > > > 
> > > > This makes the FF-A core lifetime follow the driver model while keeping
> > > > the device creation internal to the FF-A core. Use normal platform driver
> > > > registration so the probe path has standard driver-core semantics.
> > > > 
> > > > The synthetic platform device is a temporary bridge until ACPI and
> > > > devicetree describe the FF-A core device or object. Once those firmware
> > > > description paths are defined, the internal platform device creation can
> > > > be dropped and the driver can bind to the firmware-described device
> > > > directly.
> > > > 
> > > > Since the transport selection now happens from the platform probe path,
> > > > drop the __init annotation from ffa_transport_init().
> > > > 
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > 
> > > I am seeing
> > > 
> > >   arm-ffa arm-ffa: probe with driver arm-ffa failed with error -95
> > > 
> > > on my two arm64 test machines after this change landed in -next as
> > > commit e659fc8e537c ("firmware: arm_ffa: Register core as a platform
> > > driver"), is this expected? If so, perhaps it should be silenced?
> > 
> > Could you share the .config file you used for this?
> 
> Sure thing! It is attached. If you need anything else, please let me
> know.

Thanks! unless there was other error log from ff-a driver,
I think this happens because your environment either doesn’t
support FF-A or is using an SMCCC version earlier than 1.2 from
ffa_version_check() or ffa_transport_init().

If that’s the case, You can ignore this log since this behavior is
expected, and the dd core should print an error log.
Before this patch, the error was not shown because all FF-A initialization
was done during the initcall phase, and nothing was printed
even when the initcall function returned an error from caller of initcall.

[...]

--
Sincerely,
Yeoreum Yun

