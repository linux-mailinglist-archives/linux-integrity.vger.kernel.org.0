Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E314616AF
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 14:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhK2Nj0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 08:39:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343919AbhK2NhY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 08:37:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATDUqxu020358
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 13:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sxv2zgsxHurmsprdNbUPMAtRWZz+PBoQ7oKJDiywMeo=;
 b=RCWb/8jb7gx49jXKHc70eDfn+v2gnqJ4XOGsdCnziVW4h/qDqpsAsa9njQ2eWYSdmPX5
 jbhyfIj1ln10ZOJDY0cYli0Steq02sq2BU6etFXDpg3V7FUZw/DXBzbrMT8cmQ2WpPYm
 hXuuIVkr+mYcdIkRNanjqVLV3FYaMBa4mTCUOpePXmxmzZuUlBCZL2wHME1m+CSyFlue
 06IPf+vtPWJG0ik2+UV5YDhkHuKx7C1N/CuGf7Rl6IsgEdPtDNtKtHSoNXTl7eYgR8cw
 ky5JlHjVrYJ9gQFeFZFU8gfMKFQCObrszhoLJsM+rwv6w/nN//OnSpQnE4V8RqHFPlXE Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmytag24n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 13:34:06 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATDWc0S026630
        for <linux-integrity@vger.kernel.org>; Mon, 29 Nov 2021 13:34:06 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmytag249-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:34:06 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATDW6Es006786;
        Mon, 29 Nov 2021 13:34:05 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckcaa1uh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:34:05 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATDY4XY56099134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 13:34:04 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73854780D9;
        Mon, 29 Nov 2021 13:34:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71B7678205;
        Mon, 29 Nov 2021 13:34:01 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 13:34:01 +0000 (GMT)
Message-ID: <e94c0b3df28f23f89d71e546902c9f78b8facaa5.camel@linux.ibm.com>
Subject: [PATCH] fix iint inode add race resulting in duplication of iint
 entries
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Mon, 29 Nov 2021 08:34:00 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8ZKMSMR7kW0X1MrtNrO_L_5-IR-bFsvX
X-Proofpoint-GUID: cBp5akrSTOh7x7wFoMshLpqfTMAFoSg2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_08,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=792 phishscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290068
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The race happens when two threads try to lookup the iint entry for the
same inode at the same time.  The reason it happens is this pseudocode:

read_lock
lookup
read_unlock
write_lock
alloc_and_add
write_unlock

because the lookup is only protected by a read_lock, both racing
threads can execute the lookup code in parallel and conclude there's no
entry ... neither thread can get into the alloc_and_add code until the
other thread finishes and drops the read_lock, which then allows
promotion to the exclusive write lock.  Event though the alloc_and_add
will be serialized by the write lock, both threads will add an iint
entry for the same inode.

The fix for this is to do the lookup again under the exclusive lock, so
the last thread into the exclusive section will see the addition and
not do another alloc_and_add.

Signed-off-by: James Bottomley <jejb@linux.ibm.com>

---

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..eadc5890f4ec 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -116,6 +116,21 @@ struct integrity_iint_cache
*integrity_inode_get(struct inode *inode)
 
 	write_lock(&integrity_iint_lock);
 
+	/* 
+	 * unlikely race caused by two threads executing the lookup and
+	 * add simultaneously.  Because the lookup is under a read
+	 * lock, they can both execute that in parallel and both
+	 * conclude there's no entry for inode.  To prevent them then
+	 * both adding separate entries for the same inode we need to
+	 * perform the lookup again under the exclusive lock.
+	 */
+	test_iint = __integrity_iint_find(inode);
+	if (unlikely(test_iint)) {
+		write_unlock(&integrity_iint_lock);
+		kmem_cache_free(iint_cache, iint);
+		return test_iint;
+	}
+
 	p = &integrity_iint_tree.rb_node;
 	while (*p) {
 		parent = *p;

