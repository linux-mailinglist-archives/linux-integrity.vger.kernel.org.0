Return-Path: <linux-integrity+bounces-1978-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9288896625
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Apr 2024 09:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E9B1F21DAA
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Apr 2024 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9350B4D133;
	Wed,  3 Apr 2024 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="gnzXb7bf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F6C5B683
	for <linux-integrity@vger.kernel.org>; Wed,  3 Apr 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128907; cv=none; b=G7XXHhh988JaiwBROSBViJKF+0hDxuP2bTlgVeL0cdCJhWL8DbvX6teiPdWJPvuwhweoFU0Ku3K/DIyBo1k8OyT7kllb1MZzHZ6FW0PF+UbBMnr0h5J2ms8OaSK0R/v0I2R+GqY4wtSU3aXBSK+F7h+CGKX+aODdSjnF7bgE/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128907; c=relaxed/simple;
	bh=bRYywF4wQq0rFQo//c05z8eFKnTGTyCsCUjV2hS/RGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvG4PXOCWwZGsNgxWxwZgCAHmHJXa5PDWFUnlIaKEIWboS9zM/vE9VTFSUC9of3Lec3LanzVJzlEc1vnRfVfYw83HW8h9Xu5PSLpqMxgRW/wRZzF7tBvMOdut0YCi5XKorYu4H1sOynEEn6FdJo7sD1dFnhiopl7ixZZOLWXRoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=gnzXb7bf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-416244fd0a2so1250945e9.3
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2024 00:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1712128903; x=1712733703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLnAdyE+lMa8L2TlOW7Lr0VmL77gsDlT8pRhecvobmg=;
        b=gnzXb7bfcozfwKxTR3/Zpfz8W1YSsUkkrRElgo4StRZfe20jT+VBwQVKuJpNcFc5Co
         6RbC3CC98I8a0x//t9TpHunevVufZO1PmojCt8ryNBjNsFC9LXdEbJ2gwVVoZgR78/7x
         4W9Z+FmAcG+D3jmK3TDwCqjKXDQDI6ueZBXEfZca05vWcJqEUp43KUX0FM9DLLjSraGf
         fHyGB9XKGK20bmikS3CvqXfBo2PcujtZNUH5Z6IHqgPKTEow1I6Da2rB7mJBYOFdLzr2
         IcWTdAuKlhmVRGiQIMQxdQb3qFY55ri59A9jpLGD5jlnkK/oxelr6wco/n9qXdUJ8IT9
         7adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128904; x=1712733704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLnAdyE+lMa8L2TlOW7Lr0VmL77gsDlT8pRhecvobmg=;
        b=tIOMARInFX50jU6Pesz+x1Zg/LomTKiZfGmIP6xVXpOQWRkUdkXhBrh53bO1l3OCcy
         jj1HZwdaN871knd3hQF5dtqbCsqGbbBfAnMZM57y2z3LmCx5dUCTN6+J34GbSYKRiyVm
         Ie0UndUf1rIQPo7CT8m+CpGXbnon9CiQiBhTM+EbOmas3EUlAQY+YUCuWT+WJtaRMaYY
         FrOjfb6ElWkqOaxRrNqqsbM21CnhzX8nW35UFfk5fKS6+vFdtAn0nty0opKT9+QedzJy
         yQH5ZtETvIeHUNy/+QsxUnQQCPnuj5b/jFrcz7u26KidLi9+59Gyu5wDuop2t6fG1UEm
         aWxg==
X-Forwarded-Encrypted: i=1; AJvYcCU91OzsAKUD12/ftI+ymQhGAQnaeqFv/x/lVGSU5s/2ubnX8iqeim0Su9W6hkjRlzSge+uVGBHDdIe31eS23spmP7LG4Nkh3JpZvPgx5BoD
X-Gm-Message-State: AOJu0Yxw/oCBm57G3bNfB6gASgQfvi2mKtl70V4DfNGzKVdQYbqUG/KV
	D1H1ACP1u60rECZ5kpyztF429KML8X9lsxnJlt1BJXyAmbMB0XGoXN/iM7D+ytU=
X-Google-Smtp-Source: AGHT+IGBKQFCUXIuGuB/3ITVSTmpwBRNnzhoeJUE1hf5xtsCdWq2cIwS9vpwQ4hO/jWGP/x1CquarA==
X-Received: by 2002:a05:600c:3c99:b0:414:8e3:d8e0 with SMTP id bg25-20020a05600c3c9900b0041408e3d8e0mr11942948wmb.17.1712128903715;
        Wed, 03 Apr 2024 00:21:43 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id v13-20020a5d4b0d000000b0034356c434d0sm1436269wrq.117.2024.04.03.00.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:21:43 -0700 (PDT)
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
Subject: [PATCH v8 2/6] KEYS: trusted: improve scalability of trust source config
Date: Wed,  3 Apr 2024 09:21:18 +0200
Message-ID: <20240403072131.54935-3-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403072131.54935-1-david@sigma-star.at>
References: <20240403072131.54935-1-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling trusted keys requires at least one trust source implementation
(currently TPM, TEE or CAAM) to be enabled. Currently, this is
done by checking each trust source's config option individually.
This does not scale when more trust sources like the one for DCP
are added, because the condition will get long and hard to read.

Add config HAVE_TRUSTED_KEYS which is set to true by each trust source
once its enabled and adapt the check for having at least one active trust
source to use this option. Whenever a new trust source is added, it now
needs to select HAVE_TRUSTED_KEYS.

Signed-off-by: David Gstir <david@sigma-star.at>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # for TRUSTED_KEYS_TPM
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/Kconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
index dbfdd8536468..553dc117f385 100644
--- a/security/keys/trusted-keys/Kconfig
+++ b/security/keys/trusted-keys/Kconfig
@@ -1,3 +1,6 @@
+config HAVE_TRUSTED_KEYS
+	bool
+
 config TRUSTED_KEYS_TPM
 	bool "TPM-based trusted keys"
 	depends on TCG_TPM >= TRUSTED_KEYS
@@ -9,6 +12,7 @@ config TRUSTED_KEYS_TPM
 	select ASN1_ENCODER
 	select OID_REGISTRY
 	select ASN1
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Platform Module (TPM) as trusted key
 	  backend. Trusted keys are random number symmetric keys,
@@ -20,6 +24,7 @@ config TRUSTED_KEYS_TEE
 	bool "TEE-based trusted keys"
 	depends on TEE >= TRUSTED_KEYS
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of the Trusted Execution Environment (TEE) as trusted
 	  key backend.
@@ -29,10 +34,11 @@ config TRUSTED_KEYS_CAAM
 	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
 	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
 	default y
+	select HAVE_TRUSTED_KEYS
 	help
 	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
 	  (CAAM) as trusted key backend.
 
-if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
-comment "No trust source selected!"
+if !HAVE_TRUSTED_KEYS
+	comment "No trust source selected!"
 endif
-- 
2.35.3


