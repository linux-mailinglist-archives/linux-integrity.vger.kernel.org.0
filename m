Return-Path: <linux-integrity+bounces-2299-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329258B82BE
	for <lists+linux-integrity@lfdr.de>; Wed,  1 May 2024 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E701C22A2E
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4494F249E8;
	Tue, 30 Apr 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLEQQs8l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6E1EA84;
	Tue, 30 Apr 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517221; cv=none; b=A8TbVfavhJdpDyD3uo5GuLR7N9z0AeWqNVrrDz67dvU8tzF0msILn3Aft+WosFLAG2QHucDA/1GP9t+yu4yYnblb310qwv/6RQgpjRuzm96WwVO9olWd465uEiSsgjTHnUfg/vs20eB/i4TOLHOV2n2RnM/stDyWFGCpnpbUQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517221; c=relaxed/simple;
	bh=xwt+wMGSMAn7o8xRPCM2ULnPvug2GWCAzx22H9vrn+w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GbKjgXYLj79cArPluxfJhGNmyKEr59+S2zIw8xk2j6hGuFOkmjfd37BJIOaQ8vRRHkF5geJfJ06n4v/W2gAI5kqSqppRbpnbeLPKD9nS/zf8v4zYhtVG09BK4JzuvirIfuDfLiTMTnU5KLc7SWwu/P8gWXVe6XLSd8nzUhh0zgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLEQQs8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C002CC2BBFC;
	Tue, 30 Apr 2024 22:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714517220;
	bh=xwt+wMGSMAn7o8xRPCM2ULnPvug2GWCAzx22H9vrn+w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jLEQQs8lBsfOgmlVyNRRO37KsbewnAnLZTh7JCGVxS1FVgfbZV4vSlgXVvKyMOpzR
	 vojglWv+MaHo1Rr5A0j70R4hSrsqSB7IXEdEHvjfqPpFmrZzzuQTn4ijuZikoEaLAb
	 uMyJSzPABZYSvfqivLzwHD3oGlzkg9K9fseHCiFmSCFXg35qgEbfC5TSquT5yqLY3f
	 qszMqsw65VkxhTxl9teaBP36j6KS3jHp4PmWs4xuEYgnp5z+RS7YGL+S07VRwBJBZC
	 7OJUsU8ev6AQsOGsOXbIzhtYMnY2WOL6zm0xFIfZxCQzbcbCOE7G2i0DdMVGzHbx/7
	 oiY0cs9STl5fw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 May 2024 01:46:57 +0300
Message-Id: <D0XTMODYQ0MO.38N6NKD1SYOXI@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 00/22] add integrity and security to TPM2
 transactions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>
 <eef3292f4680c22b817021f973a34a1657b82c86.camel@HansenPartnership.com>
 <D0XSE6G33OHS.1B4OFPN0NCEIM@kernel.org>
 <c175a43a1c33a9513e3319e7b29e3985a140b4da.camel@HansenPartnership.com>
In-Reply-To: <c175a43a1c33a9513e3319e7b29e3985a140b4da.camel@HansenPartnership.com>

On Wed May 1, 2024 at 1:31 AM EEST, James Bottomley wrote:
> On Wed, 2024-05-01 at 00:48 +0300, Jarkko Sakkinen wrote:
> > On Tue Apr 30, 2024 at 10:23 PM EEST, James Bottomley wrote:
> > > On Tue, 2024-04-30 at 01:22 +0300, Jarkko Sakkinen wrote:
> [...]
> > > > Since I could not find the email subthread I neither have the
> > > > patch nor do know the baseline. So if you could help with these
> > > > details then we can move forward.
> > > >=20
> > > > I can also work with QEMU Git fork if you have one and point out
> > > > QEMU_OVERRIDE_SRCDIR to the clone.
> > >=20
> > > I only have the patches in a local git repository, but I could push
> > > qemu up onto kernel.org if it would help?
> >=20
> > That definitely does help. I can point out my build to that
> > repository, (or actually clone of it).
>
> OK, it's the mssim branch here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/qemu.git/log/?h=3Dms=
sim
>
> It's based on qemu head, but it works for me.
>
> James

OK, cool. I'll test this on Thursday as tomorrow is national holiday
in Finland. However, I'll quickly just try it in my host before going
to sleep (if there is any feedback to be given).

I happen to run Tumbleweed nowadays so I can just install ibmswtpm2
package, i.e. should take only a short while.

BR, Jarkko

