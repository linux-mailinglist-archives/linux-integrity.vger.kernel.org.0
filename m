Return-Path: <linux-integrity+bounces-3515-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F54974D93
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 10:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A834B26337
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A513F454;
	Wed, 11 Sep 2024 08:54:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321214A4C9;
	Wed, 11 Sep 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044861; cv=none; b=AcE/1rAlcRpPgbw7GXN7MVyuFZkqV3Cs11YzGq63pDjVJiurxETwryan9mSQ8rRcfHwhNlqpqXv8yvVjU34R2sQQkoq62YrQtj5l5R3TJ2UxmSECvP0N1zBWOt576nwxcw129cQGO7Hu4vaRHIqbQnAxWhJLXTjjwcawjjB0Bes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044861; c=relaxed/simple;
	bh=rJPbtnkHQ2l7lTyGvmWBf5lTCdxiRikteRMLjPsYh4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KBxlhz00Uc00cIq9V+clDP5Ek8a/4AiFgyDLE/EQ4pae4eP4/WWYROpFTn0DJiN+yp2L+RyvHIZUPJUa6r+6n+cDAfaUwcKU9k++0hnzXN1FsVEAHRthK6S+2idGcIcxwFCPx/r71F9LVnhBzZF6D7AB/kf5g2N2JhO7mjzaaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X3Yls2CNcz9v7NX;
	Wed, 11 Sep 2024 16:34:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1D9AF1405A0;
	Wed, 11 Sep 2024 16:54:11 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnVsenWuFmboy0AA--.59422S2;
	Wed, 11 Sep 2024 09:54:10 +0100 (CET)
Message-ID: <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, James Bottomley
	 <James.Bottomley@HansenPartnership.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Wed, 11 Sep 2024 10:53:56 +0200
In-Reply-To: <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
	 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
	 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
	 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
	 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
	 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCnVsenWuFmboy0AA--.59422S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr13uF15GF45ury3WryxuFg_yoWrZw48pF
	WrJayDKr1kXr10yws2yr4UZa4qyryrJr45Xrn8Jr1fA3Zxtryfuw1avr4a9FyDWr1kC3WS
	vr42v3sFv34qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQEjAAAsA

On Tue, 2024-09-10 at 16:28 +0300, Jarkko Sakkinen wrote:
> On Tue Sep 10, 2024 at 3:57 PM EEST, James Bottomley wrote:
> > On Tue, 2024-09-10 at 15:48 +0300, Jarkko Sakkinen wrote:
> > > On Tue Sep 10, 2024 at 3:39 PM EEST, Jarkko Sakkinen wrote:
> > > > On Tue Sep 10, 2024 at 12:05 PM EEST, Roberto Sassu wrote:
> > > > > On Tue, 2024-09-10 at 11:01 +0200, Linux regression tracking
> > > > > (Thorsten
> > > > > Leemhuis) wrote:
> > > > > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > > > > >=20
> > > > > > James, Jarkoo, I noticed a report about a regression in
> > > > > > bugzilla.kernel.org that appears to be caused by this change of
> > > > > > yours:
> > > > > >=20
> > > > > > 6519fea6fd372b ("tpm: add hmac checks to tpm2_pcr_extend()")
> > > > > > [v6.10-rc1]
> > > > > >=20
> > > > > > As many (most?) kernel developers don't keep an eye on the bug
> > > > > > tracker,
> > > > > > I decided to forward it by mail. To quote from
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229=C2=A0:
> > > > > >=20
> > > > > > > When secureboot is enabled,
> > > > > > > the kernel boot time is ~20 seconds after 6.10 kernel.
> > > > > > > it's ~7 seconds on 6.8 kernel version.
> > > > > > >=20
> > > > > > > When secureboot is disabled,
> > > > > > > the boot time is ~7 seconds too.
> > > > > > >=20
> > > > > > > Reproduced on both AMD and Intel platform on ThinkPad X1 and
> > > > > > > T14.
> > > > > > >=20
> > > > > > > It probably caused autologin failure and micmute led not
> > > > > > > loaded on AMD platform.
> > > > > >=20
> > > > > > It was later bisected to the change mentioned above. See the
> > > > > > ticket for
> > > > > > more details.
> > > > >=20
> > > > > Hi
> > > > >=20
> > > > > I suspect I encountered the same problem:
> > > > >=20
> > > > > https://lore.kernel.org/linux-integrity/b8a7b3566e6014ba102ab98e1=
0ede0d574d8930e.camel@huaweicloud.com/
> > > > >=20
> > > > > Going to provide more info there.
> > > >=20
> > > > I suppose you are going try to acquire the tracing data I asked?
> > > > That would be awesome, thanks for taking the troube.=C2=A0 Let's lo=
ok
> > > > at the data and draw conclusions based on that.
> > > >=20
> > > > Workaround is pretty simple: CONFIG_TCG_TPM2_HMAC=3Dn to the kernel
> > > > configuration disables the feature.
> > > >=20
> > > > For making decisions what to do with the=C2=A0 we are talking about=
 ~2
