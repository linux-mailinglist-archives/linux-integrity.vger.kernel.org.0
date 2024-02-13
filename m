Return-Path: <linux-integrity+bounces-1167-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E48536FE
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D8B267F6
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF645FBA2;
	Tue, 13 Feb 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="POJ+xJ0A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02996BA57;
	Tue, 13 Feb 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844558; cv=none; b=qo8TJ+r8vYRD1cxT2Eo+V+4L6TxIm1egLw1t2hMOXcbdhU8xTdQRbgYuFNFr6WaHSOgQgwav9JxjtOEMvkhsElDQyVUa+o+1HYNw/hQj7yFoh7GdEP/PnQY0DwAMOnh17EXTpJFNfTEQS2j5RUjMSe3HVZs2QwSbhpXtINBN6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844558; c=relaxed/simple;
	bh=I6Gvq5Hf1pNtrzsESMyjfVDjeg4UkqOIhC0QdXTOBag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7cdKxN8/iEoomMJ4iC+nCNrj374bCX4wIyY61H1cXEqo+z+pTmb9wgbr3N7uoPdiAxHAZrTJsGlE6zi68SVV0ZOODidhk8QrMEujSVr8KeSN244vBMR+EgDEK8viw0btPIRQKEe48Ydm+zDAKffcy66X9PZyDQ0HzSb29lHqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=POJ+xJ0A; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707844555;
	bh=I6Gvq5Hf1pNtrzsESMyjfVDjeg4UkqOIhC0QdXTOBag=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=POJ+xJ0A+VopdlHk5F/tnzHbWY2ESIHaYAFEMJcgGybKy/lQIFFOUxxUhXAS9USVP
	 u8LX30dv/1vkMIeoPJnZTvlbv/LSFsfsrLiM6PrKYpC3uuz513O4/WFHU1Sb4ES5vB
	 NT9qVFgS8eslknaxDvbchIquoSITomxBX7CbE/dI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9FF851280C16;
	Tue, 13 Feb 2024 12:15:55 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id tC4wluQippcX; Tue, 13 Feb 2024 12:15:55 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 72FFF1280BAC;
	Tue, 13 Feb 2024 12:15:54 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 04/21] tpm: Update struct tpm_buf documentation comments
Date: Tue, 13 Feb 2024 12:13:17 -0500
Message-Id: <20240213171334.30479-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

Remove deprecated portions and document enum values.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/tpm.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index bb0e8718a432..0a8c1351adc2 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -297,15 +297,14 @@ struct tpm_header {
 	};
 } __packed;
 
-/* A string buffer type for constructing TPM commands. This is based on the
- * ideas of string buffer code in security/keys/trusted.h but is heap based
- * in order to keep the stack usage minimal.
- */
-
 enum tpm_buf_flags {
+	/* the capacity exceeded: */
 	TPM_BUF_OVERFLOW	= BIT(0),
 };
 
+/*
+ * A string buffer type for constructing TPM commands.
+ */
 struct tpm_buf {
 	unsigned int flags;
 	u8 *data;
-- 
2.35.3


