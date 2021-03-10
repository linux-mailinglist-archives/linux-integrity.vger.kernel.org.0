Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699C8334B6F
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Mar 2021 23:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhCJWTv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 17:19:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232966AbhCJWTe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 17:19:34 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AMJV77081017;
        Wed, 10 Mar 2021 17:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wp/1c5NfMQfPydumePHhOuQQCmguw6uJmxK59NQNMnY=;
 b=baw+OEcxKGWKd+5Tc25jUfb6faVvpZEHJhBLRTbjqfZlDCfhZYGfcZL2+adUXNGo6lZZ
 uwbzF8+fjrXTIficXWt7Lu25AoCCSynW/5St7/821IFX236Nh/4lVgJUVDpEc8+UFnC9
 KxgKFhBuUVFGw2rO6+Tu68Fip5mCe/LwraLJ+Qh+pmXSq9gdoFcN0i080kJNwXVsIu7k
 uZnN6UfaInqN9m3DvDLkk55JtPbiASbOV6I4wWHvtleuCov1/fagRuQM/QmxXtXWFnYU
 JQAP8CSwuxUI+k6akcrWZ2JTRCfD8kbVtjAaT6fywFf1UHPUM8ux7FIYNcEr790esmV5 Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774mduumm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:19:33 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12AMJXWf081172;
        Wed, 10 Mar 2021 17:19:33 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3774mduuhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:19:32 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AMH8Up021205;
        Wed, 10 Mar 2021 22:19:19 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3768n4k8w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 22:19:19 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AMJJMO27066708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 22:19:19 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A5E9AE062;
        Wed, 10 Mar 2021 22:19:19 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6284DAE06B;
        Wed, 10 Mar 2021 22:19:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 22:19:19 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/3] tpm: acpi: Check eventlog signature before using it
Date:   Wed, 10 Mar 2021 17:19:15 -0500
Message-Id: <20210310221916.356716-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210310221916.356716-1-stefanb@linux.ibm.com>
References: <20210310221916.356716-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_12:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100105
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
 drivers/char/tpm/eventlog/acpi.c | 33 +++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 3633ed70f48f..1b18ce5ebab1 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -41,6 +41,27 @@ struct acpi_tcpa {
 	};
 };
 
+/* Check that the given log is indeed a TPM2 log. */
+static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
+{
+	struct tcg_efi_specid_event_head *efispecid;
+	struct tcg_pcr_event *event_header;
+	int n;
+
+	if (len < sizeof(*event_header))
+		return false;
+	len -= sizeof(*event_header);
+	event_header = bios_event_log;
+
+	if (len < sizeof(*efispecid))
+		return false;
+	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
+
+	n = memcmp(efispecid->signature, TCG_SPECID_SIG,
+		   sizeof(TCG_SPECID_SIG));
+	return n == 0;
+}
+
 /* read binary bios log */
 int tpm_read_log_acpi(struct tpm_chip *chip)
 {
@@ -52,6 +73,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	struct acpi_table_tpm2 *tbl;
 	struct acpi_tpm2_phy *tpm2_phy;
 	int format;
+	int ret;
 
 	log = &chip->log;
 
@@ -112,6 +134,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 
 	log->bios_event_log_end = log->bios_event_log + len;
 
+	ret = -EIO;
 	virt = acpi_os_map_iomem(start, len);
 	if (!virt)
 		goto err;
@@ -119,11 +142,19 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	memcpy_fromio(log->bios_event_log, virt, len);
 
 	acpi_os_unmap_iomem(virt, len);
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
+	    !tpm_is_tpm2_log(log->bios_event_log, len)) {
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

