Return-Path: <linux-integrity+bounces-3591-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C65597962E
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 11:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1831F21A67
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46200198A16;
	Sun, 15 Sep 2024 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmtUBGry"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD713AA2B;
	Sun, 15 Sep 2024 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726393420; cv=none; b=fMJSEkjp9qwsvp4Q0dF9CAgapRRB8oyuspBuQ2SR3fr5BtH8NHKa7lLjw14dHX7Zez8q5D1oDZQBnvdtuLzaJCBHcggqOkLcEqcF5MMtjXBAeJ+juygSfvKim9DetXA3sl/8ZHkXrzasK5xXXnJBfVg77jNKwVh2dgmvRBJlZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726393420; c=relaxed/simple;
	bh=lq0v9oHdHOUeIp62g7vMkFhZMevGNd76a2adT3E3Q54=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=oR+TSN+CITyi19PQA9asDXB2VZljbAxx67T73BaLXjF/zbhU+2yFYsS6qQr3gQVyVRV64IsPjRbPCD4ZuqvjmygwYLet5LOo5G2oEMSrAS/pjDhR2uF1sW0bVVVUznSamxnOXxtXSm72+0MTsrud45f/dz+hFQZ/CFWlEkFID5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmtUBGry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E6FC4CEC3;
	Sun, 15 Sep 2024 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726393419;
	bh=lq0v9oHdHOUeIp62g7vMkFhZMevGNd76a2adT3E3Q54=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=JmtUBGrykvcfisXD8cdC0BGMvqMfm2s3c36f/jLY4t7a5JdUt++lPmwBJQ0RAYTEx
	 4v7o9a/zMzSwvpcr+yrX7WNQpjmPiGBBTrfkg8Fn7Sq97AY2ZLvSJY/CoOUkec4NLd
	 iifBnFegBiuDvIxSARvNjU5HJVSr2lw+hh9yyYrEZoXY+vxCdVVBBN9kdGqedGwDlN
	 pBHKJSxRo9nAxu4xQ+aUr75Lcv6nylPErXiUHYuuk59gACtkgSt3dUmaIL/IkkqJ2p
	 mYF0iLTwWVW7ldDRoUYaBxDK9KyjIjVtjRi2MvJmUKJ7TgqgBBFZjnSQqx88P9/8dQ
	 7qV2penJy8/oQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 12:43:35 +0300
Message-Id: <D46RE2BWMGJ4.25VA7IVYTJ8MO@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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

These commands and TPM2_CreatePrimary are the ones that give overhead
to the AMD boot-up:

1. TPM2_LoadContext (35 ms)
2. TPM2_StartAuthSession (85 ms)

We can conclude that the implementation is too slow and making it faster
requires a whole set of small improvements. From this basis the only
right fix is to make it opt-in kernel command-line option.

That will give space to make small performance improvements over time,
and not rush. How the session is orchestrated is not production quality,
and the bug gives direct evidence of that.

High-level improvements that could be done over time:

- Do not call start_auth_session() in extend and get_random().
  Orchestrate outside.
- Find places to not close and open session sequentially, e.g.
  with the help of use SA_CONTINUE_SESSION.

When it comes to boot we should aim for one single start_auth_session
during boot, i.e. different phases would leave that session open so
that we don't have to load the context every single time.  I think it
should be doable.

Making all this happen is not a "performance regression fix". It is
set of gradual improvements to the code that is not there yet

On plus side, the kernel command-line option allows the enable the
feature by default during compilation time for all architectures.

I've made my decision on this and will submit a fix for it.

BR, Jarkko

