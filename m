Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98178403FC6
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350441AbhIHTY4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:24:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350096AbhIHTYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J3Q2u148834
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eE7LCwVepiYDf0e/MBpG3qGqrvGnmpfNw+Ny02x+TOM=;
 b=D8H6wrdvGps0DEBwMQUtUFMfAtG3AWHxPt2NY25BZ2dHXoOpF5rkZYMsADgcC0JEH/o3
 N9AOo0etgLwWwEFv5oH5t2KwDmNGsHtAOpLIaTWKz4cT8xo7WDnajDBw4odARUA5kNbO
 Xzndr59kyo7x92jqMggVCl+Sg6/y040uwOItDKr3v461aPKRgyGtoN0YuXieb84YJgW4
 E3qet/IzUcMfg5DaLPUxT+5KG6buXiaLyU0/TugzrtXxZd2Yh8HTcz43kKj87N438nIy
 Ybd1pKK8SPoBbgG2HidXvw7ECrzFUoEYEwpvrynK2fkBp3ovNzltcw++WG8oVk3YYswp QA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ay2xwrddg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:47 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JI6kv022430
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3axcnqj3pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNjea18284990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D0DA11206B;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5064F112073;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 2/9] evmctl: Handle failure to initialize the openssl engine
Date:   Wed,  8 Sep 2021 15:23:36 -0400
Message-Id: <20210908192343.4147739-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VGnQD2JCRbBRfm2jPbW8-BPhYYVTJMFY
X-Proofpoint-ORIG-GUID: VGnQD2JCRbBRfm2jPbW8-BPhYYVTJMFY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=500
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Handle failure to initialize the openssl engine. For example,

$ ./src/evmctl --engine foo
engine foo isn't available
140322992015168:error:25066067:DSO support routines:dlfcn_load:could not load the shared library:crypto/dso/dso_dlfcn.c:118:filename(/usr/lib64/engines-1.1/foo.so): /usr/lib64/engines-1.1/foo.so: cannot open shared object file: No such file or directory
140322992015168:error:25070067:DSO support routines:DSO_load:could not load the shared library:crypto/dso/dso_lib.c:162:
140322992015168:error:260B6084:engine routines:dynamic_load:dso not found:crypto/engine/eng_dyn.c:414:
140322992015168:error:2606A074:engine routines:ENGINE_by_id:no such engine:crypto/engine/eng_list.c:334:id=foo
Segmentation fault (core dumped)

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

