Return-Path: <linux-integrity+bounces-2504-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D88CA918
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0506F1F21FBF
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5C50A75;
	Tue, 21 May 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF2GoAgC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E061256A;
	Tue, 21 May 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277131; cv=none; b=eWOns4g0hU5Wh04tVgt3ydNhISPltyzge3tto+NuL57XXEyG2E1oXlQRxs1JZu8WKAOL2UEFRmI5VK6qQyi5szIWhihwmjFF/BJtbCCqSY7hUcrAMJOR4rWpWLr8qCP69f02Gr9DDinjbL9HH/a9IFcSA9UZJOmFMKnY/lScO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277131; c=relaxed/simple;
	bh=n3xfaBqyzHw0uuGiyp3gaPzVQKCAlmedilfKQVu9mgo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r9Xe8jbnnHeMuzGilBT3aolUdo3DmLleO0zSKRCvm5ziGyWggPMaer5c2A8Aa920u18t2N56GhQ/69ddcsaerAluPPb8MvtI++fq4xZ1yymi9isV6J1rR18BgxPd2WG1gbqkCdXU7I/71S8o8HqjqplGKIlWuaZNXpbz0y4yqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF2GoAgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EC7C2BD11;
	Tue, 21 May 2024 07:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716277131;
	bh=n3xfaBqyzHw0uuGiyp3gaPzVQKCAlmedilfKQVu9mgo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FF2GoAgCjJ498XNO6RAlKNhFWaypadqZPrO9K2pDtYj81cNYbQoUelahRp//zSwIK
	 dEVKHEHcKNGy/JAom8vs4u6fsKrVwqx3sABZTq4bYPjLuAJvucsv7edvjUBK7RFz0X
	 9BJc5Kg5yCzmfPti5qB/vRRA0KSv7PlzkM6KDx4ML/y9KlkjyxY5R4UCslzidFccGh
	 AWwit3scKE2v1fcoo/vu2mWN/VbylF2mvX5qDRp6CiQGJWgcDEuobS+iS3rxS54ngk
	 /icdK1nFDzd2ShkqAGZhaeOomcZ7N1X1PVLn8lz3O9vwWySaswsXTJPXT80Rz9TmdZ
	 KchKbYY5CwgDQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 10:38:45 +0300
Message-Id: <D1F5GQYP9JFC.3MXMKUM0CKGS5@kernel.org>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "Andreas.Fuchs@infineon.com" <Andreas.Fuchs@infineon.com>, "James
 Prestwood" <prestwoj@gmail.com>, "David Woodhouse" <dwmw2@infradead.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "David S. Miller"
 <davem@davemloft.net>, "open list:CRYPTO API"
 <linux-crypto@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "David Howells" <dhowells@redhat.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: Re: [EXTERNAL] [PATCH v2 6/6] keys: asymmetric:
 ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Bharat Bhushan" <bbhushan2@marvell.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240521031645.17008-1-jarkko@kernel.org>
 <20240521031645.17008-7-jarkko@kernel.org>
 <SN7PR18MB531494159D3996799475209DE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com>
In-Reply-To: <
 <SN7PR18MB531494159D3996799475209DE3EA2@SN7PR18MB5314.namprd18.prod.outlook.com>

On Tue May 21, 2024 at 10:25 AM EEST, Bharat Bhushan wrote:
> > +	rc =3D crypto_akcipher_encrypt(req);
> > +	rc =3D crypto_wait_req(rc, &cwait);
> > +
>
> Few Minor comments,=20
> Extra line here=20

Yeah, makes sense.


