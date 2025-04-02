Return-Path: <linux-integrity+bounces-5555-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722FEA78F01
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 14:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7D616E9F5
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDAF23ED53;
	Wed,  2 Apr 2025 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fm+qKJrV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F0223AE6D;
	Wed,  2 Apr 2025 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598075; cv=none; b=enaVJ9ZOg0H1ZNsOcoEADkDV1zxHvvUp8gbvt4b8X+x29oYf3U3RcIs02FmTkPohLftpWkLsdE8ebcnU9ST4SsRqGwuy4ME4yLSGaffz8RSf4l0EQeFXovhG0+aFSwegVaegT5idN/N8uc2EADXnSqz89VhDYbXVdZtPzj+Qvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598075; c=relaxed/simple;
	bh=8zKS2SB/m2lwC0ERhyJbF2sczuoV87vLywnBYYhrQ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfmeeBkkNOHv6JnzrqeoEiTAxFrkptY8HtduNmfkcrzpN+nByMpYDeSopnf4xVW735QTMBZgPSfiLw/2UyTUszmCeoTr4G3+fHdY//D5cjhLSimzNYDOGslNABnUDb3rzMSMrZYT0IcIWB5sbZug12K1BkzrpFSCABfN/jVNj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fm+qKJrV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 552AB2025659;
	Wed,  2 Apr 2025 05:47:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 552AB2025659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743598073;
	bh=TIYkqv731cfeL17ltrsNIxcY2eH8QDnF2VgGdZyqueA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fm+qKJrVOUXOB6o0pxrl+eGZ/HXdBBwWrzeph9P1dlK5GSO1qXjnHXPMtOGHknSv1
	 3UWNES/7HuZmbIe5oaKBNlt8pX+yf1f+IokQowtBgO/lUJiGla6cr0wnK/m04PQJHV
	 srjip7h7MAtTReathD6kpxwApnASVV//qH2HqIJo=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Subject: [PATCH v11 7/9] ima: verify if the segment size has changed
Date: Wed,  2 Apr 2025 05:47:20 -0700
Message-ID: <20250402124725.5601-8-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402124725.5601-1-chenste@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kexec 'load' may be called multiple times. Free and realloc the buffer
only if the segment_size is changed from the previous kexec 'load' call.

Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 5c3b3e0b2186..ed867734ee70 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -33,6 +33,14 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
 
 static int ima_alloc_kexec_file_buf(size_t segment_size)
 {
+	/*
+	 * kexec 'load' may be called multiple times.
+	 * Free and realloc the buffer only if the segment_size is
+	 * changed from the previous kexec 'load' call.
+	 */
+	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
+		goto out;
+
 	ima_free_kexec_file_buf(&ima_kexec_file);
 
 	/* segment size can't change between kexec load and execute */
@@ -41,6 +49,8 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 		return -ENOMEM;
 
 	ima_kexec_file.size = segment_size;
+
+out:
 	ima_kexec_file.read_pos = 0;
 	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
 
-- 
2.25.1


