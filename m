Return-Path: <linux-integrity+bounces-3596-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24539796EE
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715ED1F21A34
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355AB1C68AF;
	Sun, 15 Sep 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="t+cL4B6W";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="t+cL4B6W"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663781E4BE;
	Sun, 15 Sep 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408790; cv=none; b=uFhsOeyJfr1TTycAPCsZFgHK4xm+Q8i8E5MzLCewIGucEEQaD4A80yvjy4pQL2+xYUKC3P/cQUOjEOLtiIxNFhOSWgQkgfuUJjOxm8hNKJ7AoJmO/pYOM6drwk738xyrgHklCdqk28/7D6svRMi5ZSimDBlO+taeJK82RbuRGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408790; c=relaxed/simple;
	bh=M7XTnKiOkvygMAVY45yPCdZxs3a5dEDlEj1iCP1KQKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tkuKh4+fZpcVssYsRNmA0zuqj8bgbQXXY2yLPd6UpVckHtSVH1fHN8AH833e6+OH72HutZjPdZmxLg8fMe3ukzPFKpB2gfkLej8iYDG9+dmPFi6aYTROTgqDBk4xe45DGABghfw3r3e/f0tmzltYApN6vZPljTnqzS19pu2us8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=t+cL4B6W; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=t+cL4B6W; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726408785;
	bh=M7XTnKiOkvygMAVY45yPCdZxs3a5dEDlEj1iCP1KQKE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=t+cL4B6WaDuGcwfDgH3IKYaZ30ClKOZtEVeh3E64t3lH1yf6RczNsYdyIpCUMpBf8
	 26gOsY+nsVKRgVBvy9ZYgUCk6+daispswtztoDzm1RbxQ/28wOHtZyr30x2emHYulw
	 lBt1G04jjC407N0CtZOsFS4kNpsV8ryybv4vVNXw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D2A35128739B;
	Sun, 15 Sep 2024 09:59:45 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id NqA8VVMp0qDd; Sun, 15 Sep 2024 09:59:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1726408785;
	bh=M7XTnKiOkvygMAVY45yPCdZxs3a5dEDlEj1iCP1KQKE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=t+cL4B6WaDuGcwfDgH3IKYaZ30ClKOZtEVeh3E64t3lH1yf6RczNsYdyIpCUMpBf8
	 26gOsY+nsVKRgVBvy9ZYgUCk6+daispswtztoDzm1RbxQ/28wOHtZyr30x2emHYulw
	 lBt1G04jjC407N0CtZOsFS4kNpsV8ryybv4vVNXw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 95CDF12872A6;
	Sun, 15 Sep 2024 09:59:44 -0400 (EDT)
Message-ID: <0b22c2c4b4a998fb44bb08be60a359acb9ecb8da.camel@HansenPartnership.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Roberto Sassu
	 <roberto.sassu@huaweicloud.com>, Linux regressions mailing list
	 <regressions@lists.linux.dev>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Sun, 15 Sep 2024 09:59:43 -0400
In-Reply-To: <D46RWPQ211ZS.12EYKZY053BH@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-09-15 at 13:07 +0300, Jarkko Sakkinen wrote:
> On Sun Sep 15, 2024 at 12:43 PM EEST, Jarkko Sakkinen wrote:
> > When it comes to boot we should aim for one single
> > start_auth_session during boot, i.e. different phases would leave
> > that session open so that we don't have to load the context every
> > single time.  I think it should be doable.
> 
> The best possible idea how to improve performance here would be to
> transfer the cost from time to space. This can be achieved by keeping
> null key permanently in the TPM memory during power cycle.

No it's not at all.  If you look at it, the NULL key is only used to
encrypt the salt for the start session and that's the operating taking
a lot of time.  That's why the cleanest mitigation would be to save and
restore the session.  Unfortunately the timings you already complain
about still show this would be about 10x longer than a no-hmac extend
so I'm still waiting to see if IMA people consider that an acceptable
tradeoff.

> It would give about 80% increase given Roberto's benchmark to all
> in-kernel callers. There's no really other possible solution for this
> to make any major improvements. So after opt-in kernel command line
> option I might look into this.
> 
> This is already done locally in tpm2_get_random(), which uses
> continueSession to keep session open for all calls.

The other problem if the session is context saved, as I already said,
is that it becomes long lived and requires degapping the session
manager.

James


