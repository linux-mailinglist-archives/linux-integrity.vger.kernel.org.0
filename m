Return-Path: <linux-integrity+bounces-3543-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EA7976AC5
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 15:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF74B2298D
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD78187334;
	Thu, 12 Sep 2024 13:36:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4F191F9C;
	Thu, 12 Sep 2024 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148191; cv=none; b=uUKeLwkICFYb3LhfDBqhmGFZ3EAC3kacAu3DBQp/1r+CcNvqGRV/acHIMgzPNo0+SCUK835+/4t5YEwdmyR5udGfcL7tidJm1WCsgT5XQcM+e8fj4tpcK1UeqqvTv4rIkLGkFlx4SB8PHaU/snBKz9nFxCuxsIszegTxnyHtT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148191; c=relaxed/simple;
	bh=RjsoJk0fz0GT0pGzrOF7avM7SGiSZ+cDXayYZl1cJpM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3aCIYGjSKrVjVlRwM2jlo+r3+9e+eLToGpkqMwhCW7TnoTWA14/mpxjUEi83qpyiWJhNrXLTE/F3JzBO0iQwBsqxuS+tIWvmAxer9g614N6i4TXGORejPIRbjPf9yslI1B6wxOX/4HOAp71Dkr+jerZahwJDdKs56jJTklAiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X4HrC1LrJz9v7JW;
	Thu, 12 Sep 2024 21:11:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 73CDA1401F3;
	Thu, 12 Sep 2024 21:36:15 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDnlsdI7uJmEIfIAA--.3419S2;
	Thu, 12 Sep 2024 14:36:15 +0100 (CET)
Message-ID: <155190f0eb0974e223538f10afaa7860c5a61cf5.camel@huaweicloud.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
	 <jarkko@kernel.org>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Thu, 12 Sep 2024 15:36:04 +0200
In-Reply-To: <c47b129aeb95094aace5b174fc6d81bf0a7ecfbf.camel@HansenPartnership.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDnlsdI7uJmEIfIAA--.3419S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4fWr4fCFyrZF4ktFyDGFg_yoWrJFWfpr
	48JFyUGry5Gr1rtr1DKr4Utryjyr1UJw1UXrn8JF1kAF4Dtr1Ygr15Xr4Ygr1DZr4fJr1Y
	qr1UJrnxur1UGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBGbiTfQJHwADsp

On Thu, 2024-09-12 at 09:26 -0400, James Bottomley wrote:
> On Thu, 2024-09-12 at 16:16 +0300, Jarkko Sakkinen wrote:
> > On Wed Sep 11, 2024 at 3:21 PM EEST, James Bottomley wrote:
> > > On Wed, 2024-09-11 at 10:53 +0200, Roberto Sassu wrote:
> [...]
> > > > I made few measurements. I have a Fedora 38 VM with TPM
> > > > passthrough.
> > > >=20
> > > > Kernels: 6.11-rc2+ (guest), 6.5.0-45-generic (host)
> > > >=20
> > > > QEMU:
> > > >=20
> > > > rc=C2=A0 qemu-kvm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:4.2-
> > > > 3ubuntu6.27
> > > > ii=C2=A0 qemu-system-x86=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1:6.2+dfsg-
> > > > 2ubuntu6.22
> > > >=20
> > > >=20
> > > > TPM2_PT_MANUFACTURER:
> > > > =C2=A0 raw: 0x49465800
> > > > =C2=A0 value: "IFX"
> > > > TPM2_PT_VENDOR_STRING_1:
> > > > =C2=A0 raw: 0x534C4239
> > > > =C2=A0 value: "SLB9"
> > > > TPM2_PT_VENDOR_STRING_2:
> > > > =C2=A0 raw: 0x36373000
> > > > =C2=A0 value: "670"
> > > >=20
> > > >=20
> > > > No HMAC:
> > > >=20
> > > > # tracer: function_graph
> > > > #
> > > > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > > > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > > > =C2=A00)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > > > =C2=A00)=C2=A0=C2=A0 1.112 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_append_hmac_session();
> > > > =C2=A00) # 6360.029 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > > > =C2=A00) # 6415.012 us |=C2=A0 }
> > > >=20
> > > >=20
> > > > HMAC:
> > > >=20
> > > > # tracer: function_graph
> > > > #
> > > > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > > > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > > > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > > > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 tpm2_start_auth_session() {
> > > > =C2=A01) * 36976.99 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit=
_cmd();
> > > > =C2=A01) * 84746.51 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit=
_cmd();
> > > > =C2=A01) # 3195.083 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit=
_cmd();
> > > > =C2=A01) @ 126795.1 us |=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A01)=C2=A0=C2=A0 2.254 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_append_hmac_session();
> > > > =C2=A01)=C2=A0=C2=A0 3.546 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_fill_hmac_session();
> > > > =C2=A01) * 24356.46 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > > > =C2=A01)=C2=A0=C2=A0 3.496 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_check_hmac_response();
> > > > =C2=A01) @ 151171.0 us |=C2=A0 }
> > >=20
> > > Well, unfortunately, that tells us that it's the TPM itself that's
> > > taking the time processing the security overhead.=C2=A0 The ordering =
of
> > > the commands in tpm2_start_auth_session() shows
> > >=20
> > > =C2=A037ms for context restore of null key
> > > =C2=A085ms for start session with encrypted salt
> > > =C2=A0 3ms to flush null key
> > > -----
> > > 125ms
> > >=20
> > > If we context save the session, we'd likely only bear a single 37ms
> > > cost to restore it (replacing the total 125ms).=C2=A0 However, there'=
s
> > > nothing we can do about the extend execution going from 6ms to
> > > 24ms, so I could halve your current boot time with security enabled
> > > (it's currently 149ms, it would go to 61ms, but it's still 10x
> > > slower than the unsecured extend at 6ms)
> > >=20
> > > James
> >=20
> > I'll hold for better benchmarks.
>=20
> Well, yes, I'd like to see this for a variety of TPMs.
>=20
> This one clearly shows it's the real time wait for the TPM (since it
> dwarfs the CPU time calculation there's not much optimization we can do
> on the kernel end).  The one thing that's missing in all of this is
> what was the TPM?  but even if it's an outlier that's really bad at
> crypto what should we do?  We could have a blacklist that turns off the
> extend hmac (or a whitelist that turns it on), but we can't simply say
> too bad you need a better TPM.

Ops, sorry. I pasted the TPM properties. Was not that clear:

Infineon Optiga SLB9670 (interpreting the properties).

Roberto


