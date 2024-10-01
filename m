Return-Path: <linux-integrity+bounces-3719-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE898B158
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2024 02:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89F91C20B0F
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2024 00:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA3B645;
	Tue,  1 Oct 2024 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RK+s5Lno";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="csQW7FbN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E06623
	for <linux-integrity@vger.kernel.org>; Tue,  1 Oct 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741789; cv=none; b=uE4FshSqz0Hs73LSIKxjVqxR4ii/T1X8RrkZ0/tG4/gbm1qpYdDR6JYPxlLd4RrcWcsvzgoepc54cq678h4qLmNM1UgF73TKYXdUKS7rE6K6Al6/wFO/+MEd8cXD7K53WeneHA2DAXXpajrNLi+TZaaEEMvDQYc8EdP7E66qqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741789; c=relaxed/simple;
	bh=g6vJc9CNdzGl1lyt4fxzS/PFrnSNrhkciGXc3dHKxmk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qt+HGGTgeF5jCVjY4J/Ro3FJ81pMqRiOGS4dQnRKspgxhqWaEkkTzFO7QdC1Xaepl/3cq8b4M0uz41AP6MPfBTLrk+3cbUHsq0KHDqEc/lWgpRcNjrT/N945bohqlpm8n2wypgD5nGcCVUz82/w0ixCCNOlfD8gEEFZLBQ4ZR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=RK+s5Lno; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=csQW7FbN; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727741787;
	bh=g6vJc9CNdzGl1lyt4fxzS/PFrnSNrhkciGXc3dHKxmk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=RK+s5Lnowti3To74RVj2zLaXXFuMg93+djr9gF+pUco7D1Y8NSTBIgmVkkTdEUhu5
	 JDKxoTOmZn7i/BiS8uKJ6lOh+E5IkaBmu4cDvq9NcF+f34dzK7J0GuwmUZI20JTkI/
	 rhh99qxbGXR8SPv9gvMOfLLB9ytk+hxAziDJAohA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0DA8B12809D2;
	Mon, 30 Sep 2024 20:16:27 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id CVitkWhrzGi9; Mon, 30 Sep 2024 20:16:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1727741786;
	bh=g6vJc9CNdzGl1lyt4fxzS/PFrnSNrhkciGXc3dHKxmk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=csQW7FbNwfz7xkHvOJzXOst71+m9V+PNwOvjOrilB+uCWoThSdya9SI1JhhZZfByy
	 XbiH9hn4LKXwLrP2BM4+cxpTk7JglRbTk2AqS3PFR1DDr05c+LevokdoDaNIQjyZqK
	 2A7V9ZzSmRHg2vHbXMk3QXQY+Y8YgZCdWi+i9Rxg=
