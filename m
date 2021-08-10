Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605D03E5C13
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241834AbhHJNqY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 09:46:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240201AbhHJNqX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 09:46:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADXqkM062055
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=01B8SOti6lGo9z51YJ3mxaZfPPvjdx1adyYsTq3D9WU=;
 b=oSkWgBsfaOjpOuyf1ainDDp+fygyi+fuy5g4ohDDuNIXBR4uN6YFbt5kY6I8V9sh8ohI
 TQlzQkasGC/DeoVPV6kNvLTCbB1ebLU73105APJIZvXDi8bTTFAagqr0zsugteNPhwQY
 EwD+Ty5F2DO5m1ncso6uCA6CNiyHNj1jyma0rs/rkAvxeSbIjHE3oliWttlmwErHkv5n
 iRF5NDAhgXFDqSAAGijvGCvYBZMM+8Put6VMXE3FQvLEjZRwSJ8DghBOuEivoqUwml/l
 HZxhglMvkY0AVO+XgTVsIqM+Are5lKy6xFyNcNsZOZDaGwxDmoUvzXM/onbVq5q6T5nU sQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3abt13hctn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:00 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ADhM3T030208
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3aapja1tfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ADjxxO40436168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 13:45:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F086B2089;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A048B2070;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Aug 2021 13:45:58 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/8] evmctl: Handle engine initialization properly
Date:   Tue, 10 Aug 2021 09:45:51 -0400
Message-Id: <20210810134557.2444863-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GVkUAFZT1AIMKhv5ML8a37YJWn_S1CUl
X-Proofpoint-GUID: GVkUAFZT1AIMKhv5ML8a37YJWn_S1CUl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=623 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Fix the following issue when passing a not available engine:

$ ./src/evmctl --engine foo
engine foo isn't available
140322992015168:error:25066067:DSO support routines:dlfcn_load:could not load the shared library:crypto/dso/dso_dlfcn.c:118:filename(/usr/lib64/engines-1.1/foo.so): /usr/lib64/engines-1.1/foo.so: cannot open shared object file: No such file or directory
140322992015168:error:25070067:DSO support routines:DSO_load:could not load the shared library:crypto/dso/dso_lib.c:162:
140322992015168:error:260B6084:engine routines:dynamic_load:dso not found:crypto/engine/eng_dyn.c:414:
140322992015168:error:2606A074:engine routines:ENGINE_by_id:no such engine:crypto/engine/eng_list.c:334:id=foo
Segmentation fault (core dumped)

Also, jump to the exit when the setup of the engine failed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 58f8e66..ed0ece3 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2765,7 +2765,10 @@ int main(int argc, char *argv[])
 				ENGINE_free(eng);
 				eng = NULL;
 			}
-			ENGINE_set_default(eng, ENGINE_METHOD_ALL);
+			if (eng)
+				ENGINE_set_default(eng, ENGINE_METHOD_ALL);
+			else
+				goto error;
 			break;
 		case 140: /* --xattr-user */
 			xattr_ima = "user.ima";
@@ -2839,6 +2842,7 @@ int main(int argc, char *argv[])
 			err = 125;
 	}
 
+error:
 	if (eng) {
 		ENGINE_finish(eng);
 		ENGINE_free(eng);
-- 
2.31.1

