Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E660636469F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Apr 2021 17:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhDSPCc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 11:02:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239385AbhDSPCb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 11:02:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JEbX9u095722
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4tLRYv8G0ECMUArMDgFj4UGE0/zVEBdwm9ey4Qpd/yU=;
 b=goc1c3XNmWqM30hP4toSaP8wIWup2zpJR/nY9iRf7lR7pgIaPnpF9Sc5v4CY8p1vZEUK
 gxMgxTjcyEo+rIpr1IMKZZeE0EgUp6r2Kny/3+/3YITUETubRk2n3BoXem0eRCmEtPEL
 1ee77hTfNl/3emjP8cl74I5uUkR+geeJwVPnL4o+p/Vnh3Lgm4oC3I32HJmI6NuRDxwR
 /ueMRq1HaLVVvdcFH3RuLpAHLKPpG8RIGAQcPE2p89Zq/KzR1WEkajrHrZk9Bu2vTdnE
 QRHmcP9aR4yHgbb1ZWKbZ4dUATIBXJOdlawUWg4xmcN/dsgmIyO2WF0yanJxj/mUry2H iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 381bevhcc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:01 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13JEfitM122536
        for <linux-integrity@vger.kernel.org>; Mon, 19 Apr 2021 11:02:01 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 381bevhcbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 11:02:01 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13JErVRp022784;
        Mon, 19 Apr 2021 15:02:00 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 37yqa8js8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 15:02:00 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13JF1w0F63374012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 15:01:58 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36A18136051;
        Mon, 19 Apr 2021 15:01:58 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6B71136055;
        Mon, 19 Apr 2021 15:01:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 15:01:57 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 5/6] libimaevm: Report unsupported filetype using log_err
Date:   Mon, 19 Apr 2021 11:01:50 -0400
Message-Id: <20210419150151.236409-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419150151.236409-1-stefanb@linux.ibm.com>
References: <20210419150151.236409-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bacz---jjVLPV-oLppagE9rYwcp7GGu2
X-Proofpoint-GUID: qDp4kywR2pOjcoeyRTAslIHDQ1ZHcU0V
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There's no errno set at this point so that using log_errno would
display something useful. Instead use log_error().

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index b40b6d8..06f1063 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -286,7 +286,7 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		err = add_dev_hash(&st, pctx);
 		break;
 	default:
-		log_errno("Unsupported file type");
+		log_err("Unsupported file type (0x%x)", st.st_mode & S_IFMT);
 		err = -1;
 		goto err;
 	}
-- 
2.30.2

