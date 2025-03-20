Return-Path: <linux-integrity+bounces-5333-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFCBA6A3D4
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 11:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAB1176523
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E35223719;
	Thu, 20 Mar 2025 10:37:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7487214A98;
	Thu, 20 Mar 2025 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467044; cv=none; b=as97q2q77EryP3Qxund8xNmD+rvbRdlntgjR/+TbVdKtTKdTh5i0VvZs3uVIEQEBRhUIKbbSYYVxipstYfrJ0CdknEhYRjXW65tIsfBumn5VsfFysPxbII3p4G1ZJWtsKYT+EJQh55mk+uAO/gOnHPBgBPT3q03Ut2kfeZMDxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467044; c=relaxed/simple;
	bh=pTToOtQDwiAIRmWlci/2a5ad3eJkEsZVClBFVJxdpr4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fuak+UcqmX9AomhbI5ahPWpkOWWEpGuecmGVm77luSLm8LcSOmAgFTfohFpAmlbTagofLFYdS7CNqWHRpByKgIz+Lf0AZIvMXinBLIcWN/gBsxGz+72M/v9sPqkeWaJhbD8wocaV3pePQm9+p4Q2Io2KkMRrnDjynLn61Il1Aqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201606.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202503201836035228;
        Thu, 20 Mar 2025 18:36:03 +0800
Received: from localhost.localdomain (10.94.4.179) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 20 Mar 2025 18:36:02 +0800
From: Bo Liu <liubo03@inspur.com>
To: <dhowells@redhat.com>, <James.Bottomley@HansenPartnership.com>,
	<jarkko@kernel.org>, <zohar@linux.ibm.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo
 Liu <liubo03@inspur.com>
Subject: [PATCH] KEYS: trusted: dcp: Use kfree_sensitive() to fix Coccinelle warnings
Date: Thu, 20 Mar 2025 06:35:57 -0400
Message-ID: <20250320103557.7236-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20253201836038828c3e088994c058045b04d2e9e3c62
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Replace memzero_explicit() and kfree() with kfree_sensitive() to fix
warnings reported by Coccinelle:

WARNING opportunity for kfree_sensitive/kvfree_sensitive
WARNING opportunity for kfree_sensitive/kvfree_sensitive

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 security/keys/trusted-keys/trusted_dcp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index 7b6eb655df0c..c967837e72ee 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -233,8 +233,7 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 	ret = 0;
 
 out:
-	memzero_explicit(plain_blob_key, AES_KEYSIZE_128);
-	kfree(plain_blob_key);
+	kfree_sensitive(plain_blob_key);
 
 	return ret;
 }
@@ -283,8 +282,7 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 	ret = 0;
 out:
 	if (plain_blob_key) {
-		memzero_explicit(plain_blob_key, AES_KEYSIZE_128);
-		kfree(plain_blob_key);
+		kfree_sensitive(plain_blob_key);
 	}
 
 	return ret;
-- 
2.31.1


