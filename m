Return-Path: <linux-integrity+bounces-5886-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D10A8A72F
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 20:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039C57A7185
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7B6235371;
	Tue, 15 Apr 2025 18:50:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C0231A2D;
	Tue, 15 Apr 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743022; cv=none; b=TCUIOXp3NCL/y1j0GEQSEb97a0Vzs5ARWW3Euk7JqTEMBDTJYn32knyTxWyuybfvyrPAfH0C+itRHDbWetOh4dHBxVBtYGAjlJWNocNgWx8+iKC/BpUwqxBiCyIFoCUsGTbxDsk3Hrz7u84ZuU44bm2poCn/h7J/S/PMuAe1Na4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743022; c=relaxed/simple;
	bh=uTOhgAUryUxLf1wttQLUU0f6JKe/3n+pMo334suYrxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQUfHOanUpiC8WHknBRg+iPno+6qEDKSodngrPkrnQDglZqRYXuMeufDlPKibQxevlZq6JFnBnaezBI2f2QGM7//XmE7bw4Vh8+3m4jl3XGbSdZ2XYQyhizSNJ4ApLHNhuc4hUYVOmLUtHc93gKKy5uSb9iqrXJRNxb7jVlvYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 187FD1D15;
	Tue, 15 Apr 2025 11:50:18 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B12E3F694;
	Tue, 15 Apr 2025 11:50:18 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	sudeep.holla@arm.com,
	stuart.yoder@arm.com,
	sgarzare@redhat.com
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v5 2/2] tpm_crb_ffa: use dev_xx() macro to print log
Date: Tue, 15 Apr 2025 19:50:13 +0100
Message-Id: <20250415185013.2387369-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415185013.2387369-1-yeoreum.yun@arm.com>
References: <20250415185013.2387369-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of pr_xxx() macro, use dev_xxx() to print log.
This patch changes some error log level to warn log level when
the tpm_crb_ffa secure partition doesn't support properly but
system can run without it.
(i.e) unsupport of direct message ABI or unsupported ABI version

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index fed775cf53ab..66b38b2cbdd5 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -303,7 +303,7 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
 
 	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
 	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {
-		pr_err("TPM partition doesn't support direct message receive.\n");
+		dev_warn(&ffa_dev->dev, "partition doesn't support direct message receive.\n");
 		return -EINVAL;
 	}
 
@@ -324,17 +324,17 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
 	rc = tpm_crb_ffa_get_interface_version(&tpm_crb_ffa->major_version,
 					       &tpm_crb_ffa->minor_version);
 	if (rc) {
-		pr_err("failed to get crb interface version. rc:%d", rc);
+		dev_err(&ffa_dev->dev, "failed to get crb interface version. rc:%d\n", rc);
 		goto out;
 	}
 
-	pr_info("ABI version %u.%u", tpm_crb_ffa->major_version,
+	dev_info(&ffa_dev->dev, "ABI version %u.%u\n", tpm_crb_ffa->major_version,
 		tpm_crb_ffa->minor_version);
 
 	if (tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR ||
 	    (tpm_crb_ffa->minor_version > 0 &&
 	    tpm_crb_ffa->minor_version < CRB_FFA_VERSION_MINOR)) {
-		pr_err("Incompatible ABI version");
+		dev_warn(&ffa_dev->dev, "Incompatible ABI version\n");
 		goto out;
 	}
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


