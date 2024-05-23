Return-Path: <linux-integrity+bounces-2599-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA008CDC64
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 23:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01CB288940
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76947128398;
	Thu, 23 May 2024 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+QTRAc1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8C12837E;
	Thu, 23 May 2024 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716501170; cv=none; b=hFSBNKEO26RG6YRlWi6qG6LetlNMkdjd0aYROhOmojf6nKdJIz5XLus/Q4VgeGdR36v0Jzojl92ZUjUL1QUTXuoQiBcRku3AABZJNpNgMcADehCNRe9B3WsKqLwy2uoINVYndQsGeek5o6FdyI5UsRCL8xSuf9VARoe6nJmbixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716501170; c=relaxed/simple;
	bh=qVXCdb9gwnJoKTwqTDhw5JHJWQVhusvlDAvTSUdAPNA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=QDsmSkrBASVtwvMBlJD+pBoRH/dM1AFPB3FdHsJcuHUs1qBhf9V436ch2VJlTmcA4OI995yY/n3i1P1Qe9UFbn4eSirb8vSMeuc30zYZhhRJ9CSa0584lWsEB2Jtcw8ZdUcVl8b6GRAZEaXNx7bO0nTnw0EkORm6ugDzBy+Kr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+QTRAc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540A5C3277B;
	Thu, 23 May 2024 21:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716501169;
	bh=qVXCdb9gwnJoKTwqTDhw5JHJWQVhusvlDAvTSUdAPNA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=N+QTRAc1vqCf6bb6jlX8pcoBnHH0ZHS4WSWeqk4QWQAbwlSXP4+QRTxc6DyZdyhYo
	 UhElfJ7/a+UnL1Lg9fNdl64D/D7sEe33fXbTqPfqJwsRF9k/9/i+A6NvL+k3evJZ5a
	 1nPSzcCYcOst0tpv65+/Hvdm/ixRjvMtSBR48gLJkGTrRzxE7Z4Pc/Q9U7VVhSeARZ
	 F+wCkyi5wTjH8kAO1/ecrDmA7SJrgEklcQhRxw+O6mNHxlkhg2eJjL3OvPmRg9q/Jj
	 pHagKMt5mAtvokwNGR26zi0LUYHn4Ah04hxRmxFutXXoJjdJuQXttpZ+coHS3F6hsT
	 UaG2G6+jm2KrA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 00:52:44 +0300
Message-Id: <D1HCVOZ1IN7S.1SUZ75QRE8QUZ@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, "open list"
 <linux-kernel@vger.kernel.org>, "David Howells" <dhowells@redhat.com>,
 "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: Re: [PATCH v5 5/5] keys: asymmetric:
 ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240523212515.4875-1-jarkko@kernel.org>
 <20240523212515.4875-6-jarkko@kernel.org>
 <D1HCLFMAEXX5.17QYXMTZQCRYE@kernel.org>
In-Reply-To: <D1HCLFMAEXX5.17QYXMTZQCRYE@kernel.org>

On Fri May 24, 2024 at 12:39 AM EEST, Jarkko Sakkinen wrote:
> On Fri May 24, 2024 at 12:25 AM EEST, Jarkko Sakkinen wrote:
> > +	/*
> > +	 * ABI requires this according include/crypto/akcipher.h, which says
> > +	 * that there is epilogue with algorithm OID and parameters length.
> > +	 * Neither size nor semantics is documented *anywhere*, and there's n=
o
> > +	 * struct to hold them.
> > +	 *
> > +	 * So zeroing out the last eight bytes after the key blob seems like =
the
> > +	 * best bet, given no better (or any) information. The size of the
> > +	 * parameters (two u32's) was found from crypto/asymmetric/public_key=
.c.
> > +	 */
> > +	memset(work, 0, 8);
>
> This is a mystery (or nightmare).

This is from akchiper_alg documentation:

 * @set_pub_key: Function invokes the algorithm specific set public key
 *		function, which knows how to decode and interpret
 *		the BER encoded public key and parameters

No struct, no size information and no description what they are used for.

Can we get these properly documented? My documentation at the moment
is grep and kprobes, literally.

BR, Jarkko

