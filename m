Return-Path: <linux-integrity+bounces-3544-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78680976B46
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 15:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223C9281619
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Sep 2024 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824821AD258;
	Thu, 12 Sep 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXHsH5sq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AD1A0BDA;
	Thu, 12 Sep 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149267; cv=none; b=B3dbDcSc08dp0U5/fXIJFGSvReDLXc/oxSlyYXivobHR001nYvR6Il5f1hXiunxk4OLPU3aFrT+31CABHWftzd3nbEnrfdxKNJLBFkyCSx5G6m0YyBvt31yv9noYZO26WFRBukQ69wwyj1jG9wOrkyxozWDCq+16ue73UtLrk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149267; c=relaxed/simple;
	bh=r3e9l6T8+l0GSLZWpkxe5c2KHX2CvPdoVfI+8KICeY0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Jl16s705zF+a56xr9sEeBr7rHuX+6U/KY3Bv/nC6bIBRP+Rjr0UCBTx4dy9hxJD0ISnBCNWyovd5GdWNHu6xEnjKH0ysZUBPmDLMX7mGCy1JVnwyMA1KfsJsH2ESVunG5RrxOEI7wG+wdRSXfWlMcOK/fYwy9J94fkhzLQOY29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXHsH5sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C747C4CEC3;
	Thu, 12 Sep 2024 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726149266;
	bh=r3e9l6T8+l0GSLZWpkxe5c2KHX2CvPdoVfI+8KICeY0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BXHsH5sq50sAiYY4pptLoWGINTlNDsTQKD7J0nH4VxKXZuEwPBaNvhBU9omLHjAJP
	 8TqmLjj53powrk/4bCa0ebQDIR1gPDfVN2z1o44V7M/4TjLBkMoOgTc6tyI3XWmhPN
	 /h7zVJrRyQQXn1qwj6PXKI5l3r5omeFOWL2z3NbplynT43+J8NBPjfv7Eqh4NI3PIi
	 2NAk/RHFHMSf65VOTcUBO7Maobf52ICa9Pv+mqFwHixW4fCbUbYXGe/iEFhu56tbxT
	 EHX4J/wBBbJPMkWZAnlrr0jMiO9KRATHYeXHLWiBW8YbUFePvCMUkDT0E9Qq4JM0B3
	 GaGA2roasxgIA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Sep 2024 16:54:23 +0300
Message-Id: <D44CUG76DIBS.31UGN7S3KFK74@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, <torvalds@linux-foundation.org>,
 "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v3 03/14] PGPLIB: PGP definitions (RFC 9580)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
 <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.18.2
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
 <20240911122911.1381864-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240911122911.1381864-4-roberto.sassu@huaweicloud.com>

On Wed Sep 11, 2024 at 3:29 PM EEST, Roberto Sassu wrote:
> From: David Howells <dhowells@redhat.com>
>
> Provide some useful PGP definitions from RFC 9580.  These describe detail=
s
> of public key crypto as used by crypto keys for things like signature
> verification.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  crypto/asymmetric_keys/pgp.h | 216 +++++++++++++++++++++++++++++++++++
>  1 file changed, 216 insertions(+)
>  create mode 100644 crypto/asymmetric_keys/pgp.h
>
> diff --git a/crypto/asymmetric_keys/pgp.h b/crypto/asymmetric_keys/pgp.h
> new file mode 100644
> index 000000000000..eaf0ab8e0373
> --- /dev/null
> +++ b/crypto/asymmetric_keys/pgp.h
> @@ -0,0 +1,216 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* PGP definitions (RFC 9580)
> + *
> + * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/types.h>
> +
> +struct pgp_key_ID {
> +	u8 id[8];
> +} __packed;
> +
> +struct pgp_time {
> +	u8 time[4];
> +} __packed;
> +
> +/*
> + * PGP public-key algorithm identifiers [RFC 9580: 9.1]

Nicely done documentation, which is rare, i.e. tells what the thing is
and gives an easy to access reference. 0x1F44D for that.

> + */
> +enum pgp_pubkey_algo {
> +	PGP_PUBKEY_RSA_ENC_OR_SIG	=3D 1,
> +	PGP_PUBKEY_RSA_ENC_ONLY		=3D 2,
> +	PGP_PUBKEY_RSA_SIG_ONLY		=3D 3,
> +	PGP_PUBKEY_ELGAMAL		=3D 16,
> +	PGP_PUBKEY_DSA			=3D 17,
> +	PGP_PUBKEY_ECDH			=3D 18,
> +	PGP_PUBKEY_ECDSA		=3D 19,
> +	PGP_PUBKEY_EDDSA_LEGACY		=3D 22,
> +	PGP_PUBKEY_X25519		=3D 25,
> +	PGP_PUBKEY_X448			=3D 26,
> +	PGP_PUBKEY_ED25519		=3D 27,
> +	PGP_PUBKEY_ED448		=3D 28,
> +	PGP_PUBKEY__LAST
> +};
> +
> +/*
> + * PGP symmetric-key algorithm identifiers [RFC 9580: 9.3]
> + */
> +enum pgp_symkey_algo {
> +	PGP_SYMKEY_PLAINTEXT		=3D 0,
> +	PGP_SYMKEY_IDEA			=3D 1,
> +	PGP_SYMKEY_3DES			=3D 2,
> +	PGP_SYMKEY_CAST5		=3D 3,
> +	PGP_SYMKEY_BLOWFISH		=3D 4,
> +	PGP_SYMKEY_AES_128KEY		=3D 7,
> +	PGP_SYMKEY_AES_192KEY		=3D 8,
> +	PGP_SYMKEY_AES_256KEY		=3D 9,
> +	PGP_SYMKEY_TWOFISH_256KEY	=3D 10,
> +	PGP_SYMKEY_CAMELIA_128KEY	=3D 11,
> +	PGP_SYMKEY_CAMELIA_192KEY	=3D 12,
> +	PGP_SYMKEY_CAMELIA_256KEY	=3D 13,
> +	PGP_SYMKEY__LAST
> +};
> +
> +/*
> + * PGP compression algorithm identifiers [RFC 9580: 9.4]
> + */
> +enum pgp_compr_algo {
> +	PGP_COMPR_UNCOMPRESSED		=3D 0,
> +	PGP_COMPR_ZIP			=3D 1,
> +	PGP_COMPR_ZLIB			=3D 2,
> +	PGP_COMPR_BZIP2			=3D 3,
> +	PGP_COMPR__LAST
> +};
> +
> +/*
> + * PGP hash algorithm identifiers [RFC 9580: 9.4]
> + */
> +enum pgp_hash_algo {
> +	PGP_HASH_MD5			=3D 1,
> +	PGP_HASH_SHA1			=3D 2,
> +	PGP_HASH_RIPE_MD_160		=3D 3,
> +	PGP_HASH_SHA256			=3D 8,
> +	PGP_HASH_SHA384			=3D 9,
> +	PGP_HASH_SHA512			=3D 10,
> +	PGP_HASH_SHA224			=3D 11,
> +	PGP_HASH_SHA3_256		=3D 12,
> +	PGP_HASH_SHA3_512		=3D 14,
> +	PGP_HASH__LAST
> +};
> +

