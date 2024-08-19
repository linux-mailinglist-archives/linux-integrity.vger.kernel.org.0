Return-Path: <linux-integrity+bounces-3360-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5C95704F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE321F228A0
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936031779AE;
	Mon, 19 Aug 2024 16:31:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A032C8B;
	Mon, 19 Aug 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085069; cv=none; b=rLiqnos3vnFwg94i2/uae2uTep2Yd4uiQJZd+1NIww2j4nxbWwVaNmnNfrtUPp7aVZjzdgPMoIU1ZIqfMh8b43YyZ8PvNfFsEoaVRaSV7MplIluWf3EV0qv35QxqKNWGQWfDzRrf0VYsijv06M6fw2n6U8zpMHV8pwqI3EaBg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085069; c=relaxed/simple;
	bh=KayCsSrw/wPS7vuoxUC8St036JAJ2fqsYzR9mza+wY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uSX2QED7kp7KxgZ1Dz0LKiVEYOYZBMaZoUc3QTYi662xumeAwJPJlvi4AIBqwOwwr5DeSKz97RTkJIahoNpbs/eJ17JNd1djKxUXEHO7Dtg4jFZvkT0InGsZEMzu/Usi79t9B3WIV2u1h89KLQdnIvaMZGVycWWzVl86m4aRvHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Wnd035HvWz9v7NP;
	Tue, 20 Aug 2024 00:12:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E131314065B;
	Tue, 20 Aug 2024 00:30:53 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3E8Exc8NmeuqEAQ--.28899S2;
	Mon, 19 Aug 2024 17:30:52 +0100 (CET)
Message-ID: <d0070fb3b46aa9d8f02ee9d0558cd6107af74a73.camel@huaweicloud.com>
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, 
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 19 Aug 2024 18:30:38 +0200
In-Reply-To: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwD3E8Exc8NmeuqEAQ--.28899S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4xtF43GF47CF4xXFW8Zwb_yoW3Jr4fpF
	4rKr98JF98Gr92kFWfJw1xu3y5Ars5Aw43Gwnagw15A3sIqF1vya92kF43uF9xGr18Xr4F
	qrZYqr1UCw1Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABGbCqngH4gAAsV

On Sun, 2024-08-18 at 18:57 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Support for PGP keys and signatures was proposed by David long time ago,
> before the decision of using PKCS#7 for kernel modules signatures
> verification was made. After that, there has been not enough interest to
> support PGP too.
>=20
> Lately, when discussing a proposal of introducing fsverity signatures in
> Fedora [1], developers expressed their preference on not having a separat=
e
> key for signing, which would complicate the management of the distributio=
n.
> They would be more in favor of using the same PGP key, currently used for
> signing RPM headers, also for file-based signatures (not only fsverity, b=
ut
> also IMA ones).

Update: since Fedora 39, IMA file signatures are supported on an
independent key infrastructure.

Roberto

