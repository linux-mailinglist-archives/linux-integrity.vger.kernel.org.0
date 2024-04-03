Return-Path: <linux-integrity+bounces-1981-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648189663B
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Apr 2024 09:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713061F24E74
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Apr 2024 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184D26E617;
	Wed,  3 Apr 2024 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="GVqAzUrB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5646CDBA
	for <linux-integrity@vger.kernel.org>; Wed,  3 Apr 2024 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128913; cv=none; b=efd1mXPMK5BbSW/hBmRKONozGa9vvEEGOeO6XNN8V8w/+lV9VC3NP9EPI0+nbP8/Tw5gW5JWL5Q3mQAvC2EQw2tJ2edKY7mlVGZPuJ9vJpyyvv/c/ubwfk5fPKNKHCIUsbQZCX1zJ0YBBwZm0TwKjjBmKL3zw5dYNCExvzgGnJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128913; c=relaxed/simple;
	bh=lNpjeX0JcmXc23xhLQ2BRd2UsmvECEYW4zkRlizImfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciTbsBKOsw6YVetrvha7a2NFlV9Fa11Xi022BW4pbch0T4P37/KrXBx6YIyiu8r427yoe6GQrq7pLWeh+cyaKmUl8a1rQhBpnZde+SwJBYBVZughTdFZSgcnTdLBYGGjhs3WnxwyphgqTkitjCSDSes3DU8vrrq31a8bnCuhcVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=GVqAzUrB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so3179515e9.1
        for <linux-integrity@vger.kernel.org>; Wed, 03 Apr 2024 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1712128910; x=1712733710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXAm+jrLSudJosqOThMSAUphAoCkUssK7J5hWO/tUg8=;
        b=GVqAzUrBo+gk4Ad4qMSVl6TGBW1i9XLuuwDTT9QNVaplsDCRyiF5+jxqcyzq2HP33n
         q3oTnk3T0MdH07wr4kx4JSFDJ81x78Pl64bERb3Z2Pf2gbaYAMCsTh/nam4Dnm/X1D12
         xwYdw5wGNnLi/YopRc5JJw72baCywAu4iuAlY5wZOFEaO600i62hRm8R0Z/6wkUJdO3b
         3Fc/xvsLrAVPH2clNlBuJaPS76NAwuGA05EXC7E5Kz7yGKgrDmmW6FaZQJUvbmje2hiD
         j1e6HeU4aWSE0XQgnmI3q+uIwaVWgSMOP+FeRRRUjf8AHo+ScXJJwk7o5py3xcAOc9qc
         kEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712128910; x=1712733710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXAm+jrLSudJosqOThMSAUphAoCkUssK7J5hWO/tUg8=;
        b=WvE6JnwnfyGgOEyn2lV0mQs4muzdKSihp16dRuQNzECTskm7kt3PQfxBD0+cZYiwkp
         yawmFRpdbBGw8E8SuF1mY0ipMKJgoiLNfpIgJiJk6yS/s5Zd7ePZMeLGACkAZmw+Af7H
         XIqydg+FTqNwe5g5M7iPU0oeK1usVMqLcpB3PdFKaq0qnvKQNoL+FxmOzL11HTkGwEnN
         l+R22QwAZ/iBh3pWsVrvRyI4GQ1kWUao5sjbpc3++qOhOLYjTXKkQj7gc8YQ3mmR0q9Q
         ljUAck3LoJPcGNyrBivUOVyJ0wG1kUuOY+8j0J6agENSntYu5o7VVJRA6cbnae0SKLB0
         HN/g==
X-Forwarded-Encrypted: i=1; AJvYcCWqxb5n0jWKP1xqS0TE2sutjY0NvDb6UBhwH2eFPsFZ0oJG5UlIbl2g9tKSBjtZiulkuu6IISnz8jQC9Adyz2gGeURGQVLGz48Qfj6Es6l4
X-Gm-Message-State: AOJu0YyU2RBxbzAxdYzjKNcdXDUO0vkG5dYfqFTVDlLg7cVbZJi8ShMh
	n2J5EZgFjsOom5LwTQJ2Ao5p1kmY2dcf5wbjfPUqT5AxbzzZ5eB9TvEXP+HByhI=
X-Google-Smtp-Source: AGHT+IHMXJyB4E69/ab6cpDC6ve2WzDG37buI/9MLXEGacy21VN01NO4piAk3DTCP7MyWInRIdzfrA==
X-Received: by 2002:a05:600c:1c14:b0:416:24a1:4313 with SMTP id j20-20020a05600c1c1400b0041624a14313mr358429wms.19.1712128910048;
        Wed, 03 Apr 2024 00:21:50 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id m6-20020a05600c4f4600b004147db8a91asm23762409wmq.40.2024.04.03.00.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:21:49 -0700 (PDT)
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
	linux-security-module@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH v8 5/6] docs: document DCP-backed trusted keys kernel params
Date: Wed,  3 Apr 2024 09:21:21 +0200
Message-ID: <20240403072131.54935-6-david@sigma-star.at>
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

Document the kernel parameters trusted.dcp_use_otp_key
and trusted.dcp_skip_zk_test for DCP-backed trusted keys.

Co-developed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Signed-off-by: David Gstir <david@sigma-star.at>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 24c02c704049..3a59abf06039 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6698,6 +6698,7 @@
 			- "tpm"
 			- "tee"
 			- "caam"
+			- "dcp"
 			If not specified then it defaults to iterating through
 			the trust source list starting with TPM and assigns the
 			first trust source as a backend which is initialized
@@ -6713,6 +6714,18 @@
 			If not specified, "default" is used. In this case,
 			the RNG's choice is left to each individual trust source.
 
+	trusted.dcp_use_otp_key
+			This is intended to be used in combination with
+			trusted.source=dcp and will select the DCP OTP key
+			instead of the DCP UNIQUE key blob encryption.
+
+	trusted.dcp_skip_zk_test
+			This is intended to be used in combination with
+			trusted.source=dcp and will disable the check if the
+			blob key is all zeros. This is helpful for situations where
+			having this key zero'ed is acceptable. E.g. in testing
+			scenarios.
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
-- 
2.35.3


