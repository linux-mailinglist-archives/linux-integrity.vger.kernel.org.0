Return-Path: <linux-integrity+bounces-5989-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43049A9594D
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Apr 2025 00:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271877A4E3D
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B322A4E0;
	Mon, 21 Apr 2025 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q3nC6b3H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822B22A4C9;
	Mon, 21 Apr 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274349; cv=none; b=cFA0N3eSe6tgUP6X7YHI08UQwsCRWLbxVxgeilrcIyZrBF+WM/jTE1ECqHrlCffT1j+xSyCA3+AV1sbXYcQgJaixwmETi8rJ1YDM6XDXkxmxIS5z5RkAr0gkaun/Vc4Xng75454UwVFhTQUsIHjdC7Hn7bbvJGTMqfsqR2SU8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274349; c=relaxed/simple;
	bh=C68aO11fwY5Hq7MhMVBjpxhOBUfYTUWrOF7aOqYOLWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=af/fqr+l7fYjulckmluh4vJr/Nr7MuGn+FEWjiP3tyrHfFlvge7Z+hm0b46R65eRsNl9WWFmOiPfiN3yIf/oluzT544NANchQYFTfjsKE9zqNZzBmiB7lRWQNYIFoxFWix6xR9qsRdgWnFUfOW29B2eiRlmlyIzwTP88TbZ292U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q3nC6b3H; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4ECFE203B875;
	Mon, 21 Apr 2025 15:25:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4ECFE203B875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745274347;
	bh=6xgOBYzerQDrucaQC/lEMeygmGpDLxyAasYBprqw4mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3nC6b3Hi7IbCLuLtwW+3lh+1WXvmj68ZrT/fw8ahWDKC88opIExvLYFzI8HSRUqK
	 de3Bt2rmlJzSzacdZccAIvEIYxt4EY55PwlwMtVjtd8yBdqKMoCM5F/YG9ndpYTMPh
	 mbOczUN4dfQ93Ql9HFhdQKSHJ83nRKYDMGOzp4PA=
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
Subject: [PATCH v13 7/9] ima: verify if the segment size has changed
Date: Mon, 21 Apr 2025 15:25:13 -0700
Message-ID: <20250421222516.9830-8-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421222516.9830-1-chenste@linux.microsoft.com>
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Chen <chenste@linux.microsoft.com>

kexec 'load' may be called multiple times. Free and realloc the buffer
only if the segment_size is changed from the previous kexec 'load' call.

Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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
2.43.0


