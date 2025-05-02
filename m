Return-Path: <linux-integrity+bounces-6113-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABBAAA7A87
	for <lists+linux-integrity@lfdr.de>; Fri,  2 May 2025 22:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356969C8491
	for <lists+linux-integrity@lfdr.de>; Fri,  2 May 2025 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359AB1F12EF;
	Fri,  2 May 2025 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ojCOdjA6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F110A1F;
	Fri,  2 May 2025 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216229; cv=none; b=Oj552PkesGvkmWD8K0H8QVd5X10fMS6Xu7xyg0fPamcSBRfiflfamQ4KHriw1Tb6aBs4d1km/WHy8sWvmP3ZGxFrzdGXi8by9/4nNAyG+zzqPcN77YE7Erij6qw0rt3YxDyRAyc6QrMjaJ/B+mXq9H0CTP6dC8SxlCV1emOGejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216229; c=relaxed/simple;
	bh=9FDNkz8IR7ICG/3HhZVT667pe4daQd06prhHD6a/Z2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTebz6aaEvWU2WbWKO5t5GtlcL1xkP3Z5mefPy9kaikycV9M2NiLR6xVMEUd93a2ASJqd8E9IM+wu/kpHHuSth+zkiUSxH/q1oxvOasEfrUq2w0lniCBt3DfYSrn52onJmPM4K+qX/n4wX1H6wsrmSWBrM6XhFd/vyj13rmQYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ojCOdjA6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [172.200.70.89])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F9692111577;
	Fri,  2 May 2025 13:03:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F9692111577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746216227;
	bh=yvSliSI2VZ4OzZP8MlHEp1O9A0cHnM6zmQWdWeMUSvc=;
	h=From:To:Cc:Subject:Date:From;
	b=ojCOdjA6mzHKD+heQAekRu3faXQRlBVcJh5gN9NltIRxJHUDbRLOc9HdKzyBSI7pq
	 LBVB0N+4tuX4QfLUw9PkiZLk/h2p8out2g5olB+vvDJobPx4lp7dAVyDFVP0O1hj1w
	 M6URGqfwFA4JPKoK6409Ke+jHJLa8hAnPAs9zJik=
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
	bhe@redhat.com
Subject: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity measurement
Date: Fri,  2 May 2025 13:03:37 -0700
Message-ID: <20250502200337.6293-1-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Chen <chenste@linux.microsoft.com>

Kdump kernel doesn't need IMA to do integrity measurement.
Hence the measurement list in 1st kernel doesn't need to be copied to
kdump kenrel.

Here skip allocating buffer for measurement list copying if loading
kdump kernel. Then there won't be the later handling related to
ima_kexec_buffer.

Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 38cb2500f4c3..7362f68f2d8b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
 	void *kexec_buffer = NULL;
 	int ret;
 
+	if (image->type == KEXEC_TYPE_CRASH)
+		return;
+
 	/*
 	 * Reserve extra memory for measurements added during kexec.
 	 */
-- 
2.43.0


