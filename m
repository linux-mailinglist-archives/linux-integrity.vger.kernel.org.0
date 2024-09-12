Return-Path: <linux-integrity+bounces-3547-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC11976BB3
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 16:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E041F22E41
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9051AD26E;
	Thu, 12 Sep 2024 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="KHwgP26A";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="KHwgP26A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25B1A76D7;
	Thu, 12 Sep 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150403; cv=none; b=c9QhmoHyLW32MRdTJ2CE1S6f+p9CpyufM+WZgLEcxWT+hqsnJYlP05eow6RY/xFyK5uUutqs4MQxsYymQR7E3g+6eluM6EF9ZNyNsyx+dyofNRE21kgVEiQ7N/NYkLJo4ef7hz5OGzpdudRKDKhSkDudlA6NWbtlPQLRbyQdY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150403; c=relaxed/simple;
	bh=ct4z0dPkJEQlzfRDyD/0sHRx5bTXqFUn45NsNHmvyUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kQUbDWXV2b7b+VX3lGqFY+2J0gKPPmRHvA7oFyTayzGEyp3kgtmdheCKAzCeoPj1lbZiWpctw4krpKMrbbAy+K+qKmNzCggCe5lPScF8fNrL1gq9v5lddb6lQFfzU2x16NT4F7D9COCOJq93pUfaQWonmrvzkK3IshggUlyfGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=KHwgP26A; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=KHwgP26A; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726150401;
	bh=ct4z0dPkJEQlzfRDyD/0sHRx5bTXqFUn45NsNHmvyUw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=KHwgP26ABpin6e78cz13oP17+ryoY54nk8x5ny/1h9DanubVTHIQoX0VoxIOyLKfh
	 wiQ+qAsxwotEyW654aWLCvQi9Hb7zo2MrfxwzbaWGJmuGOcIqyMHsv0F8UAslyocPQ
	 NVpjlkCZM1GDcCjomQfb5XKUdlpZ04Tvz+y3n9D0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A968E1286B75;
	Thu, 12 Sep 2024 10:13:21 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 5kw-eg-FsyVm; Thu, 12 Sep 2024 10:13:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726150401;
	bh=ct4z0dPkJEQlzfRDyD/0sHRx5bTXqFUn45NsNHmvyUw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=KHwgP26ABpin6e78cz13oP17+ryoY54nk8x5ny/1h9DanubVTHIQoX0VoxIOyLKfh
	 wiQ+qAsxwotEyW654aWLCvQi9Hb7zo2MrfxwzbaWGJmuGOcIqyMHsv0F8UAslyocPQ
	 NVpjlkCZM1GDcCjomQfb5XKUdlpZ04Tvz+y3n9D0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CC88E128680B;
	Thu, 12 Sep 2024 10:13:20 -0400 (EDT)
Message-ID: <e3d0947a45f7a6fea0dca345deaa52baf9ffaaf6.camel@HansenPartnership.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Jarkko Sakkinen
	 <jarkko@kernel.org>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Thu, 12 Sep 2024 10:13:18 -0400
In-Reply-To: <155190f0eb0974e223538f10afaa7860c5a61cf5.camel@huaweicloud.com>
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
	 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
	 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
	 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
	 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
	 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
	 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
	 <10ae7b8592af7bacef87e493e6d628a027641b8d.camel@HansenPartnership.com>
	 <D44C19QB8IK1.OMUJP7N91HRN@kernel.org>
	 <c47b129aeb95094aace5b174fc6d81bf0a7ecfbf.camel@HansenPartnership.com>
	 <155190f0eb0974e223538f10afaa7860c5a61cf5.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-09-12 at 15:36 +0200, Roberto Sassu wrote:
