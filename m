Return-Path: <linux-integrity+bounces-6643-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72238AFDB66
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jul 2025 00:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5799E1C26D8E
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jul 2025 22:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF81E2288CB;
	Tue,  8 Jul 2025 22:52:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E28423182B;
	Tue,  8 Jul 2025 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015145; cv=none; b=sGViB+N6iRjv//OE0IcCdTaNr86U1nOQG3fDAnpL5MUjCpia+Ydk+JwDEwrBUxKDHgnRlxaKK63y2hCGqOLQFOqWUFUsuhTvN7735yknIs+4SJRcj+kSKnOpl3FemZNJ9zgkoquxv4roNK+3e85ZBoqL4ELp+uymRSOIGhsxpMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015145; c=relaxed/simple;
	bh=Vo8pD8Po5ZL7PSREBWn0riJSuBumIugm1ywa0PmtV70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2SwO1MG2ivva/GY3ebqybuJjHzR/1fH+yFIqYqj6XKZPBRIsK6pmdlOB3Dkig2tC+kj280fImcHSjf97dMFnewFrYwXb2L49tPPBqHoy2zyFFjH8mKchP+dcC1pGVGapoUs/LhyTQWbHNQ1WDJG1oNrwyrwE20wW9OBpUV+8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB52A1764;
	Tue,  8 Jul 2025 15:52:11 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55CD33F66E;
	Tue,  8 Jul 2025 15:52:23 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v9 2/3] tpm_crb_ffa:Remove memset usage
Date: Tue,  8 Jul 2025 17:51:50 -0500
Message-ID: <20250708225151.2473657-3-prachotan.bathi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708225151.2473657-1-prachotan.bathi@arm.com>
References: <20250708225151.2473657-1-prachotan.bathi@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify initialization of `ffa_send_direct_data2` and
`ffa_send_direct_data` structures by using designated
initializers instead of `memset()` followed by field
assignments, reducing code size and improving readability.

Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 089d1e54bb46..7faed6f3bf66 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -192,26 +192,21 @@ static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
 
 	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
-		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
-		       sizeof(struct ffa_send_direct_data2));
-
-		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
-		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
-		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
-		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
+		tpm_crb_ffa->direct_msg_data2 = (struct ffa_send_direct_data2){
+			.data = { func_id, a0, a1, a2 },
+		};
 
 		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
 				&tpm_crb_ffa->direct_msg_data2);
 		if (!ret)
 			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
 	} else {
-		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
-		       sizeof(struct ffa_send_direct_data));
-
-		tpm_crb_ffa->direct_msg_data.data1 = func_id;
-		tpm_crb_ffa->direct_msg_data.data2 = a0;
-		tpm_crb_ffa->direct_msg_data.data3 = a1;
-		tpm_crb_ffa->direct_msg_data.data4 = a2;
+		tpm_crb_ffa->direct_msg_data = (struct ffa_send_direct_data){
+			.data1 = func_id,
+			.data2 = a0,
+			.data3 = a1,
+			.data4 = a2,
+		};
 
 		ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
 				&tpm_crb_ffa->direct_msg_data);
-- 
2.43.0


