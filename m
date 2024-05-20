Return-Path: <linux-integrity+bounces-2476-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB68CA22F
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 20:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2159C281F22
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4274137935;
	Mon, 20 May 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0Gps0qA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFB28E7;
	Mon, 20 May 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230852; cv=none; b=AawFuDtqoTzr3+CGO/3gCIp8hIe4Jbl7AMuM7Evhl49k5xiOH9cmB7SY3y+I9pk/k9MQhPD4UZDWUI/GvjC2d+aB5pjRDFEnzzLmdYeoa34wv8Ws/qpdEf+50fKGi3u2/hCqplrRw5GmuTzkfi0khzOFXa20aTZ5lpgEG9vbH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230852; c=relaxed/simple;
	bh=d6EYrnuzD3VjIiiy7fQuTy2F+G7elwLdChJKZjHFS2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i19uO+lqBdIX0AGIFwwvBv5QXri3AG75hlaVfHB1J31+X4F5G52jyDsUEc0JwMvz/Cg7bK9Vq9sW3SwDoHYV/QudmsmAckIcRqOPROMC4NPtSW5BHK44rshp2j60QC82J6u5d8jca9kFl7LIp1lGsv3NtdtIUtjlTv6DRAL9TNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0Gps0qA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949E0C2BD10;
	Mon, 20 May 2024 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716230851;
	bh=d6EYrnuzD3VjIiiy7fQuTy2F+G7elwLdChJKZjHFS2A=;
	h=From:To:Cc:Subject:Date:From;
	b=D0Gps0qA55rKP3djBGDGdnPkCBynQ8qvQlcxXj7vkOOlpguDH9puzf+hc9yptKmnv
	 V8eKMQndXmhUQDq6hCXQC3HI4OH0ATVfWc6nGCaM43gTaS5wBvRsltz3Zfz7CYWjDe
	 EvXYBleL8wBMMEjmEA1IBFVvGUE3AVGXdgD55/66CdF6nCX2wvveyQB02lP3FgW1u2
	 qM80OiJwcxXZ64tkpqu97pIrYBIdIuV2+yNJupWw/+UKRgPCfpBdg5p5ASuHGe9uUx
	 UesmIBQrBTcakiqzg4mXrD1vwXWr5YVqEEa7Z0NJh514WVY698/Q93VtAtkaZD6n8w
	 mleozawrY9LwA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/6] KEYS: asymmetric: tpm2_key_rsa
Date: Mon, 20 May 2024 21:47:07 +0300
Message-ID: <20240520184727.22038-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

## Overview

Introduce tpm2_key_rsa implementing asymmetric TPM RSA key. This key type
can be enabled with CONFIG_ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE config option.
Carves groundwork for similar modules in future, such as tpm2_key_ecdsa.

## Testing

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

- Derived from https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/
- Last RFC: https://lore.kernel.org/linux-integrity/D1DMTJYL7TFC.3J3FM36K06ECD@kernel.org/T/#t

James Prestwood (1):
  keys: asymmetric: ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE

Jarkko Sakkinen (5):
  crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
  lib: Expand asn1_encode_integer() to variable size integers
  tpm: Export tpm2_load_context()
  KEYS: trusted: Move tpm2_key_decode() to the TPM driver
  tpm: tpm2_key: Extend parser to TPM_LoadableKey

 crypto/asymmetric_keys/Kconfig                |  16 +
 crypto/asymmetric_keys/Makefile               |   1 +
 crypto/asymmetric_keys/tpm2_key_rsa.c         | 726 ++++++++++++++++++
 crypto/rsa-pkcs1pad.c                         |  16 +-
 drivers/char/tpm/Kconfig                      |   1 +
 drivers/char/tpm/Makefile                     |   5 +
 drivers/char/tpm/tpm.h                        |   2 -
 drivers/char/tpm/tpm2-cmd.c                   |  77 ++
 drivers/char/tpm/tpm2-space.c                 |  61 --
 drivers/char/tpm/tpm2_key.c                   | 119 +++
 .../char/tpm}/tpm2key.asn1                    |   0
 include/crypto/rsa-pkcs1pad.h                 |  20 +
 include/crypto/tpm2_key.h                     |  35 +
 include/linux/asn1_encoder.h                  |   3 +-
 include/linux/tpm.h                           |   4 +
 lib/asn1_encoder.c                            | 185 ++---
 security/keys/trusted-keys/Makefile           |   2 -
 security/keys/trusted-keys/trusted_tpm2.c     | 130 +---
 18 files changed, 1138 insertions(+), 265 deletions(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c
 create mode 100644 drivers/char/tpm/tpm2_key.c
 rename {security/keys/trusted-keys => drivers/char/tpm}/tpm2key.asn1 (100%)
 create mode 100644 include/crypto/rsa-pkcs1pad.h
 create mode 100644 include/crypto/tpm2_key.h

-- 
2.45.1


