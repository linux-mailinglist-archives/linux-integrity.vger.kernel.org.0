Return-Path: <linux-integrity+bounces-1875-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4688D8F5
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Mar 2024 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E7129F193
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Mar 2024 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704F94D5A3;
	Wed, 27 Mar 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="TnK2buSA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC2A47F7E
	for <linux-integrity@vger.kernel.org>; Wed, 27 Mar 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527927; cv=none; b=g7FNYr8pBY4KUhNAgMnxqJHs/WAVv3D00EQU6EvKcO0CfLZIvL5fxAtZyRNozV0XlczgHYfacVC7pyInnTV4EThYzXIw+C7i5kJJCepecZDAPP0N8AmGzfVph4MtnXnh8oFAbRMHOa0mZKlXslNBh+n9oNhPrFWKW5LTF6zb5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527927; c=relaxed/simple;
	bh=IoJ5PhDwmkZFYUe1jIRt3XY+XYejXNxDc1GhQecxiN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+AqHLZkQL7rj6uJpuiWkgLraZUG9CKuqNbC0WBAy6S4Rg/ozXaappBP+rgbkzuwPXEZDXi+FVLTLl4qfxqFTS8lOzmlcc+2F4s4rgD2/lerrz/k8GJ/DtT2+R6r2k2nt3bpK4x+Q//RJwSNpfQBqzgZDtIcgbS0uGMYPe/GCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=TnK2buSA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-341ccef5058so2137784f8f.2
        for <linux-integrity@vger.kernel.org>; Wed, 27 Mar 2024 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1711527923; x=1712132723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q95Pv5eUd7/PCCDIkGY46bAHfemcttBtSKECUmP8rbg=;
        b=TnK2buSA7GmjcMGWnwWRo2itc5TOs/LCl5WiWe6EmBSNqD6EzB/LIobeLLA7HKfKwk
         6+ZLAUWDVmLsm/0xIR0mcl0A8IgaUJBXBAxbl0egxArSEjSWJmev1qZj0cD4HhimKm6g
         wDal0f82l4PclBII7nx7vCjvOeAZ0UfC1PBcasxEwYW1o4GFOvbobh9lCJCt9YNmdXE0
         OXRQ4EY8f9UjwnH5zjSLgkOIzzzeNgO99AQ59M+lraKTXwN/osk+cPIqa1iEZHCU9wO7
         81yWG1IY6zX9oRDOW+OxYj+3tEE182VIykr04UQ6qMy42CsNjKD73rjaKMKwXZhKRIEw
         vu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527923; x=1712132723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q95Pv5eUd7/PCCDIkGY46bAHfemcttBtSKECUmP8rbg=;
        b=ailJNN6lq8O9WUI+rXGTIoPg5iNO023FJSKkuRBJ7kTh7niO4aevEd/8VNBFPsSE5x
         L3Xs+g0PHocqfr7u+Nuj0QyUR7kHpDUKnQDj/LcZWoGQ6/ABE4ocWxuY/KZpgCSkDDjb
         O27s1gsamdoMxBqxejJGzaHk1DDhHyrbptYS8pRgUBpHLnBHbFBl17eRWaezWrirJNrW
         ZK+lJa4nDR/TTpXaSZ1kJdagSbL/HIZMz9TiVTxwmsQLWXFbQNW2yUQvUDZj3+Iwnmqm
         5PaydpH8leZNQiquQ+OrhuhGcVlXz63puScbBv43j9xNcFemrPnmJ8mWRnwaPXYG4ZEA
         qqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZkPIKLfJ/LxITkyqNbRFOKPoMHIyeLqnGfZ7PiZ0Jm3dnBFEKB8nSzU2p+kaiBSKt9yaHVgTX1PKrmB7j4qZ1T/8dvVbKo9L1WotGbmp/
X-Gm-Message-State: AOJu0YySvVwhTz8NeK7JExm6/bSyZP/GKi8NxbazvO2ZISHaMa8hxRHw
	nc44X+W37ljhjs+4TD6wKeR0p/jqDxJAjIKTf3yG2TLwIljj4Jcu97DGWDjGY1c=
X-Google-Smtp-Source: AGHT+IErr6t+SUrVfJunEwUJoIKv/4U7lQAfXQ9Bqp61+O4I6oZbasCzHveygFWHw9GNXm9VGKM5sA==
X-Received: by 2002:a05:600c:444c:b0:414:7e91:a992 with SMTP id v12-20020a05600c444c00b004147e91a992mr399734wmn.3.1711527923123;
        Wed, 27 Mar 2024 01:25:23 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id iw18-20020a05600c54d200b004148619f5d0sm1379012wmb.35.2024.03.27.01.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:25:22 -0700 (PDT)
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
Subject: [PATCH v7 5/6] docs: document DCP-backed trusted keys kernel params
Date: Wed, 27 Mar 2024 09:24:51 +0100
Message-ID: <20240327082454.13729-6-david@sigma-star.at>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327082454.13729-1-david@sigma-star.at>
References: <20240327082454.13729-1-david@sigma-star.at>
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
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 24c02c704049..b6944e57768a 100644
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
+			trusted.source=dcp and will disable the check if all
+			the blob key is zero'ed. This is helpful for situations where
+			having this key zero'ed is acceptable. E.g. in testing
+			scenarios.
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
-- 
2.35.3


