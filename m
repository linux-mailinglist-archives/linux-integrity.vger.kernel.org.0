Return-Path: <linux-integrity+bounces-3598-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB2E979753
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 16:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C00E1C20C07
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF491C7B65;
	Sun, 15 Sep 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnwIrAud"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915618B04;
	Sun, 15 Sep 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412140; cv=none; b=TYWagNlAV7OnbKgLWP+67ykJQuojGazKLWO/4XjaHCsk07pBHkXnlBxbzBqcBF8CEbPW0IjBLRgQifupAi2rDDzSLqbaJ1UR5+UHGVEk1GX70F06ImCkTzDzs3t47Q4wGQ4uJM5VfKEMyVhuIpGezyKZQy7Sw9OLN5Niq55Yk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412140; c=relaxed/simple;
	bh=eDYVAMcB9QXm8GrzzyxMlsOWCnurPxa71hepbHj+9TI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RtiBH2lVcNT27v2w11nZt35XyHHAAu97h4ebaZ7UYFJtMhRwm8FjkwsXg/c7hewykJ5dR6AClvLEahUhuArjuuPrYK3vA8U0YtEM97EStQo/wQ5y82plHStZcbn6oHDWTkGaUOgIdgvMIBNDsWSX4DL/KsMAfOfWfDzeBa2PfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnwIrAud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5052C4CECC;
	Sun, 15 Sep 2024 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726412140;
	bh=eDYVAMcB9QXm8GrzzyxMlsOWCnurPxa71hepbHj+9TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnwIrAudOF10nzuCpxUNX6udxK9X/qVCFlBwTSscOzxCM0FHcbYOTb/VU8Yndbnpf
	 yW+FLC10BCQGIl3UfJm5xVfyM4g+1wG9ImoHNj65kaiQdKzhkrTWAyPxyHLizEE2x8
	 qq4CFxQeM5FHJvMOSrVVoAAYecJ5qubeYvt4zi0l5Y+s8kV5lEs2AkuYDJfiEI+3VJ
	 GhbazNapwyO3EE74WLUounVrJy1unwfK4yLmXI/4vsklNj63hLDxy25rvX6RIrMAFt
	 yt1v2kT2d9nKvaejD1KQjtDDq5fQCX5dxMxITMfcmqJ+HzLA2TnZNMBR4+M+QZGm+H
	 +PvbUT9fCVYmw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Sep 2024 17:55:36 +0300
Message-Id: <D46Y0YJMYUBV.3C6B6Q5HHGGA4@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
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
 <D46RE2BWMGJ4.25VA7IVYTJ8MO@kernel.org>
 <D46RWPQ211ZS.12EYKZY053BH@kernel.org>
 <0b22c2c4b4a998fb44bb08be60a359acb9ecb8da.camel@HansenPartnership.com>
 <D46XX6HNU686.50X57ZWI2GUX@kernel.org>
In-Reply-To: <D46XX6HNU686.50X57ZWI2GUX@kernel.org>

On Sun Sep 15, 2024 at 5:50 PM EEST, Jarkko Sakkinen wrote:
> One low-hanging fruit improvement in the startup code is the handling
> of null key. If it was flushed only on need, which means in practice
> access to /dev/tpm0 or /dev/tpmrm0
>
> I'm already working on patch set which adds chip->null_key that will
> be flushed on-need basis only. I can measure with qemu how it affects
> boot time.

I can agree with that playing continueSession is not like the first
thing to try out but keeping null key in memory as long as it can be
does not affect context gap so I start experimenting with that.

BR, Jarkko

