Return-Path: <linux-integrity+bounces-3548-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA7F976BDC
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0732D283BDB
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCFE1AD25D;
	Thu, 12 Sep 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEb75SEV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0862BB09;
	Thu, 12 Sep 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150988; cv=none; b=Fl3I5yt27LAkMHLWfm6fKZ7ZS8Tr2PT0LXriGSB5w5t4kzmwE97BPUl+uzmt1CnB70Pn7l2DCzimJ7t053B+L3QFeluH9sx4VpgqY3dScsvHGGV5XVp6EJwBzBzq8xPVZ9j6nBgazfDb34eY4ndGDDkXeKWiTdgxTETIYsloH7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150988; c=relaxed/simple;
	bh=jJcTh5nuJ5D7uttcH6Y/4WauSKzkve6TgMPWd0TWE4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Yd9Innzkwx2rZsahal2i6dxDgYDPTAacjqZ7t/S5bGK90t2JUZOaE+iIkF2vmrsZZaybc22Dvb+Bb8ZpIRuJgg4H95XSIFIVE/dBhRKgVDQlY8Lz/iuC7vITbIT6cTkWdm4LC2VxRnHGKLXLB53YXJ3T8DUSnVNUSxDzTu6pHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEb75SEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC014C4CEC3;
	Thu, 12 Sep 2024 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726150987;
	bh=jJcTh5nuJ5D7uttcH6Y/4WauSKzkve6TgMPWd0TWE4c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uEb75SEV1I6iz142ZSa/gtM33bEJr03brAE9Y98I+8pnhVgJRbyc10teHgRKu93Q9
	 6EppxtWnPDWQrgYJbWbr5eAH36ydIkI2Dps4GmWtTtzB0nx0TER5DUqMsr67vmlJk0
	 mwTYJkdPYrc1UA9xN19q7BGGqaGOhHxmCYriJ0dTQXioa+K9pnuiRoPQjPds5E4cUr
	 XqR3euVYAo+IDDtEWeU43+ANHw/dxcWWcsOTMLY65/r5FhbQg7yjC3Gbs0kX/6nSh2
	 RhsuUnHirw79HbuE6tgbfAurEiqwReMCBXPZ8q2TrKKIo9YSp2ZgLRgqpoTp+q1yj2
	 ym03KgDGxg2zQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Sep 2024 17:23:03 +0300
Message-Id: <D44DGENMPU9S.C2ZOA3EA5LEW@kernel.org>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
 <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
 <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>
In-Reply-To: <7e47f97aede88b87fbb9c9284db2005764bfbedd.camel@huaweicloud.com>

