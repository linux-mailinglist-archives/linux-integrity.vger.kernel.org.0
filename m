Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9B973FBF6
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jun 2023 14:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjF0M2O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jun 2023 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjF0M2N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jun 2023 08:28:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A991999;
        Tue, 27 Jun 2023 05:28:09 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RCLIr3017495;
        Tue, 27 Jun 2023 12:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=1hU+vsd8h40bP1k4AwxoMoM9fqoy0vAXT2UYfeYQWPk=;
 b=LUxxHDZSpG+JL4J9nTS4MpJ+r1bQWOsWdMRwWaPZlEEDSbbd1vE3LDEYjOwdzQ16Y/Oe
 aNgcFzCXv/S/6J5SBoadihwliKf/dw87T3AbI18Rscr3llTAg6b3MoRVlLYeIHdkq4bk
 L4kH3tuzab0oULvXp32xBZrhA015e9CypgyjTWRW6dVL7uCTm7grYq9Tuynlj3JKOf++
 z8MyRp1iajzcmg1s/4V69BQIqOHnOvWdRqz7v7+otI7Qi0iqklFZmZ1WAomB2ldweANQ
 VumT94BWWvxDTWz2v6muoY0E04wUE7FTZPJ1B/cL67/PfJV+uNdNLojtoEEvPV/PPhcO Fg== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfypxg6ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 12:28:08 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35RAmZeF025152;
        Tue, 27 Jun 2023 12:28:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rdr45rgs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 12:28:07 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35RCS7ov42467824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 12:28:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1864F58056;
        Tue, 27 Jun 2023 12:28:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE6ED58052;
        Tue, 27 Jun 2023 12:28:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.149.212])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jun 2023 12:28:06 +0000 (GMT)
Message-ID: <bdea3a9112c28fd6c2c158a14b632f89dba53ac6.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: susbystem updates for v6.5
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Jun 2023 08:28:06 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YWHezjY4nM-U9l3gxhxld4C764K5tpps
X-Proofpoint-GUID: YWHezjY4nM-U9l3gxhxld4C764K5tpps
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=964 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Contains an i_version change, one bug fix, and three kernel doc fixes:

- Instead of IMA detecting file change by directly accesssing
i_version, it now calls vfs_getattr_nosec().

- The bug fix addresses a race condition when inserting a new node in
the iint rb-tree.

thanks,

Mimi

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.5

for you to fetch changes up to 95526d13038c2bbddd567a4d8e39fac42484e182:

  ima: Fix build warnings (2023-06-06 09:37:23 -0400)

----------------------------------------------------------------
integrity-v6.5

----------------------------------------------------------------
Jeff Layton (1):
      IMA: use vfs_getattr_nosec to get the i_version

Roberto Sassu (3):
      evm: Complete description of evm_inode_setattr()
      evm: Fix build warnings
      ima: Fix build warnings

Tianjia Zhang (1):
      integrity: Fix possible multiple allocation in integrity_inode_get()

 security/integrity/evm/evm_crypto.c |  2 +-
 security/integrity/evm/evm_main.c   |  4 +++-
 security/integrity/iint.c           | 15 +++++++++------
 security/integrity/ima/ima_api.c    |  9 ++++++---
 security/integrity/ima/ima_main.c   | 12 ++++++++----
 security/integrity/ima/ima_modsig.c |  3 +++
 security/integrity/ima/ima_policy.c |  3 ++-
 7 files changed, 32 insertions(+), 16 deletions(-)

