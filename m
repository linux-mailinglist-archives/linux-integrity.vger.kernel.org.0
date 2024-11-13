Return-Path: <linux-integrity+bounces-4110-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DC59C7C1B
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 20:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0BCDB25AEB
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9A204012;
	Wed, 13 Nov 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETqF7xgE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518D2038AA
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524397; cv=none; b=aXe8d9e1P1E7+9cH/PpdUSyNm6UHDYfoc0UyHIALA3LyInunziDKqXSWiLf3UUqaqkg4zJtE4sBHCvK72Z/kt86n+A63s5h6Muw0poPK3lHNbyjSqJJ8H7OTJ71QxyPvEbgu1P0v6gYXwzavlGdV/jKIF2YDXi9ZslY29cdlj80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524397; c=relaxed/simple;
	bh=ryyhAnF2SO0tJwmUNlyD1f/Q3W3wVkcxK9WXdEWlaBA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=uT3hYhD7tQTSp2SfHIvtK2FQb4Aqux8UhnsmPuWDK8Ar3ntUgDgNA6xKqrX79o0UzkwS/OsHLO5cyBmt8d9Lac7U8ILPPChE3RXZJuZhH43u2Sm1DQmcUabjPAv/gAYfq2Zj+m37p4UOL3/cmIFPeAZR6UD7EpHGgLyIw3fD2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETqF7xgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF489C4CEC3;
	Wed, 13 Nov 2024 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731524397;
	bh=ryyhAnF2SO0tJwmUNlyD1f/Q3W3wVkcxK9WXdEWlaBA=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=ETqF7xgERq6NAtYN/jzhUfEK02pZumMNwirapsrtdxh/5nDW56r5U1nZ1DBNfKRuJ
	 JcpgKJTyGB7BvD2gM1loqpumk5Q1L8HMWypTobymZGIyEGXKVIHZLsTA+0tvqsRaD0
	 c28aWgWSwA9k+YZHULxFKeKFyzZLFBDG0M6oq7lZB2j6vng6SL21W0i5pf8FWJNWrE
	 84vnO9OqpNMtjiLfneHBf7hWV2GqE3z05E91AnFjxpm4B/VBsQEN/K7YO7AfWiAV/O
	 6l/jY72w8DmTBvJl1GOlDPLRWBDVzdPlD7HXaQQxyUvmA5HGDuyOCXdJZRJ+Ju5UNf
	 vz0gXZ6bNQ7Bw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Nov 2024 20:59:52 +0200
Message-Id: <D5LA64STJRU1.1V6GQCO7Y95K9@kernel.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Christoph Anton Mitterer"
 <calestyo@scientia.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
 <D5L9XVNXYQR1.2EBNEZRV0QVUI@kernel.org>
In-Reply-To: <D5L9XVNXYQR1.2EBNEZRV0QVUI@kernel.org>

On Wed Nov 13, 2024 at 8:49 PM EET, Jarkko Sakkinen wrote:
> On Wed Nov 13, 2024 at 4:44 PM EET, Christoph Anton Mitterer wrote:
> > Hey.
> >
> > Forwarding myself from:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1087331
> >
> > Since 6.11.7 (might have also happened with .6, which I've skipped, but
> > wasn't the case at least in 6.11.5).
> >
> > I get:
> > Nov 11 17:50:20 heisenberg kernel: tpm tpm0: A TPM error (2306) occurre=
d attempting to create NULL primary
>
> Yep, I found the reason. My fix causes this. I sent a fix.
>
> The problem still persists related to TPM bus encryption not working
> with hibernate in 6.11.5 but the message was shown only once in the
> log (and thus you did not notice it).
>
> That can be worked around e.g. with kernel command-line flag that
> would disable TPM bus encryption but it is out-of-scope as far as
> I'm concerned.
>
> Please test my fix and I can take it to PR.

https://lore.kernel.org/linux-integrity/20241113184449.477731-1-jarkko@kern=
el.org/T/#u

BR, Jarkko

