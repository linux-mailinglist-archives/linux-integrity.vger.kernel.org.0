Return-Path: <linux-integrity+bounces-4337-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A79EBDD3
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 23:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B081695BC
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435A1EE7CE;
	Tue, 10 Dec 2024 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z1GQSxbg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736282451F1;
	Tue, 10 Dec 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869592; cv=none; b=EYmothD/NCNSa/f3Wytshl90scSHNhlbtnwe1G1Sexv7Vq3THjPRhFyBJ1H31KE8C5pLqM+CXEvqAHlJw2vc8AUGgzRxSEcuwFFBdPFBFc4R4v+W+PBuLfiZ1lPQqFmwmsU4uVMgGbVkJ+7izXhR7qEPfan01WpTDWpsKpwfiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869592; c=relaxed/simple;
	bh=3NCMVw/Lby/M4m7AcE6GO4Jv/FYRr6XCAdEnlPolzy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0/ioNVi3hDsV/K7FoHU+o7oJz9nIO+SjZpR5swvWL9lrDviCrZCQyrmeuELALSkgFcXnx6W0pQZC8n2MqIDlQGH8DyeejVWMbS6brzk+g8rMPQSufwO6x2crObbWmR4ZeIxlHbKhR3+QNqEzq1Fwjj4aVOcT4yuP03y54encSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z1GQSxbg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADraZ3009236;
	Tue, 10 Dec 2024 22:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jnzZkYeW8tWSyuUF39ZkUJVg3Xdkp4MeuZXuKcDYJ
	0k=; b=Z1GQSxbgd1TfNCiV8uz3MyrW8ugL3kEEezu+9RzHiM028antD29uns2mi
	oaVTMJODshXTLXaKEPmxQRXNALd4ylItkG93QYO38Qf3TgHzQW/8B8uxGT/38HLo
	Qo5obMDCFjrqiqoKB3XljGWWWrpA3E2g80dQ0EVX4vfDiOJFmdeQHCCVGs86Q6pO
	3dxKabgw4HF5IlLC5gj7kSEVkf9W9H2aA3rtD3mDJPzoTcBPsCD9Agqqt7zTdkIK
	1a59VtRtqjzDjcfcL7b/SyStgDbvBwwTsyBHL96H86/4fgEueja58BBa6eLS6Arl
	0b/f8n24oJqng7y1KNsCEJjsNdkxg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38ssdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 22:26:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAKvhLC017428;
	Tue, 10 Dec 2024 22:26:22 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1nht3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 22:26:22 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BAMQMQo17760832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 22:26:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1BA458052;
	Tue, 10 Dec 2024 22:26:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D35158054;
	Tue, 10 Dec 2024 22:26:21 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 22:26:21 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>,
        Andy Liang <andy.liang@hpe.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] tpm/eventlog: Limit memory allocations for event logs with excessive size
Date: Tue, 10 Dec 2024 17:26:08 -0500
Message-ID: <20241210222608.598424-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fko00RqIkJ3ZBmeBtyrGZ37_2ubZdB0d
X-Proofpoint-ORIG-GUID: fko00RqIkJ3ZBmeBtyrGZ37_2ubZdB0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100157

The TPM2 ACPI BIOS eventlog of a particular machine indicates that the
length of the log is 4MB, even though the actual length of its useful data,
when dumped, are only 69kb. To avoid allocating excessive amounts of memory
for the event log, limit the size of any eventlog to 128kb. This should be
sufficient memory and also not unnecessarily truncate event logs on any
other machine.

Reported-by: Andy Liang <andy.liang@hpe.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/eventlog/acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 69533d0bfb51..701fd7d4cc28 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -26,6 +26,8 @@
 #include "../tpm.h"
 #include "common.h"
 
+#define MAX_TPM_LOG_LEN		(128 * 1024)
+
 struct acpi_tcpa {
 	struct acpi_table_header hdr;
 	u16 platform_class;
@@ -135,6 +137,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		return -EIO;
 	}
 
+	if (len > MAX_TPM_LOG_LEN) {
+		dev_warn(&chip->dev, "Excessive TCPA log len %llu truncated to %u bytes\n",
+			 len, MAX_TPM_LOG_LEN);
+		len = MAX_TPM_LOG_LEN;
+	}
+
 	/* malloc EventLog space */
 	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
 	if (!log->bios_event_log)
-- 
2.43.0


