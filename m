Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585145AF518
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiIFTzU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 15:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiIFTxR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 15:53:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BFDB1BB5
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 12:50:59 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JH0Hc003025;
        Tue, 6 Sep 2022 19:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N69wR1mV5qKCMCs9CYE76RAoJOz2SKx2OwoLJjJCodk=;
 b=JGuI+iUNHt9HiCwvq5ia3rP2A+/YQQpMDiuuwODdx5l5tysaoB+ii02bNknM6vwKBFo4
 AexKPCdZeEASqnj9EyXnJRCaX7SGssHT/B6YZ0SjXDbmH8AhAXuJ3K9N0pb+KWYR5aRc
 JscA463XpNWyNk2jKWeEhF3F2MBjs9pWlR1I0LrBpjhTpakWztdfq72dFyCo55QW9gbO
 bYwZTnv4joGAE2zEXk37Yp4o5hY0LaVtuI2hkaRVinuuASkYeNbeUHSkXMPWX4pIcSTw
 jwei0fn5VVRMIVkW53SWV2c9iuOdO9BUyLg1cKEU+UOO5S7NfZ8swr0wIPP0oQX7M5df 4A== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jec7t0uc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:54 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286Jol93001138;
        Tue, 6 Sep 2022 19:50:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3jbxj8u380-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286Jom2s39584186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:50:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A86A411C04C;
        Tue,  6 Sep 2022 19:50:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E01711C04A;
        Tue,  6 Sep 2022 19:50:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.107.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:50:47 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 10/12] Limit the file hash algorithm name length
Date:   Tue,  6 Sep 2022 15:50:19 -0400
Message-Id: <20220906195021.854090-11-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906195021.854090-1-zohar@linux.ibm.com>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y4tb5AdBuLShkPX3SUNbT6M5yOV0lcxk
X-Proofpoint-GUID: Y4tb5AdBuLShkPX3SUNbT6M5yOV0lcxk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Instead of assuming the file hash algorithm is a properly NULL terminated
string, properly limit the "algo:<hash>" field size.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index a497b1a468d6..aac669438a1c 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1602,7 +1602,7 @@ void ima_ng_show(struct template_entry *entry)
 	total_len -= sizeof(field_len);
 
 	algo = (char *)fieldp;
-	len = strlen(algo) + 1;
+	len = strnlen(algo, field_len - 1) + 1;
 	digest_len = field_len - len;
 	digest = fieldp + len;
 
-- 
2.31.1

