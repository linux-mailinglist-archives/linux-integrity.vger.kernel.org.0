Return-Path: <linux-integrity+bounces-3550-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F25B976CBE
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 16:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A578D1F24D5A
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207CC1B5808;
	Thu, 12 Sep 2024 14:53:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0BC176FCF;
	Thu, 12 Sep 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152781; cv=none; b=PSQHeeb76Nf9kVzBRxgRo4oOd1i3Xmk6uKvzZ8m8pmJokdY5a9QAwXFUgg1azZ2+SQOzqzAa38vTR6S04YSyxMhG0u1zBgwCAA/v4p0FWX4m72lYQNs9yXX97RtLYwNn9vfZx4XaLIH7vEaCkBFDbiRcJsMqkiKrMRUFoMdqo6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152781; c=relaxed/simple;
	bh=jJRKHuyFhRwIGFXt36hK6RLoLWePKd0LtKVg67zuh5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TV5YUoTWChZigxt5kY7uGsVEfukFs8tDM6uHp4Hyxy3XeAYSA3hmyLmvN/8GZ8CeloSiD7OWe/rlsYk8rWvPSyA/5TOJyc8hCmVu1t2b0hVOYyknBIVFLH7LrBa7qFfvCyZdctOPBLbBz4H51p5dKjjwzk/9gbD3yw1Fhc3P1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X4KgB51hrz9v7NT;
	Thu, 12 Sep 2024 22:33:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id AC2A4140B27;
	Thu, 12 Sep 2024 22:52:53 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDndy88AONmTKPHAA--.2627S2;
	Thu, 12 Sep 2024 15:52:52 +0100 (CET)
Message-ID: <0cd01bd94b6e29b4db2f071a32e5d543df02eb21.camel@huaweicloud.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
	 <jarkko@kernel.org>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Thu, 12 Sep 2024 16:52:40 +0200
In-Reply-To: <e3d0947a45f7a6fea0dca345deaa52baf9ffaaf6.camel@HansenPartnership.com>
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
	 <e3d0947a45f7a6fea0dca345deaa52baf9ffaaf6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDndy88AONmTKPHAA--.2627S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFWrGF4kXw1DZw18Jr43Wrg_yoWxGw4xpw
	48JFyUGr95Jr1rtr1vyr1Dtry2y34UJw1UXrn5JF1kAF1DKr1Ygr15Xr1Y9r1DXr4xJr15
	tr1UJr13ur1UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBGbiTfQKWAAAsu

