Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9D54FD6F
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jun 2022 21:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiFQTVq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jun 2022 15:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiFQTVp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jun 2022 15:21:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B863496BE
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jun 2022 12:21:43 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HJFxn2013050;
        Fri, 17 Jun 2022 19:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5eCsl6N8+9NHbzUTxkSPIb1BB3eag/NnwGdgPuTTbig=;
 b=ibDq1dv2N/BA5imJNt9+8RK/02bppZJepyRrOpu2wBbXUilU+unzeLe92jEcW4Pwaq3Q
 JX22XQG2ptYl45qHq+c5Dxz0aWHk+583EtUNkj/i9oriK9u5YrjLdFOWXl9l7ndYULe1
 LlGcDaAVHjF46BoL8zUIB1OmY0I45NlbhLi50LeqZfPXnxaGvBQsf8VtLLFqwcU9uJvv
 vkvXC+2h6WAgZoWRaWvnb+ha1Q1qVXSmslPeZc+mPUEXB5iOQQDF1JlRKFmq/yvSh38V
 j+UvFSZWBmDiSMsdpRK7jCoQLJQcbuPVsz9acLQJTOm6C3lhOdGwwbKeovv+wm/kofFs Ag== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gryma843w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 19:21:34 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25HJ69np030690;
        Fri, 17 Jun 2022 19:21:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3gmjp8y657-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 19:21:32 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25HJLTET15729094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 19:21:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76B1AA4053;
        Fri, 17 Jun 2022 19:21:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3190A4040;
        Fri, 17 Jun 2022 19:21:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.64.10])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jun 2022 19:21:28 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 ima-evm-utils 0/3] fs-verity file signature support
Date:   Fri, 17 Jun 2022 15:21:04 -0400
Message-Id: <20220617192107.270865-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zSQMYDXhRlOf0VuWHWigDvanjzhQmHHx
X-Proofpoint-ORIG-GUID: zSQMYDXhRlOf0VuWHWigDvanjzhQmHHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-17_13,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170083
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

Changelog v4:
- Addressed Stefan's comments (e.g. fixed max digest size, removed
  unnecessary errno clearing, updated evmctl sign_hash usage format).

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
 4 files changed, 268 insertions(+), 32 deletions(-)

-- 
2.27.0

