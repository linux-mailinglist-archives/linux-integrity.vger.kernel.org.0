Return-Path: <linux-integrity+bounces-3504-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A50697381A
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AF228315D
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50B191F82;
	Tue, 10 Sep 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="vqrlV9G/";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="B1OwzTKa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3B1EB2F;
	Tue, 10 Sep 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973065; cv=none; b=jQydNh5vKbjFtj20Z+3a9qjiDjxWP+JrqpM2FyFgxii07l0Pp8AOX6VzdiVP5BvuhSaje5yHQLKfjxiFCI5hBEmRuKPm/6o2SVg2C94Ci/kqE2DxRYRvVdzcCWaxwp5JLtRprqGR4LuG1Qk+qa1qe/Y2Qx86Pxe22ZHJ2bNEN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973065; c=relaxed/simple;
	bh=rDSX+r3NYKNXUOnNJDEw12reW1bY7cdGqinLXrl1VjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tDeW3M7T3aNUQESIVBlxs4TnNCJeGf8F+79CQ/UoC4eifvas4YlraeuvSkV6+9gyN9mxl4XQxVSB0uc2VgPctefy+/2ajQy+vuOPAJ87kJ5X2lk0Rnyl+5wflf9n6YoE3fjvSYBmjiozJBXZL0ZRuZgj4xpzIyG2YxF+PDKgEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=vqrlV9G/; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=B1OwzTKa; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1725973062;
	bh=rDSX+r3NYKNXUOnNJDEw12reW1bY7cdGqinLXrl1VjI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=vqrlV9G/Q4NxT2/El31foM0e/c4L+lEJSoH/thjKHoXX/tMUOTeqzy6xevvoTVy7L
	 MFn1LVotJ8EzZsWVDk2uehuJ5vgngt1rONBq0FUEuFc6igw7iEvaYaee19+qZ5ZQzf
	 OZ0rs5UiusM5jx+xIHuOH5PAA1rJbwx6f3/MsUTE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3DF55128635D;
	Tue, 10 Sep 2024 08:57:42 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id WQpE-h6sQKbI; Tue, 10 Sep 2024 08:57:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1725973061;
	bh=rDSX+r3NYKNXUOnNJDEw12reW1bY7cdGqinLXrl1VjI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=B1OwzTKaFwrWklkvOIEvNiQjMJgtcF1L5QsTKbGLkY/CZctOVr1GLRwRO6MFmu0d0
	 qbi6R3EC6EJQ+D9/Jxg4vW8ucFFCnCz47xsnqazJbumt1EgfKFoZxgYZMVeEyIycZ4
	 KQ8hMG1LMTyE/7/+z8eAvbDGGh4pMEYrOWX5WCqE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 02A0612817C5;
	Tue, 10 Sep 2024 08:57:40 -0400 (EDT)
Message-ID: <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Roberto Sassu
	 <roberto.sassu@huaweicloud.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Tue, 10 Sep 2024 08:57:36 -0400
In-Reply-To: <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
	 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
	 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
	 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-09-10 at 15:48 +0300, Jarkko Sakkinen wrote:
> On Tue Sep 10, 2024 at 3:39 PM EEST, Jarkko Sakkinen wrote:
> > On Tue Sep 10, 2024 at 12:05 PM EEST, Roberto Sassu wrote:
> > > On Tue, 2024-09-10 at 11:01 +0200, Linux regression tracking
> > > (Thorsten
> > > Leemhuis) wrote:
> > > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > > > 
> > > > James, Jarkoo, I noticed a report about a regression in
> > > > bugzilla.kernel.org that appears to be caused by this change of
> > > > yours:
> > > > 
> > > > 6519fea6fd372b ("tpm: add hmac checks to tpm2_pcr_extend()")
> > > > [v6.10-rc1]
> > > > 
> > > > As many (most?) kernel developers don't keep an eye on the bug
> > > > tracker,
> > > > I decided to forward it by mail. To quote from
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=219229 :
> > > > 
> > > > > When secureboot is enabled,
> > > > > the kernel boot time is ~20 seconds after 6.10 kernel.
> > > > > it's ~7 seconds on 6.8 kernel version.
> > > > > 
> > > > > When secureboot is disabled,
> > > > > the boot time is ~7 seconds too.
> > > > > 
> > > > > Reproduced on both AMD and Intel platform on ThinkPad X1 and
> > > > > T14.
> > > > > 
> > > > > It probably caused autologin failure and micmute led not
> > > > > loaded on AMD platform.
> > > > 
> > > > It was later bisected to the change mentioned above. See the
> > > > ticket for
> > > > more details.
> > > 
> > > Hi
> > > 
> > > I suspect I encountered the same problem:
> > > 
> > > https://lore.kernel.org/linux-integrity/b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com/
> > > 
> > > Going to provide more info there.
> > 
> > I suppose you are going try to acquire the tracing data I asked?
> > That would be awesome, thanks for taking the troube.  Let's look
> > at the data and draw conclusions based on that.
> > 
> > Workaround is pretty simple: CONFIG_TCG_TPM2_HMAC=n to the kernel
> > configuration disables the feature.
> > 
> > For making decisions what to do with the  we are talking about ~2
> > week window estimated, given the Vienna conference slows things
> > down, so I hope my workaround is good enough before that.
> 
> I can enumerate three most likely ways to address the issue:
> 
> 1. Strongest: drop from defconfig.
> 2. Medium: leave to defconfig but add an opt-in kernel command-line
>    parameter.
> 3. Lightest: if we can based on tracing data nail the regression in
>    sustainable schedule, fix it.

Actually, there's a fourth: not use sessions for the PCR extend (if
we'd got the timings when I asked, this was going to be my suggestion
if they came back problematic).  This seems only to be a problem for
IMA measured boot (because it does lots of extends).  If necessary this
could even be wrapped in a separate config or boot option that only
disables HMAC on extend if IMA (so we still get security for things
like sd-boot)

The down side of doing this is that an interposer can drop any extend
it wants without being immediately detected, but as long as they don't
have control of the kernel they can't change the log entry, so the
mismatch would be detected on check (which has to be done by the remote
verifier).  The unavoidable increased threat is that if you get tricked
into booting a malicious kernel (so the attacker has control of the
log) and the interposer substitutes the boot measurements, it can
actually fake out a remote verification system into thinking you're
actually a good node.

James


