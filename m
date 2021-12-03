Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A64466FF8
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378248AbhLCCgX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:36:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378250AbhLCCfZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:25 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B30xTwF026830;
        Fri, 3 Dec 2021 02:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Pek8epzdzpxEN+nG+RHo3egO/gaDeVYufYkeMvLUIRs=;
 b=qaK6fd93h70wOQ5s23gCl6n9+N1jS2Y5NThzJU+RqwmRgaXp1SAchVq9aHyWNW37Pr+0
 KO2LlNdt21Ofc3UdeAMr8OzYYaIilZaOwaL6d5bnnarRGkeADg0U+Hwzx+KMGCGKjlkg
 M+kTINkzbZuqW4BGCsbqAChwm3UM3mlFyIPe3QLymNFOMOk2kTr4CHrT09yLrhH0YMw0
 ia1qeK4b3pHTHeF1UYhwtCzYr/6R25tK+63QJ3EPcAVG8Y517fCKZvoRCU34hWZ/AwMO
 /rtwDyQF9fCL8qEuB0j0OpmgciQPBcQXMdrbVc7jcuFEAG2rhVS9HzJdBFWcv5TiqLy1 sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq551a3jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:51 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B32NNuM013660;
        Fri, 3 Dec 2021 02:31:50 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq551a3hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:50 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32RGnP000848;
        Fri, 3 Dec 2021 02:31:49 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3ckcadbg6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:49 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32Vl3L22414068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:47 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A7A6E059;
        Fri,  3 Dec 2021 02:31:47 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F00B16E0A0;
        Fri,  3 Dec 2021 02:31:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:45 +0000 (GMT)
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
Subject: [RFC v2 17/19] userns: Introduce a refcount variable for calling early teardown function
Date:   Thu,  2 Dec 2021 21:31:16 -0500
Message-Id: <20211203023118.1447229-18-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZElXuD_ipTo2EseKxRF5KZI3dS5IPQZ5
X-Proofpoint-ORIG-GUID: MBMzrgtleyLS5kLZA-3iZtIK3JZx8Oyo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_01,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030014
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

