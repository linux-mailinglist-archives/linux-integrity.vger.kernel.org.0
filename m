Return-Path: <linux-integrity+bounces-8517-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLL8NETQlmkZoQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8517-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 09:56:36 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0515D245
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 488C0302257E
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA39D3346B9;
	Thu, 19 Feb 2026 08:56:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3912C3268;
	Thu, 19 Feb 2026 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491391; cv=none; b=NibqNfNSOA0uZ61ciFWGTriPJdDS9A3kqMoyQ+bQ//9x0H3Ulr3V9MO7yitpmotz6ghYazxOtayK1s0k/qgAW139HWT32JAWdDuALKxysUz/quGkAB0jnrbghiI56BlhkeL3QwNeRmO/bPsuW1YoW1z1N35M+uIKtsdyBbk6Vbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491391; c=relaxed/simple;
	bh=EwHS1L9BIR3ctr5bx3ZTPybAJBFJFLV/CPx8oRNy0Ps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WNHuXu6l0Wy5aSaeoGzAGuaXnSCi9TYVgCWoaicovkyw9HtdVI3PIr2btVsALTxMnwl/92BRhL0T/g/+Uq0u/2zpVqbZQKr+cLLfe/dY5ziJwpMIBleBq9zTdDpimYjzvhPyj4Dj/epnYtnM1MWX2GHUY6HNaD5VybZPNwyC2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fGnGW4GdHz1HBPD;
	Thu, 19 Feb 2026 16:53:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 4224540499;
	Thu, 19 Feb 2026 16:56:26 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDnsm0y0JZp9QEWBA--.31492S2;
	Thu, 19 Feb 2026 09:56:25 +0100 (CET)
Message-ID: <4ca2066adaca1a8f1a6e48e5d535aafa1766296b.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: check return value of crypto_shash_final() in boot
 aggregate
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Daniel Hodges <hodgesd@meta.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
 <paul@paul-moore.com>,  James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2026 09:56:16 +0100
In-Reply-To: <20260201024015.2862236-1-hodgesd@meta.com>
References: <20260201024015.2862236-1-hodgesd@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDnsm0y0JZp9QEWBA--.31492S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw45JFyxGw48JF18uFWkXrb_yoW8Wr4fpa
	1qgayxKrykKFy7CF9xC3Z3AFyfGrWYyw13Gw48Wr90yr9rXw40vrn7Cry09Fn8GF1UAr1x
	KFs2vr1Yyw4jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBGmWgZsFQAABst
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8517-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_TO(0.00)[meta.com,linux.ibm.com,huawei.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.886];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 54E0515D245
X-Rspamd-Action: no action

On Sat, 2026-01-31 at 18:40 -0800, Daniel Hodges wrote:
> The return value of crypto_shash_final() is not checked in
> ima_calc_boot_aggregate_tfm(). If the hash finalization fails, the
> function returns success and a corrupted boot aggregate digest could
> be used for IMA measurements.
>=20
> Capture the return value and propagate any error to the caller.
>=20
> Fixes: 76bb28f6126f ("ima: use new crypto_shash API instead of old crypto=
_hash")
> Signed-off-by: Daniel Hodges <hodgesd@meta.com>

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
>  security/integrity/ima/ima_crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
> index 6f5696d999d0..8ae7821a65c2 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -825,21 +825,21 @@ static int ima_calc_boot_aggregate_tfm(char *digest=
, u16 alg_id,
>  	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
>  	 */
>  	if (alg_id !=3D TPM_ALG_SHA1) {
>  		for (i =3D TPM_PCR8; i < TPM_PCR10; i++) {
>  			ima_pcrread(i, &d);
>  			rc =3D crypto_shash_update(shash, d.digest,
>  						crypto_shash_digestsize(tfm));
>  		}
>  	}
>  	if (!rc)
> -		crypto_shash_final(shash, digest);
> +		rc =3D crypto_shash_final(shash, digest);
>  	return rc;
>  }
> =20
>  int ima_calc_boot_aggregate(struct ima_digest_data *hash)
>  {
>  	struct crypto_shash *tfm;
>  	u16 crypto_id, alg_id;
>  	int rc, i, bank_idx =3D -1;
> =20
>  	for (i =3D 0; i < ima_tpm_chip->nr_allocated_banks; i++) {