On Thu Sep 12, 2024 at 11:13 AM EEST, Roberto Sassu wrote:
> On Wed, 2024-09-11 at 18:14 +0300, Jarkko Sakkinen wrote:
> > On Wed Sep 11, 2024 at 11:53 AM EEST, Roberto Sassu wrote:
> > > I made few measurements. I have a Fedora 38 VM with TPM passthrough.
> >=20
> > I was thinking more like
> >=20
> > sudo bpftrace -e 'k:tpm_transmit { @start[tid] =3D nsecs; } kr:tpm_tran=
smit { @[kstack, ustack, comm] =3D sum(nsecs - @start[tid]); delete(@start[=
tid]); } END { clear(@start); }'
> >=20
> > For example when running "tpm2_createprimary --hierarchy o -G rsa2048 -=
c owner.txt", I get:
>
> Sure:
>
> Without HMAC:
>
> @[
>     tpm_transmit_cmd+50
>     tpm2_pcr_extend+295
>     tpm_pcr_extend+221
>     ima_add_template_entry+437
>     ima_store_template+114
>     ima_store_measurement+209
>     process_measurement+2473
>     ima_file_check+82
>     security_file_post_open+92
>     path_openat+550
>     do_filp_open+171
>     do_sys_openat2+186
>     do_sys_open+76
>     __x64_sys_openat+35
>     x64_sys_call+9589
>     do_syscall_64+96
>     entry_SYSCALL_64_after_hwframe+118
> ,=20
>     0x7f338ee7be55
>     0x55bf24459ac2
>     0x7f338eda2b8a
>     0x7f338eda2c4b
>     0x55bf2445a9b5
> , cat]: 5273648
>
>
> With HMAC:
>
> @[
>     tpm_transmit_cmd+50
>     tpm2_flush_context+95
>     tpm2_start_auth_session+676
>     tpm2_pcr_extend+39
>     tpm_pcr_extend+221
>     ima_add_template_entry+437
>     ima_store_template+114
>     ima_store_measurement+209
>     process_measurement+2473
>     ima_file_check+82
>     security_file_post_open+92
>     path_openat+550
>     do_filp_open+171
>     do_sys_openat2+186
>     do_sys_open+76
>     __x64_sys_openat+35
>     x64_sys_call+9589
>     do_syscall_64+96
>     entry_SYSCALL_64_after_hwframe+118
> ,=20
>     0x7f03ea0ade55
>     0x55f929b7dac2
>     0x7f03e9fd4b8a
>     0x7f03e9fd4c4b
>     0x55f929b7e9b5
> , cat]: 3128177
> @[
>     tpm_transmit_cmd+50
>     tpm2_pcr_extend+338
>     tpm_pcr_extend+221
>     ima_add_template_entry+437
>     ima_store_template+114
>     ima_store_measurement+209
>     process_measurement+2473
>     ima_file_check+82
>     security_file_post_open+92
>     path_openat+550
>     do_filp_open+171
>     do_sys_openat2+186
>     do_sys_open+76
>     __x64_sys_openat+35
>     x64_sys_call+9589
>     do_syscall_64+96
>     entry_SYSCALL_64_after_hwframe+118
> ,=20
>     0x7f03ea0ade55
>     0x55f929b7dac2
>     0x7f03e9fd4b8a
>     0x7f03e9fd4c4b
>     0x55f929b7e9b5
> , cat]: 25851638
> @[
>     tpm_transmit_cmd+50
>     tpm2_load_context+161
>     tpm2_start_auth_session+98
>     tpm2_pcr_extend+39
>     tpm_pcr_extend+221
>     ima_add_template_entry+437
>     ima_store_template+114
>     ima_store_measurement+209
>     process_measurement+2473
>     ima_file_check+82
>     security_file_post_open+92
>     path_openat+550
>     do_filp_open+171
>     do_sys_openat2+186
>     do_sys_open+76
>     __x64_sys_openat+35
>     x64_sys_call+9589
>     do_syscall_64+96
>     entry_SYSCALL_64_after_hwframe+118
> ,=20
>     0x7f03ea0ade55
>     0x55f929b7dac2
>     0x7f03e9fd4b8a
>     0x7f03e9fd4c4b
>     0x55f929b7e9b5
> , cat]: 35928108
> @[
>     tpm_transmit_cmd+50
>     tpm2_start_auth_session+650
>     tpm2_pcr_extend+39
>     tpm_pcr_extend+221
>     ima_add_template_entry+437
>     ima_store_template+114
>     ima_store_measurement+209
>     process_measurement+2473
>     ima_file_check+82
>     security_file_post_open+92
>     path_openat+550
>     do_filp_open+171
>     do_sys_openat2+186
>     do_sys_open+76
>     __x64_sys_openat+35
>     x64_sys_call+9589
>     do_syscall_64+96
>     entry_SYSCALL_64_after_hwframe+118
> ,=20
>     0x7f03ea0ade55
>     0x55f929b7dac2
>     0x7f03e9fd4b8a
>     0x7f03e9fd4c4b
>     0x55f929b7e9b5
> , cat]: 84616611
>
> Roberto

Looking into tomorrow thank you.

BR, Jarkko

