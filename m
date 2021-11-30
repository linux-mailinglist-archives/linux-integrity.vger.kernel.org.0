Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920FA463B1F
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Nov 2021 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbhK3QLT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Nov 2021 11:11:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243424AbhK3QK7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Nov 2021 11:10:59 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUFkUiJ019688;
        Tue, 30 Nov 2021 16:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Pek8epzdzpxEN+nG+RHo3egO/gaDeVYufYkeMvLUIRs=;
 b=QnelxNu4j35G5zTKjoag8QXMWVhSQ8WR1ew6AHd33oecF4e7fG3ZzyrCty7nqHC3j28Z
 tKoTLQJo/oUG+R/SwbIJCDcs8h6mFxFY6Xjv9p0KNLIqQ2qgKmYZ1TkDIWNoXd99Vx0C
 Oq2R4k8g/5Kxbljp5Y176uFaB7qJwdJyk0p57642h6pMOvPVw8SPlcYNcXjH/8S5dWj2
 1PGxupV8/gIiV5LeMu7HwhNm0MJvI6iM7lJiauoy/OH4vbVLRl2CGySz7ufmZYiM7TdB
 O1sf6t2iWVuvX51BQqSQrQgKMPEf/IxCcp7W9GCSpbuo5WZ/aq4LfdYLNSegqMhgX3XS aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpw4ghw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:18 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AUFkbhA020557;
        Tue, 30 Nov 2021 16:07:18 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnpw4ghvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:18 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUG2pjQ024657;
        Tue, 30 Nov 2021 16:07:17 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne1b9w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 16:07:17 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUG7EHu59638096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 16:07:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CEF6B2091;
        Tue, 30 Nov 2021 16:07:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C831B209D;
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
Subject: [RFC 18/20] userns: Introduce a refcount variable for calling early teardown function
Date:   Tue, 30 Nov 2021 11:06:52 -0500
Message-Id: <20211130160654.1418231-19-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211130160654.1418231-1-stefanb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IdUt_42I6xN2R1XhEQtzjqW8TvUljqUf
X-Proofpoint-ORIG-GUID: Oa9jrwP7tsZsJGTmELVq0ff96JbTOkYY
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

Extend the user_namespace structure with a refcount_teardown variable to
cause an early teardown function to be invoked. This allows the IMA
namespace to initialize a filesystem that holds one additional reference
to the user namespace it 'belongs' to. Therefore, the refount_teardown
variable will be incremented by '1' once that additional reference has
been created. Once the user namespace's reference counter is decremented
to '1', this early teardown function is invoked and the additional user
namespace reference released and the actual deletion of the user
namespace can then proceed as usual.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/user_namespace.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 5249db04d62b..505e3b3748b6 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -103,6 +103,11 @@ struct user_namespace {
 #ifdef CONFIG_IMA
 	struct ima_namespace	*ima_ns;
 #endif
+	/* The refcount at which to start tearing down dependent namespaces
+	 * (currently only IMA) that may hold additional references to the
+	 * user namespace.
+	 */
+	unsigned int            refcount_teardown;
 } __randomize_layout;
 
 struct ucounts {
@@ -156,8 +161,12 @@ extern void __put_user_ns(struct user_namespace *ns);
 
 static inline void put_user_ns(struct user_namespace *ns)
 {
-	if (ns && refcount_dec_and_test(&ns->ns.count))
-		__put_user_ns(ns);
+	if (ns) {
+		if (refcount_dec_and_test(&ns->ns.count))
+			__put_user_ns(ns);
+		else if (refcount_read(&ns->ns.count) == ns->refcount_teardown)
+			;
+	}
 }
 
 struct seq_operations;
-- 
2.31.1

