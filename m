Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D107776940
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Aug 2023 21:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjHITxu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Aug 2023 15:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHITxr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Aug 2023 15:53:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F334E45;
        Wed,  9 Aug 2023 12:53:47 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379Jfo71029839;
        Wed, 9 Aug 2023 19:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+Ki1oKIwDxjtgyY+7vdefE9L5j5AW/bixMirZNbv5xM=;
 b=RYig7b3JKcphxWvSk4V6cjnpIs4hTyvTP/+LhgXsLheBOCBt8WzEoEldb/qhIJJv39Wn
 lWYdxKpO5gBr4UQJRx10MR/9x79xcme90ZRP5lfWiwmne05tfDU67KuVikzJVRC58kzn
 zqKw8je6PG3vf+mLmd5jUIGh3lF92ygFW7+WSwa/QNBo42GrEItDiOI3kuZg30mkHF0R
 x8rSfN06mWx/ejWpJRo6X6TMD5q+dPhl+MWPrzTr1V4H7djiszwRkVa09W/8VJghq0yh
 lJ05Ba4dww7g4DQwiekrY9GIdxJFv0HkOg5aKx8ia45LI/XyCn4957722ynWBdYLiF5N qw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sch06rc28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 19:53:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 379J33EA007552;
        Wed, 9 Aug 2023 19:53:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14ykjwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 19:53:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 379JrY1A61866344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 19:53:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFB1220040;
        Wed,  9 Aug 2023 19:53:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9E8820043;
        Wed,  9 Aug 2023 19:53:32 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.61.3.84])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  9 Aug 2023 19:53:32 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 2/6] integrity: ignore keys failing CA restrictions on non-UEFI platform
Date:   Wed,  9 Aug 2023 15:53:11 -0400
Message-Id: <20230809195315.1085656-3-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230809195315.1085656-1-nayna@linux.ibm.com>
References: <20230809195315.1085656-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vRcGcGXs0NjfjA2kNoxWOM8fnxaoISSN
X-Proofpoint-ORIG-GUID: vRcGcGXs0NjfjA2kNoxWOM8fnxaoISSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_17,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308090171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On non-UEFI platforms, handle restrict_link_by_ca failures differently.

Certificates which do not satisfy CA restrictions on non-UEFI platforms
are ignored.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/platform_certs/machine_keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index 7aaed7950b6e..389a6e7c9245 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -36,7 +36,7 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
 	 * If the restriction check does not pass and the platform keyring
 	 * is configured, try to add it into that keyring instead.
 	 */
-	if (rc && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+	if (rc && efi_enabled(EFI_BOOT) && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
 		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
 					 data, len, perm);
 
-- 
2.31.1

