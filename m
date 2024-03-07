Return-Path: <linux-integrity+bounces-1636-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0752B875355
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 16:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD37B2389D
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3911512F595;
	Thu,  7 Mar 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="C5ezOgzI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BCE12F36F
	for <linux-integrity@vger.kernel.org>; Thu,  7 Mar 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825937; cv=none; b=N7HMeLReMaL+Dd3GMBhfHT8+7AvXcb+O7P83/eMjI85DEAAe5fVdd0YicA4y7IqZboHjOAFDEe66kByaEC5l/Yip5jfpgH2mLVSHsvS130iEWVs5jOxx6ioGbw/YGLgL/0VWwFe/R6nHXRPnxDv4Yw5ZbeGJTPPAwCH4k31zbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825937; c=relaxed/simple;
	bh=B+JmF0tJIPj3wbY1chvm0GN/4OtyptRfp48hjdeKYqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ReczhR5kAuPQV0y5TLBAaoyOWeRJdp5Fe86+8jpm0GufI0R1yptVk0A/4Q4de+CuBBkW2BqHURvDXbKVo4gZlwx0rqPaswDpoYYsLMzItvLgUF8L2/TydApA933D282A4SPpqBqZX3g5cqzXOWtQJ5e+HVsKVS8wOox8hui67sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=C5ezOgzI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso1105628a12.2
        for <linux-integrity@vger.kernel.org>; Thu, 07 Mar 2024 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1709825932; x=1710430732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/sb7JCKnQxY6+bofS2F9a3HSfL3HCYhaNmIrccEydSM=;
        b=C5ezOgzIi6rea2A+1g/wIpDEIUn/QGgeB6eqLfZphCm0P/xF2Tsx7asKp4PAX1Qki/
         ITWJtLlroqffuaFbBUTEJdjK43SKk3YCTlHZwSXFNgHiz7scN036VzBWdNFqiw0P97bq
         4EPKWI8XqfybWpzklfU42L09JspuzgBE53iJceEeRT8TZ318jKeE4XfsOaPtLZvDSOm6
         bpA7h9MNqquh31ZFe3mwqgl3cQkTuXg2AVpMiyqQzgKh0eaCUTIA1iKuhin0LsH+8oLD
         xWXqI6Yu/vzuM0Baxfd7SeTMiiNJuUcMIVd1KKOE0rjSJJNnUetTl+cRUrFiTC6Hp8sR
         Nevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825932; x=1710430732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sb7JCKnQxY6+bofS2F9a3HSfL3HCYhaNmIrccEydSM=;
        b=G9z95wBWtD4clqqax2Badq3tDse4U24xAUpyBeL/bgA8ObedzOPybX1vJyrf/6z6ON
         XOUaF9Skd7nh7Kq8owMcIrpcuXBV/uHioS2LMZI8QpcyiwksIa3cUDM38fEbV9+riYSa
         Amo0bCnnlbWMzypiIaX+MI8XKsN9qOjat3d288AWKYl13GTwypw9NgHnPO7oVHZvK6QW
         5WKCrdlzGrlIt9nJXnnJ4Npb5cedrTem8OBMaeaKeez0nfkMrUpJnedudhuUHO6bETl7
         0UeEEr8PO4zHMr4aE3Db8q4DdSLzPjv2a0VDG7J/jHy5/qImWnAZQkF2mHQmrUA2epFY
         XhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4iwciilufNjBI5SSjbABt6yOLDZfmH9bgRj1o7q4Gf79Nue0JTjUSVAwq/e1GtQ/DUUaX2n3VlrcIfuWaQ9l0gSRo2HcKchW7rClt0aJz
X-Gm-Message-State: AOJu0YxpIf+t2aYzJNQGR5UO/pN3IZGfZ2zgDuL/B0vEYp2zC9mA1xHF
	aaPh7cGRY7hvW36TiV4sVRzPfa++7VtD0KPSwjYonbxTDoI4H1QlSDxTP/AHv/s=
X-Google-Smtp-Source: AGHT+IHwLiJ8Xqii7MLU+WSk259AiKVc44sCiLKwKtvfdz5jSQ7LlzaPXARtN1leZWRnGjhhAivcbg==
X-Received: by 2002:a50:cc4b:0:b0:568:231e:31dd with SMTP id n11-20020a50cc4b000000b00568231e31ddmr104652edi.30.1709825932678;
        Thu, 07 Mar 2024 07:38:52 -0800 (PST)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id g2-20020a056402114200b0056735c5e9eesm5178879edw.75.2024.03.07.07.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 07:38:52 -0800 (PST)
