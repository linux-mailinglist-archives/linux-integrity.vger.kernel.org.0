Return-Path: <linux-integrity+bounces-3519-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469089751E7
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2E41F2126E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883AD1885A3;
	Wed, 11 Sep 2024 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IU9RW3mI";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="bK5KFEC2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9730142E9D;
	Wed, 11 Sep 2024 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057317; cv=none; b=Vhsgg1OSClHGHlmdDeHdfIh/MfSeUaWTsOQnawFYIt4HA1T5t3jffOe5mCFXKdUlRjZRCVn2BmMb9yUW5A75Ho/t4FN0giBMRI/WU/kLW664n4z/ficXKbmrSCTu4+0wLKlnT8A4SNZFl4epHklA+bysDKa/+EQKIU3urGVmhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057317; c=relaxed/simple;
	bh=I3CU6vqBc1DNQE9kRbWBsirZu84BFe/dOVd+LtekJ3A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q7HsVC9VCzv7JWUdUhjglTYrTHQtB6iFTog0LF9Rz6KQ80YyUr84hub3ec/q5w6rfMmIFfDJ9TXTIDiOlHQ3vSOtsL04HqAhGOZiqR1XzqgEyB9w4ND6moelf+lq+qMrvBOUMAhf83IUcVJAGJY2320NoxEyoWBCC2t60DyUSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=IU9RW3mI; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=bK5KFEC2; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726057315;
	bh=I3CU6vqBc1DNQE9kRbWBsirZu84BFe/dOVd+LtekJ3A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=IU9RW3mI9R8zl/C99P+Gku9V5E5D6jugg9pGgd538R18GP5eHl/P/5S0OV8hn5wTt
	 8Rn0SisJ9RMtCf9QOpJ1+Wsk0+GSblPXUcB22RySZFy/uTIj5lgib8weTFlM7zuoLj
	 s1hBTaD1ixlph9CBeFkMAyBjLPGoQKghPJ/IR36U=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 206781286B94;
	Wed, 11 Sep 2024 08:21:55 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Mqnf5WyWn0IY; Wed, 11 Sep 2024 08:21:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726057314;
	bh=I3CU6vqBc1DNQE9kRbWBsirZu84BFe/dOVd+LtekJ3A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=bK5KFEC2xXZMxT0KBb4+57Tt+JHEd4w2ElYK5ZNJAL4GnrBiCkCkJIxurXqFzDfhd
	 8/utvLgx12JT3SAiX0ijQieoSY8SrR9/LAexq81C/QXrYqtTXLB5gAewCJwPiliuyj
	 6kSL0camRQrz5IiG1SCvAuh1RMry2oDDhMaGs+Ac=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 27AE31286A12;
	Wed, 11 Sep 2024 08:21:54 -0400 (EDT)
Message-ID: <10ae7b8592af7bacef87e493e6d628a027641b8d.camel@HansenPartnership.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Jarkko Sakkinen
	 <jarkko@kernel.org>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Wed, 11 Sep 2024 08:21:52 -0400
In-Reply-To: <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
	 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
	 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
	 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
	 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
	 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
	 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-09-11 at 10:53 +0200, Roberto Sassu wrote:
