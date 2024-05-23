Return-Path: <linux-integrity+bounces-2592-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F78CDBF8
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 23:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC102868C2
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2024 21:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8293127E04;
	Thu, 23 May 2024 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heIQ+CIm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA81127E38;
	Thu, 23 May 2024 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499521; cv=none; b=rEsuqNUiz3hjVs55TLQBVC00LozCDTUJAa8WM9S5UdJJwZC8OLx85mGYmN67Po7Qd5G/XL6hlns+DWnrH665WJB6WVZnvegi+DKjCmJJVm9T0lxrTu39gLDAAParnV/FYgCMi7WxV4Wyg43LsL6axbpmmu4B1USp7y4N3QCZ130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499521; c=relaxed/simple;
	bh=IuC7pNZzzslPJuuCpAPR9im2akGIeG/gnIj3He/N/zY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqyGenUazRKnzCNO6zDYCw7qQWE/fPR1rFhR5vOQYujV5Ja4vXYJLkK612suA8tyheoR+HMuXv/qRK7CM5QgvNje0JIkUAXFdRMEaNNYQ8ydq1A0P8bvYAhSZFD/TCd9n17x6Fgyv+soM7BsWs9ko6OlNrR1WcuAmamhmO6nXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heIQ+CIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2727C2BD10;
	Thu, 23 May 2024 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716499521;
	bh=IuC7pNZzzslPJuuCpAPR9im2akGIeG/gnIj3He/N/zY=;
	h=From:To:Cc:Subject:Date:From;
	b=heIQ+CImupoR+mWaqXZk9xei64EV98tTpR4QDsoBgvq3kaoqdHqK4dadvEv4dWUEV
	 /RJ6NeX2ClWS0+ZUJF9mwelwjElJ4r6OvtovlNkNHI2WUgKTFhXSp2xzosV6jsUUR/
	 t2wZw4WT07+p6DhBfbS3qx2iyGhDtRsllIFKuL4Sellzmwm8q13dw2SjeGZt5OtKDy
	 AR8JQEhoGVO4bCe/dTHCUjgaCgsIZGRU6kzJQmrtgyvK30tPDw/q5sZZXk5jvqghEt
	 efJU/GVs4KRIXVDDtnyZdy5AVucythd7to0Ml+TAEkDGCj46ezXoxEiMNRpdZHbb8E
	 MOvnuP8tHbXWw==
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
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 0/5] KEYS: asymmetric: tpm2_key_rsa
Date: Fri, 24 May 2024 00:25:01 +0300
Message-ID: <20240523212515.4875-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

## Overview

Introduce tpm2_key_rsa module, which implements asymmetric TPM2 RSA key.
The feature can be enabled with the CONFIG_ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE 
kconfig option. This feature allows the private key to be uploaded to
the TPM2 for signing, and software can use the public key to verify
the signatures.

The idea in the design is to over time to have submodule per key type
For instance, tpm2_key_ecdsa could be one potential future addition in
the future. Perhaps, it might sense to consider at that point also a
top-level tpm2_key module. The gist is that the naming convention is
free from potential future bottlencks.

### Testing

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

## References

- v4: https://lore.kernel.org/linux-integrity/20240522005252.17841-1-jarkko@kernel.org/
- v3: https://lore.kernel.org/linux-integrity/20240521152659.26438-1-jarkko@kernel.org/
- v2: https://lore.kernel.org/linux-integrity/336755.1716327854@warthog.procyon.org.uk/
- v1: https://lore.kernel.org/linux-integrity/20240520184727.22038-1-jarkko@kernel.org/
- Derived from https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/

James Prestwood (1):
  keys: asymmetric: ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE

Jarkko Sakkinen (4):
  crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
  KEYS: trusted: Change -EINVAL to -E2BIG
  KEYS: trusted: Move tpm2_key_decode() to the TPM driver
  tpm: tpm2_key: Extend parser to TPM_LoadableKey

 crypto/asymmetric_keys/Kconfig                |  15 +
 crypto/asymmetric_keys/Makefile               |   1 +
 crypto/asymmetric_keys/tpm2_key_rsa.c         | 680 ++++++++++++++++++
 crypto/rsa-pkcs1pad.c                         |  16 +-
 drivers/char/tpm/Kconfig                      |   1 +
 drivers/char/tpm/Makefile                     |   5 +
 drivers/char/tpm/tpm2_key.c                   | 118 +++
 .../char/tpm}/tpm2key.asn1                    |   0
 include/crypto/rsa-pkcs1pad.h                 |  20 +
 include/crypto/tpm2_key.h                     |  35 +
 include/linux/tpm.h                           |   2 +
 security/keys/trusted-keys/Makefile           |   2 -
 security/keys/trusted-keys/trusted_tpm2.c     | 131 +---
 13 files changed, 908 insertions(+), 118 deletions(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c
 create mode 100644 drivers/char/tpm/tpm2_key.c
 rename {security/keys/trusted-keys => drivers/char/tpm}/tpm2key.asn1 (100%)
 create mode 100644 include/crypto/rsa-pkcs1pad.h
 create mode 100644 include/crypto/tpm2_key.h

-- 
2.45.1


