Return-Path: <linux-integrity+bounces-2668-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B005A8D12FB
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 05:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43CF1C21900
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 03:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99351429B;
	Tue, 28 May 2024 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwEjQoXw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80C17E8E4;
	Tue, 28 May 2024 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868305; cv=none; b=RyMSzroET6fzmTcA/V4XATst7ojoB+XlrtQ1cr1xHsvnZux/4u9QtoohmG72XgIJm2s0qkLDc7V//lBSvjXzthdzKRC4TQMiL3W8AUQzsgzMod2iGHmfpVMaS2qdnw0VLyfM/cu80Eo5oGBkYMxD8q11HAH4puUzQGeKU6W+XtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868305; c=relaxed/simple;
	bh=+iPQMa+6kqA2ZUh+VMv82Bt86ZQQJcbmF1UL0D12zgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkO1wzhnIOdMWOIj9uhnXnR85bcABIIwyyC7FNkeSmMKk3uSoPCt8SQdgeOVCtUHL4/HbCq/u6Ao3/8TSetua3wEhHBlW8reHrq+2PkGx+H/3zHqRMOey9S8G+w/HXuLqTZs4B0kGKAVB2x9RkUwgLd9UKQlw2G+t96L4/xv6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwEjQoXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B02C32782;
	Tue, 28 May 2024 03:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716868305;
	bh=+iPQMa+6kqA2ZUh+VMv82Bt86ZQQJcbmF1UL0D12zgU=;
	h=From:To:Cc:Subject:Date:From;
	b=OwEjQoXw8tUNKXnC6ZHQXCqX15EaRAtYAcoyxmOHwE+25AQxtLCGQ/b2GmgrUPG29
	 C48jRJw3bNve++wTLpFcP56mLnhBAxHp30Zaq7dben+j9+x/WGHSDRRImd4lOpk/CZ
	 kDHnOpkzjbFubaLMTAxQEUDjaHdwx9vJ64mVcx8N+NRJmee93eveQJ2jkm0MI2Nykb
	 +++vmfkmJpuyTjjy2RjIP290suV7aY7UMaB9aWOFH+DzQTcitQkam8jD4lM6cO0X2L
	 c4BPb+ba+MEiRWD+Xyzyxk7y5SLk/ETzu0xIRaneb4Dr4Do4XgmP4nqHKOcAlsf+rH
	 HsMhf1/mwMNuQ==
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
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 0/6] KEYS: asymmetric: tpm2_key_{rsa,ecdsa}
Date: Tue, 28 May 2024 06:51:15 +0300
Message-ID: <20240528035136.11464-1-jarkko@kernel.org>
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

Open Issues
===========

* When verifying ECDSA signature, _ecdsa_verify() returns -EKEYREJECTED.

References
==========

* v5: https://lore.kernel.org/linux-integrity/20240523212515.4875-1-jarkko@kernel.org/
* v4: https://lore.kernel.org/linux-integrity/20240522005252.17841-1-jarkko@kernel.org/
* v3: https://lore.kernel.org/linux-integrity/20240521152659.26438-1-jarkko@kernel.org/
* v2: https://lore.kernel.org/linux-integrity/336755.1716327854@warthog.procyon.org.uk/
* v1: https://lore.kernel.org/linux-integrity/20240520184727.22038-1-jarkko@kernel.org/
* Derived from https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/

Jarkko Sakkinen (6):
  tpm: Open code tpm_buf_parameters()
  crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
  KEYS: trusted: Change -EINVAL to -E2BIG
  crypto: tpm2_key: Introduce a TPM2 key type
  keys: asymmetric: Add tpm2_key_rsa
  keys: asymmetric: Add tpm2_key_ecdsa

 crypto/Kconfig                            |   7 +
 crypto/Makefile                           |   6 +
 crypto/asymmetric_keys/Kconfig            |  30 +
 crypto/asymmetric_keys/Makefile           |   2 +
 crypto/asymmetric_keys/tpm2_key_ecdsa.c   | 441 ++++++++++++++
 crypto/asymmetric_keys/tpm2_key_rsa.c     | 678 ++++++++++++++++++++++
 crypto/ecdsa.c                            |   1 -
 crypto/rsa-pkcs1pad.c                     |  16 +-
 crypto/tpm2_key.asn1                      |  11 +
 crypto/tpm2_key.c                         | 134 +++++
 drivers/char/tpm/tpm-buf.c                |  26 -
 drivers/char/tpm/tpm2-cmd.c               |  10 +-
 include/crypto/rsa-pkcs1pad.h             |  20 +
 include/crypto/tpm2_key.h                 |  46 ++
 include/linux/tpm.h                       |  10 +-
 security/keys/trusted-keys/Kconfig        |   2 +-
 security/keys/trusted-keys/Makefile       |   2 -
 security/keys/trusted-keys/tpm2key.asn1   |  11 -
 security/keys/trusted-keys/trusted_tpm2.c | 141 +----
 19 files changed, 1433 insertions(+), 161 deletions(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_ecdsa.c
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c
 create mode 100644 crypto/tpm2_key.asn1
 create mode 100644 crypto/tpm2_key.c
 create mode 100644 include/crypto/rsa-pkcs1pad.h
 create mode 100644 include/crypto/tpm2_key.h
 delete mode 100644 security/keys/trusted-keys/tpm2key.asn1

-- 
2.45.1


