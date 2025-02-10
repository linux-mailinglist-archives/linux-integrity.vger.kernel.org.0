Return-Path: <linux-integrity+bounces-4768-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 430F2A2F54B
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 18:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAC61883514
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F343255E2D;
	Mon, 10 Feb 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B24YywH0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0A255E23
	for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208608; cv=none; b=o5JUGjIt8fL0LlM5/MAxigWGgEEfw3mEPCanV52+h1tSQs4BAT2bM1yf2/3vyWK1lQ6IOR78w1fe9pphZ+BJvGWhDXaFDykxXloFhkCbJc46s6rdzN4LH0+XBS5GKAChO8/x+HbS93RVzKRx1A4+3B5t4PtLxAelyqu41nJ3Gck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208608; c=relaxed/simple;
	bh=1NwFT/YQB6ZUKRIOHGVRf0xBGm9bsA0CHdJi3vUp6NU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mAYEUeV2ca7c0vvHxuOOvdRhkEVzvNEmplaAhSVD10dUIeohaLXotKKIIIqaLWa+XIAzN47Z3mGDlPh1+RPVkHhGAHgjWj5V77mlXmLo+LkAzHH3Cmfke/sIqWBa7pQS/EjQLuOO/zgl0BospFrAsxw6mot3eyZ7eLbVpBI4N/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B24YywH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ABCC4CEE7;
	Mon, 10 Feb 2025 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208607;
	bh=1NwFT/YQB6ZUKRIOHGVRf0xBGm9bsA0CHdJi3vUp6NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B24YywH0HUeUZ5JmQz6cn4yzhHcXxRSvlQ4onS6n/xVGnOi4jSnEHxjnEbKcZc16g
	 I9uP644DNqJ53qtP6Th7vg9jPV0L1vx7iMJKNwSrL3HZK0ZB5bBXq766S6n/mFg3jE
	 dn5bSiVbvJmHr/0yhdukpegDJvOr1h/W0Gb5jyZJGhHGCuvrnh2W4Ac8jQhoRytobq
	 VR6LKSNWdIjDa4nVE8zxPFW32TbVgg4uYZXEZ7/2uyiwNfMwvmiKdESzRLmMgwV9tm
	 gGGS4oVbT0gujSDXASglaYrmmrUJPMziSXKUTktD0HMIaFs1UHb9rvJWJqnsiNu9OY
	 EZCppwcxSGc8w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Feb 2025 19:30:01 +0200
Message-Id: <D7OXZTO4LKTX.V4J1P9Q4OP0T@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jonathan McDowell" <noodles@earth.li>, =?utf-8?q?Michal_Such=C3=A1nek?=
 <msuchanek@suse.de>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: TPM operation times out (very rarely)
X-Mailer: aerc 0.20.1
References: <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
 <Z50IKdYe42_n2B0b@kitsune.suse.cz> <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
 <Z6Nm7Y8TFF8YG56Z@kitsune.suse.cz> <Z6N10NQY75hpX0Ed@earth.li>
 <Z6UdFCdqCNZ8VGOL@kernel.org> <Z6XRuFnEXeQI_rEZ@earth.li>
 <Z6XVAEfLIVDuwSLn@kitsune.suse.cz> <Z6XWoWAy66P97pAU@earth.li>
 <Z6XZN3U5nmb6qu9u@kitsune.suse.cz> <Z6olt1NHonKkamtM@earth.li>
In-Reply-To: <Z6olt1NHonKkamtM@earth.li>

On Mon Feb 10, 2025 at 6:13 PM EET, Jonathan McDowell wrote:
> FWIW bpftrace is great for this. I'm using the attached script as a
> basis for investigations. Obviously the timings it reports are the whole
> command rather than just the wait for status, but over a long period it
> can then show you the latency histogram. (Run it in one terminal, do TPM
> stuff elsewhere, hit Ctrl-C when you're done and it dumps the
> histogram.)
>
> J.

Yes, I used that to trace and spot issues with HMAC integrity protection
in the near past.

BR, Jarkko

