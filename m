Return-Path: <linux-integrity+bounces-5549-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86186A78F09
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 14:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D053B3784
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866D23BD10;
	Wed,  2 Apr 2025 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jAILEI5p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E662397B9;
	Wed,  2 Apr 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598060; cv=none; b=jwaFpYcrHyaMvmqAEEP4rjFKhc6+peVh+pf8xCQMbdX3AyJoGFOxmhvi0M96RWFYy6okeqOqhYfAaK1zooSJbaxzUc6bCHtA01Yx2lW08XG7FE7YxmApfO+GNqOG8ZGnKud8M6t6syUjanCjKxbjAquoDvtUOOHo07wJqmHwiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598060; c=relaxed/simple;
	bh=hZi9oXKtafjfMDBtwL81ZeBozwb0pXIsgwsMccGcsbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QG+794sATI2ykntrxh0OvNF/OI+ziAwQ6pXMe6FxtQqp4TWYom31MyyS4CIfZZ9T/FfWLk03C2da00LXfMSeqGspRy9/RfNDUn3bcneGBqxQ849yRTTTgSwzNcsBzHupsFqqgLuyJ8HrjF/0LF4Cfn5SVIHBJ5trdfelWYKAxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jAILEI5p; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 219FD2025659;
	Wed,  2 Apr 2025 05:47:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 219FD2025659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743598058;
	bh=h/cpgKcbrvyKJYGjsn7+e/Tvw7I5+jxPdp1ilsIXavc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jAILEI5pItipCfyuKGVNeMXN1b9ysS7Iw139vrqnCCH1ygchjkRpoJP5O7C1+cH4N
	 4kqeT2Zu5SngVoo3Rb8/ijhtnav0K3bO+MU6yAKnFh9jYlnLFGRFRTY19Cm2ezgHCa
	 HgUTgeLPcymBB01YjkL7CRb0OZMNCKPSHZUkyjfU=
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
Subject: [PATCH v11 1/9] ima: rename variable the set_file "file" to "ima_kexec_file"
Date: Wed,  2 Apr 2025 05:47:14 -0700
Message-ID: <20250402124725.5601-2-chenste@linux.microsoft.com>
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

The current kernel behavior is IMA measurements snapshot is taken at
kexec 'load' and not at kexec 'execute'. IMA log is then carried
over to the new kernel after kexec 'execute'. However, the time gap
between kexec load and kexec reboot can be very long. During this
time window, new events extended into TPM PCRs miss the chance
to be carried over to the second kernel.
 
To address the above, the following approach is proposed:
  - Allocate the necessary buffer during the kexec load phase.
  - Populate this buffer with the IMA measurements during
    the kexec execute phase.

In the current implementation, a local variable "file" of type seq_file
is used in the API ima_dump_measurement_list() to store the IMA measurements
to be carried over across kexec system call. To make this buffer accessible
at kexec 'execute' time, rename it to "ima_kexec_file" before making it
a file variable to better reflect its purpose.

Renaming the local variable "file" of type seq_file defined in the 
ima_dump_measurement_list function to "ima_kexec_file" will improve code
readability and maintainability by making the variable's role more explicit.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: steven chen <chenste@linux.microsoft.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_kexec.c | 31 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 9d45f4d26f73..650beb74346c 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -18,30 +18,30 @@
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
+	struct seq_file ima_kexec_file;
 	struct ima_queue_entry *qe;
-	struct seq_file file;
 	struct ima_kexec_hdr khdr;
 	int ret = 0;
 
 	/* segment size can't change between kexec load and execute */
-	file.buf = vmalloc(segment_size);
-	if (!file.buf) {
+	ima_kexec_file.buf = vmalloc(segment_size);
+	if (!ima_kexec_file.buf) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	file.file = NULL;
-	file.size = segment_size;
-	file.read_pos = 0;
-	file.count = sizeof(khdr);	/* reserved space */
+	ima_kexec_file.file = NULL;
+	ima_kexec_file.size = segment_size;
+	ima_kexec_file.read_pos = 0;
+	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
 
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
 	/* This is an append-only list, no need to hold the RCU read lock */
 	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
-		if (file.count < file.size) {
+		if (ima_kexec_file.count < ima_kexec_file.size) {
 			khdr.count++;
-			ima_measurements_show(&file, qe);
+			ima_measurements_show(&ima_kexec_file, qe);
 		} else {
 			ret = -EINVAL;
 			break;
@@ -55,23 +55,24 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	 * fill in reserved space with some buffer details
 	 * (eg. version, buffer size, number of measurements)
 	 */
-	khdr.buffer_size = file.count;
+	khdr.buffer_size = ima_kexec_file.count;
 	if (ima_canonical_fmt) {
 		khdr.version = cpu_to_le16(khdr.version);
 		khdr.count = cpu_to_le64(khdr.count);
 		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
 	}
-	memcpy(file.buf, &khdr, sizeof(khdr));
+	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
 
 	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
-			     file.buf, file.count < 100 ? file.count : 100,
+			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
+			     ima_kexec_file.count : 100,
 			     true);
 
-	*buffer_size = file.count;
-	*buffer = file.buf;
+	*buffer_size = ima_kexec_file.count;
+	*buffer = ima_kexec_file.buf;
 out:
 	if (ret == -EINVAL)
-		vfree(file.buf);
+		vfree(ima_kexec_file.buf);
 	return ret;
 }
 
-- 
2.25.1


