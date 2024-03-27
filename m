Return-Path: <linux-integrity+bounces-1870-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B9888D8D6
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Mar 2024 09:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3AF1C268DF
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Mar 2024 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174852DF92;
	Wed, 27 Mar 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="gZiImaV+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1E2D7B8
	for <linux-integrity@vger.kernel.org>; Wed, 27 Mar 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527910; cv=none; b=aQ1nr0W5zsuWhqMFoBnwDFzWMppVtICDS++9KaFEREezPR9B92V71e4Qg4hNP1UbIWFGLj4fLlIwZ4WwkPxm5PSoj/eLJcSh3Q+w6j/bbeKLQHTSEtvPTi7xJC9mjfxQEu8ALESFfGQzn/qiEv13nwZ2vPHTGzIHqbJQcy0vbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527910; c=relaxed/simple;
	bh=Ze8zK2HY9+0PRvVXT50gi5jYVTJlg7k/wpO4RIzfls4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Is6ZYzAO1RxvyAO7AiTGEPYevz+Ot9uJhdMv7l/MS4vrn2GwxzD9KIFvm88ZnjI3OO92rBuVnTxPcP8dixiQDl9vdSQA4XujcUSG7wIYYAaZAWzuJVr5t4ogR/pR6zoXADkqhqBPGh5kBrDtSFrsfHlydE66vm0SFbhlVF8F52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=gZiImaV+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513edc88d3cso7184856e87.0
        for <linux-integrity@vger.kernel.org>; Wed, 27 Mar 2024 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1711527904; x=1712132704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXnPhQZ/7MwqBVH7e72M3iqDK5PHqiK3NcW8fk9T+qY=;
        b=gZiImaV+WStIGoHn7lC47kIhZg4G3h+FDJrdHrnaQjDzOWa4Fd+HQAQSiWjfA7aNi/
         teQOtXTFUeTcCQEGDDr0Q6PCZGG+18Szom39b0TfzdEIt5lwFmoweaRENqDpG2nTM81v
         XaKZMTl+w4VNa99Cpgbokm9OFRpgUA1FhpL5rugcOMwDTLSmwl0X8kFy+aQ1uOtfat/3
         3cEuDqdIVpVUvCS2alftIm4wERpMh3JuKVZwt37buiqa7SvFuQ5yHHUHkMk2OfJwjE/S
         x9nuy1l370P8A2uUj6NpBBXXcQj5ydR9yiL2HwXwuHV9P2L6w042mot2x9DHk3oiquQI
         dmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527904; x=1712132704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXnPhQZ/7MwqBVH7e72M3iqDK5PHqiK3NcW8fk9T+qY=;
        b=GVfqz5DAhk+HLG99PclVkhE5X0vP7r96I7v31myE9vZtpP+46cWFdVx/hTqTg4Bf9a
         L3ole2MVKJHCKvx0QC/ZhHD6tlRoDs0LntNwdPwnrtiK0DLBixRl/NFdB09KPJ2k+vvk
         dcioOrJkcmHhOfC+g9ZVIgLG84syaAku+uG7qNk7r4OkAY/5k/0tsr9ZqPh9ly1AJM6+
         V6kelv1I3nai9Sf2hyuuqxfX/APzozQwI+8yz8g9/7hD6CInn59odXH9mmmayRmem+SS
         Tl6Ra2x/ExTSUAogMj5EgXBQQ7eTpJe8zbIAiyfmLZgUZhqAQG+NwlZLcNNteiCagjQD
         ufsw==
X-Forwarded-Encrypted: i=1; AJvYcCWv8EFZrqtL8pmE3hckizQzyx+uXfaRNZLQv67dZLzFAbr9jxDTHgdqSz9wd0QkG5JJRkeNgzrBI1/ddpa468LWyLyYZ4YB4tC4fZidizmj
X-Gm-Message-State: AOJu0Yzda+Dv5bX3asOwUjBwlwI0SIj6tJ3Si4dKCygTbsamJolh/hpt
	PsEULG3JIGKohcw2TUAGtNL9JPsiwAK/7AUCOeXwHClYZ7BPTFBjkTu9Cl36hnE=
X-Google-Smtp-Source: AGHT+IEWDMVFB/sih4uk6d/ut3w2v5mnLyG+wQLmIUZcFC2ZLVZVl9kZujBi8i5UNu5rg7+ev/+CLw==
X-Received: by 2002:a2e:a984:0:b0:2d4:170d:245f with SMTP id x4-20020a2ea984000000b002d4170d245fmr2716878ljq.12.1711527904204;
        Wed, 27 Mar 2024 01:25:04 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id ch9-20020a5d5d09000000b00341c6778171sm9880373wrb.83.2024.03.27.01.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:25:04 -0700 (PDT)
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
Subject: [PATCH v7 0/6] DCP as trusted keys backend
Date: Wed, 27 Mar 2024 09:24:46 +0100
Message-ID: <20240327082454.13729-1-david@sigma-star.at>
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

After having been thoroughly reviewed by Jarkko, it would be great if this
could go into 6.10. :-)

v6 is here (please ignore the incorrect version number in the cover letter):
https://lore.kernel.org/keyrings/20240307153842.80033-1-david@sigma-star.at/

v6 -> v7:
- Add Reviewed-by from Jarkko Sakkinen for patches #1 and #3
- Improved commit messages
- Changed log level for non-trusted/secure mode check from error to warning
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
 security/keys/trusted-keys/trusted_dcp.c      | 313 ++++++++++++++++++
 10 files changed, 567 insertions(+), 14 deletions(-)
 create mode 100644 include/keys/trusted_dcp.h
 create mode 100644 include/soc/fsl/dcp.h
 create mode 100644 security/keys/trusted-keys/trusted_dcp.c

-- 
2.35.3


