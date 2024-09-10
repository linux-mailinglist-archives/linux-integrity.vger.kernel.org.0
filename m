Return-Path: <linux-integrity+bounces-3500-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D509E97371A
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 14:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8031F26312
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 12:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD118D637;
	Tue, 10 Sep 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="U1xPKDnU";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="U1xPKDnU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AD18FC93;
	Tue, 10 Sep 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970926; cv=none; b=Ae4aKT1jKk0ApT2gpXuS+3SDWVpsVbeSXaLl2hAMAbce0PT8hyd74ug9wMb0CVrZStgPR09G4F8R2l0IE/SmxA31a3oK8VBbDebxeOjsevcJgYR3Fke/zvami8PM4Q1o0HLa6Tw9GkV+Ze30l6MRugRUcahkM9sdgaW/jEwvx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970926; c=relaxed/simple;
	bh=t8W/jmPNnZNV0/iZgLBsYsClFsS4Tymq4Z557UQtzxQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0h3xop7Iyy4D5FqOg/XZWfturefmeDAo1GY7RPDwGz1yO6PxwgogGwEcw0Rhy7va4p/K7C9mGczxuNSJCMW7LROcKpICOXM8WZBJxMxPhbFyVTBIfYmipB0a7Ke6xYJWmEfWi9hFVoTzPvv4z1JpqHmkvvUEv35gMYb0Z5PXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=U1xPKDnU; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=U1xPKDnU; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1725970923;
	bh=t8W/jmPNnZNV0/iZgLBsYsClFsS4Tymq4Z557UQtzxQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=U1xPKDnUlTfuns15BHiTbf+jieehV24DELi68PDG7aNklsA06iZsJVtkqSE7z78xR
	 ixpyokwfzWzLBbjaEWAMFowV984kwChWG7kRTe5tqkpdg7B//lp4FBGt3hIW7x8qZF
	 pJMD0Rv7CuFvs858mX6LtwdrccXwaW0nQU7RE1aI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE32C128739B;
	Tue, 10 Sep 2024 08:22:03 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hQhBGdRparfz; Tue, 10 Sep 2024 08:22:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1725970923;
	bh=t8W/jmPNnZNV0/iZgLBsYsClFsS4Tymq4Z557UQtzxQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=U1xPKDnUlTfuns15BHiTbf+jieehV24DELi68PDG7aNklsA06iZsJVtkqSE7z78xR
	 ixpyokwfzWzLBbjaEWAMFowV984kwChWG7kRTe5tqkpdg7B//lp4FBGt3hIW7x8qZF
	 pJMD0Rv7CuFvs858mX6LtwdrccXwaW0nQU7RE1aI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0F1CF128627B;
	Tue, 10 Sep 2024 08:22:02 -0400 (EDT)
Message-ID: <db275ab4fb73fc089c66738ffbcab23557e53055.camel@HansenPartnership.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Jarkko
	Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Tue, 10 Sep 2024 08:22:00 -0400
In-Reply-To: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-09-10 at 11:01 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> James, Jarkoo, I noticed a report about a regression in
> bugzilla.kernel.org that appears to be caused by this change of
> yours:
> 
> 6519fea6fd372b ("tpm: add hmac checks to tpm2_pcr_extend()") [v6.10-
> rc1]
> 
> As many (most?) kernel developers don't keep an eye on the bug
> tracker, I decided to forward it by mail. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=219229 :
> 
> > When secureboot is enabled,
> > the kernel boot time is ~20 seconds after 6.10 kernel.
> > it's ~7 seconds on 6.8 kernel version.
> > 
> > When secureboot is disabled,
> > the boot time is ~7 seconds too.
> > 
> > Reproduced on both AMD and Intel platform on ThinkPad X1 and T14.
> > 
> > It probably caused autologin failure and micmute led not loaded on
> > AMD platform.
> 
> It was later bisected to the change mentioned above. See the ticket
> for more details.

We always suspected encryption and hmac would add overheads which is
why it's gated by a config option.  The way to fix this is to set

CONFIG_TCG_TPM_HMAC to N

of course, TPM transactions are then insecure, but it's the same state
as you were in before.

James