> Another envisioned use case would be to add the ability to appraise RPM
> headers with their existing PGP signature, so that they can be used as an
> authenticated source of reference values for appraising remaining
> files [2].
>=20
> To make these use cases possible, introduce support for PGP keys and
> signatures in the kernel, and load provided PGP keys in the built-in
> keyring, so that PGP signatures of RPM headers, fsverity digests, and IMA
> digests can be verified from this trust anchor.
>=20
> In addition to the original version of the patch set, also introduce
> support for signature verification of PGP keys, so that those keys can be
> added to keyrings with a signature-based restriction (e.g. .ima). PGP key=
s
> are searched with partial IDs, provided with signature subtype 16 (Issuer=
).
> Search with full IDs could be supported with
> draft-ietf-openpgp-rfc4880bis-10, by retrieving the information from
> signature subtype 33 (Issuer Fingerprint). Due to the possibility of ID
> collisions, the key_or_keyring restriction is not supported.
>=20
> The patch set includes two preliminary patches: patch 1 introduces
> mpi_key_length(), to get the number of bits and bytes of an MPI; patch 2
> introduces rsa_parse_priv_key_raw() and rsa_parse_pub_key_raw(), to parse
> an RSA key in RAW format if the ASN.1 parser returns an error.
>=20
> Patches 3-5 introduce the library necessary to parse PGP keys and
> signatures, whose support is added with patches 6-10. Patch 11 introduces
> verify_pgp_signature() to be used by kernel subsystems (e.g. fsverity and
> IMA). Patch 12 is for testing of PGP signatures. Finally, patches 13-14
> allow loading a set of PGP keys from a supplied blob at boot time.
>=20
> Changelog
>=20
> v1 [4]:
> - Remove quiet_cmd_extract_certs (redundant, likely leftover from
>   conflict resolution)
> - Load PGP keys embedded in the kernel image within load_module_cert()
>   and load_system_certificate_list(), instead of using a separate initcal=
l
> - Style bug fixes found by checkpatch.pl
> - Add <crypto/pgp.h> include in crypto/asymmetric_keys/pgp_preload.c, to
>   remove no previous prototype warning
> - Correctly check returned tfm in pgp_generate_fingerprint()
> - Fix printing message in pgp_generate_fingerprint()
> - Don't create a public key if the key blob does not contain a PGP key
>   packet
> - Remove unused pgp_pubkey_hash array
> - Set KEY_EFLAG_DIGITALSIG key flag if the key has the capability
> - Allow PGP_SIG_GENERAL_CERT_OF_UID_PUBKEY signature type (for key sigs)
> - Add is_key_sig parameter to pgp_sig_get_sig() to ensure the key
>   signature type is PGP_SIG_GENERAL_CERT_OF_UID_PUBKEY or
>   PGP_SIG_POSTITIVE_CERT_OF_UID_PUBKEY
>=20
> v0 [3]:
> - style fixes
> - move include/linux/pgp.h and pgplib.h to crypto/asymmetric_keys
> - introduce verify_pgp_signature()
> - replace KEY_ALLOC_TRUSTED flag with KEY_ALLOC_BUILT_IN
> - don't fetch PGP subkeys
> - drop support for DSA
> - store number of MPIs in pgp_key_algo_p_num_mpi array
> - replace dynamic memory allocations with static ones in
>   pgp_generate_fingerprint()
> - store only keys with capability of verifying signatures
> - remember selection of PGP signature packet and don't repeat parsing
> - move search of the PGP key to verify the signature from the beginning
>   to the end of the verification process (to be similar with PKCS#7)
> - don't retry key search in the session keyring from the signature
>   verification code, let the caller pass the desired keyring
> - for the PGP signature test key type, retry the key search in the sessio=
n
>   keyring
> - retry key search in restrict_link_by_signature() with a partial ID
>   (provided in the PGP signature)
>=20
> [1] https://fedoraproject.org/wiki/Changes/FsVerityRPM
> [2] https://lore.kernel.org/linux-integrity/20240415142436.2545003-1-robe=
rto.sassu@huaweicloud.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-modsig=
n.git/log/?h=3Dpgp-parser
> [4] https://lore.kernel.org/linux-integrity/20220111180318.591029-1-rober=
to.sassu@huawei.com/
>=20
> David Howells (8):
>   PGPLIB: PGP definitions (RFC 4880)
>   PGPLIB: Basic packet parser
>   PGPLIB: Signature parser
>   KEYS: PGP data parser
>   KEYS: Provide PGP key description autogeneration
>   KEYS: PGP-based public key signature verification
>   PGP: Provide a key type for testing PGP signatures
>   KEYS: Provide a function to load keys from a PGP keyring blob
>=20
> Roberto Sassu (6):
>   mpi: Introduce mpi_key_length()
>   rsa: add parser of raw format
>   KEYS: Retry asym key search with partial ID in
>     restrict_link_by_signature()
>   KEYS: Calculate key digest and get signature of the key
>   verification: introduce verify_pgp_signature()
>   KEYS: Introduce load_pgp_public_keyring()
>=20
>  MAINTAINERS                             |   1 +
>  certs/Kconfig                           |  11 +
>  certs/Makefile                          |   7 +
>  certs/system_certificates.S             |  18 +
>  certs/system_keyring.c                  |  93 ++++
>  crypto/asymmetric_keys/Kconfig          |  38 ++
>  crypto/asymmetric_keys/Makefile         |  13 +
>  crypto/asymmetric_keys/pgp.h            | 206 ++++++++
>  crypto/asymmetric_keys/pgp_library.c    | 620 ++++++++++++++++++++++++
>  crypto/asymmetric_keys/pgp_parser.h     |  18 +
>  crypto/asymmetric_keys/pgp_preload.c    | 111 +++++
>  crypto/asymmetric_keys/pgp_public_key.c | 492 +++++++++++++++++++
>  crypto/asymmetric_keys/pgp_signature.c  | 505 +++++++++++++++++++
>  crypto/asymmetric_keys/pgp_test_key.c   | 129 +++++
>  crypto/asymmetric_keys/pgplib.h         |  74 +++
>  crypto/asymmetric_keys/restrict.c       |  10 +-
>  crypto/rsa.c                            |  14 +-
>  crypto/rsa_helper.c                     |  69 +++
>  include/crypto/internal/rsa.h           |   6 +
>  include/crypto/pgp.h                    |  36 ++
>  include/linux/mpi.h                     |   2 +
>  include/linux/verification.h            |  23 +
>  lib/crypto/mpi/mpicoder.c               |  33 +-
>  23 files changed, 2516 insertions(+), 13 deletions(-)
>  create mode 100644 crypto/asymmetric_keys/pgp.h
>  create mode 100644 crypto/asymmetric_keys/pgp_library.c
>  create mode 100644 crypto/asymmetric_keys/pgp_parser.h
>  create mode 100644 crypto/asymmetric_keys/pgp_preload.c
>  create mode 100644 crypto/asymmetric_keys/pgp_public_key.c
>  create mode 100644 crypto/asymmetric_keys/pgp_signature.c
>  create mode 100644 crypto/asymmetric_keys/pgp_test_key.c
>  create mode 100644 crypto/asymmetric_keys/pgplib.h
>  create mode 100644 include/crypto/pgp.h
>=20


