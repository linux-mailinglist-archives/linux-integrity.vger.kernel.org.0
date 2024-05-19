Return-Path: <linux-integrity+bounces-2458-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D04628C9320
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 02:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950ED281A1B
	for <lists+linux-integrity@lfdr.de>; Sun, 19 May 2024 00:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E93F33D5;
	Sun, 19 May 2024 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz0eW68c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CC623;
	Sun, 19 May 2024 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716078384; cv=none; b=byNKuYZttZy6KynyTyBgE1VlbSpGKZpQqIoEtF9NNAawYrtua4+adBrM77ssCyKdhAzbT77B3iDL1rlMxDKUd51UtZED9UhMKUEt1TkJWE9W6iZzBragSWpg/26NDxyxZ3Ux6vMcbJGz2ETK+9kgDkcVt0BgW5z2b7/kRjZH5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716078384; c=relaxed/simple;
	bh=FnAEJAT2KZiL8xN2u659Y/J3RlLZadh5FrBsUs6TDVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZvAZnMkmgnPpxaVgRdmfd3henT/CiMVq06k5wSXQZ+OhLERGPEhuO4J1ko/l9H6/r26I748miqWB3c0QIXFzEbnHzCgltLi1v7fMti7Zp+P3isFw1ZAh6CzPRn4uLghzBOVG7/Ju+wVQ41NVsmfnBRct09oVOHrBafFt4uSfe4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz0eW68c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF3BC113CC;
	Sun, 19 May 2024 00:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716078384;
	bh=FnAEJAT2KZiL8xN2u659Y/J3RlLZadh5FrBsUs6TDVI=;
	h=From:To:Cc:Subject:Date:From;
	b=tz0eW68cJTWmh6lhG7ABWp92O9wHXpAGC9uVpBO9Ao50ugeMlE35Eeo621Pcx8i19
	 jI9KP1eBn83Hi8nLVOj2beZOpEWNfVwMQJUbvbP81c46ilzextaUELyEF9BGEekVz9
	 lk1RRPdwA7KTGlcSm2ENeH9eZahpJiDzkpVEZCBSWvSWSAqDslewKOFRCdln94x5Jt
	 EDU+nLwPhrCeLdU7ROlSiAMTYLDa0WJNirbNIGhdxRw/SGdUliQl47lVTWUfikplGM
	 TMfpxuv/w3LgZe2bbwO9mgGkegIM72DFz5N9Jc7dTwZxQGb/7H1iSkWxsTks/rRlQR
	 e7a4FAtVmPeZQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com,
	James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-crypto@vger.kernel.org (open list:CRYPTO API),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC v2 0/5] Asymmetric TPM2 key type
Date: Sun, 19 May 2024 03:25:35 +0300
Message-ID: <20240519002616.4432-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

## Overview

Introduce tpm2_key_rsa implementing asymmetric TPM RSA key.

I submit this first as RFC as I could not execute the keyctl padd in the
following sequence (returns EBADF):

tpm2_createprimary --hierarchy o -G rsa2048 -c owner.txt
tpm2_evictcontrol -c owner.txt 0x81000001
tpm2_getcap handles-persistent
openssl genrsa -out private.pem 2048
tpm2_import -C 0x81000001 -G rsa -i private.pem -u key.pub -r key.priv
tpm2_encodeobject -C 0x81000001 -u key.pub -r key.priv -o key.priv.pem
openssl asn1parse -inform pem -in key.priv.pem -noout -out key.priv.der
key_serial=`cat key.priv.der | keyctl padd asymmetric tpm @u`

This is derived work from James Prestwoodâ€™s earlier work from 2020:
https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/

## Change Log

v2:
Sorry for rush update. I noticed that not all changes were in the
commits. This version just fixes those compilation errors.

James Prestwood (1):
  keys: asymmetric: ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE

Jarkko Sakkinen (4):
  crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
  tpm: export tpm2_load_context()
  KEYS: trusted: Do not use WARN when encode fails
  KEYS: trusted: Migrate tpm2_key_{encode,decode}() to TPM driver

 crypto/asymmetric_keys/Kconfig                |  13 +
 crypto/asymmetric_keys/Makefile               |   1 +
 crypto/asymmetric_keys/tpm2_key_rsa.c         | 655 ++++++++++++++++++
 crypto/rsa-pkcs1pad.c                         |  16 +-
 drivers/char/tpm/Kconfig                      |   2 +
 drivers/char/tpm/Makefile                     |   5 +
 drivers/char/tpm/tpm.h                        |   2 -
 drivers/char/tpm/tpm2-cmd.c                   |  77 ++
 drivers/char/tpm/tpm2-space.c                 |  61 --
 drivers/char/tpm/tpm2_key.c                   | 192 +++++
 .../char/tpm}/tpm2key.asn1                    |   0
 include/crypto/rsa-pkcs1pad.h                 |  20 +
 include/crypto/tpm2_key.h                     |  36 +
 include/linux/tpm.h                           |   3 +
 security/keys/trusted-keys/Makefile           |   2 -
 security/keys/trusted-keys/trusted_tpm2.c     | 183 +----
 16 files changed, 1032 insertions(+), 236 deletions(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c
 create mode 100644 drivers/char/tpm/tpm2_key.c
 rename {security/keys/trusted-keys => drivers/char/tpm}/tpm2key.asn1 (100%)
 create mode 100644 include/crypto/rsa-pkcs1pad.h
 create mode 100644 include/crypto/tpm2_key.h

-- 
2.45.1


