Return-Path: <linux-integrity+bounces-2598-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45688CDC39
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 23:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5A01F24409
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C584DF5;
	Thu, 23 May 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0H9br4a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCC42A94;
	Thu, 23 May 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500366; cv=none; b=AnCdp0eamBTeSDPh+90P1gfJv1U9laD9kFNFXDS1T5dPXUv87Kc8lRI0s91LA0Xq5eQJKJk0VXjsCkRCbUe9QI5M6Mx1EtoGPrRWlID3IB3WNyxP4cT7ch/yKrKEqOM37fX84twhwgYl4qotaeVjYulClVc/y0Jkv8BYSSQmnMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500366; c=relaxed/simple;
	bh=MABXd/LGmZtWyBG3t8ftCTHS+SQ0rjqhQSLRN+Nb7+g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iXPKd3yIwN48uNtB6qs5JWSFYfkGb5wYEaIOBHMxiQX6lW0cB/O3udEWG038/Z/bQ+Wxq2ZKEhEuvsqq5+QlBeH6rCiTSlBxyZEVQni/9jvyWZYSNLvVKXCLpZKkAohAdFXZCo0KJpQvFtyQN+cYn6ep9MiA0W+kyzJBK9iKWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0H9br4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649A6C2BD10;
	Thu, 23 May 2024 21:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716500365;
	bh=MABXd/LGmZtWyBG3t8ftCTHS+SQ0rjqhQSLRN+Nb7+g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=c0H9br4aUfy6r2sPGYZft2AlGhkDWbS4YJ36sTxNOtPAgEyvNFKQXpmj4jBKRon+0
	 Ee+o6XyoGXbFMNmIzmEYR5l7kTJ7g9oWLqgetF4i+lftbbbXZOG7ACUrtHBqrXzJmt
	 e5vVLVAZgZcJfERrxYbjQwdUE6P/wQgseaCwo/C+tcz7kKpNb7QtlYQpCEOi4lKXCi
	 WnaoUfsuyI8xWt9M2q941ViJBgzxvVXHwZeDUjnNie8/Jz+Sn1g3OGQgNx1P2S1xpG
	 I2KTqvuU6EkJ0hl7kzftKI0IEW5nRt82VxYzijzN2iUv8Olii7KWOsge0UPbZeQoYY
	 BAW+6SoWnb1zw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 00:39:20 +0300
Message-Id: <D1HCLFMAEXX5.17QYXMTZQCRYE@kernel.org>
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
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240523212515.4875-1-jarkko@kernel.org>
 <20240523212515.4875-6-jarkko@kernel.org>
In-Reply-To: <20240523212515.4875-6-jarkko@kernel.org>

On Fri May 24, 2024 at 12:25 AM EEST, Jarkko Sakkinen wrote:
> +	/*
> +	 * ABI requires this according include/crypto/akcipher.h, which says
> +	 * that there is epilogue with algorithm OID and parameters length.
> +	 * Neither size nor semantics is documented *anywhere*, and there's no
> +	 * struct to hold them.
> +	 *
> +	 * So zeroing out the last eight bytes after the key blob seems like th=
e
> +	 * best bet, given no better (or any) information. The size of the
> +	 * parameters (two u32's) was found from crypto/asymmetric/public_key.c=
.
> +	 */
> +	memset(work, 0, 8);

This is a mystery (or nightmare).

BR, Jarkko

