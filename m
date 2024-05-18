Return-Path: <linux-integrity+bounces-2452-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2AA8C927B
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 23:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29809B20B3D
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF626CDBA;
	Sat, 18 May 2024 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVldWSgx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36036BB26;
	Sat, 18 May 2024 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716068224; cv=none; b=afld8Gs0XpxezUYNz0QC/gLz1LTFr4zXyznzbL+/PE8X2sL8Zbmu3O0QuxAQZoxRn5ROYeJI4mZlfylAZM/5OOFs6wlUebRdeWrxWrR8Txc655g6TZ62fmvsNJuKWEfBHOpXycqbPt2iCZJFbUys8eSQcZJflQ5z//pkG3zgIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716068224; c=relaxed/simple;
	bh=i4wo/8Z7T3kmv6I4NXf5lzXYWB0n3G483Xogj9SqaVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p5GrG7qh0k2jsqUZcad8o53nPIGVN7bnvig5FWiszMUM6QUzaGolw2gwdr5GueBMuHRbIMwvf/LgBySclZFZotSlvC7OSqqCclKZ2kOaFMBWiKhMjiY8Xu3QenGLIk2sa7HOQ4VM2oS6qQOBmcv7Aq1yxcrYFvkd1QyHme8EqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVldWSgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF4C113CC;
	Sat, 18 May 2024 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716068224;
	bh=i4wo/8Z7T3kmv6I4NXf5lzXYWB0n3G483Xogj9SqaVA=;
	h=From:To:Cc:Subject:Date:From;
	b=CVldWSgxGr4g0z5XNEwCL7QcDO+hMOyI9mKV8shYMrMibPSuVxPouloxnVAPcAS9c
	 w1i8kxWBGddPf3nOPEBG1CWxgtkM9RCmMzAZ3cjSXdCqnMeBF625xlDnVVwnrdLNvu
	 1elTcuFneynPRM3F8ULcTZTNBTVGnvMhe2xlQ0modf0YAWd6YGNlBF6zj7zsp/kg+z
	 uHldcs5KdgayiSJRRyxndDAIEoBBZrRXUYdhhbcxB5gxQ0RU6xrUum6MAmwYqtm3vc
	 psUSwtMIl8JE96e1Jj3hrN00/jOH3eqr41Hy0NXe48SbZ9e/8yxmOV4uoLvUbqRB3N
	 pPjGDP4md+qwg==
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
Subject: [PATCH RFC 0/5] Asymmetric TPM2 key type
Date: Sun, 19 May 2024 00:36:20 +0300
Message-ID: <20240518213700.5960-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

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

This is derived work from James Prestwood’s earlier work from 2020:
https://lore.kernel.org/all/20200518172704.29608-1-prestwoj@gmail.com/

James Prestwood (1):
  keys: asymmetric: ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE

Jarkko Sakkinen (4):
  crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
  tpm: export tpm2_load_context()
  KEYS: trusted: Do not use WARN when encode fails
  KEYS: trusted: Migrate tpm2_key_{encode,decode}() to TPM driver

 crypto/asymmetric_keys/Kconfig                |  12 +
 crypto/asymmetric_keys/Makefile               |   1 +
 crypto/asymmetric_keys/tpm2_key_rsa.c         | 648 ++++++++++++++++++
 crypto/rsa-pkcs1pad.c                         |  16 +-
 drivers/char/tpm/Kconfig                      |   5 +
 drivers/char/tpm/Makefile                     |   5 +
 drivers/char/tpm/tpm.h                        |   2 -
 drivers/char/tpm/tpm2-cmd.c                   |  77 +++
 drivers/char/tpm/tpm2-space.c                 |  61 --
 drivers/char/tpm/tpm2_key.c                   | 192 ++++++
 .../char/tpm}/tpm2key.asn1                    |   0
 include/crypto/rsa-pkcs1pad.h                 |  20 +
 include/crypto/tpm2_key.h                     |  36 +
 include/linux/tpm.h                           |   3 +
 security/keys/trusted-keys/Makefile           |   2 -
 security/keys/trusted-keys/trusted_tpm2.c     | 183 +----
 16 files changed, 1027 insertions(+), 236 deletions(-)
 create mode 100644 crypto/asymmetric_keys/tpm2_key_rsa.c
 create mode 100644 drivers/char/tpm/tpm2_key.c
 rename {security/keys/trusted-keys => drivers/char/tpm}/tpm2key.asn1 (100%)
 create mode 100644 include/crypto/rsa-pkcs1pad.h
 create mode 100644 include/crypto/tpm2_key.h

-- 
2.45.1