From: David Gstir <david@sigma-star.at>
To: Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Gstir <david@sigma-star.at>,
	Shawn Guo <shawnguo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>,
	Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v5 0/6] DCP as trusted keys backend
Date: Thu,  7 Mar 2024 16:38:27 +0100
Message-ID: <20240307153842.80033-1-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a revival of the previous patch set submitted by Richard Weinberger:
https://lore.kernel.org/linux-integrity/20210614201620.30451-1-richard@nod.at/

v5 is here:
https://lore.kernel.org/keyrings/20231215110639.45522-1-david@sigma-star.at/

v5 -> v6:
- Cleaned up coding style and commit messages to make the whole series more
  coherent as suggested by Jarkko Sakkinen
- Added Acked-By from Jarkko Sakkinen to patch #4 - thanks!
- Rebased against next-20240307
v4 -> v5:
- Make Kconfig for trust source check scalable as suggested by Jarkko Sakkinen
- Add Acked-By from Herbert Xu to patch #1 - thanks!
v3 -> v4:
- Split changes on MAINTAINERS and documentation into dedicated patches
- Use more concise wording in commit messages as suggested by Jarkko Sakkinen
v2 -> v3:
- Addressed review comments from Jarkko Sakkinen
v1 -> v2:
- Revive and rebase to latest version
- Include review comments from Ahmad Fatoum

The Data Co-Processor (DCP) is an IP core built into many NXP SoCs such
as i.mx6ull.

Similar to the CAAM engine used in more powerful SoCs, DCP can AES-
encrypt/decrypt user data using a unique, never-disclosed,
device-specific key. Unlike CAAM though, it cannot directly wrap and
unwrap blobs in hardware. As DCP offers only the bare minimum feature
set and a blob mechanism needs aid from software. A blob in this case
is a piece of sensitive data (e.g. a key) that is encrypted and
authenticated using the device-specific key so that unwrapping can only
be done on the hardware where the blob was wrapped.

This patch series adds a DCP based, trusted-key backend and is similar
in spirit to the one by Ahmad Fatoum [0] that does the same for CAAM.
It is of interest for similar use cases as the CAAM patch set, but for
lower end devices, where CAAM is not available.

Because constructing and parsing the blob has to happen in software,
we needed to decide on a blob format and chose the following:

struct dcp_blob_fmt {
	__u8 fmt_version;
	__u8 blob_key[AES_KEYSIZE_128];
	__u8 nonce[AES_KEYSIZE_128];
	__le32 payload_len;
	__u8 payload[];
} __packed;

The `fmt_version` is currently 1.

The encrypted key is stored in the payload area. It is AES-128-GCM
encrypted using `blob_key` and `nonce`, GCM auth tag is attached at
the end of the payload (`payload_len` does not include the size of
the auth tag).

The `blob_key` itself is encrypted in AES-128-ECB mode by DCP using
the OTP or UNIQUE device key. A new `blob_key` and `nonce` are generated
randomly, when sealing/exporting the DCP blob.

This patchset was tested with dm-crypt on an i.MX6ULL board.

[0] https://lore.kernel.org/keyrings/20220513145705.2080323-1-a.fatoum@pengutronix.de/

David Gstir (6):
  crypto: mxs-dcp: Add support for hardware-bound keys
  KEYS: trusted: improve scalability of trust source config
  KEYS: trusted: Introduce NXP DCP-backed trusted keys
  MAINTAINERS: add entry for DCP-based trusted keys
  docs: document DCP-backed trusted keys kernel params
  docs: trusted-encrypted: add DCP as new trust source

 .../admin-guide/kernel-parameters.txt         |  13 +
 .../security/keys/trusted-encrypted.rst       |  85 +++++
 MAINTAINERS                                   |   9 +
 drivers/crypto/mxs-dcp.c                      | 104 +++++-
 include/keys/trusted_dcp.h                    |  11 +
 include/soc/fsl/dcp.h                         |  20 ++
 security/keys/trusted-keys/Kconfig            |  18 +-
 security/keys/trusted-keys/Makefile           |   2 +
 security/keys/trusted-keys/trusted_core.c     |   6 +-
 security/keys/trusted-keys/trusted_dcp.c      | 309 ++++++++++++++++++
 10 files changed, 563 insertions(+), 14 deletions(-)
 create mode 100644 include/keys/trusted_dcp.h
 create mode 100644 include/soc/fsl/dcp.h
 create mode 100644 security/keys/trusted-keys/trusted_dcp.c

-- 
2.35.3


