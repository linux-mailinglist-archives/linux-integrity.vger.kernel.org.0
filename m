Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4E3331D5C
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Mar 2021 04:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCIDUT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Mar 2021 22:20:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50608 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhCIDUF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Mar 2021 22:20:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129334B9006995;
        Mon, 8 Mar 2021 22:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=67FXqN1B0PQEsZg9gzPWAoe1tpFzaOkVa87vK/uhebA=;
 b=AsrQP+jrtdjna38eMHRpHncytxtYZsxDFfD3WRmT8ZOgQTXxhJRvofnKy+XnM2SiubLy
 mHt5tG8oUdDQMbGGPYeWTGAjaVaF5sCCJtKt9rQ5wm5CPYFNIWy3Sg2/FDsBZXk0Zvog
 oFt/jhiFzvHd5oWPvU7PL3G1A2XUlTrSf0oqUsYHn5DQ+ILRROteEQD2l0yOUq68KaUF
 0+mHzxMkKmTrvcibefHC87Kg4tEMittnpmqq7+9BmmTZ2FP3dfqDRTo+CqUNnAPH66TN
 kPBZWuVGkiMyuX6ToZWbUUSWPFXHUZDJoR9GwPxSkTqrhPtX97nL758R7ZhBpbtldpIu 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375wfsccuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 22:20:03 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12935Fwk012159;
        Mon, 8 Mar 2021 22:20:03 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375wfsccu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 22:20:03 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1293Gg5v024988;
        Tue, 9 Mar 2021 03:20:02 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 3741c8u9ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 03:20:02 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1293K1PJ42205530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 03:20:01 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75631BE05F;
        Tue,  9 Mar 2021 03:20:01 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5F19BE056;
        Tue,  9 Mar 2021 03:20:00 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 03:20:00 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/3] tpm: acpi: Check eventlog signature before using it
Date:   Mon,  8 Mar 2021 22:19:53 -0500
Message-Id: <20210309031954.6232-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309031954.6232-1-stefanb@linux.ibm.com>
References: <20210309031954.6232-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_22:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Check the eventlog signature before using it. This avoids using an
empty log, as may be the case when QEMU created the ACPI tables,
rather than probing the EFI log next. This resolves an issue where
the EFI log was empty since an empty ACPI log was used.

Fixes: 85467f63a05c ("tpm: Add support for event log pointer found in TPM2 ACPI table")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/eventlog/acpi.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 3633ed70f48f..b6bfd22e4a2f 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -41,6 +41,25 @@ struct acpi_tcpa {
 	};
 };
 
+/* check that the given log is indeed a TPM2 log */
+static int tpm_check_tpm2_log_header(void *bios_event_log, u64 len)
+{
+	struct tcg_efi_specid_event_head *efispecid;
+	struct tcg_pcr_event *event_header = bios_event_log;
+
+	if (len < sizeof(*event_header))
+		return 1;
+	len -= sizeof(*event_header);
+
+	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
+	if (len < sizeof(*efispecid) ||
+	    memcmp(efispecid->signature, TCG_SPECID_SIG,
+		   sizeof(TCG_SPECID_SIG)))
+		return 1;
+
+	return 0;
+}
+
 /* read binary bios log */
 int tpm_read_log_acpi(struct tpm_chip *chip)
 {
@@ -52,6 +71,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	struct acpi_table_tpm2 *tbl;
 	struct acpi_tpm2_phy *tpm2_phy;
 	int format;
+	int ret;
 
 	log = &chip->log;
 
@@ -112,6 +132,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 
 	log->bios_event_log_end = log->bios_event_log + len;
 
+	ret = -EIO;
 	virt = acpi_os_map_iomem(start, len);
 	if (!virt)
 		goto err;
@@ -119,11 +140,19 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	memcpy_fromio(log->bios_event_log, virt, len);
 
 	acpi_os_unmap_iomem(virt, len);
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
+	    tpm_check_tpm2_log_header(log->bios_event_log, len)) {
+		/* try EFI log next */
+		ret = -ENODEV;
+		goto err;
+	}
+
 	return format;
 
 err:
 	kfree(log->bios_event_log);
 	log->bios_event_log = NULL;
-	return -EIO;
+	return ret;
 
 }
-- 
2.29.2