Received: from [10.106.168.49] (unknown [167.220.104.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A92AF12805CF;
	Mon, 30 Sep 2024 20:16:26 -0400 (EDT)
Message-ID: <1f1e3b64c24608e9a37f959d9cf7e1f869311410.camel@HansenPartnership.com>
Subject: Re: TPM HMAC (really) bad performance
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	 <roberto.sassu@huaweicloud.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
Date: Mon, 30 Sep 2024 17:16:25 -0700
In-Reply-To: <dd0f55e179ae6aaa1c99c320facc1bb33ccb25c8.camel@linux.ibm.com>
References: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
	 <d66af0d491f7576c7d865bf6de4da4c83cf0c3ba.camel@huaweicloud.com>
	 <7025be516c4de1cbd8958c80242f503cc6e92c4a.camel@HansenPartnership.com>
	 <dd0f55e179ae6aaa1c99c320facc1bb33ccb25c8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-09-30 at 10:09 -0400, Mimi Zohar wrote:
> On Fri, 2024-09-27 at 10:15 -0400, James Bottomley wrote:
> > On Fri, 2024-09-27 at 15:53 +0200, Roberto Sassu wrote:
> > > On Fri, 2024-09-06 at 14:32 +0200, Roberto Sassu wrote:
> > > > Hi all
> > > > 
> > > > when running the benchmark on my new component, the Integrity
> > > > Digest Cache, I ran into a serious performance issue.
> > > > 
> > > > The benchmark is extending a TPM PCR with 12313 entries of the
> > > > IMA measurement list, and calculating the time elapsed for the
> > > > operation.
> > > > 
> > > > Without TPM HMAC: 102.8 seconds
> > > > 
> > > > With TPM HMAC: 1941.71 seconds
> > > 
> > > Jarkko patch set [1] improved the performance:
> > > 
> > > 404.4 seconds
> > > 
> > > 
> > > Still quite slow.
> > 
> > So this is now the internal TPM overhead.  There's not much we can
> > do in the kernel to optimize that.  Your own figures were
> > 
> > > No HMAC:
> > > 
> > > # tracer: function_graph
> > > #
> > > # CPU  DURATION                  FUNCTION CALLS
> > > # |     |   |                     |   |   |   |
> > >  0)               |  tpm2_pcr_extend() {
> > >  0)   1.112 us    |    tpm_buf_append_hmac_session();
> > >  0) # 6360.029 us |    tpm_transmit_cmd();
> > >  0) # 6415.012 us |  }
> > > 
> > > 
> > > HMAC:
> > > 
> > > # tracer: function_graph
> > > #
> > > # CPU  DURATION                  FUNCTION CALLS
> > > # |     |   |                     |   |   |   |
> > >  1)               |  tpm2_pcr_extend() {
> > >  1)               |    tpm2_start_auth_session() {
> > >  1) * 36976.99 us |      tpm_transmit_cmd();
> > >  1) * 84746.51 us |      tpm_transmit_cmd();
> > >  1) # 3195.083 us |      tpm_transmit_cmd();
> > >  1) @ 126795.1 us |    }
> > >  1)   2.254 us    |    tpm_buf_append_hmac_session();
> > >  1)   3.546 us    |    tpm_buf_fill_hmac_session();
> > >  1) * 24356.46 us |    tpm_transmit_cmd();
> > >  1)   3.496 us    |    tpm_buf_check_hmac_response();
> > >  1) @ 151171.0 us |  }
> > 
> > or 6ms for no session extend vs 24ms for with session extend, so
> > effectively 4x slower, which is exactly what the above figures are
> > also showing.
> > 
> > >  We should consider not only the boot performance.
> > > Depending on the use case, IMA can be used after boot and slow
> > > down applications performance.
> > 
> > Right, but this is IMA fish or cut bait time: are you willing to
> > pay a 4x penalty for improved security, bearing in mind that not
> > all TPMs will show the 4x slow down, since some have much better
> > optimized crypto routines.  If yes, we can simply keep the no flush
> > optimization. If no, we'd have to turn off security for IMA extends
> 
> Another way of looking at it is that the performance for existing
> TPMs is unacceptable with CONFIG_TCG_TPM2_HMAC configured at least
> for the builtin "ima_policy=tcb" policy, replaced with a similar
> custom policy.  Without Jarkko's patch set it takes ~10 minutes to
> boot.  With Jarkko's patch set it takes ~3 minutes.

So that's the question: is 3 minutes acceptable?

>  Saying it will work with newer, faster TPMs isn't a viable solution
> for distros.  Either the Kconfig is turned on or not for all systems.
> 
> Is the reason for the performance degradation due to the HMAC or
> encryption?

It's the HMAC.  There's no security sensitive information in an extend
so no reason to do encrypt/decrypt as well.

>   If the performance degradation is due to the HMAC, then the last
> line should be:
> "Saying Y here adds some overhead to all kernel to TPM transactions".
> 
> config TCG_TPM2_HMAC
>         bool "Use HMAC and encrypted transactions on the TPM bus"
>         default X86_64
>         select CRYPTO_ECDH
>         select CRYPTO_LIB_AESCFB
>         select CRYPTO_LIB_SHA256
>         help
>           Setting this causes us to deploy a scheme which uses
> request
>           and response HMACs in addition to encryption for
>           communicating with the TPM to prevent or detect bus
> snooping
>           and interposer attacks (see tpm-security.rst).  Saying Y
>           here adds some encryption overhead to all kernel to TPM
>           transactions.
> 
> I'm not quite sure what you mean by "If no, we'd have to turn off
> security for IMA extends."  Are you leaving it enabled for all other
> TPM communication,

Since IMA is the only current user of tpm2_pcr_extend() that's an
option, yes.  This would mean an interposer could intercept and either
discard or modify an extend without being detected.

>  just disabling it for IMA or disabling it entirely based on whether
> IMA is configured?

Since tpm2_pcr_extend() is unused if IMA is disabled, we don't really
need to condition on it, we could just remove the HMAC from extends.

James


