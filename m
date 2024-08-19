Return-Path: <linux-integrity+bounces-3362-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97882957272
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 19:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FA31F23E7F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D22E188CB6;
	Mon, 19 Aug 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlnr14ig"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D93D531;
	Mon, 19 Aug 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090022; cv=none; b=O7HY6P1TbwYdlBKd37U+b0VB+lIjD0d1oiTk+bvlrKhb1xAOu4weTAFfSnIvLlwFu4c6FAFdtj8BrINimbNFbsbHTIobNiiPAhUwuAIZ7JcnJ0LiagvKdgSZim+KT1np46LHwmFYDFP7Mdv15Ek4DMIA07tiGucfPPaltF3pCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090022; c=relaxed/simple;
	bh=jVvW7jUKnI3NPvslQYAUNkMBvcBd3F9eldqTeSxkjTE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JWAYpoB9nMSjXBnj6qC8XPmMQLr/eOxIyFUuSqZeZWlPnyhjyTTCi0tdrhUK+LgFMapDyOOrey+81rVE5ISDiQ5wlLfDcjjXmdFdB7k23wjZOn4LGN9h3hYvRI/OFQmevTkQEUWu+R5yCIY6rEIwk71PWSoIhkl5aRdyobL5UEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlnr14ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CE6C32782;
	Mon, 19 Aug 2024 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724090021;
	bh=jVvW7jUKnI3NPvslQYAUNkMBvcBd3F9eldqTeSxkjTE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Wlnr14igXcgic+mw2PlGKbb77JSNw9RuOP9s/VJDw8r9IOo/EAP15BUm80FRlKHxh
	 D//EjvZlXnB9PdgQWtKgWUPFfwKBijl0yWMrGVyLQuYm5goCVHZTditIIKvpBw25EN
	 PBui7hPlO560zMLldyjhKNZWg+IwKHLBwJosyrcMrcO8ogm2C62xfN/Yvrgtx8zkSF
	 6fw0DGStg1voThrYyTl2kPlgRtRMWVsqs8z7IuOfpLA6VmEoe66zGnaga0vmbNjDum
	 6biN5pfLHLaEWyjIyvydwI995OSejs19av+XLbBKxja0zUy6J8VExmJkZoGIUrqnKY
	 fvCLcbGwDG7wQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Aug 2024 20:53:37 +0300
Message-Id: <D3K2WJR5TW80.1NNF9E2RUW4TX@kernel.org>
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
 <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, "Roberto Sassu"
 <roberto.sassu@huawei.com>
X-Mailer: aerc 0.18.2
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>

On Sun Aug 18, 2024 at 7:57 PM EEST, Roberto Sassu wrote:
> The patch set includes two preliminary patches: patch 1 introduces
> mpi_key_length(), to get the number of bits and bytes of an MPI; patch 2
> introduces rsa_parse_priv_key_raw() and rsa_parse_pub_key_raw(), to parse
> an RSA key in RAW format if the ASN.1 parser returns an error.

I'd leave the discussion about these patches and delete the whole
paragraph. Preliminary patches happen they are not a goal and definitely
do not require a disclaimer in the cover letter.

>
> Patches 3-5 introduce the library necessary to parse PGP keys and
> signatures, whose support is added with patches 6-10. Patch 11 introduces
> verify_pgp_signature() to be used by kernel subsystems (e.g. fsverity and
> IMA). Patch 12 is for testing of PGP signatures. Finally, patches 13-14
> allow loading a set of PGP keys from a supplied blob at boot time.

Write a high-level description of the pieces that lead to solution and
leave patch numbers out.

I'd suggest rewrite the previous paragraphs simply as:

"PGP signatures center around verify_pgp_signature(). The patches
prepending it introduce helpers necessary to operate with the PGP
signatures."

That's all information they have.

BR, Jarkko

