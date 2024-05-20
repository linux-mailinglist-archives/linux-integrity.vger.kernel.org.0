Return-Path: <linux-integrity+bounces-2486-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D344C8CA356
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 22:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E659C1C212FC
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 20:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37976139CE7;
	Mon, 20 May 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnQOFHgd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8ED27A;
	Mon, 20 May 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237367; cv=none; b=m8joTydnDE11uyV1bdvNjC2p9kAdFWLPHOx7gvvypQkyBA495t1M9Kw+sjLkez7UDgrmx1FJ2KShE8OlZn1dnkXzjm3pI66nl/EESdUc8SspJmHqcrpKKu8yB/oawi6Q/+Xj/NTBsNqOsFwwoWJw0TUn5CAx3vtx2hJ8m/kh00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237367; c=relaxed/simple;
	bh=+VY1j3n1YoqE2DUlZ1stU+E39GkhX9GJ33huspw8fe4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=c541VcuFEPXijLKV25/xzpIh8A/RSEXR+nY0NNZu0xbs/NLU/NOmNrBDgipP92JQEHgXj07wsG45HMF2BYvVUPyAnvisiyGFJxf9SmG3ag+mSQdEIJOXeWXr5fu5+ppk28nC6h+xuaUyqyM2ExJoInpwBSadfP5+7JqP2egtdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnQOFHgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C90C2BD10;
	Mon, 20 May 2024 20:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716237366;
	bh=+VY1j3n1YoqE2DUlZ1stU+E39GkhX9GJ33huspw8fe4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=rnQOFHgdoqphfLmE7gSbyjiBhXSet2VuuzXxCMx2Y3o1WSps+jHFWC1HQDknzf39M
	 nPogvKeP0EVogt0BZeYryYq/TebcHfuWmNmmI5GsTkrqJOQt97xSk4OWtZMSFeLdKY
	 Jwb+8EJbXvwsNHbV+8wczgzcWTZzL7FRPWTdbvHmY03D1cG2DUyeFMaG52A2KEJjUP
	 BvrBBjwdLKUdbPevF0HQ3g8hCq//j5kxbbQ1e9yX2OGAAd2LlMgo/uYPEILvnbQyWj
	 tU0PiQWi8PO9QXl7didzAfS3WsKS841qSmWix8C5dOKz8S5DL4OcIrIYiHCCi1LX5V
	 Kl/wmhf1YBDCQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 May 2024 23:36:02 +0300
Message-Id: <D1ERDC16XLUO.578U4ZE7VXW@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "David S. Miller"
 <davem@davemloft.net>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>
Subject: Re: [PATCH 0/6] KEYS: asymmetric: tpm2_key_rsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240520184727.22038-1-jarkko@kernel.org>
In-Reply-To: <20240520184727.22038-1-jarkko@kernel.org>

On Mon May 20, 2024 at 9:47 PM EEST, Jarkko Sakkinen wrote:
> ## Overview
>
> Introduce tpm2_key_rsa implementing asymmetric TPM RSA key. This key type
> can be enabled with CONFIG_ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE config option.
> Carves groundwork for similar modules in future, such as tpm2_key_ecdsa.

Cc to Eric (forgot).

BR, Jarkko

