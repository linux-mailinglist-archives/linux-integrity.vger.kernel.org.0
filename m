Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C54F5B7EFE
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiINCaZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiINCaV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0647F422DB
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:19 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E2N6rw012539;
        Wed, 14 Sep 2022 02:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vFzrvy6J8AxzpUCFd4MxvVPUHJ0f5ocdHDnZ0khOy9A=;
 b=I1yZ5K0secVljaduwYoHiYBP6UzECSB/XkLizKwmf8odozBVlfPoSNdoDqaN3Q0GUUnJ
 1JUaGRaEa+BJDJBXkrURMsLYW5PaLNIYtdQXh1qJk/9iIj4kYhGKs6Y2XWfnNU0Fzqb7
 Ux1AFWdX/PHtT7HTA9T9Ig7oyi7Nynu7MM0uvssRNFkokeHaNRPOdbGB+djfTYslEy6o
 pf0V9z1Y4yzz6k3syy8qyq8yvSXiuf718L9gaUIWbXNqwV0rZPWdicQCgWPWdTwzU/fD
 6LTMhOsunw5doRQgZ376BQF0C+g8kPPYu0DimVrZePuiCfpuyW2AbT44YLuGnp9+Ewib Zw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk64fr3j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:15 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2LTmS006611;
        Wed, 14 Sep 2022 02:30:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3jjymmr82f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:13 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2UAR535586420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:30:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83E9EA4040;
        Wed, 14 Sep 2022 02:30:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C08EAA404D;
        Wed, 14 Sep 2022 02:30:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:09 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 10/15] Missing template data size lower bounds checking
Date:   Tue, 13 Sep 2022 22:29:51 -0400
Message-Id: <20220914022956.1359218-11-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zn1OVSRdpR11HsomMnFKsQFAva8aPcqc
X-Proofpoint-ORIG-GUID: zn1OVSRdpR11HsomMnFKsQFAva8aPcqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Each record in the IMA measurement list must contain some template data.
Ensure the template data is not zero length.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 9dfbb2373997..d3f8eac26362 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2189,6 +2189,10 @@ static int ima_measurement(const char *file)
 				log_err("Unable to read template length\n");
 				goto out;
 			}
+			if (entry.template_len == 0) {
+				log_err("Invalid template data len\n");
+				goto out;
+			}
 		} else {
 			entry.template_len = SHA_DIGEST_LENGTH +
 					     TCG_EVENT_NAME_LEN_MAX + 1;
-- 
2.31.1

