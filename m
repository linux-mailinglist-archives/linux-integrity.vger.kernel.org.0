Return-Path: <linux-integrity+bounces-2490-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF3F8CA6B6
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 05:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5281F21D83
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B943101F2;
	Tue, 21 May 2024 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mufnkycR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB3848A;
	Tue, 21 May 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261411; cv=none; b=PPtYCziyFlAFhS3tkAW6VrB+TDjG04zBTB3X6dL1I70BYn1JLQsjUCaSXw/cfZQjLnva2DREiv+S3sdwt+kkuhL71dRsQblZzKxROAcCkoLlFwAGfemg0D/1dt2o5VpvyncLEygv5G8ZP/qh4VvGC/vqjyCgaHinuwlWu/77i1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261411; c=relaxed/simple;
	bh=YK2OIxpfjJaaDk91GjlEjElige5eBrqgDYVjkNdZEEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaYkFn1zbWWA1ih4COtb5l5+3tKQGL1RLl7hMxFdTdCgyWW31T6YKHQOjNLo78sfy+b0gIdMAR2GB8L84x8QMa4QDQjF64UGNeJ6VXuedQFTO4IeuqyM30cvWre9vBRjXOgYi58m+wovV6rLNFgZ2Kpo7FmrL2BApQ8kHY08jcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mufnkycR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9C3C32786;
	Tue, 21 May 2024 03:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716261410;
	bh=YK2OIxpfjJaaDk91GjlEjElige5eBrqgDYVjkNdZEEo=;
	h=From:To:Cc:Subject:Date:From;
	b=mufnkycRqgDnEKVs0Z8YdZMXrmiM4FjhjHgsPPRH415K1hGvGc7FXZohKtrutljZJ
	 kzd5d40xulh0Pe5nG+T9w48QmMwWGQXAldO8h/DZog93F7AE5pzXbZ032XIqjcl1HH
	 j17xXmiw2y+BaaDIcYOlsBhX+uhkAPJRDMwvsqn7qQD8oTHoyolRomqbdwfq9mnCaQ
	 prQhbvBXSTkiKRUzsk21QcU5fe7yrqYz8bLuKCF7t5FVaZu2GMtZQdGb6VGXk2Q8Nw
	 fvol5NhCQvOKBf1nRvfjBr+GGbNKOs+3gDoo40MfjcXmDjrNMIVlESEVI/GzH9f4Vk
	 UJ/mPhE6LgNCg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/6] KEYS: asymmetric: tpm2_key_rsa
Date: Tue, 21 May 2024 06:16:25 +0300
Message-ID: <20240521031645.17008-1-jarkko@kernel.org>
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
kconfig option.

The idea in the design is to over time to have submodule per key type
For instance, tpm2_key_ecdsa could be one potential future addition in
the future. Perhaps, it might sense to consider at that point also a
top-level tpm2_key module. The gist is that the naming convention is
free from potential future bottlencks.

## Change Log

v2
Cleaned up all the low-hanging fruit for the sake of saving everyones
time. After this I move into reactive mode (I promise) ;-)

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

- v1: https://lore.kernel.org/linux-integrity/20240520184727.22038-1-jarkko@kernel.org/
- Derived from https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/

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
 crypto/asymmetric_keys/tpm2_key_rsa.c         | 698 ++++++++++++++++++
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
 security/keys/trusted-keys/trusted_tpm2.c     | 135 +---
 18 files changed, 1110 insertions(+), 270 deletions(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c
 create mode 100644 drivers/char/tpm/tpm2_key.c
 rename {security/keys/trusted-keys => drivers/char/tpm}/tpm2key.asn1 (100%)
 create mode 100644 include/crypto/rsa-pkcs1pad.h
 create mode 100644 include/crypto/tpm2_key.h

-- 
2.45.1