/*
 * doc
 */
> +extern const char *const pgp_hash_algorithms[PGP_HASH__LAST];
> +
> +/*
> + * PGP packet type tags [RFC 9580: 5].
> + */
> +enum pgp_packet_tag {
> +	PGP_PKT_RESERVED		=3D 0,
> +	PGP_PKT_PUBKEY_ENC_SESSION_KEY	=3D 1,
> +	PGP_PKT_SIGNATURE		=3D 2,
> +	PGP_PKT_SYMKEY_ENC_SESSION_KEY	=3D 3,
> +	PGP_PKT_ONEPASS_SIGNATURE	=3D 4,
> +	PGP_PKT_SECRET_KEY		=3D 5,
> +	PGP_PKT_PUBLIC_KEY		=3D 6,
> +	PGP_PKT_SECRET_SUBKEY		=3D 7,
> +	PGP_PKT_COMPRESSED_DATA		=3D 8,
> +	PGP_PKT_SYM_ENC_DATA		=3D 9,
> +	PGP_PKT_MARKER			=3D 10,
> +	PGP_PKT_LITERAL_DATA		=3D 11,
> +	PGP_PKT_TRUST			=3D 12,
> +	PGP_PKT_USER_ID			=3D 13,
> +	PGP_PKT_PUBLIC_SUBKEY		=3D 14,
> +	PGP_PKT_USER_ATTRIBUTE		=3D 17,
> +	PGP_PKT_SYM_ENC_AND_INTEG_DATA	=3D 18,
> +	PGP_PKT_MODIFY_DETECT_CODE	=3D 19,
> +	PGP_PKT_PRIVATE_0		=3D 60,
> +	PGP_PKT_PRIVATE_3		=3D 63,
> +	PGP_PKT__HIGHEST		=3D 63
> +};
> +
> +/*
> + * Signature (tag 2) packet [RFC 9580: 5.2].
> + */
> +enum pgp_signature_version {
> +	PGP_SIG_VERSION_3			=3D 3,
> +	PGP_SIG_VERSION_4			=3D 4,
> +};
> +
> +/*
> + * Signature types [RFC 9580: 5.2.1].
> + */
> +enum pgp_signature_type {
> +	PGP_SIG_BINARY_DOCUMENT_SIG		=3D 0x00,
> +	PGP_SIG_CANONICAL_TEXT_DOCUMENT_SIG	=3D 0x01,
> +	PGP_SIG_STANDALONE_SIG			=3D 0x02,
> +	PGP_SIG_GENERAL_CERT_OF_UID_PUBKEY	=3D 0x10,
> +	PGP_SIG_PERSONAL_CERT_OF_UID_PUBKEY	=3D 0x11,
> +	PGP_SIG_CASUAL_CERT_OF_UID_PUBKEY	=3D 0x12,
> +	PGP_SIG_POSTITIVE_CERT_OF_UID_PUBKEY	=3D 0x13,
> +	PGP_SIG_SUBKEY_BINDING_SIG		=3D 0x18,
> +	PGP_SIG_PRIMARY_KEY_BINDING_SIG		=3D 0x19,
> +	PGP_SIG_DIRECTLY_ON_KEY			=3D 0x1F,
> +	PGP_SIG_KEY_REVOCATION_SIG		=3D 0x20,
> +	PGP_SIG_SUBKEY_REVOCATION_SIG		=3D 0x28,
> +	PGP_SIG_CERT_REVOCATION_SIG		=3D 0x30,
> +	PGP_SIG_TIMESTAMP_SIG			=3D 0x40,
> +	PGP_SIG_THIRD_PARTY_CONFIRM_SIG		=3D 0x50,
> +};
> +

