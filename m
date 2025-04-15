Return-Path: <linux-integrity+bounces-5880-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC8A895C9
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 09:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A520C3B0117
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143D27B50A;
	Tue, 15 Apr 2025 07:57:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9227A909;
	Tue, 15 Apr 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703842; cv=none; b=P1Uedr3D03G1PxMzmZxhGC++TMghnpnBXYfBxFRJ5JdsjIGJd7WfBuxB9XV/VGarA/7b6FIQC5IrezF+Vz2+ju27FRbLK4vzuJSvSTE+BPWnEhj0h3nBtxmaRIz7S6TVlVLjVJdKk0vxikKBmUu15vpBggOr5HZVhQ0rXtEtgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703842; c=relaxed/simple;
	bh=risjSvGT9DMUyvH+iJ7dySPW1C4aKdWt1fsz46h8Y4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWS+HOu03tTPpeyLDrvHzOpwSL1Fv6vaOR1M7/wpFfrGOi7gO56iacKNmWXMqsQ0YFb49kGjcumnNn39bz7TThuMnFKLu18Wb7PU/A9dPBRBI+0iHUOdAFIcP212p8pEkqor+5Pi4YdChLzbjU0szfMx7nkcetgw+hznDzoJGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E838315A1;
	Tue, 15 Apr 2025 00:57:18 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 35A753F694;
	Tue, 15 Apr 2025 00:57:19 -0700 (PDT)
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
Subject: [PATCH v4 2/2] tpm_crb_ffa: use dev_xx() macro to print log
Date: Tue, 15 Apr 2025 08:57:12 +0100
Message-Id: <20250415075712.2157073-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415075712.2157073-1-yeoreum.yun@arm.com>
References: <20250415075712.2157073-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instread of pr_xxx() macro, use dev_xxx() to print log.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index fed775cf53ab..0bb8098e93ae 100644
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
+		dev_err(&ffa_dev->dev, "failed to get crb interface version. rc:%d", rc);
 		goto out;
 	}
 
-	pr_info("ABI version %u.%u", tpm_crb_ffa->major_version,
+	dev_info(&ffa_dev->dev, "ABI version %u.%u", tpm_crb_ffa->major_version,
 		tpm_crb_ffa->minor_version);
 
 	if (tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR ||
 	    (tpm_crb_ffa->minor_version > 0 &&
 	    tpm_crb_ffa->minor_version < CRB_FFA_VERSION_MINOR)) {
-		pr_err("Incompatible ABI version");
+		dev_warn(&ffa_dev->dev, "Incompatible ABI version");
 		goto out;
 	}
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


