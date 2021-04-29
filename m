Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA94F36F0B6
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhD2TzB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 15:55:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236969AbhD2Typ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 15:54:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13TJXItk044857;
        Thu, 29 Apr 2021 15:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=G12Iz6Dk/1EZyRnlKcACqndloRDCQYlA4S1zPMr1B/w=;
 b=MDs2VpWMER16A6rvtIluqHzkrqJgfn/xpH581N4u/EHmWntFOL0GBIkWbhKwk9PgDVOT
 POE2hdIulB0HarYLdpAnWVpNvOr6P/Y57P8sjj+1eLC341bx9jTx0Ig/76jshtPGBiBm
 0Ztm3sk1llSTs86SPFFGSz1LHEy/XcHP/5mD9i/cDTx448aJPZZAbmiWXwStMLcLdTi6
 eQD4/cFs6iJhczFcUVp1g0pkl4w16RoFSj+PKGASpEkCwnxjia4yoIG4e99B5430fLc3
 nLEZPJ+OLZHyhI2Ar2Y1aTAjQzgk2uDrdodtFMFlvfR+uWdgrSap3wGx1dBGGuIT9GvX 4g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3882s6gxae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 15:53:58 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13TJruxs006383;
        Thu, 29 Apr 2021 19:53:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 384ay89etm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 19:53:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13TJrq1x31785252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 19:53:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5029AE04D;
        Thu, 29 Apr 2021 19:53:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ED3FAE045;
        Thu, 29 Apr 2021 19:53:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.163.24.93])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Apr 2021 19:53:51 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] evm: fix writing <securityfs>/evm overflow
Date:   Thu, 29 Apr 2021 15:53:32 -0400
Message-Id: <20210429195332.310697-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IEyyskeBiHizlLYvERj9FkwgQfrqS7Ur
X-Proofpoint-ORIG-GUID: IEyyskeBiHizlLYvERj9FkwgQfrqS7Ur
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_10:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=884 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

EVM_SETUP_COMPLETE is defined as 0x80000000, which is larger than INT_MAX.
The "-fno-strict-overflow" compiler option properly prevents signaling
EVM that the EVM policy setup is complete.  Define and read an unsigned
int.

Fixes: f00d79750712 ("EVM: Allow userspace to signal an RSA key has been
loaded")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/evm/evm_secfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index bbc85637e18b..0007d3362754 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -66,12 +66,13 @@ static ssize_t evm_read_key(struct file *filp, char __user *buf,
 static ssize_t evm_write_key(struct file *file, const char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	int i, ret;
+	unsigned int i;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP_COMPLETE))
 		return -EPERM;
 
-	ret = kstrtoint_from_user(buf, count, 0, &i);
+	ret = kstrtouint_from_user(buf, count, 0, &i);
 
 	if (ret)
 		return ret;
-- 
2.27.0

