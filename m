Return-Path: <linux-integrity+bounces-9665-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GECrLmNsFWoBVAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9665-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 11:48:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173CD5D3ABD
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 11:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9037303429A
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137233D8101;
	Tue, 26 May 2026 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHS2tBhC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFB3D3328;
	Tue, 26 May 2026 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788494; cv=none; b=A0igZwwmlajPA0mdBC2iISpyfC2BetmGi2G1r6lvhrk+hq1DdriKQsK6ZZUVJv5tRemO7oxyP8+gLNPu6FEIZuezkt40CHBaiT6Unv69M8r3Sirt+8xwDG96tcpYJnZJCt8Ta3vj2RjsxOzYyTeDXGu6/XZ9+ivIR1sGg22/rjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788494; c=relaxed/simple;
	bh=Gz4q5QgFQbnOnnEUIl7EeAovXaR6hiGdxtHZjlMHF3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsI6d3sY7+4yV91YNqrwsvRPzBxgbyXd4DVLKRTNp+Yh6HyPpjCHXEu/qHG5HA6As2c24/T/COqL8xbvwMppyFgxs1jP8wGtnC8xTb4PuVNmzZcD26Uw1LM2c5y7OxvNZf5Y/SNrJIqZmG7kv5p2Uk8nyjxHjdBZQ9AAUMyXH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHS2tBhC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F77F1F000E9;
	Tue, 26 May 2026 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788492;
	bh=1cPnc2HBwlXfOQHf4P6mq2XSBykV+yW2Sb/oJ4JFuHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IHS2tBhCEydy2L07hJTcjM2HawQ0ovbNQl+hx4PVNB71ZoA4rTE3d7lLKy9yIRyIu
	 94wJnUs5fypXA1knSNnpU6ScReOv1Cms6BmxmsUyf46hOfqGrbl5srN+zUcsLGJd8n
	 3lhLvDF+2+rgiwlfPw3lbIWelm1siCxGBWv0+R5vn7UepsFhGsHCwfca70VLpAPJ9B
	 TXyzPQbD2hj21Rdz94XxI1F8rpVRMzD66kWE4TTkYUmpgoVVBE11fQUFNvTJWZJFxv
	 rzgJHG0HviKrOetFrQpWZ4KSQ2kT812y1ppJNnmxiJp3LJNdNz2RwTYMxmj2ML1N+P
	 JjkSSUTNGAKsw==
Date: Tue, 26 May 2026 10:41:29 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 2/4] firmware: arm_ffa: Register core as a platform driver
Message-ID: <20260526-ancient-bulky-numbat-915f10@sudeepholla>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9665-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 173CD5D3ABD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 05:11:48PM -0700, Nathan Chancellor wrote:
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

Yes it should be silenced, I will see how it can be done. Thanks for the
report.

-- 
Regards,
Sudeep