> > > > week window estimated, given the Vienna conference slows things
> > > > down, so I hope my workaround is good enough before that.
> > >=20
> > > I can enumerate three most likely ways to address the issue:
> > >=20
> > > 1. Strongest: drop from defconfig.
> > > 2. Medium: leave to defconfig but add an opt-in kernel command-line
> > > =C2=A0=C2=A0 parameter.
> > > 3. Lightest: if we can based on tracing data nail the regression in
> > > =C2=A0=C2=A0 sustainable schedule, fix it.
> >=20
> > Actually, there's a fourth: not use sessions for the PCR extend (if
> > we'd got the timings when I asked, this was going to be my suggestion
> > if they came back problematic).  This seems only to be a problem for
> > IMA measured boot (because it does lots of extends).  If necessary this
> > could even be wrapped in a separate config or boot option that only
> > disables HMAC on extend if IMA (so we still get security for things
> > like sd-boot)
>=20
> I can buy that but with a twist that make it an opt-in kernel command
> line option. We don't want to take already existing functionality away
> from those who might want to use it (given e.g. hardening requirements),
> and with that basis opt-in (by default disabled) would be more balanced
> way to address the issue.
>=20
> Please do a send a patch!

I made few measurements. I have a Fedora 38 VM with TPM passthrough.

Kernels: 6.11-rc2+ (guest), 6.5.0-45-generic (host)

QEMU:

rc  qemu-kvm                                          1:4.2-3ubuntu6.27
ii  qemu-system-x86                                   1:6.2+dfsg-2ubuntu6.2=
2


TPM2_PT_MANUFACTURER:
  raw: 0x49465800
  value: "IFX"
TPM2_PT_VENDOR_STRING_1:
  raw: 0x534C4239
  value: "SLB9"
TPM2_PT_VENDOR_STRING_2:
  raw: 0x36373000
  value: "670"


No HMAC:

# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 0)               |  tpm2_pcr_extend() {
 0)   1.112 us    |    tpm_buf_append_hmac_session();
 0) # 6360.029 us |    tpm_transmit_cmd();
 0) # 6415.012 us |  }


HMAC:

# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 1)               |  tpm2_pcr_extend() {
 1)               |    tpm2_start_auth_session() {
 1) * 36976.99 us |      tpm_transmit_cmd();
 1) * 84746.51 us |      tpm_transmit_cmd();
 1) # 3195.083 us |      tpm_transmit_cmd();
 1) @ 126795.1 us |    }
 1)   2.254 us    |    tpm_buf_append_hmac_session();
 1)   3.546 us    |    tpm_buf_fill_hmac_session();
 1) * 24356.46 us |    tpm_transmit_cmd();
 1)   3.496 us    |    tpm_buf_check_hmac_response();
 1) @ 151171.0 us |  }

Roberto


