Return-Path: <linux-integrity+bounces-4037-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200909BF97C
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 23:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C531C21259
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C3820821F;
	Wed,  6 Nov 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S7/a9XEa";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S7/a9XEa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F0645;
	Wed,  6 Nov 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933533; cv=none; b=RuQdo2odUfSSEScNkkq0Dd5K/rmiGTep8uaepKG4e8f7sXgp/ewt0+0aclHlySWKCA2BE97le2Yw+7xflXqmQo/sk1VHMmxtbXfQn9EeGPLjeIXIw7OzbiCX0+z7hwTT8YjticBlSQLKLs5baP3MELGhucA2BJ7UvMzF9tSGPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933533; c=relaxed/simple;
	bh=YG0xrm1DMyRugxYDIM2uk8ax1govnNSiGqbTfgnvB2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hTnM6hYl+ZtGEkz49xzZMZTLhgk8VqNh7IivgPUHxGeumemIGrWjn8kumL3vFwCneJslJR1mMORPkP+YomNZcXE/6DP0BPHpsz22RPNa3SkglT7ODwhv/ifGKNDRzMGrR0w+HXr6dQ062+bSqrs25tBs242o53lAh7gYuy0rC8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=S7/a9XEa; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=S7/a9XEa; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730933530;
	bh=YG0xrm1DMyRugxYDIM2uk8ax1govnNSiGqbTfgnvB2M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=S7/a9XEaONvL1K7Jh3GNBO4amVUzR7wE2HHIPdw63oVHR/DeT6mnk5vZ9pJ5Aa3KB
	 snEnKhFZy7ONADvxRyp9RbL8F/o+F5LV0fijNjc2JJgaFfn7vk+6ImOAPSNXIoxAAs
	 Wt3ODoUcRTQ8enFPtvge9SS/X5dYoKT2ohj2Nu44=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 617791286A09;
	Wed, 06 Nov 2024 17:52:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id c81u-kYJ4seN; Wed,  6 Nov 2024 17:52:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730933530;
	bh=YG0xrm1DMyRugxYDIM2uk8ax1govnNSiGqbTfgnvB2M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=S7/a9XEaONvL1K7Jh3GNBO4amVUzR7wE2HHIPdw63oVHR/DeT6mnk5vZ9pJ5Aa3KB
	 snEnKhFZy7ONADvxRyp9RbL8F/o+F5LV0fijNjc2JJgaFfn7vk+6ImOAPSNXIoxAAs
	 Wt3ODoUcRTQ8enFPtvge9SS/X5dYoKT2ohj2Nu44=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 98F7212869AC;
	Wed, 06 Nov 2024 17:52:09 -0500 (EST)
Message-ID: <321b247dcfaba5d9691919eec8476b3c6fc7875d.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH] tpm: Allow the TPM2 pcr_extend HMAC capability to
 be disabled on boot
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, mapengyu@gmail.com, Paul Moore
 <paul@paul-moore.com>,  linux-kernel@vger.kernel.org
Date: Wed, 06 Nov 2024 17:52:08 -0500
In-Reply-To: <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
References: <20241015193916.59964-1-zohar@linux.ibm.com>
	 <D5FG6TOVUY5W.3SUG1J3CDB3J5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-11-07 at 00:26 +0200, Jarkko Sakkinen wrote:
> On Tue Oct 15, 2024 at 10:39 PM EEST, Mimi Zohar wrote:
> > The initial TPM2 HMAC session capability added HMAC authentication
> > to each and every TPM communication making the pcr_extend
> > performance abysmal for HW TPMs. Further, the new
> > CONFIG_TCG_TPM2_HMAC option was configured by default on x86_64.
> > 
> > The decision to use the TPM2 HMAC session capability feature
> > doesn't differentiate between the critical encrypted and the non-
> > encrypted communication, but when configured is required for all
> > TPM communication.
> > 
> > In addition, the reason to HMAC the tpm2_pcr_extend() as provided
> > in commit 6519fea6fd37 ("tpm: add hmac checks to
> > tpm2_pcr_extend()") was to protect tpm2_pcr_extend() when used by
> > "trusted keys" to lock the PCR.  However, locking the PCR is
> > currently limited to TPM 1.2.
> > 
> > We can revert the commit which adds the HMAC sessions for
> > tpm2_pcr_extend, allow just the TPM2 pcr_extend HMAC capability to
> > be disabled on boot for better IMA performance, or define a generic
> > boot command line option to disable HMAC in general.  This patch
> > allows disabling the HMAC for just the TPM2_pcr_extend.
> > 
> > Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
> > Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> I have alternative proposal that hit me today.
> 
> First an observation: I think this issue shows that we also stress
> beyond limits desktop configurations with encrypted bus, even tho it
> is
> not in the same way visible. This affects bunch of things, including
> e.g. power consumption. Not a lot but best possible situation would
> be
> if callers could be served without any additional stress.
> 
> A second observation is in [1]: 
> 
> "It is recommended that a TPM implement the RNG in a manner that
> would
> allow it to return RNG octets such that, as long as the value of
> bytesRequested is not greater than the maximum digest size, the
> frequency of bytesRequested being more than the number of octets
> available is an infrequent occurrence."
> 
> I think from this we can derive a fair assumption that with any
> possible
> TPM2 chip we can pull a 32 byte value within a single transcation
> (i.e.
> matching SHA256 digest size).
> 
> So based on these facts I think this might be a sweet spot in making
> a
> compromise between performance and security:
> 
> 1. Generate a 32 byte seed every N iterations (calls of
>    tpm2_get_random(). Store it to chip->random_seed.
> 2. In-between iterations use PRNG to generate the values
>    starting form chip->random_seed.
> 
> I think N could be fairly large without causing any major difference
> (even when analyzed through numerical error analysis) between calling
> TPM2_GetRandom for each and every iteration. And this way bus
> encryption
> never has to be disabled.
> 
> I'd see this as win-win approach.
> 
> PS. I have no idea what kind of PRNG's kernel provides (never used
> such).
> 
> [1] 16.1.TPM2_GetRandom
>    
> https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-3-Commands.pdf

I'm a bit confused here.  It's TPM2_PCR_Extend we have the trouble with
(as Mimi says in her email that you quoted) not TPM2_GetRandom.

The random number generator reseed occurs in a kernel thread that fires
about once a minute, so it doesn't show up in really any of the boot
timings.  Plus even with sessions added, what there now isn't a
significant overhead even to the running kernel given it's asynchronous
and called infrequently.

James


