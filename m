Return-Path: <linux-integrity+bounces-3546-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD11976B5C
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C49280CA4
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFCE1A4F2F;
	Thu, 12 Sep 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csnbXsrM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB418028;
	Thu, 12 Sep 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149522; cv=none; b=MRMSzq2WQ3SMsRHVTOETLm6BG5Ji/dwImhyhcQ1HL8vEV21lTPLOnmQmH1/ISc5KKs7BOG8BDcvPF0ZVtAqAMWsm7xSo72QFNUUdxwk3Lq8yH55FnYX5c69y7+sBSXSqQ+IrViJIZDlQIXfhDgBUSCMPqZGJ2Qor3VeP72Lcb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149522; c=relaxed/simple;
	bh=6FRcDodVvNXxMEWs0BU+xqVfHKs5h4wLPTQ04GUmOCg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XLiKkoTdS6xKiOnKzGYemyG7CPMzKJkPpAOj6ST2DFZMeocDTDUsaNADr5HGZzJDnz+DyfBLtYB97PTICzZgLcyzDpII4ZYJnZI5uNOcazTDcSbl/5dUB8yFjveTN5x6b7Qlb2kaFybyrYsJhGzjd2xYp3dpjW5gtx73toevsW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csnbXsrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6B5C4CEC3;
	Thu, 12 Sep 2024 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726149521;
	bh=6FRcDodVvNXxMEWs0BU+xqVfHKs5h4wLPTQ04GUmOCg=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=csnbXsrMVhjtFlJMm/GdlZcd0YVEEe9P2wLE2/LxNl6Tj/7AqHqEFqne6tMi56kWl
	 rTGaP0PiDoafBl+nO6n5QRN8B8BrGiW1byyzqPD5Lhvfnwrit55v21g25O8rWPMic6
	 FXPGzHbeZeqCH7S1/1w4wBSPIRVbs7hF9uC19XM9YN7xXmccxCUrUAOlIUuPdjhoZ6
	 3PNKWKd9BJ0tKE+HlaGErbJwudt0gTDNdBvUl7xvektWQ4h3a6usU+SmNDFgziI+cC
	 sGktbqHUNVUfigkwGPV3smdnrKLWbQPeqP6eN/iMXuTbzKGBEH9rsOERa6k0DzjTA/
	 skD4pPs+lwDcQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Sep 2024 16:58:38 +0300
Message-Id: <D44CXPF7VCWY.3PA48YV8MVXF1@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
 <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <torvalds@linux-foundation.org>,
 "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v3 05/14] PGPLIB: Signature parser
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
 <20240911122911.1381864-6-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240911122911.1381864-6-roberto.sassu@huaweicloud.com>

On Wed Sep 11, 2024 at 3:29 PM EEST, Roberto Sassu wrote:
> From: David Howells <dhowells@redhat.com>
>
> Provide some PGP signature parsing helpers:
>
>  (1) A function to parse V4 signature subpackets and pass the desired one=
s
>      to a processor function:
>
> 	int pgp_parse_sig_subpkts(const u8 *data, size_t datalen,
> 				  struct pgp_parse_sig_context *ctx);
>
>  (2) A function to parse out basic signature parameters from any PGP
>      signature such that the algorithms and public key can be selected:
>
> 	int pgp_parse_sig_params(const u8 **_data, size_t *_datalen,
> 				 struct pgp_sig_parameters *p);
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  crypto/asymmetric_keys/pgp_library.c | 284 +++++++++++++++++++++++++++
>  crypto/asymmetric_keys/pgplib.h      |  25 +++
>  2 files changed, 309 insertions(+)
>
> diff --git a/crypto/asymmetric_keys/pgp_library.c b/crypto/asymmetric_key=
s/pgp_library.c
> index 1b87f8af411b..a9708ccbcb81 100644
> --- a/crypto/asymmetric_keys/pgp_library.c
> +++ b/crypto/asymmetric_keys/pgp_library.c
> @@ -260,3 +260,287 @@ int pgp_parse_public_key(const u8 **_data, size_t *=
_datalen,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pgp_parse_public_key);
> +
> +/**
> + * pgp_parse_sig_subpkt_header - Parse a PGP V4 signature subpacket head=
er
                                 ()

BR, Jarkko

