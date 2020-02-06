Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C448F154989
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 17:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgBFQpM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 11:45:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52420 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgBFQpL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 11:45:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016GcnbI050769;
        Thu, 6 Feb 2020 16:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=mOd/toCf6IcfjIYE08cObI/VB0Rx512cP6g2PbHIXoQ=;
 b=Rm4fw9qsTxTuQKGOf2eAh31Ow77Nu1oftxFWkCVXieAGjLVrnx9C0Dw8v00YJjIeND9B
 4w/UYlbAiTrNE8RxmyTYs1N2VjMmlPBeXg+MZXAdNUUzcG66yfDPpnPw415XmnyJe5Gx
 fDnRPZYfexuSoSyZe65E9ma1HLi+P24vqxwx4DE5dZXPyw6eOFhCn67P4Zr2UFiB2Q4a
 R1wu5KHMR35SGCHg1l4UIbR6uYcsX6QJDdAEWlWYkyabsbwTW4bw1Cj12dzUuZ1SIwag
 tFO5p23AgvxvOpiikBaFMWGj8wjr2+TCY4Tn+tVUQL+Jp5bnGRMLD3lxAPLjW26XsdVo tA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=mOd/toCf6IcfjIYE08cObI/VB0Rx512cP6g2PbHIXoQ=;
 b=SqlFTqplMp2Z1yKySBLpekymcQsblolEpUZZwgGxODcBKcXQcVEyP9y+kVGuOYu6/XnF
 XCf/DypZBF6OXmCbW7jzCeIeGzqMwUZfW+x7hBCiQYWuUoenWvVo80ofzuzjn1UEarKw
 SXLAphomROT4GDCKsTNT2mtKetH8g7LxoY2zCf3q4Wk4JEaZUn2ynntQeaAfOl5wyeBQ
 giLglDKn6UMsUKTjWSW0UtZ5GBKyzE9sQjDSHemd4Ott+T6umU+WOgZkI+pn/30/M/cc
 l22moEyy98Pe1TtiwnjyEgUl+/UQAQBXS3BBejc4ZYHBMnjK+H1yifX+Y2VGx4NhHEb8 ZA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xykbpawdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 16:42:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016Gd8Rr009698;
        Thu, 6 Feb 2020 16:42:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y0mnk0n9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 16:42:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 016GgdMW017902;
        Thu, 6 Feb 2020 16:42:40 GMT
Received: from localhost.us.oracle.com (/10.147.27.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 08:42:39 -0800
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     dhowells@redhat.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        eric.snowberg@oracle.com, tglx@linutronix.de,
        bauerman@linux.ibm.com, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] ima: Change default secure_boot policy to include appended signatures
Date:   Thu,  6 Feb 2020 11:42:26 -0500
Message-Id: <20200206164226.24875-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200206164226.24875-1-eric.snowberg@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the default secure_boot policy from:

appraise func=MODULE_CHECK appraise_type=imasig
appraise func=FIRMWARE_CHECK appraise_type=imasig
appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig
appraise func=POLICY_CHECK appraise_type=imasig

to

appraise func=MODULE_CHECK appraise_type=imasig|modsig
appraise func=FIRMWARE_CHECK appraise_type=imasig
appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig
appraise func=POLICY_CHECK appraise_type=imasig

This will allow appended signatures to work with the default
secure_boot policy.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/ima/ima_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ef8dfd47c7e3..5d835715b472 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -189,11 +189,11 @@ static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
 
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	{.action = APPRAISE, .func = MODULE_CHECK,
-	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED},
 	{.action = APPRAISE, .func = FIRMWARE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
-	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED},
 	{.action = APPRAISE, .func = POLICY_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 };
-- 
2.18.1

