Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8048463B1A
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbhK3QLS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 11:11:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243430AbhK3QK7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 11:10:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFkT7N019624;
        Tue, 30 Nov 2021 16:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MIVZzxjgMmeJCIdHNNw1iQwAyNiLWHTfl9Fay9tp2sE=;
 b=eZa1m56uK9ibsWII3iByxFLaq7op9RdiSYGZAvMooIdGy4HDBWrieIVZWmeyUIRxDjtZ
 k0flCmtioqacf2RykFQHVG6EUE6THjMp6lo/KUMFNq+K+AQgZW0hZ8Vdge5e6Y4p1gNF
 okFf6OlPeAPWOCtzZNkvrvuqGnFoFvFJwJAJRBAY5q26hV81NMsscuMxP5x8N3pphbaO
 /2NR4UduwnVyg0F9nlwR8w1AmphYLNdv3ph5mL4J3k+T6YFJSQh8FYVPaoTuJSaGCFSc
 yZruLvNBnmxN1tthYP4jOUofzEeUtM5nEp3yfqkec2b/eWW3OhhVSHgciy7tu29yWlYU ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpw4ghuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:17 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUFsvAP025794;
        Tue, 30 Nov 2021 16:07:16 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpw4ghu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:16 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUG41NO003119;
        Tue, 30 Nov 2021 16:07:15 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckcaayqvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:15 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUG7DE862390686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 16:07:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B249B206B;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11CF4B2066;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC 16/20] ima: Use ns_capable() for namespace policy access
Date:   Tue, 30 Nov 2021 11:06:50 -0500
Message-Id: <20211130160654.1418231-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130160654.1418231-1-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yJvZb5TsMfaBc7dBUXcRxBz_sYaD6KaH
X-Proofpoint-ORIG-GUID: AKdySvXM8bkdAToGzjx5LNn-ySfcQC_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_09,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Replace capable() with ns_capable() for IMA namespace policy access with
the CAP_SYS_ADMIN permission.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 6c86f81c9998..fd2798f2d224 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -393,7 +393,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!capable(CAP_SYS_ADMIN))
+		if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
-- 
2.31.1