> On Tue, 2024-09-10 at 16:28 +0300, Jarkko Sakkinen wrote:
> > On Tue Sep 10, 2024 at 3:57 PM EEST, James Bottomley wrote:
> > > On Tue, 2024-09-10 at 15:48 +0300, Jarkko Sakkinen wrote:
> > > > On Tue Sep 10, 2024 at 3:39 PM EEST, Jarkko Sakkinen wrote:
> > > > > On Tue Sep 10, 2024 at 12:05 PM EEST, Roberto Sassu wrote:
> > > > > > On Tue, 2024-09-10 at 11:01 +0200, Linux regression
> > > > > > tracking
> > > > > > (Thorsten
> > > > > > Leemhuis) wrote:
> > > > > > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > > > > > > 
> > > > > > > James, Jarkoo, I noticed a report about a regression in
> > > > > > > bugzilla.kernel.org that appears to be caused by this
> > > > > > > change of
> > > > > > > yours:
> > > > > > > 
> > > > > > > 6519fea6fd372b ("tpm: add hmac checks to
> > > > > > > tpm2_pcr_extend()")
> > > > > > > [v6.10-rc1]
> > > > > > > 
> > > > > > > As many (most?) kernel developers don't keep an eye on
> > > > > > > the bug
> > > > > > > tracker,
> > > > > > > I decided to forward it by mail. To quote from
> > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=219229 :
> > > > > > > 
> > > > > > > > When secureboot is enabled,
> > > > > > > > the kernel boot time is ~20 seconds after 6.10 kernel.
> > > > > > > > it's ~7 seconds on 6.8 kernel version.
> > > > > > > > 
> > > > > > > > When secureboot is disabled,
> > > > > > > > the boot time is ~7 seconds too.
> > > > > > > > 
> > > > > > > > Reproduced on both AMD and Intel platform on ThinkPad
> > > > > > > > X1 and
> > > > > > > > T14.
> > > > > > > > 
> > > > > > > > It probably caused autologin failure and micmute led
> > > > > > > > not
> > > > > > > > loaded on AMD platform.
> > > > > > > 
> > > > > > > It was later bisected to the change mentioned above. See
> > > > > > > the
> > > > > > > ticket for
> > > > > > > more details.
> > > > > > 
> > > > > > Hi
> > > > > > 
> > > > > > I suspect I encountered the same problem:
> > > > > > 
> > > > > > https://lore.kernel.org/linux-integrity/b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com/
> > > > > > 
> > > > > > Going to provide more info there.
> > > > > 
> > > > > I suppose you are going try to acquire the tracing data I
> > > > > asked?
> > > > > That would be awesome, thanks for taking the troube.  Let's
> > > > > look
> > > > > at the data and draw conclusions based on that.
> > > > > 
> > > > > Workaround is pretty simple: CONFIG_TCG_TPM2_HMAC=n to the
> > > > > kernel
> > > > > configuration disables the feature.
> > > > > 
> > > > > For making decisions what to do with the  we are talking
> > > > > about ~2
> > > > > week window estimated, given the Vienna conference slows
> > > > > things
> > > > > down, so I hope my workaround is good enough before that.
> > > > 
> > > > I can enumerate three most likely ways to address the issue:
> > > > 
> > > > 1. Strongest: drop from defconfig.
> > > > 2. Medium: leave to defconfig but add an opt-in kernel command-
> > > > line
> > > >    parameter.
> > > > 3. Lightest: if we can based on tracing data nail the
> > > > regression in
> > > >    sustainable schedule, fix it.
> > > 
> > > Actually, there's a fourth: not use sessions for the PCR extend
> > > (if
> > > we'd got the timings when I asked, this was going to be my
> > > suggestion
> > > if they came back problematic).  This seems only to be a problem
> > > for
> > > IMA measured boot (because it does lots of extends).  If
> > > necessary this
> > > could even be wrapped in a separate config or boot option that
> > > only
> > > disables HMAC on extend if IMA (so we still get security for
> > > things
> > > like sd-boot)
> > 
> > I can buy that but with a twist that make it an opt-in kernel
> > command
> > line option. We don't want to take already existing functionality
> > away
> > from those who might want to use it (given e.g. hardening
> > requirements),
> > and with that basis opt-in (by default disabled) would be more
> > balanced
> > way to address the issue.
> > 
> > Please do a send a patch!
> 
> I made few measurements. I have a Fedora 38 VM with TPM passthrough.
> 
> Kernels: 6.11-rc2+ (guest), 6.5.0-45-generic (host)
> 
> QEMU:
> 
> rc  qemu-kvm                                          1:4.2-
> 3ubuntu6.27
> ii  qemu-system-x86                                   1:6.2+dfsg-
> 2ubuntu6.22
> 
> 
> TPM2_PT_MANUFACTURER:
>   raw: 0x49465800
>   value: "IFX"
> TPM2_PT_VENDOR_STRING_1:
>   raw: 0x534C4239
>   value: "SLB9"
> TPM2_PT_VENDOR_STRING_2:
>   raw: 0x36373000
>   value: "670"
> 
> 
> No HMAC:
> 
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
>  0)               |  tpm2_pcr_extend() {
>  0)   1.112 us    |    tpm_buf_append_hmac_session();
>  0) # 6360.029 us |    tpm_transmit_cmd();
>  0) # 6415.012 us |  }
> 
> 
> HMAC:
> 
> # tracer: function_graph
> #
> # CPU  DURATION                  FUNCTION CALLS
> # |     |   |                     |   |   |   |
>  1)               |  tpm2_pcr_extend() {
>  1)               |    tpm2_start_auth_session() {
>  1) * 36976.99 us |      tpm_transmit_cmd();
>  1) * 84746.51 us |      tpm_transmit_cmd();
>  1) # 3195.083 us |      tpm_transmit_cmd();
>  1) @ 126795.1 us |    }
>  1)   2.254 us    |    tpm_buf_append_hmac_session();
>  1)   3.546 us    |    tpm_buf_fill_hmac_session();
>  1) * 24356.46 us |    tpm_transmit_cmd();
>  1)   3.496 us    |    tpm_buf_check_hmac_response();
>  1) @ 151171.0 us |  }

Well, unfortunately, that tells us that it's the TPM itself that's
taking the time processing the security overhead.  The ordering of the
commands in tpm2_start_auth_session() shows

 37ms for context restore of null key
 85ms for start session with encrypted salt
  3ms to flush null key
-----
125ms

If we context save the session, we'd likely only bear a single 37ms
cost to restore it (replacing the total 125ms).  However, there's
nothing we can do about the extend execution going from 6ms to 24ms, so
I could halve your current boot time with security enabled (it's
currently 149ms, it would go to 61ms, but it's still 10x slower than
the unsecured extend at 6ms)

James