/*
 * doc
 */
> +struct pgp_signature_v3_packet {
> +	enum pgp_signature_version version : 8; /* =3D=3D PGP_SIG_VERSION_3 */
> +	u8	length_of_hashed;	/* =3D=3D 5 */
> +	struct {
> +		enum pgp_signature_type signature_type : 8;
> +		struct pgp_time	creation_time;
> +	} __packed hashed;
> +	struct pgp_key_ID issuer;
> +	enum pgp_pubkey_algo pubkey_algo : 8;
> +	enum pgp_hash_algo hash_algo : 8;
> +} __packed;
> +

/*
 * doc
 */
> +struct pgp_signature_v4_packet {
> +	enum pgp_signature_version version : 8;	/* =3D=3D PGP_SIG_VERSION_4 */
> +	enum pgp_signature_type signature_type : 8;
> +	enum pgp_pubkey_algo pubkey_algo : 8;
> +	enum pgp_hash_algo hash_algo : 8;
> +} __packed;
> +
> +/*
> + * V4 signature subpacket types [RFC 9580: 5.2.3.7].
> + */
> +enum pgp_sig_subpkt_type {
> +	PGP_SIG_CREATION_TIME			=3D 2,
> +	PGP_SIG_EXPIRATION_TIME			=3D 3,
> +	PGP_SIG_EXPORTABLE_CERT			=3D 4,
> +	PGP_SIG_TRUST_SIG			=3D 5,
> +	PGP_SIG_REGEXP				=3D 6,
> +	PGP_SIG_REVOCABLE			=3D 7,
> +	PGP_SIG_KEY_EXPIRATION_TIME		=3D 9,
> +	PGP_SIG_PREF_SYM_ALGO			=3D 11,
> +	PGP_SIG_REVOCATION_KEY			=3D 12,
> +	PGP_SIG_ISSUER				=3D 16,
> +	PGP_SIG_NOTATION_DATA			=3D 20,
> +	PGP_SIG_PREF_HASH_ALGO			=3D 21,
> +	PGP_SIG_PREF_COMPR_ALGO			=3D 22,
> +	PGP_SIG_KEY_SERVER_PREFS		=3D 23,
> +	PGP_SIG_PREF_KEY_SERVER			=3D 24,
> +	PGP_SIG_PRIMARY_USER_ID			=3D 25,
> +	PGP_SIG_POLICY_URI			=3D 26,
> +	PGP_SIG_KEY_FLAGS			=3D 27,
> +	PGP_SIG_SIGNERS_USER_ID			=3D 28,
> +	PGP_SIG_REASON_FOR_REVOCATION		=3D 29,
> +	PGP_SIG_FEATURES			=3D 30,
> +	PGP_SIG_TARGET				=3D 31,
> +	PGP_SIG_EMBEDDED_SIG			=3D 32,
> +	PGP_SIG_ISSUER_FINGERPRINT		=3D 33,
> +	PGP_SIG_INTENDED_RECIPIENT_FINGERPRINT	=3D 35,
> +	PGP_SIG_PREFERRED_AEAD_CIPHERS		=3D 39,
> +	PGP_SIG__LAST
> +};
> +

/*
 * Documentation what is the critical mask.
 */
> +#define PGP_SIG_SUBPKT_TYPE_CRITICAL_MASK	0x80
> +
> +/*
> + * Key (tag 5, 6, 7 and 14) packet
> + */
> +enum pgp_key_version {
> +	PGP_KEY_VERSION_4			=3D 4,
> +};
> +

/*
 * doc
 */
> +struct pgp_key_v4_packet {
> +	enum pgp_key_version version : 8;
> +	struct pgp_time	creation_time;
> +	enum pgp_pubkey_algo pubkey_algo : 8;
> +	u8 key_material[];
> +} __packed;
> +
> +/*
> + * Literal Data (tag 11) packet
> + */
> +enum pgp_literal_data_format {
> +	PGP_LIT_FORMAT_BINARY			=3D 0x62,
> +	PGP_LIT_FORMAT_TEXT			=3D 0x74,
> +	PGP_LIT_FORMAT_TEXT_UTF8		=3D 0x75,
> +};


BR, Jarkko

