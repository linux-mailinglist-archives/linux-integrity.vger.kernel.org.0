Return-Path: <linux-integrity+bounces-3585-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E997907E
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2024 13:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F111F2199D
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2024 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1151CF5DA;
	Sat, 14 Sep 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+wCW3dB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B641CF2A3;
	Sat, 14 Sep 2024 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313361; cv=none; b=Fh5RR4WW2hWVtnAD4bV0Cd64hf7n05tBbsm6fZJzB3x0jqsvTnwrRhO/StEnfumfIZ14R928p40g39FW7nlEsX3h0RuUOUOuOYjaYJdD8+09Pddul7u4oq4rPrmH9lKLUuQV1+4mx7im4p/IO4h7KJ5LgZvl1aLWZOO6Vmq65es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313361; c=relaxed/simple;
	bh=casbvh9kbHncZBmUL5DCOYGilWBuBqqCYSzHdmiNt/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=MqqATcEVUYvn+wBd0LmxU+eLNF+rchF1qiekY2SMHsVs9M+VzaRB/x8u1yZZ9IqrMh/UMOxBPzhwDwEgxsx/U+fN5tzCIDNReELoxI+XjT0BTljZVV4qkGkL8pZzm0CsmcgPh8LbWSRnPF7QSySCdOBeDKIB9NuHS/UHtEAnmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+wCW3dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBEDC4CEC0;
	Sat, 14 Sep 2024 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726313360;
	bh=casbvh9kbHncZBmUL5DCOYGilWBuBqqCYSzHdmiNt/8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=j+wCW3dBq0EzO2qOfJrE/61ylDd4Yq+Xa+vSSkwJSxd69j5q9OwCTm/8rq7OJv5/g
	 1z2Lc27tHVsveKkEbDNaCQU604YToadR1nmCTtiP/jqF+aA2TgMNT+rwtWsrjz8ugK
	 2PkjhVn3L460P3Xi2pQZGOHmELfRfSFVJJQyLZ8GaLfoGTlCNA66RgJcJj4v5hHmBb
	 gq9RzEimoGW99aR3IjN4F5i+zfmjK4M64okcgtc7dtz5sWXgc1kMDD3jguqjjDJHA/
	 1GVpIdyCmXE50MmtSLkVEk0OoPi3oCH6SviONFHqoBebYPPuru0oe/EFxDXV07fKsx
	 /foWJMuwpkjpw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Sep 2024 14:29:16 +0300
Message-Id: <D45Z0FUO6UXA.3SUWRYAENNFNT@kernel.org>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>
Cc: <dhowells@redhat.com>, <dwmw2@infradead.org>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <torvalds@linux-foundation.org>,
 <roberto.sassu@huawei.com>
X-Mailer: aerc 0.18.2
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
 <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
In-Reply-To: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>

On Fri Sep 13, 2024 at 7:45 AM EEST, Herbert Xu wrote:
> Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >
> > For the envisioned use cases, PGP operations cannot be done in user spa=
ce,
> > since the consumers are in the kernel itself (Integrity Digest Cache an=
d
> > IMA). Also they cannot be done in a trusted initial ram disk, since PGP
> > operations can occur also while the system is running (e.g. after softw=
are
> > package installation).
>
> Does this address Linus's objections? If not then we cannot proceed.

I don't get why integrity digest cache is brought up in patch set
discussion in the first place. It is RFC patch set. It is misleading
to bring up everywhere as it was something we would need to take in
the account.

Let's worry about that once it is even a feature.

BR, Jarkko

