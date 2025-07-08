Return-Path: <linux-integrity+bounces-6642-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBCBAFDB64
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jul 2025 00:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC40584F58
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Jul 2025 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD25223DF5;
	Tue,  8 Jul 2025 22:52:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE1522E3E8;
	Tue,  8 Jul 2025 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015141; cv=none; b=l0ibUZ9t+wAIAbHPzOppOZR+P3yu/jw24YQgkBZ6h+Bt3RF4sKwb3LSjdddpKWjJ8EAZ5A4yQOIPTFcRBFp4iKOXRhsGX6qzbST6/rS/LS1UAYBcPcwci9Zc2a5B0zXKEoi0NZefeviJ4pFWEz4vO0Goe57n1qw1vlakBOTV3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015141; c=relaxed/simple;
	bh=SNdgHJE/X20HFoSToPtJnMgu1jFH6EnxA9NRuQ3YCog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQSQTAt35umhIdw7Tkd7YnYOB6OHIObLHYZjY9qncfCRtcVvAAlm1Cga4zgFRvP4jw5nGIpslq34YCIw7RXnZLSIY3qTGnSthEgkOpc8+mjGcuucOFOA9xcNV4Ra/lnJsg27RaPae7K30UtDfrkENSwkEsXRe5PKA7fhRWmjA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADE991764;
	Tue,  8 Jul 2025 15:52:06 -0700 (PDT)
Received: from u103485.austin.arm.com (u103485.arm.com [10.118.30.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 587733F66E;
	Tue,  8 Jul 2025 15:52:18 -0700 (PDT)
From: Prachotan Bathi <prachotan.bathi@arm.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prachotan Bathi <prachotan.bathi@arm.com>
Subject: [PATCH v9 1/3] tpm_crb_ffa: Fix typos in function name
Date: Tue,  8 Jul 2025 17:51:49 -0500
Message-ID: <20250708225151.2473657-2-prachotan.bathi@arm.com>
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

s/recieve/receive in __tpm_crb_ffa_send_receive

Signed-off-by: Prachotan Bathi <prachotan.bathi@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 4ead61f01299..089d1e54bb46 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -178,7 +178,7 @@ int tpm_crb_ffa_init(void)
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
 
-static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
+static int __tpm_crb_ffa_send_receive(unsigned long func_id,
 				      unsigned long a0,
 				      unsigned long a1,
 				      unsigned long a2)
@@ -251,7 +251,7 @@ int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
 
 	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
 
-	rc = __tpm_crb_ffa_send_recieve(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
+	rc = __tpm_crb_ffa_send_receive(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
 	if (!rc) {
 		if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
 			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
@@ -289,7 +289,7 @@ int tpm_crb_ffa_start(int request_type, int locality)
 
 	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
 
-	return __tpm_crb_ffa_send_recieve(CRB_FFA_START, request_type, locality, 0x00);
+	return __tpm_crb_ffa_send_receive(CRB_FFA_START, request_type, locality, 0x00);
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_start);
 
-- 
2.43.0


