Return-Path: <linux-integrity+bounces-1948-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E0893B31
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A42D1F21D3D
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 13:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2F3E497;
	Mon,  1 Apr 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs3dk4vM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FD3E491;
	Mon,  1 Apr 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711976696; cv=none; b=Ox5aCCsKSyIppYfrqkL3MuJGhCf66DcYYK8xgy0pqRHbHaF1P/xxfZ46AyxeEe3ue6jvsIlpQtowB7GcsekwNzj7q3cBIMkR3a965NaA+k4JQvTYANwgsvQOiFSlu3U+FxFfLghgESTXL0NZulXs2TXLeB5TqCGyFamk3+psmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711976696; c=relaxed/simple;
	bh=LsKwqBI3UN17wqyHf5jITWSvh8LGm3Tkr59aZXOj3Cg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l/D7mHLugDi2Jl8YNK2tclmYrxxsZTw+2S5O8L1hKMRDk6fuidwU/QIzCuniMm3GNIzoVGFm2iSuWVnfNRvBbNG+0mF2bx1lwTr2Uf/GTRUa5wx8CNJ1Jn7VZdMOBlzkspgy4xB6iMUJHXIZcGrZn4WlPcbVj9cpnqROLr38XLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs3dk4vM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B39C43390;
	Mon,  1 Apr 2024 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711976696;
	bh=LsKwqBI3UN17wqyHf5jITWSvh8LGm3Tkr59aZXOj3Cg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Vs3dk4vMeKjhM2guiRDI0bhfJFP0Q5/QccS66Mr7wtCUqi9epy6BX55E7vSr/TBi8
	 kWpeVyYzjAWDnVpM3b97I/D+XRRwVCMW5wnpun4VAaqjsB/fXtPDF6MsMUWlomMw7k
	 DPEis1kbWRR7pl4a8aYzNPE1RotUgV3s1AoZf/vEJ7KLzvzIkZZinzLCOvonFnF4pR
	 mL9p1vfcPQLCAWPPsBzfhvPEHp5689thlP0veF0Hr3Xx+vH+tJ8Me7/LH6iGir4Ni+
	 83OkyE63jStCOrP0/x868TIv8lx3RvZcvBpow8J/4XkU26o/4pB1dS7DRS4SAYh7ZU
	 KaUtZxg3n7T7Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Apr 2024 16:04:53 +0300
Message-Id: <D08T37HYOTOJ.2P9FYL2UB0GX8@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 =?utf-8?q?Gabr=C3=ADel_Arth=C3=BAr_P=C3=A9tursson?= <gabriel@system.is>,
 "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
 <D08273C2C8HD.2QT57ZPAWPS9H@kernel.org>
 <ea2a3a9a2bea2f1af5565ed32e9584caee2fbecf.camel@system.is>
 <D08SXGNWN4PG.8KW3OIV7WTIK@kernel.org>
In-Reply-To: <D08SXGNWN4PG.8KW3OIV7WTIK@kernel.org>

On Mon Apr 1, 2024 at 3:57 PM EEST, Jarkko Sakkinen wrote:
> > > So for the time being the patch set is NAK just because we lack
> > > clear definition of done here. I revisit it only when I know how
> > > to test it.
> >
> > I want to note that I'm not affiliated with the patches' author. I'm
> > merely an outside observer who has taken interest in the proposed
> > changes. Wanted to share my thoughts.

I.e. thanks a lot for the feedback. It makes sense to I'm just confused
overally of the provisioning topic as one big player (Canonical) in the
cloud seems to break that guide, unless I missed something.

It would interesting to get some feedback on this from Ubuntu developers
but I don't know who has worked on TPM2 boot feature on that side.

BR, Jarkko

