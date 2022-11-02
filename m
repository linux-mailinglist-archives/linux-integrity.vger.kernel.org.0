Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B63616CF6
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 19:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiKBSpu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 14:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiKBSpq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 14:45:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93412FC04
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 11:45:44 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2HbF31012222
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=O8FzKbrLowEeyWnss9jfAkBVmDdSEDb1KaVOR6P/gjU=;
 b=f3SBcTj59queLYt/2HOutq0AI6kNkpoo5wYQ+LZfZajpYcGZtGYVwqmgcZOYFluYrwkI
 /myMFlpCqxWO4OiZLkVK56BzF/CAdK75px3ARzyhjtCexeAEZYrYCUKxhg+rbfNRWaeg
 KKmr81AycI1ITjNhTwVnh01zuogoNkw1JFunCQphrHRSxs7X0yzqdoF7gvtqDXfNmsEO
 bOTYmlbmn3BBG/ImnOciUbjml3PZpL6NBhtcwfwOl1npkM9W+hMvu/xrVkxvhCyOkQNM
 jDe296xCBopn/omAc4onYd6oJDdPgtjGMKjCba+1+yYqj1aB2Ql3zX6eEbWfsDo5WTsD hA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkqxwywrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:44 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2IaFes004877
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:43 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 3kgut9vg92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2Ijesf14287384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 18:45:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D86B458059;
        Wed,  2 Nov 2022 18:45:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94BED58060;
        Wed,  2 Nov 2022 18:45:41 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 18:45:41 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v1 3/4] Add assert to ensure that algo_name in bank is set
Date:   Wed,  2 Nov 2022 14:45:33 -0400
Message-Id: <20221102184534.1075049-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102184534.1075049-1-stefanb@linux.ibm.com>
References: <20221102184534.1075049-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SXdhQmqm_74LgzCLbFni1KlY-qO7Wxyw
X-Proofpoint-GUID: SXdhQmqm_74LgzCLbFni1KlY-qO7Wxyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=828
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To avoid numerous warning messages from gcc 12.2.1 when compiling with
-fanalyzer, insert an assert to ensure that algo_name in each bank
is set. The assert resolves the following warnings:

evmctl.c:1998:30: warning: use of NULL where non-null expected [CWE-476] [-Wanalyzer-null-argument]
 1998 |                         if (!strcmp(tpm_banks[j].algo_name, alg)) {
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

evmctl.c: In function ‘ima_measurement’:
evmctl.c:2146:24: warning: use of NULL where non-null expected [CWE-476] [-Wanalyzer-null-argument]
 2146 |                     && strcmp(pseudo_padded_banks[c].algo_name, verify_bank)) {
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ‘ima_measurement’: events 1-2

evmctl.c: In function ‘cmd_ima_bootaggr’:
evmctl.c:2611:33: warning: use of NULL where non-null expected [CWE-476] [-Wanalyzer-null-argument]
 2611 |                 bootaggr_len += strlen(tpm_banks[i].algo_name) + 1;
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 4afc265..4f55fb6 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1723,6 +1723,7 @@ static struct tpm_bank_info *init_tpm_banks(int *num_banks)
 			if (!strcmp(default_algos[i], hash_algo_name[j]))
 				set_bank_info(&banks[i], hash_algo_name[j]);
 		}
+		assert(banks[i].algo_name);
 	}
 	return banks;
 }
-- 
2.38.1

