Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF994AB330
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Feb 2022 02:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347971AbiBGBwc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Feb 2022 20:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiBGBwc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Feb 2022 20:52:32 -0500
X-Greylist: delayed 8379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 17:52:31 PST
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82270C061A73;
        Sun,  6 Feb 2022 17:52:31 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216MOF4L005276;
        Sun, 6 Feb 2022 23:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=UuP/8S3/SKQ4IbTOycySOWXhpmyFsZS5NE7Z1KSmSjU=;
 b=VxMn9GAzXhdH+Aw/2MJhw848lpmxnM8kVZ6hHDMDmmEYHCwcpvffppX8aya8LPj+LEhC
 AFHvbBPal6K0JEmeiS+Qd6ZVN4BethMaLPiD1KwRp/R7f73nCNi1iqMVOxnU0MHss3dV
 GeQwl87T1JBT2e+cpr3yYDcCNFQ2sRNhbusNm9CYBB7rQWAiKzJtiOXXnWVLVhAFFBVB
 G9/i9CHBn2XfojSzZuDir+67HfPdTs0TH0h02efg9VsTt6dzbU7EqivLfR0Yxvc8QjO4
 9ve4UYTjYF6eHhO27/EYgy75yqd3/8dIk9gpEMRLGWuu4eveGU6YUDGYeu1dl4tNNksN QQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22m5eeys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 23:32:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 216NWSoQ001044;
        Sun, 6 Feb 2022 23:32:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv8y9ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 23:32:48 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 216NWkd148628178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Feb 2022 23:32:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E6C1A4040;
        Sun,  6 Feb 2022 23:32:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98C7DA404D;
        Sun,  6 Feb 2022 23:32:45 +0000 (GMT)
Received: from sig-9-65-78-117.ibm.com (unknown [9.65.78.117])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Feb 2022 23:32:45 +0000 (GMT)
Message-ID: <3a988ebfffe725e3172a6850c3b2b603d16c2330.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v5.17
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 06 Feb 2022 18:32:45 -0500
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z0qb66HVzRdQY2Plmb2OSJgYTHgmgv8N
X-Proofpoint-ORIG-GUID: z0qb66HVzRdQY2Plmb2OSJgYTHgmgv8N
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-06_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202060169
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

These are fixes for recently found bugs.  One was found/noticed while
reviewing IMA support for fsverity digests and signatures.  Two of them
were found/noticed while working on IMA namespacing.  Plus two other bu
gs.  All of them are for previous kernel releases.

thanks,

Mimi

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.17-fix

for you to fetch changes up to 89677197ae709eb1ab3646952c44f6a171c9e74c:

  ima: Do not print policy rule with inactive LSM labels (2022-02-02 11:59:54 -0500)

----------------------------------------------------------------
integrity-v5-17-fix

----------------------------------------------------------------
Eric Biggers (1):
      ima: fix reference leak in asymmetric_verify()

Roberto Sassu (1):
      ima: Allow template selection with ima_template[_fmt]= after ima_hash=

Stefan Berger (2):
      ima: Remove ima_policy file before directory
      ima: Do not print policy rule with inactive LSM labels

Xiaoke Wang (1):
      integrity: check the return value of audit_log_start()

 security/integrity/digsig_asymmetric.c | 15 +++++++++------
 security/integrity/ima/ima_fs.c        |  2 +-
 security/integrity/ima/ima_policy.c    |  8 ++++++++
 security/integrity/ima/ima_template.c  | 10 +++++++---
 security/integrity/integrity_audit.c   |  2 ++
 5 files changed, 27 insertions(+), 10 deletions(-)

