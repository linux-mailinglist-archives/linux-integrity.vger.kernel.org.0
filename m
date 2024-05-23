Return-Path: <linux-integrity+bounces-2580-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC68C8CD539
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 16:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962E92827F9
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 14:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303914AD02;
	Thu, 23 May 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psZsFl9w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD61DFCF;
	Thu, 23 May 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472844; cv=none; b=ZhbSODWC0KNddp8uOZv9uQcG/DBcMCpG1JgHh71l5j46UqAyMzBHGZ/Eqy174lvrU6FUVRXfBsYKJ8498GyJhtnB3tz/R6/fkMQBzfELRf9i6aTrfw7/bIxadBzQbO9TVV5g5eHVfUtS4bOp/WEbTbUm8NLtLcHiBJcHVMhQZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472844; c=relaxed/simple;
	bh=g2wrvqWke5gA9/lbD8RQMqZzkfJoHpqwiVs/RmRTzr4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Py/3aPm+QCI+TRVf6+jkYIthvxPM9uS9Zd4HVLQMS7e9SesFpdfVFW/9731T2nn6cje4aJFfenTRLtXvkxLqvdAeX9BpjrzbhxzCs1j15sXr6hlfoDZAgafk/VWmBi7tvMmX5QN6/87LtZIZ45m8j/jlejExubkv/YCHIU9UazU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psZsFl9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA831C32781;
	Thu, 23 May 2024 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716472844;
	bh=g2wrvqWke5gA9/lbD8RQMqZzkfJoHpqwiVs/RmRTzr4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=psZsFl9woJqpNRxeB6ga91wgwUKA43qJkrtIjMRwJsuxhuCWHvATheNyRKZRQq+Mw
	 5QEoeK04FHgTX3ttw14Wfz/UP8lQ9BTqUDc8V1vco7aSjTLonN4Hpe9G7AUevLTWJo
	 vkz59hM96LssCBwtL30vX2WxL+UqjSEz/lh7M1TKwvdvqd4hKaYQzPsJTVHI6Qsx3z
	 P2gRxAH0DSw1+w6I0Ib8KDRHP17KgOYbhTOEoQMDRTmbiOaJN26cgrOiMb14vonUV+
	 2ZZK6vyxa+XgQBY3ARIFiXjY13c7PFkz7W07F0Tu8wuT1/8nrVrfTNfWCtgJawwuKh
	 w2Pi9qHYwnvuA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 May 2024 17:00:38 +0300
Message-Id: <D1H2U8D0NDDC.20TI6BZ9BEFQY@kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Use ASN.1 encoded OID
From: "Jarkko Sakkinen" <jarkko@kernel.org>
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
X-Mailer: aerc 0.17.0
References: <20240523132341.32092-1-jarkko@kernel.org>
 <575953.1716471389@warthog.procyon.org.uk>
In-Reply-To: <575953.1716471389@warthog.procyon.org.uk>

On Thu May 23, 2024 at 4:36 PM EEST, David Howells wrote:
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
>
> This seems reasonable.  We have a limited set of OIDs we can generate
> (currently 1).  Better to store the BER-encoded form and copy that in rat=
her
> than trying to turn a pretty-printed OID into the BER encoding unless we
> absolutely have to.

Yup, I crafted a plan in response to James about possibility to generate
all from a CSV file (oid_registry.gen.[sh] and oid_registry.h incldues
oid_registry.gen.h for compat).=20

No bandwidth to work in it, but happy to review it.

>
> David

BR, Jarkko

