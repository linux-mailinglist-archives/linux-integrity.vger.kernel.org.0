Return-Path: <linux-integrity+bounces-2581-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0793B8CD540
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 16:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6784284E82
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801C13D621;
	Thu, 23 May 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGjpHLR9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E901DFF8;
	Thu, 23 May 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472880; cv=none; b=bf5kBh97xEMxUV8kL+Nc1S5l4jOWXeN4bz/+3a/rSKlYN7EdV0YXHtx0CvM7OH1RaLnYAD4TqiMe9Er41AUBqx3zKjGuQg+qZ6GpEHfXvwlLqhxXRou7oTI5LtJDjNYziis9KPC2K0pRDOBy21VjBYBOZg44xb8fnKP8oH8dey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472880; c=relaxed/simple;
	bh=tRKZmbPOTvI23VV67m+vV9W4fwcgI39dj6FthEbjgi8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=njM+N0TyQ/OA0yrBqjPtSzJw1lHQIk/2c3FNTtAfG/1z4btDdBQ16zC8vRHQDzWJ4DMwQ1rjre7OEtVVKksRl0vDGUAmd0xAygOvB4LFkh/Eudqiz8smayVkzwcfpsxtmyiZ5ERg2hC40sLDzqnDp14l8XB+TB0BuT50GVQyDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGjpHLR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FA9C2BD10;
	Thu, 23 May 2024 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716472879;
	bh=tRKZmbPOTvI23VV67m+vV9W4fwcgI39dj6FthEbjgi8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=gGjpHLR9w345lhL8pxttkPEpky4+fa6YtHkdcCUWM08co1kKjYD9+Q0cyUtVBZONN
	 Lw+TsMUFQYmq/xWzr9lmWVsKbiYbCwCXosLZtmqq+kAiQynlnlxB3gzshLWHyosTs3
	 S/Nr8gMPsHWKB9I9kUxDdr3TPBOQjI655XRen2zwRKZNZ+Xb2RRXAfedfLKplf5JI2
	 NsUWSf/pc12UbaPPrgFLf1YpCyT9Ypnaj6j90/ge238n0m7lrsM2FWoNDES0GMkdPS
	 5gpkPEmuAMAMvkZ7xPKV6xoxwdxbgsiZczivCCdYjnxVgrtHG2vTmOgTCaWQNxhWhP
	 4boxiv62xXGLA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 17:01:14 +0300
Message-Id: <D1H2UON4NTVS.1JG8PCOCAL4NY@kernel.org>
To: "David Howells" <dhowells@redhat.com>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, "Eric Biggers" <ebiggers@kernel.org>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:SECURITY SUBSYSTEM"
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Use ASN.1 encoded OID
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240523132341.32092-1-jarkko@kernel.org>
 <576061.1716471541@warthog.procyon.org.uk>
In-Reply-To: <576061.1716471541@warthog.procyon.org.uk>

On Thu May 23, 2024 at 4:39 PM EEST, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> > There's no reason to encode OID_TPMSealedData at run-time, as it never
> > changes.
> >=20
> > Replace it with the encoded version, which has exactly the same size:
> >=20
> > 	67 81 05 0A 01 05
> >=20
> > Include OBJECT IDENTIFIER (0x06) tag and length as the epilogue so that
> > the OID can be simply copied to the blob.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Reviewed-by: David Howells <dhowells@redhat.com>

Thanks!

BR, Jarkko

