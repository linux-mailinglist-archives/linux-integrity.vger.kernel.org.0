Return-Path: <linux-integrity+bounces-2614-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9898CE632
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F9B1F22078
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F06D85C6C;
	Fri, 24 May 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCG2FMss"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448681EEE9;
	Fri, 24 May 2024 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557687; cv=none; b=goaSMzxwBeMBxEWGDz01nNe4KIyEjUehwVkvG+V8T3Gybo5YbpwrLzZlZV83B3VUopB1+PhdDQG2EBnAjJejsR3n2bw8qPN75g/aH3yalGzfWYlOY37CyhEyRzM6WYncIyHMiCXDr8PFpCeU6WN+fAe0ULSv0vjV9MFDTaQKA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557687; c=relaxed/simple;
	bh=ePlYK0oLPxsViV0ph69iWh5OXUibz6rA8+Nk/IRswgE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fzzBaQob283RLX5A+yS/RvFcsjDDoLOkQVZrboAVWut5vJSOSl4z7MWbfj8zMAOlOxYuAxAz9zu7Qi4OCJQEn6XHP0v1oLTYaJacZdC71C6eAaqUMyKqxcHe7NwjxKsGDvGXLaUzkl36f5qPXKmJvolvYqrT4AdtvxNjd95w790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCG2FMss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058C3C2BBFC;
	Fri, 24 May 2024 13:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716557685;
	bh=ePlYK0oLPxsViV0ph69iWh5OXUibz6rA8+Nk/IRswgE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HCG2FMss3mT3wqk7zuy89KNvCrJljI8/9/yjubCM8cIxgPpSqGbotJungFnhO4aYL
	 nIFAi/cl73EFVj6U6vhdahWLHnqmM8iKeVVyElSceimJoU2Q18wcwHe8ZeCg/fMv44
	 sTo41+Ix6qIdaEs9LgM7Kd7TVmVcd6XRs9u1FbWTAGFgwBVeS8a+FP/eEwY46OZKi3
	 yIEn60POnriPwXpzWUtld1t3fqi9nrCw6cjNgkLKwwF3R7UQGSMuRRLjgtFiSlBmeY
	 guoUVI1WB3CYcNGdHIOPIqaIp5Fr1zfO4GlNSf9OiUvFUd1wO3w+7fv1dTSPiuWVry
	 vbYSIDryN9uVw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 16:34:42 +0300
Message-Id: <D1HWWX4G4ZOO.2UBZQ3L4225UM@kernel.org>
Cc: <keyrings@vger.kernel.org>, "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] lib/oid_registry: add ability to ASN.1 encode OIDs
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
 <20240524125955.20739-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524125955.20739-2-James.Bottomley@HansenPartnership.com>

On Fri May 24, 2024 at 3:59 PM EEST, James Bottomley wrote:
> Consumers of the ASN.1 encoder occasionally need to insert OIDs into
> the ASN.1 stream.  The existing interface in lib/asn1_encoder.c is
> clunky in that it directly encodes the u32 array form of the OID.
> Instead introduce a function, encode_OID() which takes the OID enum
> and returns the ASN.1 encoding.  This is easy because the OID registry
> table already has the binary encoded form for comparison.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  include/linux/oid_registry.h |  1 +
>  lib/oid_registry.c           | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index 51421fdbb0ba..87a6bcb2f5c0 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -151,5 +151,6 @@ extern enum OID look_up_OID(const void *data, size_t =
datasize);
>  extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
>  extern int sprint_oid(const void *, size_t, char *, size_t);
>  extern int sprint_OID(enum OID, char *, size_t);
> +extern ssize_t encode_OID(enum OID, u8 *, size_t);
> =20
>  #endif /* _LINUX_OID_REGISTRY_H */
> diff --git a/lib/oid_registry.c b/lib/oid_registry.c
> index fe6705cfd780..adbc287875c1 100644
> --- a/lib/oid_registry.c
> +++ b/lib/oid_registry.c
> @@ -12,6 +12,7 @@
>  #include <linux/errno.h>
>  #include <linux/bug.h>
>  #include <linux/asn1.h>
> +#include <linux/asn1_ber_bytecode.h>
>  #include "oid_registry_data.c"
> =20
>  MODULE_DESCRIPTION("OID Registry");
> @@ -196,3 +197,31 @@ int sprint_OID(enum OID oid, char *buffer, size_t bu=
fsize)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(sprint_OID);
> +
> +/**
> + * encode_OID - embed an ASN.1 encoded OID in the provide buffer

nit: "encode_OID()"

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

> + * @oid: The OID to encode
> + * @buffer: The buffer to encode to
> + * @bufsize: the maximum size of the buffer

Align with tab characters.

Hmm just for sake of consistency s/the/The/

> + *
> + * Returns: negative error or encoded size in the buffer.

"Return:"

> + */
> +ssize_t encode_OID(enum OID oid, u8 *buffer, size_t bufsize)
> +{
> +	int oid_size;
> +
> +	BUG_ON(oid >=3D OID__NR);

Please use neither WARN's nor BUG_ON's as some sort of assertions.

It neither need pr_err() given it has enum type which AFAIK will
be detected by static analysis, but at most pr_err().


> +
> +	oid_size =3D oid_index[oid + 1] - oid_index[oid];
> +
> +	if (bufsize < oid_size + 2)
> +		return -EINVAL;

Hmm... maybe -E2BIG? It would overflow.

Here it would make actually sense since it is not enum typed
parameter to issue pr_err() because it is clearly a programming
error.

> +
> +	buffer[0] =3D _tag(UNIV, PRIM, OID);
> +	buffer[1] =3D oid_size;
> +
> +	memcpy(&buffer[2], &oid_data[oid_index[oid]], oid_size);
> +
> +	return oid_size + 2;
> +}
> +EXPORT_SYMBOL_GPL(encode_OID);

Yep, makes more sense than the old code for sure.

BR, Jarkko

