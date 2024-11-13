Return-Path: <linux-integrity+bounces-4114-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F39C7E41
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 23:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E50DB20E91
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A2515444E;
	Wed, 13 Nov 2024 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQVD3hNX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1513959D
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537275; cv=none; b=n2DmIPPO05TVIsBJpuXYxRwTREVP/SGgoaKzNRznpRpuBlZdhSLJtpeCVzv23WydQBIb3g+iwRuzerVAPdUhsS5/TIOESlWRQTUKIpR5TRExjzCL/OwagY0GeFnfEMQ7AgqIIW/dOPrgb4b2Yg5K0Hr3KSzD2iTGpOT2PlnTo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537275; c=relaxed/simple;
	bh=RtVhSAyivYj1SOkWewbZPk/a0NLPUO99+4OoewwmURI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=mW2AeaN5ldlid/IzawANTgKVJmkXXQa5SNf1aQ69qLvTJVN1XYa8qSfmRTRsfVUcdNfX9V4ToO73CqD+AIfYeI0GBVkE54j64Bdc12ox+1A9MF9Z8AJ4d033UG0dL6L4zFx4hyBYA74GO42tj1gCMG7RbNwQY+O2R56ymtJgAYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQVD3hNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501BBC4CEC3;
	Wed, 13 Nov 2024 22:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731537274;
	bh=RtVhSAyivYj1SOkWewbZPk/a0NLPUO99+4OoewwmURI=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=uQVD3hNXby426v0R4AQr1Ma+mN9V+9chaMARCUh1NwAFT2yE4rJ/jX/QL1iLi5er3
	 WNfShkCMKLRRKA8qQ32qgGQfRMHGAxe9JZfMPxldqjYLu5uDsNL7O74pEWzSRGaf6J
	 qSPZr0yT0CVcQ9jzxvFSTP1zAeDlRcmXEpSQIpNwB6tqCpDdxP9MYABg1E6YYlP78L
	 TCEn8c495+WSWJQEkXshqqFZL+nIENf8sc9LyeJFZVPyyuipUyys91zFyszOTJJZEI
	 6V1+PCRlwnfQTBkdmvSVtpFwkm34D9x3WTZdQdGnvnj/rgVVALZ8CClE+Uaxvkppi1
	 co2OSWfa3KCOw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Nov 2024 00:34:30 +0200
Message-Id: <D5LEQGJ9X3NF.3K3YVPNE6KQJK@kernel.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Christoph
 Anton Mitterer" <calestyo@scientia.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
 <89542959611252d64572ffad438f48b4f54131f0.camel@HansenPartnership.com>
In-Reply-To: <89542959611252d64572ffad438f48b4f54131f0.camel@HansenPartnership.com>

On Wed Nov 13, 2024 at 8:12 PM EET, James Bottomley wrote:
> > I think we might have to expect the NULL name to change on actual
> > hibernation because unlike suspend to ram it does power off the TPM.
>
> I checked the code: we're coming in on the correct path to renew the
> null seed after hibernation, so it should all work.  The problem seems
> to be that your TPM itself is doing something invalid because the name
> we calculate for the primary key doesn't match what your TPM says it
> should be.  Absent some form of attack or bus integrity problem, that
> shouldn't ever happen, so I'm even more curious to know why it worked
> in 6.11.5 and before and whether current upstream works.
>
> I haven't found it yet, but I think the every 10s signature is because
> the hibernation path is trying to restart the TPM device and won't take
> no for an answer.

My fix returned the behavior how it was before my earlier fix in this
corner case (i.e. disable TPM). The issue has gone unnoticed before
since it has emitted only a single klog entry.

On suspend this has not happened to me so obvious deduction is that
hibernate resets the null seed.

Hibernate needs an addition a fix to disable bus encryption from kernel
command-line completely, i.e. tpm.disable_integrity following the
convention from my earlier fix [1].

Fast-forward, in order to *enable* bus encryption with hibernate, a
feature patch would be needed to specify a NV key in the kernel
command-line. It probably cannot be resolved with a null key, at least
not based on these empirical results... I would not mind to be wrong in
this tho.

So to summarize:

1. Fix: tpm.disable_integrity
2. Feature:  tpm.integrity_key=3D<persistent handle>

I've never got hibernate working even after trying and without even=20
having TPM in the configuration so pretty hard to test it beforehand...

[1] https://lore.kernel.org/linux-integrity/20241113184449.477731-1-jarkko@=
kernel.org/T/#u

BR, Jarkko

