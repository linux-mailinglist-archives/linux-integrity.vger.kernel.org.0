Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92887304A37
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Jan 2021 21:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbhAZFL6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Jan 2021 00:11:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbhAZBuG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Jan 2021 20:50:06 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10Q1WAfm079981;
        Mon, 25 Jan 2021 20:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qDlLTrJhI9pAWTPZzvEj2myghWfEoN4K/hh1AcU5nnc=;
 b=A4jcBSUCed/y8O6j82+m2GYzSBr/aUIO0I73UYCGUArwUx0K6/bFzkcfMLmIocKzPkUq
 Pjeg/MGeo+XSF55PgkgFMmnWYIW5HA5TWW1yvNQN4yWyKuNfnxL/GgGwOd5SbroyMUgg
 UJjsrzaJvSsOtjfEp2cX6O2HwjykI1FkY7y0XJ7t0pwdwQt9jGmjctaGMACTj0Z3M02B
 DXYDLrc0axFPvjGSSOtfGyg7bL4DMvtocZ6VF2wK0jdCbNQ83GS2XLVi8JJUYMW7cT4t
 bjfiMrfljNQnviIi21EAJiAFk1zXPcjwHmhwRyES4BDRIfngTiMSB+CWnydyRKtNEt18 uQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36a4ttpfta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 20:48:45 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10Q1kXDu004438;
        Tue, 26 Jan 2021 01:48:44 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 36a8uh09ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 01:48:44 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10Q1mhJw17891772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 01:48:43 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3AC26A057;
        Tue, 26 Jan 2021 01:48:43 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13A986A04F;
        Tue, 26 Jan 2021 01:48:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jan 2021 01:48:42 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Hulk Robot <hulkci@huawei.com>, Wang Hai <wanghai38@huawei.com>
Subject: [PATCH v2] tpm: ibmvtpm: fix error return code in tpm_ibmvtpm_probe()
Date:   Mon, 25 Jan 2021 20:47:53 -0500
Message-Id: <20210126014753.340299-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_10:2021-01-25,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260002
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Return error code -ETIMEDOUT rather than '0' when waiting for the
rtce_buf to be set has timed out.

Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 994385bf37c0..813eb2cac0ce 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -687,6 +687,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 				ibmvtpm->rtce_buf != NULL,
 				HZ)) {
 		dev_err(dev, "CRQ response timed out\n");
+		rc = -ETIMEDOUT;
 		goto init_irq_cleanup;
 	}
 
-- 
2.25.4

