Return-Path: <linux-integrity+bounces-3280-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA360946AAE
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 19:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7232816CF
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E1910A2A;
	Sat,  3 Aug 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHEfc2MN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E710A0A
	for <linux-integrity@vger.kernel.org>; Sat,  3 Aug 2024 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722705703; cv=none; b=Ls11l1S/JADgZmqg0woxpxUqLP7SPhbQMYDqX13PcEatmnAOcjK+JfYps1UTIb58po5xcWJZ1hm9Rei7of1aUdnWE/rrCU/mE+gV46de55179mFB8YiVpc+LEWHsNh+H3MYsVNlfa0zUSoWX0LslJWXxs/Ul729R2O1yM8CnGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722705703; c=relaxed/simple;
	bh=vCJCrKSI2sdbbuRWE97NzU5ChCduJ5eztyyP9gLsHVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k2AF18LaqKRBU6l2ZWN5YgRVyDJmtTJRo6gdIGMav+BbGtYy6x95Qe7gJHXqGwFRweLTqKd1t+fX+6G92xH8szds7pf057hQIVaEUX+b8aC/UxFdzTqlsgweynRb68XWqotF3kGfsr/yf9lsJl4q75MS2hrEZa/ChURmBThmKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHEfc2MN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E044C116B1;
	Sat,  3 Aug 2024 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722705702;
	bh=vCJCrKSI2sdbbuRWE97NzU5ChCduJ5eztyyP9gLsHVg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PHEfc2MNvyJ22Srwbey5mP/iU8MPX4wE4gAqc/uUTR7orGMoUiZxESIH9w4U0djbC
	 mqOHeEovSXwgPEksxQ9EyI0dq55Rduopsfpf6fjeHIShnmannG8jyAS4SAnhytHMPZ
	 gd0Tj9GIUr4F5THfqASaph0xOeISgHk0iEpfBsadUQIzMqRuRIH24O+Rh3NFDkgrfl
	 JRnt0+Cfuwq/7oRabVj+b1GuaPUxkqxeQ3mcsacqSTVdButoI8/degs8Fj5HeIBpeO
	 Dqx8fQKZ6zAXGMEf9k75BSIc/wIHXrtDhBvcqy1vQmjabCqACUgqknmVhM4KPQvsTw
	 pfb0znLvC5ncg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Aug 2024 20:21:38 +0300
Message-Id: <D36G7CO03I80.EOC2EBL7M7LU@kernel.org>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 3/8] libcommon: add bin2hex and tmp2_get_hexname
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <openssl-tpm2-engine@groups.io>
X-Mailer: aerc 0.18.0
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
 <20240802202606.12767-4-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240802202606.12767-4-James.Bottomley@HansenPartnership.com>

On Fri Aug 2, 2024 at 11:26 PM EEST, James Bottomley wrote:
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  src/include/tpm2-common.h   |  5 +++++
>  src/libcommon/tpm2-common.c | 16 ++++++++++++++++
>  2 files changed, 21 insertions(+)

Would not hurt to introduce them in the commit message.

>
> diff --git a/src/include/tpm2-common.h b/src/include/tpm2-common.h
> index 97b60f2..0e0f28a 100644
> --- a/src/include/tpm2-common.h
> +++ b/src/include/tpm2-common.h
> @@ -9,6 +9,9 @@
>   * not a TPM error, so don't process the rc as one */
>  #define NOT_TPM_ERROR (0xffffffff)
> =20
> +/* maximum space for a sha256 name in ascii */
> +#define MAX_HEXNAME 132
> +
>  extern TPM_ALG_ID name_alg;
> =20
>  struct policy_command {
> @@ -141,4 +144,6 @@ int tpm2_rsa_decrypt(const struct app_data *ad, PUBLI=
C_KEY_RSA_2B *cipherText,
>  		     char *srk_auth);
>  int tpm2_rm_signed_policy(char *tpmkey, int rmnum);
>  int tpm2_get_signed_policy(char *tpmkey, STACK_OF(TSSAUTHPOLICY) **sk);
> +void bin2hex(char *dst, const unsigned char *src, size_t count);
> +void tpm2_get_hexname(char hexname[MAX_HEXNAME], TPM2B_PUBLIC *pub);
>  #endif
> diff --git a/src/libcommon/tpm2-common.c b/src/libcommon/tpm2-common.c
> index b70ac27..3ffa773 100644
> --- a/src/libcommon/tpm2-common.c
> +++ b/src/libcommon/tpm2-common.c
> @@ -2320,6 +2320,14 @@ int hex2bin(unsigned char *dst, const char *src, s=
ize_t count)
>  	return 0;
>  }
> =20
> +void bin2hex(char *dst, const unsigned char *src, size_t count)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < count; i++)
> +		sprintf(&dst[i<<1], "%02x", src[i]);
> +}
> +
>  TPM_RC tpm2_parse_policy_file(const char *policy_file,
>  			      STACK_OF(TSSOPTPOLICY) *sk,
>  			      char *auth, TPMT_HA *digest)
> @@ -3376,6 +3384,14 @@ openssl_print_errors()
>  	ERR_print_errors_fp(stderr);
>  }
> =20
> +void tpm2_get_hexname(char hexname[MAX_HEXNAME], TPM2B_PUBLIC *pub)
> +{
> +	NAME_2B n;
> +
> +	tpm2_ObjectPublic_GetName(&n, &pub->publicArea);
> +	bin2hex(hexname, (unsigned char *)n.name, n.size);
> +}
> +
>  IMPLEMENT_ASN1_FUNCTIONS(TSSOPTPOLICY)
>  IMPLEMENT_ASN1_FUNCTIONS(TSSAUTHPOLICY)
>  IMPLEMENT_ASN1_FUNCTIONS(TSSLOADABLE)


BR, Jarkko

