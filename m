Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00EF6E6929
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Apr 2023 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjDRQQT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Apr 2023 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjDRQQQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Apr 2023 12:16:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D13AC
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 09:16:08 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IFdjdh023583
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 16:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Xixctmug59dXz+qyQhiScPHYHKV7k4erIWhsqZ5W92o=;
 b=nlchz0FK8jK2q0jlE8pYy4lqCMBFjPmmUkqp+7QLzD19ec424L9/cw0nWV9mNkR8Ju5/
 JLpV0I2cu8qBU92HvaJDzC7JJNz0n9VXWKgptypB7kjH98n5Gj+qf4QN0POPeL4fBffJ
 Rafz7z9jltEHjirhNDU8aEZR1cIUv02FfYz2r/OHYhhpakedBvV1vY/Tf0KOlI8Vjw3R
 DDh1H1E0WvFGbgaMvXCnFrmmbA3HiWu2kb7ZNCgEg2muULk1XM1z/N6lJN3ZpAyFRQzP
 Jjtyn95hv6VWH3u8+vaNCPmFxiPiGH7WL6BsaJPp5cobLeP0l06P35FPgptiwL0BYVzm YQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1pww73dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 16:16:07 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33IFANBe024272
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 16:16:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3pykj7htxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 18 Apr 2023 16:16:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33IGG4oe4457008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 16:16:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3BDD58066;
        Tue, 18 Apr 2023 16:16:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 788AB58065;
        Tue, 18 Apr 2023 16:16:04 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Apr 2023 16:16:04 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils] Do not get 'generation' using ioctl when evm_portable is true
Date:   Tue, 18 Apr 2023 12:16:02 -0400
Message-Id: <20230418161602.86219-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3WA8yv1u--0DD4iPmWpUwqAkbwtDMim5
X-Proofpoint-ORIG-GUID: 3WA8yv1u--0DD4iPmWpUwqAkbwtDMim5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=934
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If a signatures is detected as being portable do not attempt to read the
generation with the ioctl since in some cases this may not be supported
by the filesystem and is also not needed for computing a portable
signature.

This avoids the current work-around of passing --generation 0 when the
ioctl is not supported by the filesystem.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 6d2bb67..c35a28c 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -376,7 +376,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 	if (mode_str)
 		st.st_mode = strtoul(mode_str, NULL, 10);
 
-	if (!evm_immutable) {
+	if (!evm_immutable && !evm_portable) {
 		if (S_ISREG(st.st_mode) && !generation_str) {
 			int fd = open(file, 0);
 
-- 
2.39.2

