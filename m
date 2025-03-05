Return-Path: <linux-integrity+bounces-5087-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5920A4F217
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 01:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F351016E727
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 00:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840A11185;
	Wed,  5 Mar 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsBfEBZa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D01078F;
	Wed,  5 Mar 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133171; cv=none; b=kycKkJ9Lc8is/i/1DAGf+up10Te1jbgd32/GiHv7YZCPqpzhTJ9YLHEFLYo/Myg2qjee68sixAyJnY+KeIy8fuBussRdKYLKjNqegQDozok8rHBQjTcQtMVYlhOFImhVByglygq88xs02a5fxK8mRnvohQp5j92vkvNz+uhjRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133171; c=relaxed/simple;
	bh=4d0t/Os2/GGQ6qNG/OGV8T4IdUwA2m6Stm5czZf5DrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aanS/xVNUxEV4TAgyWd/PNFL3h9dTAB0QYy3fymjeo0nnyECZdxiSi8xI0rkc51ctLUkLLl5TgIzHTe/tx+sCmqoNwLItRO/1q5KD5XionqaVM4CPb7AiUeA0XT4fm26vyt20RzLjfI8IFVIkANNyChOTslJa4butjS9Pc3UzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsBfEBZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AA5C4CEE5;
	Wed,  5 Mar 2025 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741133171;
	bh=4d0t/Os2/GGQ6qNG/OGV8T4IdUwA2m6Stm5czZf5DrI=;
	h=From:To:Cc:Subject:Date:From;
	b=GsBfEBZaVxGKwilAHG/ScWxdCIBsmwK+XJmLfPUQYAgZNfCubB5pFME5Zfqoc4Bo8
	 3fSXhWZLKm0Y7o8eYVO1JEPxeigdAPGzeW0xB9btJQZsjW54JsAnwpBsWxAAS5uSTM
	 qobkLvRs0UodevrZiMOE7NGtG8Axqc/DrFNAgaLIyzQdv9nhMnmdor5bBh4hrgOP5L
	 vte5FDi2uYnk7iIMbMV6PTHrltF7uoyC6HDApKDSpFK44jPyuxSp/SioVa9dpU85nH
	 F1UmI0H9V3eGl8LjkunhbS1EWIlGyf99QxGSg3dYJDURv3hsHk0i0XS0qzXYdAOb+M
	 cK60uxx6JIieA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arch/x86: Fix size overflows in sgx_encl_create()
Date: Wed,  5 Mar 2025 02:06:02 +0200
Message-ID: <20250305000602.127665-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The total size calculated for EPC can overflow u64 given the added up page
for SECS.  Further, the total size calculated for shmem can overflow even
when the EPC size stays within limits of u64, given that it adds the extra
space for 128 byte PCMD structures (one for each page).

Address this by pre-evaluating the micro-architectural requirement of
SGX: the address space size must be power of two. This is eventually
checked up by ECREATE but the pre-check has the additional benefit of
making sure that there is some space for additional data.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-sgx/c87e01a0-e7dd-4749-a348-0980d3444f04@stanley.mountain/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2: Simply check the micro-architetural requirement in order to address
    Dave's comment:
    https://lore.kernel.org/linux-sgx/45e68dea-af6a-4b2a-8249-420f14de3424@intel.com/
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab214bdf5..fedd5f666b5e 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -64,6 +64,14 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
+	/*
+	 * This is a micro-architectural requirement. ECREATE would detect this
+	 * too without mentionable overhead but this check guarantees also that
+	 * the space calculations for EPC and shmem allocations never overflow.
+	 */
+	if (!is_power_of_2(secs->size))
+		return -EINVAL;
+
 	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
-- 
2.48.1