On Thu, 2024-09-12 at 10:13 -0400, James Bottomley wrote:
> On Thu, 2024-09-12 at 15:36 +0200, Roberto Sassu wrote:
> > On Thu, 2024-09-12 at 09:26 -0400, James Bottomley wrote:
> > > On Thu, 2024-09-12 at 16:16 +0300, Jarkko Sakkinen wrote:
> > > > On Wed Sep 11, 2024 at 3:21 PM EEST, James Bottomley wrote:
> > > > > On Wed, 2024-09-11 at 10:53 +0200, Roberto Sassu wrote:
> > > [...]
> > > > > > I made few measurements. I have a Fedora 38 VM with TPM
> > > > > > passthrough.
> > > > > >=20
> > > > > > Kernels: 6.11-rc2+ (guest), 6.5.0-45-generic (host)
> > > > > >=20
> > > > > > QEMU:
> > > > > >=20
> > > > > > rc=C2=A0 qemu-kvm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:4.2-
> > > > > > 3ubuntu6.27
> > > > > > ii=C2=A0 qemu-system-x86=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
> > > > > > 1:6.2+dfsg-
> > > > > > 2ubuntu6.22
> > > > > >=20
> > > > > >=20
> > > > > > TPM2_PT_MANUFACTURER:
> > > > > > =C2=A0 raw: 0x49465800
> > > > > > =C2=A0 value: "IFX"
> > > > > > TPM2_PT_VENDOR_STRING_1:
> > > > > > =C2=A0 raw: 0x534C4239
> > > > > > =C2=A0 value: "SLB9"
> > > > > > TPM2_PT_VENDOR_STRING_2:
> > > > > > =C2=A0 raw: 0x36373000
> > > > > > =C2=A0 value: "670"
> > > > > >=20
> > > > > >=20
> > > > > > No HMAC:
> > > > > >=20
> > > > > > # tracer: function_graph
> > > > > > #
> > > > > > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > > > > > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > > > > > =C2=A00)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > > > > > =C2=A00)=C2=A0=C2=A0 1.112 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 tpm_buf_append_hmac_session();
> > > > > > =C2=A00) # 6360.029 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > > > > > =C2=A00) # 6415.012 us |=C2=A0 }
> > > > > >=20
> > > > > >=20
> > > > > > HMAC:
> > > > > >=20
> > > > > > # tracer: function_graph
> > > > > > #
> > > > > > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > > > > > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > > > > > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > > > > > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 tpm2_start_auth_session(=
) {
> > > > > > =C2=A01) * 36976.99 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_tran=
smit_cmd();
> > > > > > =C2=A01) * 84746.51 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_tran=
smit_cmd();
> > > > > > =C2=A01) # 3195.083 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_tran=
smit_cmd();
> > > > > > =C2=A01) @ 126795.1 us |=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A01)=C2=A0=C2=A0 2.254 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 tpm_buf_append_hmac_session();
> > > > > > =C2=A01)=C2=A0=C2=A0 3.546 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 tpm_buf_fill_hmac_session();
> > > > > > =C2=A01) * 24356.46 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > > > > > =C2=A01)=C2=A0=C2=A0 3.496 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 tpm_buf_check_hmac_response();
> > > > > > =C2=A01) @ 151171.0 us |=C2=A0 }
> > > > >=20
> > > > > Well, unfortunately, that tells us that it's the TPM itself
> > > > > that's
> > > > > taking the time processing the security overhead.=C2=A0 The order=
ing
> > > > > of
> > > > > the commands in tpm2_start_auth_session() shows
> > > > >=20
> > > > > =C2=A037ms for context restore of null key
> > > > > =C2=A085ms for start session with encrypted salt
> > > > > =C2=A0 3ms to flush null key
> > > > > -----
> > > > > 125ms
> > > > >=20
> > > > > If we context save the session, we'd likely only bear a single
> > > > > 37ms
> > > > > cost to restore it (replacing the total 125ms).=C2=A0 However,
> > > > > there's
> > > > > nothing we can do about the extend execution going from 6ms to
> > > > > 24ms, so I could halve your current boot time with security
> > > > > enabled
> > > > > (it's currently 149ms, it would go to 61ms, but it's still 10x
> > > > > slower than the unsecured extend at 6ms)
> > > > >=20
> > > > > James
> > > >=20
> > > > I'll hold for better benchmarks.
> > >=20
> > > Well, yes, I'd like to see this for a variety of TPMs.
> > >=20
> > > This one clearly shows it's the real time wait for the TPM (since
> > > it dwarfs the CPU time calculation there's not much optimization we
> > > can do on the kernel end).=C2=A0 The one thing that's missing in all =
of
> > > this is what was the TPM?=C2=A0 but even if it's an outlier that's
> > > really bad at crypto what should we do?=C2=A0 We could have a blackli=
st
> > > that turns off the extend hmac (or a whitelist that turns it on),
> > > but we can't simply say too bad you need a better TPM.
> >=20
> > Ops, sorry. I pasted the TPM properties. Was not that clear:
> >=20
> > Infineon Optiga SLB9670 (interpreting the properties).
>=20
> OK, that's reasonably modern and common:
>=20
> https://www.infineon.com/cms/en/product/security-smart-card-solutions/opt=
iga-embedded-security-solutions/optiga-tpm/
>=20
> I assume it's one of the Q20 (otherwise it would be a TPM 1.2) but what
> firmware version (as in could it be upgraded and the tests re-run to
> see if that makes a difference).
>=20
> I also need the IMA community to start thinking about what they're
> willing to accept in terms of performance for the added security hmac
> brings to TPM extends.

Just for curiosity, I made a comparison of the boot time of Fedora 38
(minimal installation) without and with HMAC enabled, without and with
the Integrity Digest Cache [1], which I originally designed exactly for
this purpose (one measurement per package):


Without HMAC:
Without Integrity Digest Cache:

[root@fedora ~]# systemd-analyze=20
Startup finished in 2.486s (kernel) + 3.594s (initrd) + 11.613s (userspace)=
 =3D 17.694s=20
multi-user.target reached after 11.559s in userspace.
[root@fedora ~]# cat /sys/kernel/security/ima/ascii_runtime_measurements|wc=
 -l
444

With Integrity Digest Cache:

[root@fedora ~]# systemd-analyze=20
Startup finished in 2.381s (kernel) + 3.469s (initrd) + 11.794s (userspace)=
 =3D 17.644s=20
multi-user.target reached after 11.750s in userspace.
[root@fedora ~]# cat /sys/kernel/security/ima/ascii_runtime_measurements|wc=
 -l
218



With HMAC:
Without Integrity Digest Cache:

[root@fedora ~]# systemd-analyze=20
Startup finished in 2.911s (kernel) + 3.453s (initrd) + 1min 5.754s (usersp=
ace) =3D 1min 12.119s=20
multi-user.target reached after 1min 5.707s in userspace.
[root@fedora ~]# cat /sys/kernel/security/ima/ascii_runtime_measurements|wc=
 -l
444


With Integrity Digest Cache:

[root@fedora ~]# systemd-analyze=20
Startup finished in 2.990s (kernel) + 3.462s (initrd) + 37.038s (userspace)=
 =3D 43.491s=20
multi-user.target reached after 36.997s in userspace.
[root@fedora ~]# cat /sys/kernel/security/ima/ascii_runtime_measurements|wc=
 -l
218


[1]: https://lore.kernel.org/linux-integrity/20240905150543.3766895-1-rober=
to.sassu@huaweicloud.com/

Roberto


