Return-Path: <linux-integrity+bounces-2329-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E238BB81D
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2024 01:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FAAB213D1
	for <lists+linux-integrity@lfdr.de>; Fri,  3 May 2024 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2785883A1E;
	Fri,  3 May 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndf/TOYM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE583A10;
	Fri,  3 May 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778297; cv=none; b=kYG6iQG9y65dxSC4dZILU3/+3Ndz7mWGdGPAngHjXBSWG9lIolO/B0jVwcEE+T95wLIbWoXQnW718nxqnz+/NTSnedNhSKb+PnQ11wV3jv4geDBBX9TfimiLSBYSvIzjJ3RbMMPvQ1ZJnWkwPNHnfd3iQNmPsFmdQqaUa8v2mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778297; c=relaxed/simple;
	bh=9K0PVQiTsoZ92c0Cq2U34+g4IgKR1lCE1JKTheJN+YI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V+UhYSaq5TAGMZYfBE9ATGLczbOCYnG3KtzM1VpRm1buH71ucTX1TFQYlJA7RLonOHKkuf/+xhRGwUypmI7KLpsw79Izp/G3DECzr0jRW4buBP6tO0ZkoLUWlswG1v+rUWkaw5xJmOVyZ2m6dvWmol5WnMdmzEBRQGec9lQvd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndf/TOYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89995C116B1;
	Fri,  3 May 2024 23:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714778296;
	bh=9K0PVQiTsoZ92c0Cq2U34+g4IgKR1lCE1JKTheJN+YI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ndf/TOYM4OxIVcshSAgUawL9bdJV2HIiik3Nw04thS58M25egHJuKh0LO1ISCAeP1
	 OFfAFmfEfCR6zvgXCN9NZYk85U4txHMZmKamjDtqXqxxXdX3w07nlFNHcyWdv4oJfd
	 fx7xbMXp+Ff9O0bJWnDW3/y9riyG9wdqTFmL7YjstlUfnMDPFhzLkTyB4JxhxwPPBC
	 xEN5tiuhkmi+GgHrrmVFy/VoSiiCOm3QeWbgQqieCxGgWgKOSblFjhsAIL8mF0Jfsr
	 NDIIOeRax6aEDtWgrJFeGFRDF9GgcXxYBEBV3J8DH0gVVE8vNVvJWFuga2+7R3OVu4
	 xYiwqr9bLDlaQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 May 2024 02:18:13 +0300
Message-Id: <D10E68XSE1FV.1XZL0Z6TV7DWX@kernel.org>
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

OK so

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

National holiday mixed up this week a bit and I've been preparing also
abstract to ethprague (https://ethprague.com/) which I need to put out
during weekend, thus the delays.

Pretty good timing BTW also considering latest developments in systemd.
Let's stay put for any emerging issues with this through the release
cycle.

If possible, CC me to QEMU patch set iterations. I'll pick these during
the weekend.

Thanks for the good work (and patience in the review cycles)! Awesome
achievement.

BR, Jarkko