> > +	if (!rc)
> > +		rc =3D req->dst_len;
> > +
> > +	akcipher_request_free(req);
> > +
> > +err_tfm:
> > +	crypto_free_akcipher(tfm);
> > +
> > +	return rc;
> > +}
> > +
> > +static int __tpm2_key_rsa_decrypt(struct tpm_chip *chip,
> > +				  struct tpm2_key_rsa *key,
> > +				  struct kernel_pkey_params *params,
> > +				  const void *in, int in_len, void *out)
> > +{
> > +	unsigned int offset =3D 0;
> > +	u32 key_handle =3D 0;
> > +	struct tpm_buf buf;
> > +	u16 decrypted_len;
> > +	u32 parent;
> > +	u8 *pos;
> > +	int ret;
> > +
> > +	ret =3D tpm_try_get_ops(chip);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D tpm2_start_auth_session(chip);
> > +	if (ret)
> > +		goto err_ops;
> > +
> > +	if (key->key.parent =3D=3D TPM2_RH_NULL) {
> > +		ret =3D tpm2_load_context(chip, chip->null_key_context,
> > &offset,
> > +					&parent);
> > +		if (ret) {
> > +			ret =3D -EIO;
> > +			goto err_auth;
> > +		}
> > +	} else {
> > +		parent =3D key->key.parent;
> > +	}
>
> Do we need braces here?


I think I added them because checkpatch complained me about not having
them. So I guess the rule is that if any branch has braces, all of them
should have...
>
> > +
> > +	ret =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
> > +	if (ret < 0)
> > +		goto err_parent;
> > +
> > +	tpm_buf_append_name(chip, &buf, parent, NULL);
> > +	tpm_buf_append_hmac_session(chip, &buf,
> > TPM2_SA_CONTINUE_SESSION |
> > +				    TPM2_SA_ENCRYPT, NULL, 0);
> > +	tpm_buf_append(&buf, key->key.blob, key->key.blob_len);
> > +	if (buf.flags & TPM_BUF_OVERFLOW) {
> > +		ret =3D -E2BIG;
> > +		goto err_buf;
> > +	}
> > +	tpm_buf_fill_hmac_session(chip, &buf);
> > +	ret =3D tpm_transmit_cmd(chip, &buf, 4, "RSA key loading");
> > +	ret =3D tpm_buf_check_hmac_response(chip, &buf, ret);
> > +	if (ret) {
> > +		ret =3D -EIO;
> > +		goto err_buf;
> > +	}
> > +	key_handle =3D be32_to_cpup((__be32
> > *)&buf.data[TPM_HEADER_SIZE]);
> > +
> > +	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_RSA_DECRYPT);
> > +	tpm_buf_append_name(chip, &buf, key_handle, NULL);
> > +	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
> > NULL, 0);
> > +	tpm_buf_append_u16(&buf, in_len);
> > +	tpm_buf_append(&buf, in, in_len);
> > +	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
> > +	tpm_buf_append_u16(&buf, 0);
> > +	tpm_buf_fill_hmac_session(chip, &buf);
> > +	ret =3D tpm_transmit_cmd(chip, &buf, 4, "RSA key decrypting");
> > +	ret =3D tpm_buf_check_hmac_response(chip, &buf, ret);
> > +	if (ret) {
> > +		ret =3D -EIO;
> > +		goto err_blob;
> > +	}
> > +
> > +	pos =3D buf.data + TPM_HEADER_SIZE + 4;
> > +	decrypted_len =3D be16_to_cpup((__be16 *)pos);
> > +	pos +=3D 2;
> > +
> > +	if (params->out_len < decrypted_len) {
> > +		ret =3D -EMSGSIZE;
> > +		goto err_blob;
> > +	}
> > +
> > +	memcpy(out, pos, decrypted_len);
> > +	ret =3D decrypted_len;
> > +
> > +err_blob:
> > +	tpm2_flush_context(chip, key_handle);
> > +
> > +err_buf:
> > +	tpm_buf_destroy(&buf);
> > +
> > +err_parent:
> > +	if (key->key.parent =3D=3D TPM2_RH_NULL)
> > +		tpm2_flush_context(chip, parent);
> > +
> > +err_auth:
> > +	if (ret < 0)
> > +		tpm2_end_auth_session(chip);
> > +
> > +err_ops:
> > +	tpm_put_ops(chip);
> > +	return ret;
> > +}
> > +
> > +static int tpm2_key_rsa_decrypt(struct tpm_chip *chip, struct tpm2_key=
_rsa
> > *key,
> > +				struct kernel_pkey_params *params,
> > +				const void *in, void *out)
> > +{
> > +	const u8 *ptr;
> > +	int out_len;
> > +	u8 *work;
> > +	int ret;
> > +
> > +	work =3D kzalloc(params->out_len, GFP_KERNEL);
> > +	if (!work)
> > +		return -ENOMEM;
>
> Maybe use ERR_PTR() here and couple of more places

Hmm... but the function returns 'int'?

BR, Jarkko

