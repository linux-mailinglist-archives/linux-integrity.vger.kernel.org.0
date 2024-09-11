Return-Path: <linux-integrity+bounces-3537-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D15C97569E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15661C202EA
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1049F1AAE32;
	Wed, 11 Sep 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qid0OwwQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14EA1AAE20;
	Wed, 11 Sep 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067680; cv=none; b=E+GLVTci1dEPfe3+m3opXUtV4dBD1Hk+ueX5RBUWa9tJVWBjK23PApbWVg5xFxSc6vfJgYv1CWUPvdbIkXrnvLzAimzT5IwkQ58B3gQW6JYKvyLIQPc8mOrQUSC/FGnqC2CPVF/aZsZF+Boy377kPll6b57LSBjJWyDIhXdmyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067680; c=relaxed/simple;
	bh=PiPFhxOCWpTWiOs7tP6Fa3NGL6/VbqwXaT+AzVDdajA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=aTZ9J0FC2hgAFpZckO2Cbmd1iMHNtNoVQP0D6adWlTOZCBq5uOJHn1x1uPzXkNaPLUmGf0YE+ooUMd91KaEKAusSvBSKNyInPWV4V3CYBzd3TKqtl/twaOTONW+swu3/kbWFn0aZ2hwKsaAa9hCKToUsynjGRwziRre98bM+MnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qid0OwwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D7BC4CEC0;
	Wed, 11 Sep 2024 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726067679;
	bh=PiPFhxOCWpTWiOs7tP6Fa3NGL6/VbqwXaT+AzVDdajA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=qid0OwwQiQB6xRYk8H184zEtj1LHIGbSgeLt2rO1RQuKWNwxb9UitrJR9BJm02DqR
	 3h09QrrJu3q2mLlpP4cc08jUtgty87LHqtMHwBp4ICiOYFS2cgJjtyFrThmznraoOV
	 iboj0338yO0h+iYKub8URKudGajeTbeH2WEaG9oCXUhtTM0S8fQYpa/fJAnQ+DEbpg
	 ax/wQRVdDqKZQhACRQdCACJuqvlW4sKZyL/9RK5ex9JskfQbY+rBZxSECo6bT8vQ7u
	 W/H6UOEyFh/Jqu50FWp0r8C9t69EpIRRbLwzeqV0kDuAvPKx1oQ0a26VEdeopfVqcp
	 ggv7+11hQiiTw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 18:14:35 +0300
Message-Id: <D43JXBFOOB2O.3U6ZQ7DASR1ZW@kernel.org>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Cc: <keyrings@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Pengyu Ma" <mapengyu@gmail.com>
X-Mailer: aerc 0.18.2
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
 <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
 <D42LZPLE8HR3.2UTNOI9CYZPIR@kernel.org>
 <D42M6OE94RLT.6EZSZLBTX437@kernel.org>
 <663d272617d1aead08077ad2b72929cbc226372a.camel@HansenPartnership.com>
 <D42N17MFTEDM.3E6IK034S26UT@kernel.org>
 <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>
In-Reply-To: <f554031343039883068145f9f4777277e490dc05.camel@huaweicloud.com>

On Wed Sep 11, 2024 at 11:53 AM EEST, Roberto Sassu wrote:
> I made few measurements. I have a Fedora 38 VM with TPM passthrough.

I was thinking more like

sudo bpftrace -e 'k:tpm_transmit { @start[tid] =3D nsecs; } kr:tpm_transmit=
 { @[kstack, ustack, comm] =3D sum(nsecs - @start[tid]); delete(@start[tid]=
); } END { clear(@start); }'

For example when running "tpm2_createprimary --hierarchy o -G rsa2048 -c ow=
ner.txt", I get:

Attaching 3 probes...
^C

@[
    tpm_transmit_cmd+46
    tpm2_flush_context+120
    tpm2_commit_space+197
    tpm_dev_transmit.constprop.0+137
    tpm_dev_async_work+102
    process_one_work+374
    worker_thread+614
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
, , kworker/4:2]: 2860677
@[
    tpm_dev_transmit.constprop.0+111
    tpm_dev_async_work+102
    process_one_work+374
    worker_thread+614
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
, , kworker/16:1]: 3890693
@[
    tpm_transmit_cmd+46
    tpm2_load_context+195
    tpm2_prepare_space+410
    tpm_dev_transmit.constprop.0+54
    tpm_dev_async_work+102
    process_one_work+374
    worker_thread+614
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
, , kworker/4:2]: 9058524
@[
    tpm_transmit_cmd+46
    tpm2_save_context+179
    tpm2_commit_space+314
    tpm_dev_transmit.constprop.0+137
    tpm_dev_async_work+102
    process_one_work+374
    worker_thread+614
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
, , kworker/4:2]: 11426260
@[
    tpm_transmit_cmd+46
    tpm2_load_context+195
    tpm2_prepare_space+318
    tpm_dev_transmit.constprop.0+54
    tpm_dev_async_work+102
    process_one_work+374
    worker_thread+614
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
, , kworker/4:2]: 14182972
@[
    tpm_transmit_cmd+46
    tpm2_save_context+179
    tpm2_commit_space+155
    tpm_dev_transmit.constprop.0+137
    tpm_dev_async_work+102
    process_one_work+374
    worker_thread+614
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
, , kworker/4:2]: 22597059
@[
    tpm_dev_transmit.constprop.0+111
    tpm_dev_async_work+102
    process_one_work+374
    worker_thread+614
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
, , kworker/4:2]: 1958500581

This results stacks to compare with "real" time spent total in each
stack (in nsecs). CPU time is relevant measure in the problem we're
dealing.

BR, Jarkko

