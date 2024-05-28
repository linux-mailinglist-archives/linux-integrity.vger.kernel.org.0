Return-Path: <linux-integrity+bounces-2681-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A8D8D26CE
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 23:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3FD2862D6
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F308917BB35;
	Tue, 28 May 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmQEETWO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024D17B4F1;
	Tue, 28 May 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930508; cv=none; b=DUmVeRo7YeMuJCpL++ctMTBGOhMXIA6RzVby59rNAYpod6b0kIQTy323HGzitjeAsVMEjnPVGhxul9V6ELdlMYF7giX0VuJIWHYrMza6KA2AWiRJkhkMOU/mwUEYymzIY7bLpeNMyQEXAitS/KuJjYYvFYI52Ew8makM730WdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930508; c=relaxed/simple;
	bh=+RJf99b+oqpd6tk1J7zvY8EG9GzEuyxbjjBaa9Ju10U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m16KibBCDv0QV0p6CY9x8NHjAzJPdl21s5qof6Jt4M6Tm4J3v/+RiIrtfioFEHRLOwmG4o61MdvRCF+Sp4UPYle56whrFsjhezZCd1Tq3n4OgZEUYyg0ok1n5WNPEeuKBYxAjxlFZnkekp1Gf74/TwBKQl6IML0yEkKaGmQIQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmQEETWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9844C3277B;
	Tue, 28 May 2024 21:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716930508;
	bh=+RJf99b+oqpd6tk1J7zvY8EG9GzEuyxbjjBaa9Ju10U=;
	h=From:To:Cc:Subject:Date:From;
	b=QmQEETWOamaXBKb3C0E6fMxUfWTry5v6fu4RmDLTYQ3mFu9haVVjAyxCJwa4biJdd
	 EYHxCpTQILzTwkrjI6a/dfgY0UqQjUx19CkxySCYeuaKcIXFvq4GgOQm+5DSuaWuBS
	 /+yDjhK1Wn41mzKN5P8Frf74IapxxftrePpp+lmBIdi2TmU8z4G5o+UZQM6HlJCgcV
	 v/KlgZ/IGCPtOltsv2K5S57mfWXwCwGlw5/u5tDIr5RXgqJ/cHF+RHGUgk1j+lr7uS
	 FaGOJwOBcCjtJODiEnDbDmnsSvY5FVLVtv4YbHY/WUWLl+uyhm+qE0he1WSJgN5EEs
	 /+gGNQDQiu/5g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Lennart Poettering <lennart@poettering.net>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 0/5] KEYS: asymmetric: tpm2_key_{rsa,ecdsa}
Date: Wed, 29 May 2024 00:08:05 +0300
Message-ID: <20240528210823.28798-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing
=======

RSA
---

tpm2_createprimary --hierarchy o -G rsa2048 -c owner.txt
tpm2_evictcontrol -c owner.txt 0x81000001
tpm2_getcap handles-persistent
openssl genrsa -out private.pem 2048
tpm2_import -C 0x81000001 -G rsa -i private.pem -u key.pub -r key.priv
tpm2_encodeobject -C 0x81000001 -u key.pub -r key.priv -o key.priv.pem
openssl asn1parse -inform pem -in key.priv.pem -noout -out key.priv.der
serial=`cat key.priv.der | keyctl padd asymmetric tpm @u`
echo "abcdefg" > plaintext.txt
keyctl pkey_encrypt $serial 0 plaintext.txt enc=pkcs1 > encrypted.dat
keyctl pkey_decrypt $serial 0 encrypted.dat enc=pkcs1 > decrypted.dat
keyctl pkey_sign $serial 0 plaintext.txt enc=pkcs1 hash=sha256 > signed.dat
keyctl pkey_verify $serial 0 plaintext.txt signed.dat enc=pkcs1 hash=sha256

ECDSA
-----

tpm2_createprimary --hierarchy o -G ecc -c owner.txt
tpm2_evictcontrol -c owner.txt 0x81000001
openssl ecparam -name prime256v1 -genkey -noout -out private.pem
tpm2_import -C 0x81000001 -G ecc -i private.pem -u key.pub -r key.priv
tpm2_encodeobject -C 0x81000001 -u key.pub -r key.priv -o key.priv.pem
openssl asn1parse -inform pem -in key.priv.pem -noout -out key.priv.der
serial=`cat key.priv.der | keyctl padd asymmetric tpm @u`
echo "abcdefg" > plaintext.txt
keyctl pkey_sign $serial 0 plaintext.txt hash=sha256 > signed.dat
keyctl pkey_verify $serial 0 plaintext.txt signed.dat hash=sha256

Closed Issues
=============

* When verifying ECDSA signature, _ecdsa_verify() returns -EKEYREJECTED.
  * v7: rewrote the signature encoder with a more structured layout.

References
==========

* v6: https://lore.kernel.org/linux-integrity/20240528035136.11464-1-jarkko@kernel.org/
* v5: https://lore.kernel.org/linux-integrity/20240523212515.4875-1-jarkko@kernel.org/
* v4: https://lore.kernel.org/linux-integrity/20240522005252.17841-1-jarkko@kernel.org/
* v3: https://lore.kernel.org/linux-integrity/20240521152659.26438-1-jarkko@kernel.org/
* v2: https://lore.kernel.org/linux-integrity/336755.1716327854@warthog.procyon.org.uk/
* v1: https://lore.kernel.org/linux-integrity/20240520184727.22038-1-jarkko@kernel.org/
* Derived from https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/

Jarkko Sakkinen (5):
  crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
  KEYS: trusted: Change -EINVAL to -E2BIG
  crypto: tpm2_key: Introduce a TPM2 key type
  keys: asymmetric: Add tpm2_key_rsa
  keys: asymmetric: Add tpm2_key_ecdsa

 crypto/Kconfig                            |   7 +
 crypto/Makefile                           |   6 +
 crypto/asymmetric_keys/Kconfig            |  30 +
 crypto/asymmetric_keys/Makefile           |   2 +
 crypto/asymmetric_keys/tpm2_key_ecdsa.c   | 462 +++++++++++++++
 crypto/asymmetric_keys/tpm2_key_rsa.c     | 678 ++++++++++++++++++++++
 crypto/ecdsa.c                            |   1 -
 crypto/rsa-pkcs1pad.c                     |  16 +-
 crypto/tpm2_key.asn1                      |  11 +
 crypto/tpm2_key.c                         | 134 +++++
 drivers/char/tpm/tpm-buf.c                |   2 +-
 include/crypto/rsa-pkcs1pad.h             |  20 +
 include/crypto/tpm2_key.h                 |  46 ++
 include/linux/tpm.h                       |   9 +
 security/keys/trusted-keys/Kconfig        |   2 +-
 security/keys/trusted-keys/Makefile       |   2 -
 security/keys/trusted-keys/tpm2key.asn1   |  11 -
 security/keys/trusted-keys/trusted_tpm2.c | 141 +----
 18 files changed, 1447 insertions(+), 133 deletions(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_ecdsa.c
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c
 create mode 100644 crypto/tpm2_key.asn1
 create mode 100644 crypto/tpm2_key.c
 create mode 100644 include/crypto/rsa-pkcs1pad.h
 create mode 100644 include/crypto/tpm2_key.h
 delete mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.45.1


