Return-Path: <linux-integrity+bounces-3538-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C297641D
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 10:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D24C1C21660
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 08:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFED18FDDB;
	Thu, 12 Sep 2024 08:14:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0231885BC;
	Thu, 12 Sep 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128851; cv=none; b=G3mF1OvWtP9MTWrK4Uf3YDUczuuPRhht1pGRTj19ZLdU9pWupZeLrDiGuk9Vo1sv27Jb3D7N0TpwK6iRJU9wWQkyWv94oKAWQZIzJdKdeiIeR7MUjjxanS1V5PePvY2pVhka5sZV3G10FTEGyWWmxbnYIPiYLPqhuqDt1s2H8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128851; c=relaxed/simple;
	bh=S12iHFD+Ylpk128Urn+AhyYnPt/pw3Tm5yihTA31VQU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aRD0+xgkv5GkpOZ6ScO4KmBzTOfly9iTBNEvRJMHXUxW6KXY+638cSANltzm6FolSVYRYek3OcwktFoAvNPJWMTIoOjkShPM63fpDqd2nAeVENq5gYepPHCElbxOTCpVdY4Y2ekLYcez7WmkRYK5gMNsZBpPOmVO0PpdwpiF9kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X48hN5BNdz9v7JT;
	Thu, 12 Sep 2024 15:48:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 9C9071402E1;
	Thu, 12 Sep 2024 16:14:05 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3ZsfGouJmHcLEAA--.1679S2;
	Thu, 12 Sep 2024 09:14:05 +0100 (CET)
Message-ID: <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, James Bottomley
	 <James.Bottomley@HansenPartnership.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Thu, 12 Sep 2024 10:13:55 +0200
In-Reply-To: <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
	 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
	 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
	 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
	 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
	 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
	 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
	 <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwC3ZsfGouJmHcLEAA--.1679S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW8GFy5GF4kWr1ruF4kWFg_yoW5ury8pF
	Z7GryxWry0kw1DXryI9ayDXFn8Awn7X3y2qw4DWryvk3WaqrnavF4fAFWaya4DG345K34r
	ua4Syr4DCwn0gaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBGbiTnsECgAAs9

On Wed, 2024-09-11 at 18:14 +0300, Jarkko Sakkinen wrote:
> On Wed Sep 11, 2024 at 11:53 AM EEST, Roberto Sassu wrote:
> > I made few measurements. I have a Fedora 38 VM with TPM passthrough.
>=20
> I was thinking more like
>=20
> sudo bpftrace -e 'k:tpm_transmit { @start[tid] =3D nsecs; } kr:tpm_transm=
it { @[kstack, ustack, comm] =3D sum(nsecs - @start[tid]); delete(@start[ti=
d]); } END { clear(@start); }'
>=20
> For example when running "tpm2_createprimary --hierarchy o -G rsa2048 -c =
owner.txt", I get:

Sure:

Without HMAC:

@[
    tpm_transmit_cmd+50
    tpm2_pcr_extend+295
    tpm_pcr_extend+221
    ima_add_template_entry+437
    ima_store_template+114
    ima_store_measurement+209
    process_measurement+2473
    ima_file_check+82
    security_file_post_open+92
    path_openat+550
    do_filp_open+171
    do_sys_openat2+186
    do_sys_open+76
    __x64_sys_openat+35
    x64_sys_call+9589
    do_syscall_64+96
    entry_SYSCALL_64_after_hwframe+118
,=20
    0x7f338ee7be55
    0x55bf24459ac2
    0x7f338eda2b8a
    0x7f338eda2c4b
    0x55bf2445a9b5
, cat]: 5273648


With HMAC:

@[
    tpm_transmit_cmd+50
    tpm2_flush_context+95
    tpm2_start_auth_session+676
    tpm2_pcr_extend+39
    tpm_pcr_extend+221
    ima_add_template_entry+437
    ima_store_template+114
    ima_store_measurement+209
    process_measurement+2473
    ima_file_check+82
    security_file_post_open+92
    path_openat+550
    do_filp_open+171
    do_sys_openat2+186
    do_sys_open+76
    __x64_sys_openat+35
    x64_sys_call+9589
    do_syscall_64+96
    entry_SYSCALL_64_after_hwframe+118
,=20
    0x7f03ea0ade55
    0x55f929b7dac2
    0x7f03e9fd4b8a
    0x7f03e9fd4c4b
    0x55f929b7e9b5
, cat]: 3128177
@[
    tpm_transmit_cmd+50
    tpm2_pcr_extend+338
    tpm_pcr_extend+221
    ima_add_template_entry+437
    ima_store_template+114
    ima_store_measurement+209
    process_measurement+2473
    ima_file_check+82
    security_file_post_open+92
    path_openat+550
    do_filp_open+171
    do_sys_openat2+186
    do_sys_open+76
    __x64_sys_openat+35
    x64_sys_call+9589
    do_syscall_64+96
    entry_SYSCALL_64_after_hwframe+118
,=20
    0x7f03ea0ade55
    0x55f929b7dac2
    0x7f03e9fd4b8a
    0x7f03e9fd4c4b
    0x55f929b7e9b5
, cat]: 25851638
@[
    tpm_transmit_cmd+50
    tpm2_load_context+161
    tpm2_start_auth_session+98
    tpm2_pcr_extend+39
    tpm_pcr_extend+221
    ima_add_template_entry+437
    ima_store_template+114
    ima_store_measurement+209
    process_measurement+2473
    ima_file_check+82
    security_file_post_open+92
    path_openat+550
    do_filp_open+171
    do_sys_openat2+186
    do_sys_open+76
    __x64_sys_openat+35
    x64_sys_call+9589
    do_syscall_64+96
    entry_SYSCALL_64_after_hwframe+118
,=20
    0x7f03ea0ade55
    0x55f929b7dac2
    0x7f03e9fd4b8a
    0x7f03e9fd4c4b
    0x55f929b7e9b5
, cat]: 35928108
@[
    tpm_transmit_cmd+50
    tpm2_start_auth_session+650
    tpm2_pcr_extend+39
    tpm_pcr_extend+221
    ima_add_template_entry+437
    ima_store_template+114
    ima_store_measurement+209
    process_measurement+2473
    ima_file_check+82
    security_file_post_open+92
    path_openat+550
    do_filp_open+171
    do_sys_openat2+186
    do_sys_open+76
    __x64_sys_openat+35
    x64_sys_call+9589
    do_syscall_64+96
    entry_SYSCALL_64_after_hwframe+118
,=20
    0x7f03ea0ade55
    0x55f929b7dac2
    0x7f03e9fd4b8a
    0x7f03e9fd4c4b
    0x55f929b7e9b5
, cat]: 84616611

Roberto


