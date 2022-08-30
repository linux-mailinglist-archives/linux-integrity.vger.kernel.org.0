Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F415A58B1
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 03:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiH3BAM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 21:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiH3BAL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 21:00:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945572AC74
        for <linux-integrity@vger.kernel.org>; Mon, 29 Aug 2022 18:00:09 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U0o8H6020670;
        Tue, 30 Aug 2022 01:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9I21ak7dUQ1I9aeoGj2xC0fMsumeHmVwzq6M3jGf40w=;
 b=T2/St9GKIGFU0RHTpu13znb4lr83TjsovXwEPv9ZOS0cGWnwYeyG/n5dOjoBQ0kokUte
 kAIlc4w/u3JIglPYBjDL1GaYZG529x53+cJr3cdIUfKsHjpWXQpiprq8EVuCvJuCVCp/
 M78DJvdmUPN7thLLYETKNHEaTzD8DW3RL+lmDKFl7mKTSYwUWSnCZHRrAX3JjI3hsNHC
 I6ZRBD2WFHxe0k9i0o9bT1YoGHI3ok1hPDV6XlUQQySNNvRR6BZ/i89ql8OjGZNMIRxG
 1pAp98JVmsow4+clULIVn1q3lpNK6ljNjUu7wRiBqKbGfiYnMPApzcxnv/GWjY+6SCnY QA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j98bn8ahr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:00:06 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U0qtK0007819;
        Tue, 30 Aug 2022 01:00:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3j7aw8t5hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:00:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U100TV33161686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 01:00:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C695EA4051;
        Tue, 30 Aug 2022 01:00:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BE25A404D;
        Tue, 30 Aug 2022 00:59:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.117.120])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 00:59:59 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH ima-evm-utils 09/11] Fix potential use after free in read_tpm_banks()
Date:   Mon, 29 Aug 2022 20:59:34 -0400
Message-Id: <20220830005936.189922-10-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830005936.189922-1-zohar@linux.ibm.com>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7253Qkh1DEqEzkaEY1q7-jlFKyhBbUQl
X-Proofpoint-GUID: 7253Qkh1DEqEzkaEY1q7-jlFKyhBbUQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=850 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On failure to read TPM 2.0 bank PCRs 'errmsg' is not properly set to
NULL after being freed.  Fix potential use after free.

Fixes: 3472f9ba9c05 ("ima-evm-utils: read the PCRs for the requested TPM banks")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index ad96789f1984..4bdc62d2e2e4 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2076,6 +2076,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 				log_debug("Failed to read %s PCRs: (%s)\n",
 					  bank[i].algo_name, errmsg);
 				free(errmsg);
+				errmsg = NULL;
 				bank[i].supported = 0;
 			}
 		}
-- 
2.31.1

