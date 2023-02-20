Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4A469D1C6
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Feb 2023 18:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjBTRAe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Feb 2023 12:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBTRAc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Feb 2023 12:00:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67B9E3BF;
        Mon, 20 Feb 2023 09:00:31 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KG3XSt028165;
        Mon, 20 Feb 2023 17:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=CbJXhk0sld4b1qBn69aVBQube5W90uHQhPBbPjlZiTQ=;
 b=Llw6dvFoKSPJ9eDo7JzpB0JiHILO7R+qNZrisZNtg6GEhpNE1M5A87KgDcRKHU2u/UBm
 iloHEM4bbFPdvMHC0x6wzBoPOjESv6J550WIIp9KqDpA3gOinLFiucIH/hfaEp3NNULt
 7SGfl5slsfaDhc2ZfNb0eHbH552UnvyDQFHM4utrxOINtUX9uVzYpBAabWkESmyw3vHK
 x4gI+zmYauMtHrfE3pLge6t/eUqHNWlT/ZMLR1Yynt3m2EzQFjI7+Sz4VJ6sR3Q+uIHF
 LU1RkDxYKhqXpZfrzZI7mMk8yF9jroLEsr/NLbA13QBRr0SYHhBRJvKaDYaopoPIh7v1 MA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvc24h9qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 17:00:30 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KFJAnL023050;
        Mon, 20 Feb 2023 17:00:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa6p92h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 17:00:29 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KH0SOd25559790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 17:00:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A7F55806A;
        Mon, 20 Feb 2023 17:00:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8C835806B;
        Mon, 20 Feb 2023 17:00:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.169.160])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 17:00:27 +0000 (GMT)
Message-ID: <1c1482de9ab0573f0ca4bef0a47260026264e926.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: susbsytem updates for v6.3
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Feb 2023 12:00:26 -0500
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g8IM6t8TNWBDMLQV91K0rHedad2NCJOg
X-Proofpoint-ORIG-GUID: g8IM6t8TNWBDMLQV91K0rHedad2NCJOg
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_13,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Contains one of each doc and code cleanup, and two bug fixes (4
patches).

FYI, Stephen Rothwell is carrying a merge conflict with "fs: port xattr
to mnt_idmap" from the vfs-idmapping tree.

thanks,

Mimi

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.3

for you to fetch changes up to 4958db3245fa655bf18251bd2a83bcc164071c39:

  ima: Introduce MMAP_CHECK_REQPROT hook (2023-01-31 13:08:39 -0500)

----------------------------------------------------------------
integrity-v6.3

----------------------------------------------------------------
Matt Bobrowski (2):
      ima: fix error handling logic when file measurement failed
      ima: return IMA digest value only when IMA_COLLECTED flag is set

Randy Dunlap (1):
      ima: fix ima_delete_rules() kernel-doc warning

Roberto Sassu (2):
      ima: Align ima_file_mmap() parameters with mmap_file LSM hook
      ima: Introduce MMAP_CHECK_REQPROT hook

Xiu Jianfeng (1):
      evm: call dump_security_xattr() in all cases to remove code duplication

 Documentation/ABI/testing/ima_policy  |  2 +-
 include/linux/ima.h                   |  6 ++++--
 security/integrity/evm/evm_crypto.c   | 33 +++++++++++++++---------------
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_api.c      |  5 +++--
 security/integrity/ima/ima_appraise.c |  3 +++
 security/integrity/ima/ima_main.c     | 38 ++++++++++++++++++++++++++---------
 security/integrity/ima/ima_policy.c   |  7 ++++++-
 security/security.c                   |  7 ++++---
 9 files changed, 67 insertions(+), 35 deletions(-)

