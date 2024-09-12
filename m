Return-Path: <linux-integrity+bounces-3541-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2237A976A84
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 15:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C0B284D8E
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663A1B12DE;
	Thu, 12 Sep 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWEF/pDB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27231B12D4;
	Thu, 12 Sep 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147596; cv=none; b=Jkq3n5Q3TQZrudqKk8f84i1f+KL2y+yFM/h+yFrvSpbf/Jzr7tBLbJ487X6utFzG4rwxKMwrOQugCojnMwcqgykOaeGbkPZoaLm44hT1fNBaw6jl0jPjC7/wrgwnP3ITXjKjsKMFh0O8VhxY4qFO2PcHz8Go6q+4oTCKji2op2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147596; c=relaxed/simple;
	bh=Tc4u9Ur+RxqzPmaagLAnuv87+0ZYJw2yA01w/bJu3AM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dM157K2COWY8ibcbDpQf7juZNK9lPUJxmmDySuFS1o3a1B8n2vRRr5PDIHuaIG/8ZFMM/yKYV+lZcT05aK8gktHpibsZtZW5NBbkTm6VazTrno9TFwhryGH4bKHjhDncHGzuj/uh3KO0YPUFhRhQsQ6CIWaKodlp3bvtpVWErWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWEF/pDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80E0C4CEC3;
	Thu, 12 Sep 2024 13:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726147596;
	bh=Tc4u9Ur+RxqzPmaagLAnuv87+0ZYJw2yA01w/bJu3AM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RWEF/pDB5DMX8LWqEoGsoTu9EhH86qZr4hfAcwDk8bmgiqRP9FZfjTXMzbvUc9PCJ
	 2JZ/Gq8r8uOoW/0LJq7MvOmeE8VwDjG4ioPu0ODu1kAl6rhQyj/hBf+R/J9pqQA8v9
	 qOnBdO90MFw5ySyyu0nfi2xgf4ANvme6dHdGXFHOmLeie7+yOfvbMyLG9ObPd4XwQi
	 cUbkpuysGDe/4cxYQa2SwkCv8uviW6UbuQq6Pm37+6+owHu8VKtX6drLn+PNPxXjYc
	 9l52dVjNAO2hiM4Zn446VqdjXmFdLCZX/3L2jZdOCCH6G+J5oAFCmvHFH12kcHhiFL
	 T9w5+NLDvo6OQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Sep 2024 16:26:32 +0300
Message-Id: <D44C94RCUEH1.1DTWZRGG5J5PJ@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <torvalds@linux-foundation.org>,
 "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v3 01/14] mpi: Introduce mpi_key_length()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
 <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.18.2
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
 <20240911122911.1381864-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240911122911.1381864-2-roberto.sassu@huaweicloud.com>

On Wed Sep 11, 2024 at 3:28 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce the new function to get the number of bits and bytes from an MP=
I.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/mpi.h       |  2 ++
>  lib/crypto/mpi/mpicoder.c | 33 ++++++++++++++++++++++++++-------
>  2 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mpi.h b/include/linux/mpi.h
> index eb0d1c1db208..a7dd4c9d8120 100644
> --- a/include/linux/mpi.h
> +++ b/include/linux/mpi.h
> @@ -90,6 +90,8 @@ enum gcry_mpi_format {
>  };
> =20
>  MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes);
> +int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
> +		   unsigned int *nbits_arg, unsigned int *nbytes_arg);

"_arg" - what is the point of this?

>  MPI mpi_read_from_buffer(const void *buffer, unsigned *ret_nread);
>  int mpi_fromstr(MPI val, const char *str);
>  MPI mpi_scanval(const char *string);
> diff --git a/lib/crypto/mpi/mpicoder.c b/lib/crypto/mpi/mpicoder.c
> index 3cb6bd148fa9..92447a1c8bf9 100644
> --- a/lib/crypto/mpi/mpicoder.c
> +++ b/lib/crypto/mpi/mpicoder.c
> @@ -79,22 +79,41 @@ MPI mpi_read_raw_data(const void *xbuffer, size_t nby=
tes)
>  }
>  EXPORT_SYMBOL_GPL(mpi_read_raw_data);
> =20
> -MPI mpi_read_from_buffer(const void *xbuffer, unsigned *ret_nread)
> +int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
> +		   unsigned int *nbits_arg, unsigned int *nbytes_arg)
>  {
>  	const uint8_t *buffer =3D xbuffer;
> -	unsigned int nbits, nbytes;
> -	MPI val;
> +	unsigned int nbits;
> =20
> -	if (*ret_nread < 2)
> -		return ERR_PTR(-EINVAL);
> +	if (ret_nread < 2)
> +		return -EINVAL;
>  	nbits =3D buffer[0] << 8 | buffer[1];
> =20
>  	if (nbits > MAX_EXTERN_MPI_BITS) {
>  		pr_info("MPI: mpi too large (%u bits)\n", nbits);
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
> =20
> -	nbytes =3D DIV_ROUND_UP(nbits, 8);
> +	if (nbits_arg)
> +		*nbits_arg =3D nbits;
> +	if (nbytes_arg)
> +		*nbytes_arg =3D DIV_ROUND_UP(nbits, 8);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mpi_key_length);
> +
> +MPI mpi_read_from_buffer(const void *xbuffer, unsigned int *ret_nread)
> +{
> +	const uint8_t *buffer =3D xbuffer;
> +	unsigned int nbytes;
> +	MPI val;
> +	int ret;
> +
> +	ret =3D mpi_key_length(xbuffer, *ret_nread, NULL, &nbytes);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
>  	if (nbytes + 2 > *ret_nread) {
>  		pr_info("MPI: mpi larger than buffer nbytes=3D%u ret_nread=3D%u\n",
>  				nbytes, *ret_nread);

BR, Jarkko

