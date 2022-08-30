Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2285A58B3
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 03:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiH3BAO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 21:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH3BAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 21:00:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83180F51
        for <linux-integrity@vger.kernel.org>; Mon, 29 Aug 2022 18:00:11 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U0o35E020048;
        Tue, 30 Aug 2022 01:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MQFo5LYv6BY+PUZ3R8QzbQ1PybhcmArSKoA+MLVN0ag=;
 b=NKs4w/NfnFORHxnzaAjgVU7C19hW6tzPROHJ8NwUbSTPUUd1FL4bJ/ok5w/4l9IG8SbE
 d5t5OsYp13dCFSXOa5RJGiwlGYm95nC9I8bTeSha16j0ah9/gQgn3kajii/FPKT87LFB
 mUrzoDxXQoYNGWjdyN1xYnYzQMXkaJEqwwxcA0VOhxqYyPOnoxme0i/+VYVKjD+pksCg
 g05UvvLX5I6hoo9+sVmLUO/AggF2ua7H5hRlnyETjoaPcvIJ7Eb1xKFDDZuwGoIrlHS9
 J8YQgijylu0uTxJ/CinEkiKMJ9pfHZGtAGOHDYdXCD+QbfK2KBLmmQI80G3XGi7anvfn Cg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j98bn8akd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:00:07 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U0oPwN013169;
        Tue, 30 Aug 2022 01:00:06 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3j7ahht5kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:00:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U102VV37814582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 01:00:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A514A404D;
        Tue, 30 Aug 2022 01:00:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EB25A4040;
        Tue, 30 Aug 2022 01:00:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.117.120])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 01:00:00 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH ima-evm-utils 10/11] Limit the file hash algorithm name length
Date:   Mon, 29 Aug 2022 20:59:35 -0400
Message-Id: <20220830005936.189922-11-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830005936.189922-1-zohar@linux.ibm.com>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ivct-V-iNSQn4L2kW38rjfJ6dQM1d25P
X-Proofpoint-GUID: ivct-V-iNSQn4L2kW38rjfJ6dQM1d25P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=969 suspectscore=0
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

Instead of assuming the file hash algorithm is a properly NULL terminated
string, properly limit the "algo:<hash>" field size.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 4bdc62d2e2e4..4619bb433926 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1603,7 +1603,7 @@ void ima_ng_show(struct template_entry *entry)
 	total_len -= sizeof(field_len);
 
 	algo = (char *)fieldp;
-	len = strlen(algo) + 1;
+	len = strnlen(algo, field_len - 1) + 1;
 	digest_len = field_len - len;
 	digest = fieldp + len;
 
-- 
2.31.1

