Return-Path: <linux-integrity+bounces-2518-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3058CB13D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31C4B22012
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E6C1448C7;
	Tue, 21 May 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH+WHB4e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDCF4F8A1;
	Tue, 21 May 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305225; cv=none; b=Fhja2hCgnPQCrHbG2wUD3X4+LEK4RXIFOKIpS626W0zF0CPEtwtmv6iWyk4yBbglSriWZi6okSnpwRhhcIaXoUbi/bfRI3+lxCqex1JAjHpcF0nHenPQmUmD/yMAYXxJ17vI/hDGYM/it5xu1zxLAJIeajyGZPJG4WfEXEaiSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305225; c=relaxed/simple;
	bh=n/t9ygsCu+dIywdceMNRbQoZd1YbzShavt/GF+DNRdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvEKnWyahgSmum+qR700n/ADm4zeC+1P2L2oSrpUhPBeOOfY/IQikXrVGkP0s4C2phcK0B+kye48vBeXjHGFr+ZkrZEXNkj7sYraSlc8fmJ/RV7qu/xekcGg8AXe8gaQk7WVTrBqT0TrEiiAE15NSTRuxGbow/CBrAxl63+o6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH+WHB4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5BAC2BD11;
	Tue, 21 May 2024 15:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716305224;
	bh=n/t9ygsCu+dIywdceMNRbQoZd1YbzShavt/GF+DNRdU=;
	h=From:To:Cc:Subject:Date:From;
	b=sH+WHB4epJLkHySfroputnQcIAMiaITheMYk7sAGDYNYfT0N34aPZ0Szrpe2cY4qX
	 XrikC0QsSvnM1zcQ0Mp5a2c81BOKzRg+XGJg58gn/WkbpH+nNUFBDebgog8SMcb2VU
	 xWtCqfGZWN9lil9vwXtAfvEC8neiyW1PJ/IjxHPZakZVooxC5XHnWwIVl4FA2w7VAX
	 UqKJ6VewEp6pcbpwrIEvgM1zyciF3vAi6nSw4FhtQPa79ajk7ynxcdWYdKeoy+RC8q
	 37rumUIJpOHv9wrWHFJ72LyxjemfYTBVQiO6tFSr2JR4QCJ/sI5Wsgo1az9hzpDgYA
	 3wMSDE367mlcQ==
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
Subject: [PATCH v3 0/5] KEYS: asymmetric: tpm2_key_rsa
Date: Tue, 21 May 2024 18:26:42 +0300
Message-ID: <20240521152659.26438-1-jarkko@kernel.org>
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

v3:
* Dropped special policy when RH_NULL is given. Kernel will just try to
  use the handle as parent given.
* Thus could drop the patch exporting tpm2_load_context().
v2:
* Cleaned up all the low-hanging fruit for the sake of saving everyones
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

- v2: https://lore.kernel.org/linux-integrity/20240521031645.17008-1-jarkko@kernel.org/
- v1: https://lore.kernel.org/linux-integrity/20240520184727.22038-1-jarkko@kernel.org/
- Derived from https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/

James Prestwood (1):
  keys: asymmetric: ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE

Jarkko Sakkinen (4):
  crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
  lib: Expand asn1_encode_integer() to variable size integers
  KEYS: trusted: Move tpm2_key_decode() to the TPM driver
  tpm: tpm2_key: Extend parser to TPM_LoadableKey

 crypto/asymmetric_keys/Kconfig                |  16 +
 crypto/asymmetric_keys/Makefile               |   1 +
 crypto/asymmetric_keys/tpm2_key_rsa.c         | 688 ++++++++++++++++++
 crypto/rsa-pkcs1pad.c                         |  16 +-
 drivers/char/tpm/Kconfig                      |   1 +
 drivers/char/tpm/Makefile                     |   5 +
 drivers/char/tpm/tpm2_key.c                   | 118 +++
 .../char/tpm}/tpm2key.asn1                    |   0
 include/crypto/rsa-pkcs1pad.h                 |  20 +
 include/crypto/tpm2_key.h                     |  35 +
 include/linux/asn1_encoder.h                  |   3 +-
 include/linux/tpm.h                           |   2 +
 lib/asn1_encoder.c                            | 185 ++---
 security/keys/trusted-keys/Makefile           |   2 -
 security/keys/trusted-keys/trusted_tpm2.c     | 135 +---
 15 files changed, 1020 insertions(+), 207 deletions(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c
 create mode 100644 drivers/char/tpm/tpm2_key.c
 rename {security/keys/trusted-keys => drivers/char/tpm}/tpm2key.asn1 (100%)
 create mode 100644 include/crypto/rsa-pkcs1pad.h
 create mode 100644 include/crypto/tpm2_key.h

-- 
2.45.1


