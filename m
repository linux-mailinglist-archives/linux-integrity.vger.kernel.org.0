Return-Path: <linux-integrity+bounces-2701-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9F18D3BDD
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 18:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893451F2245D
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61F1836FD;
	Wed, 29 May 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SukM/c9v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D61836CC;
	Wed, 29 May 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998852; cv=none; b=dMzEu24ls2iNEyGoAQret8nsQeZUL2LG10O+QluQRbtdWHwZ+38I1LhQg/2Uew9JDCxm8pfrBQCxAeQ7JktWUbNGdDHYdF8CQCP1MXdzBHd0SP0FwDQKbuWgrQC/0aNCG+x8XRXJJ6fpscYhAYEpCCJ5PK5c69B8GKvcxolGYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998852; c=relaxed/simple;
	bh=BqJYQUD414oUHDTKcg4GFQrry8JqQEJqLasmiA4XQgI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iJFlcAjH3U/xImClg15b9TDmE9lKdRVDcbP2cqpIP/aVB085m+dpt/gLPvaG3ZkUy1IxEt3kZCUKuBS6d3zsLfgFaL4DWqEl1tWPgf7ShU491BJ7P8HEFHi19UTA4cdNNMMdoSFyAgwOiL+J+/3ChyYIsrmoWoXG4ltoyUIBIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SukM/c9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B99C113CC;
	Wed, 29 May 2024 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716998851;
	bh=BqJYQUD414oUHDTKcg4GFQrry8JqQEJqLasmiA4XQgI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SukM/c9vDlVvEL/70LCGicsuIODMhF2QAZ9JNGxVMaXQ61GZ1MF+g18g3G1NBXloA
	 7r7b3kfJsT1kxUCbBOo+IS3s2OZKY+l7vmi9b0KDb2Ccq0KMgwluDxQdQh8fNBpLJZ
	 J9N45xwLd8Srd7XY2kTEUJUm2B96HdKGxpt1vMxKOXBt00u6sCNkLbOb+G3W57e4Vg
	 8bz3x34XiM4ddZkInfds4MgFsvEwd3084x2LD+4j2tJdSjR5htlPyL2R8Q6so/EUMc
	 KcBg/X7D7115mMKfwDwXNbqd5jlisLasa2fvz5SUmJr4fz5pcXvBosRQPaG6jyfzf7
	 lCVisuyUk/aFA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 19:07:26 +0300
Message-Id: <D1M9AKX8TO34.1EMXQ88L3T58C@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "Lennart Poettering"
 <lennart@poettering.net>, "David S. Miller" <davem@davemloft.net>, "open
 list" <linux-kernel@vger.kernel.org>, "David Howells"
 <dhowells@redhat.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Mario Limonciello" <mario.limonciello@amd.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>
Subject: Re: [PATCH v7 4/5] keys: asymmetric: Add tpm2_key_rsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-5-jarkko@kernel.org>
In-Reply-To: <20240528210823.28798-5-jarkko@kernel.org>

On Wed May 29, 2024 at 12:08 AM EEST, Jarkko Sakkinen wrote:
> * Asymmetric TPM2 RSA key with signing and verification.
> * Encryption and decryption when pcks1 encoding is used.
> * Enabled with CONFIG_ASYMMETRIC_TPM2_KEY_ECDSA_SUBTYPE.
>
> Signed-off-by: James Prestwood <prestwoj@gmail.com>
> Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

To be addressed in v8:

"
4970b8d723c3af Jarkko Sakkinen 2024-05-26  634  	key =3D tpm2_key_decode(pr=
ep->data, prep->datalen);
4970b8d723c3af Jarkko Sakkinen 2024-05-26  635  	if (IS_ERR(key))
4970b8d723c3af Jarkko Sakkinen 2024-05-26 @636  		return ret;
                                                                ^^^^^^^^^^
Same.  return PTR_ERR(key);
" - https://lore.kernel.org/all/cbae0ed0-e0a6-41ba-9671-a9f48e8f07f3@moroto=
.mountain/

BR, Jarkko

