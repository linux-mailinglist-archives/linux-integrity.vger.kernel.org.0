Return-Path: <linux-integrity+bounces-6557-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D583AEA5A4
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 20:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE304E278E
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A0C2EF646;
	Thu, 26 Jun 2025 18:45:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC62EF299;
	Thu, 26 Jun 2025 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963538; cv=none; b=IkUeAecC39Bkwh2KpBVWI4b255gzO5gbK5VVj7kndg6Dc5iPzQF9vpArpMOoFrI0SLTYDd2c5PRxzWoqAp3onWM5iQIgdsB4eI+op5YBkBa0i2vGZymqDQDabC3fvJgSUztGXfAY+pdhPl6BHfV8VL11Wb8X5SsuAAMegAfn+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963538; c=relaxed/simple;
	bh=JS0FN7Nvo86wc6uic7BCbCZ6mLct9DfhPdVoz7hI3MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlIrO/mEyXgYYb5nNXrgKeQtGFmCcxJ1we6t0xzxNs5nsdqMZ2Fkvv1ds89+3JNG+CekZ687zqxktAkP+QvzL4HUxbjIw0vhW9lTjZmx4q4qTTpm504iEU3upmgFce3wAkf70KaCi2LolMtd3F6AO+n+3xn92XpgRb2RFEab55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE72B1758;
	Thu, 26 Jun 2025 11:45:18 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42B993F66E;
	Thu, 26 Jun 2025 11:45:36 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v8 2/3] tpm_crb_ffa:Introduce memzero macro to replace memset
Date: Thu, 26 Jun 2025 13:45:20 -0500
Message-ID: <20250626184521.1079507-3-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626184521.1079507-1-prachotan.bathi@arm.com>
References: <20250626184521.1079507-1-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a memzero macro to simplify and standardize zeroing
FF-A data args, replacing direct uses of memset for
improved readability and maintainability.

Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 089d1e54bb46..397cc3b0a478 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -12,6 +12,8 @@
 #include <linux/arm_ffa.h>
 #include "tpm_crb_ffa.h"
 
+#define memzero(s, n) memset((s), 0, (n))
+
 /* TPM service function status codes */
 #define CRB_FFA_OK			0x05000001
 #define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
@@ -192,7 +194,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
 
 	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
-		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
+		memzero(&tpm_crb_ffa->direct_msg_data2,
 		       sizeof(struct ffa_send_direct_data2));
 
 		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
@@ -205,7 +207,7 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 		if (!ret)
 			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
 	} else {
-		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
+		memzero(&tpm_crb_ffa->direct_msg_data,
 		       sizeof(struct ffa_send_direct_data));
 
 		tpm_crb_ffa->direct_msg_data.data1 = func_id;
-- 
2.43.0


