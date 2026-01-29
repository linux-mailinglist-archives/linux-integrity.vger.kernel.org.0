Return-Path: <linux-integrity+bounces-8360-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB/3B4iIe2mlFQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8360-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 17:19:20 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4DDB20D6
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 890223002F50
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9C33F389;
	Thu, 29 Jan 2026 16:19:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92133E35F;
	Thu, 29 Jan 2026 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703553; cv=none; b=YqXWUjsq6gvgOEkKWS9zinTKdeKys2FGIzKx1O1jqbcp2IADA8NJLVP1THCY4w6/l3t2lCKRVP30ACMP/EY/qlnwoLDd/WFkQpbRmF8F9zMkfEln2/5CHmeJ9e41g/49sXPHDlKlMzV+vohH1rbY3r1a+LyoyVl8ur9O64s+TU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703553; c=relaxed/simple;
	bh=B3UA3hNrFo9BU/nOejIsF2QM+GSGPXVwTM8pl0g0+nE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EceyCtNg3CCBxn9krHe3d9EHtczzVJFVyQrzRYxw1aKJ2QzzMfSZ3G0a5jK5UePl+rXmrrpJXp40LnZaLq+ga1JxDQmIea3IryaS9Oonv7OS6UNqQp2KXR1X2nTjToSx3Q7ktDXRrt1LrQzTSAbvpEtDKiucyMzEorME+sD+tBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f245b6R62ztfjS;
	Fri, 30 Jan 2026 00:16:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 513834009B;
	Fri, 30 Jan 2026 00:19:07 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBHhAZyiHtpQVzcAg--.46756S2;
	Thu, 29 Jan 2026 17:19:06 +0100 (CET)
Message-ID: <facea3621fc240ebb05dedb0127d8a514970d40d.camel@huaweicloud.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>, James Bottomley
 <James.Bottomley@HansenPartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
 "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,  "open list:SECURITY
 SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 29 Jan 2026 17:18:55 +0100
In-Reply-To: <20260125192526.782202-2-jarkko@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
	 <20260125192526.782202-2-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBHhAZyiHtpQVzcAg--.46756S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZry3Kw43Ww48ZF4xZw4xWFg_yoW5Cr15pF
	W8KF12qws7trZ7J3s3Ca1IkF1a934rKrW3Gr4rK34qgFsxJF1xJry0vFW5Ka4jyrWqgF1a
	qFWxXFyjga4DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBGl60h0SsgAAsy
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8360-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F4DDB20D6
X-Rspamd-Action: no action

On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
>    use should be pooled rather than directly used. This both reduces
>    latency and improves its predictability.
>=20
> 2. Linux is better off overall if every subsystem uses the same source fo=
r
>    generating the random numbers required.
>=20
> Thus, unset '.get_random', which causes fallback to kernel_get_random().
>=20
> One might argue that TPM RNG should be used for the generated trusted key=
s,
> so that they have matching entropy with the TPM internally generated
> objects.
>=20
> This argument does have some weight into it but as far cryptography goes,
> FIPS certification sets the exact bar, not which exact FIPS certified RNG
> will be used. Thus, the rational choice is obviously to pick the lowest
> latency path, which is kernel RNG.
>=20
> Finally, there is an actual defence in depth benefit when using kernel RN=
G
> as it helps to mitigate TPM firmware bugs concerning RNG implementation,
> given the obfuscation by the other entropy sources.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v7:
> - A new patch. Simplifies follow up patches.
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/tr=
usted-keys/trusted_tpm1.c
> index 636acb66a4f6..7ce7e31bcdfb 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -6,6 +6,16 @@
>   * See Documentation/security/keys/trusted-encrypted.rst
>   */
> =20
> +/**
> + * DOC: Random Number Generation
> + *
> + * tpm_get_random() was previously used here as the RNG in order to have=
 equal
> + * entropy with the objects fully inside the TPM. However, as far as goe=
s,
> + * kernel RNG is equally fine, as long as long as it is FIPS certified. =
Also,
> + * using kernel RNG has the benefit of mitigating bugs in the TPM firmwa=
re
> + * associated with the RNG.
> + */

If we switch to the kernel RNG that is better, and the TPM one is
flawed, I guess we are going to have big problems anyway, since the TPM
random number generator is used by the TPM itself internally.

I think it makes sense to leave as it is.

Thanks

Roberto

> +
>  #include <crypto/hash_info.h>
>  #include <crypto/sha1.h>
>  #include <crypto/utils.h>
> @@ -936,11 +946,6 @@ static int trusted_tpm_unseal(struct trusted_key_pay=
load *p, char *datablob)
>  	return ret;
>  }
> =20
> -static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
> -{
> -	return tpm_get_random(chip, key, key_len);
> -}
> -
>  static int __init init_digests(void)
>  {
>  	int i;
> @@ -992,6 +997,5 @@ struct trusted_key_ops trusted_key_tpm_ops =3D {
>  	.init =3D trusted_tpm_init,
>  	.seal =3D trusted_tpm_seal,
>  	.unseal =3D trusted_tpm_unseal,
> -	.get_random =3D trusted_tpm_get_random,
>  	.exit =3D trusted_tpm_exit,
>  };


