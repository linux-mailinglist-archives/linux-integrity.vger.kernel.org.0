Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC95E52F039
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351018AbiETQLd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351544AbiETQLR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 12:11:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B250E165B0
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 09:11:16 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KFp76o017305;
        Fri, 20 May 2022 16:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rOO5rDkIAbnD9sFxvCAVF2Ffv2a/9exQolkAa7q6psQ=;
 b=BhS5lxNPCIGWcdKKI2/4v/Jeb2FcOx4B/POfD91KczhGSY8pmor2KPS0yWRFe06ShAsH
 QWBhkZtXF5n4H7HJpI0g5zokynaAMA3kGWWK6WGW4am83ceH1bJDcUb5CcydqkMuvZxc
 Qpmptw1XOGUSnsYJq3zp2PT/0ZhAS6DA5khTEghl2vYfraqLl1l2PoJ2+qgNAlKuWrFL
 jaGdX4817HASDEyUBJE1Ox664hL+/cuon7hZrWXzeahttqrcp0iBh0yRaffss4R4OBP3
 C0DCd7vZ7afS60H6R+Exjcgknte0fJ0pi4D64HJO91T5m8HdHBc63n+RRd7/dWpAggE3 Sw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6dyygcm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:11:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KFqxxd016003;
        Fri, 20 May 2022 16:11:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjh3pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:11:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KGB9wt51380568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 16:11:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E63152052;
        Fri, 20 May 2022 16:11:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.82.251])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 094985204E;
        Fri, 20 May 2022 16:11:08 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 ima-evm-utils 0/3] fs-verity file signature support
Date:   Fri, 20 May 2022 12:11:00 -0400
Message-Id: <20220520161103.373554-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PW-jG5ongDqdAHCYfBaz-ALe1FoXBUAI
X-Proofpoint-ORIG-GUID: PW-jG5ongDqdAHCYfBaz-ALe1FoXBUAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_04,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend the existing file list digest signing and the IMA measurement
list file signature verification to support the new sigv3 format
version.  Neither file digest signing nor signature verification
require calculating the fs-verity file digest.

evmctl examples of signing fs-verity file hashes and verifying the
fs-verity file signatures are included the respective patch
description.

Changelog v3:

- Refactor the existing file hash signing function so that both
signature format version 2 and 3 may use it.  Signature v2 directly
signs the file hash, while signature v3 indirectly signs the file hash.

- Addressed Stefan Berger's comments: properly clear errno, properly
limit the hash algorithm name size to address an out of bounds error.
Instead of allowing the maximum hash algorithm name size, use the
current fs-verity supported maximum hash algorithm size.

- Based on Eric Bigger's recommendation of using "fsverity digest"
instead of "fsverity measure", replaced all references.


Mimi Zohar (3):
  Reset 'errno' after failure to open or access a file
  Sign an fs-verity file digest
  Verify an fs-verity file digest based signature

 README          |   3 +-
 src/evmctl.c    | 126 ++++++++++++++++++++++++++++++------
 src/imaevm.h    |   5 +-
 src/libimaevm.c | 166 ++++++++++++++++++++++++++++++++++++++++++++----
 src/utils.c     |   5 +-
 5 files changed, 272 insertions(+), 33 deletions(-)

-- 
2.27.0