> On Thu, 2024-09-12 at 09:26 -0400, James Bottomley wrote:
> > On Thu, 2024-09-12 at 16:16 +0300, Jarkko Sakkinen wrote:
> > > On Wed Sep 11, 2024 at 3:21 PM EEST, James Bottomley wrote:
> > > > On Wed, 2024-09-11 at 10:53 +0200, Roberto Sassu wrote:
> > [...]
> > > > > I made few measurements. I have a Fedora 38 VM with TPM
> > > > > passthrough.
> > > > > 
> > > > > Kernels: 6.11-rc2+ (guest), 6.5.0-45-generic (host)
> > > > > 
> > > > > QEMU:
> > > > > 
> > > > > rc  qemu-kvm                                          1:4.2-
> > > > > 3ubuntu6.27
> > > > > ii  qemu-system-x86                                  
> > > > > 1:6.2+dfsg-
> > > > > 2ubuntu6.22
> > > > > 
> > > > > 
> > > > > TPM2_PT_MANUFACTURER:
> > > > >   raw: 0x49465800
> > > > >   value: "IFX"
> > > > > TPM2_PT_VENDOR_STRING_1:
> > > > >   raw: 0x534C4239
> > > > >   value: "SLB9"
> > > > > TPM2_PT_VENDOR_STRING_2:
> > > > >   raw: 0x36373000
> > > > >   value: "670"
> > > > > 
> > > > > 
> > > > > No HMAC:
> > > > > 
> > > > > # tracer: function_graph
> > > > > #
> > > > > # CPU  DURATION                  FUNCTION CALLS
> > > > > # |     |   |                     |   |   |   |
> > > > >  0)               |  tpm2_pcr_extend() {
> > > > >  0)   1.112 us    |    tpm_buf_append_hmac_session();
> > > > >  0) # 6360.029 us |    tpm_transmit_cmd();
> > > > >  0) # 6415.012 us |  }
> > > > > 
> > > > > 
> > > > > HMAC:
> > > > > 
> > > > > # tracer: function_graph
> > > > > #
> > > > > # CPU  DURATION                  FUNCTION CALLS
> > > > > # |     |   |                     |   |   |   |
> > > > >  1)               |  tpm2_pcr_extend() {
> > > > >  1)               |    tpm2_start_auth_session() {
> > > > >  1) * 36976.99 us |      tpm_transmit_cmd();
> > > > >  1) * 84746.51 us |      tpm_transmit_cmd();
> > > > >  1) # 3195.083 us |      tpm_transmit_cmd();
> > > > >  1) @ 126795.1 us |    }
> > > > >  1)   2.254 us    |    tpm_buf_append_hmac_session();
> > > > >  1)   3.546 us    |    tpm_buf_fill_hmac_session();
> > > > >  1) * 24356.46 us |    tpm_transmit_cmd();
> > > > >  1)   3.496 us    |    tpm_buf_check_hmac_response();
> > > > >  1) @ 151171.0 us |  }
> > > > 
> > > > Well, unfortunately, that tells us that it's the TPM itself
> > > > that's
> > > > taking the time processing the security overhead.  The ordering
> > > > of
> > > > the commands in tpm2_start_auth_session() shows
> > > > 
> > > >  37ms for context restore of null key
> > > >  85ms for start session with encrypted salt
> > > >   3ms to flush null key
> > > > -----
> > > > 125ms
> > > > 
> > > > If we context save the session, we'd likely only bear a single
> > > > 37ms
> > > > cost to restore it (replacing the total 125ms).  However,
> > > > there's
> > > > nothing we can do about the extend execution going from 6ms to
> > > > 24ms, so I could halve your current boot time with security
> > > > enabled
> > > > (it's currently 149ms, it would go to 61ms, but it's still 10x
> > > > slower than the unsecured extend at 6ms)
> > > > 
> > > > James
> > > 
> > > I'll hold for better benchmarks.
> > 
> > Well, yes, I'd like to see this for a variety of TPMs.
> > 
> > This one clearly shows it's the real time wait for the TPM (since
> > it dwarfs the CPU time calculation there's not much optimization we
> > can do on the kernel end).  The one thing that's missing in all of
> > this is what was the TPM?  but even if it's an outlier that's
> > really bad at crypto what should we do?  We could have a blacklist
> > that turns off the extend hmac (or a whitelist that turns it on),
> > but we can't simply say too bad you need a better TPM.
> 
> Ops, sorry. I pasted the TPM properties. Was not that clear:
> 
> Infineon Optiga SLB9670 (interpreting the properties).

OK, that's reasonably modern and common:

https://www.infineon.com/cms/en/product/security-smart-card-solutions/optiga-embedded-security-solutions/optiga-tpm/

I assume it's one of the Q20 (otherwise it would be a TPM 1.2) but what
firmware version (as in could it be upgraded and the tests re-run to
see if that makes a difference).

I also need the IMA community to start thinking about what they're
willing to accept in terms of performance for the added security hmac
brings to TPM extends.

James



