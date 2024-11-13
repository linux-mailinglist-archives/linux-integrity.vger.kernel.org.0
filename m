Return-Path: <linux-integrity+bounces-4107-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52E29C7ACF
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 19:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8918128B8E7
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495FA202F80;
	Wed, 13 Nov 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Q7NgK5hT";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Q7NgK5hT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617D13CFBD
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521579; cv=none; b=tx8NQZWhYk1b8MS0cF8/s/KUddRM3Ugf1QaP2iCkuZKNkVEQPdoC+PArPLpSe5839DqhOCg1n+z+RePnX9aoiwK9vteSPuWxQZHC96XUnqyJe/bGg0iKWazE/92XM4QYmob+s7lfus4ZNHa+9eIjskXFGrdeSAPDFTDMKWxW+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521579; c=relaxed/simple;
	bh=DO4v255/lB8S5OtMlDk2fKw2CtihxhflQjmaKeMSAxg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HC72oWSJQUMDgfhc0/EKZed9KiXw9GS+DTaoDbrcCe5lw5hCNLyXbgnqE+IdZpzpAZBaWPuNU7xE36BZAH3YfGyB+QPag0ikbBuyPjZscJE5SVo0vfYHuatUQVAZetGmMYOOIHY/nNijF8GFNd1Ze//yvBsZII5VO2H201p62IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Q7NgK5hT; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Q7NgK5hT; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731521576;
	bh=DO4v255/lB8S5OtMlDk2fKw2CtihxhflQjmaKeMSAxg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Q7NgK5hTNlLYhyZYIsSyr/z4vae6KBipOuhCMkRwW1hzn/L0G9FJBzM83cu5LQqkY
	 WNvN57HIydq3awHGNmUI0nH0YatiEDeZyH7kYfH4eHt/NqO2H1xV0jNqug2nnc3jQ5
	 9aP0qtM4Zyd4ntxbHmWdNgS7zgOc1cdOHpdYoip0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6BA391285F82;
	Wed, 13 Nov 2024 13:12:56 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id VcTbQnrehrxG; Wed, 13 Nov 2024 13:12:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1731521576;
	bh=DO4v255/lB8S5OtMlDk2fKw2CtihxhflQjmaKeMSAxg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Q7NgK5hTNlLYhyZYIsSyr/z4vae6KBipOuhCMkRwW1hzn/L0G9FJBzM83cu5LQqkY
	 WNvN57HIydq3awHGNmUI0nH0YatiEDeZyH7kYfH4eHt/NqO2H1xV0jNqug2nnc3jQ5
	 9aP0qtM4Zyd4ntxbHmWdNgS7zgOc1cdOHpdYoip0=
Received: from [10.106.168.49] (unknown [167.220.104.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 269911281B1B;
	Wed, 13 Nov 2024 13:12:56 -0500 (EST)
Message-ID: <89542959611252d64572ffad438f48b4f54131f0.camel@HansenPartnership.com>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christoph Anton Mitterer <calestyo@scientia.org>, 
	linux-integrity@vger.kernel.org
Date: Wed, 13 Nov 2024 10:12:54 -0800
In-Reply-To: <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
	 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-11-13 at 07:47 -0800, James Bottomley wrote:
> On Wed, 2024-11-13 at 15:44 +0100, Christoph Anton Mitterer wrote:
> > Hey.
> > 
> > Forwarding myself from:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1087331
> > 
> > Since 6.11.7 (might have also happened with .6, which I've skipped,
> > but wasn't the case at least in 6.11.5).
> > 
> > I get:
> > Nov 11 17:50:20 heisenberg kernel: tpm tpm0: A TPM error (2306)
> > occurred attempting to create NULL primary
> > Nov 11 17:50:30 heisenberg kernel: tpm tpm0: A TPM error (2306)
> > occurred attempting to create NULL primary
> > Nov 11 17:50:41 heisenberg kernel: tpm tpm0: A TPM error (2306)
> > occurred attempting to create NULL primary
> > Nov 11 17:50:51 heisenberg kernel: tpm tpm0: A TPM error (2306)
> > occurred attempting to create NULL primary
> > Nov 11 17:51:01 heisenberg kernel: tpm tpm0: A TPM error (2306)
> > occurred attempting to create NULL primary
> > Nov 11 17:51:11 heisenberg kernel: tpm tpm0: A TPM error (2306)
> > occurred attempting to create NULL primary
> 
> 2306 is TPM_RC_OBJECT_MEMORY - out of memory for object contexts. 
> What it's saying is that somewhere we're missing a context flush. 
> I'll take a look.  Does this happen with the current upstream
> kernel?  It couldbe a flush got lost as a result of a bad stable
> backport.

OK, I found it; there's a bug in the handling of create primary on a
validation rather than a TPM error (it doesn't flush the handle). 
However, even when I fix that you're apparently going to get the below
message every 10s or so as the TPM tries to init

> 
> > It seems that this doesn't occur on a fresh boot, but only when I
> > resume from hibernation:
> 
> That could be more significant, especially with this in the log:
> 
> > Nov 13 12:33:06 heisenberg kernel: tpm tpm0: NULL Seed name
> > comparison failed
> > Nov 13 12:33:16 heisenberg kernel: tpm tpm0: NULL Seed name
> > comparison failed
> > Nov 13 12:33:26 heisenberg kernel: tpm tpm0: NULL Seed name
> > comparison failed
> 
> I think we might have to expect the NULL name to change on actual
> hibernation because unlike suspend to ram it does power off the TPM.

I checked the code: we're coming in on the correct path to renew the
null seed after hibernation, so it should all work.  The problem seems
to be that your TPM itself is doing something invalid because the name
we calculate for the primary key doesn't match what your TPM says it
should be.  Absent some form of attack or bus integrity problem, that
shouldn't ever happen, so I'm even more curious to know why it worked
in 6.11.5 and before and whether current upstream works.

I haven't found it yet, but I think the every 10s signature is because
the hibernation path is trying to restart the TPM device and won't take
no for an answer.


