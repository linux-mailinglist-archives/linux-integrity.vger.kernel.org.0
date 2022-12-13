Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8572964BDE3
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Dec 2022 21:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiLMUYq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 15:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbiLMUYR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 15:24:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683E527DD5;
        Tue, 13 Dec 2022 12:20:09 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDJXNTZ008119;
        Tue, 13 Dec 2022 20:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=zkFJ3+RBL9CmYP4LHNdAMRtSER55VO4d7qnzzXFPKNk=;
 b=iQj1lFJYrYi3TfvtvGYK8oLXUNAD5Yr8YkUwnpdzDiuaqeZ9sW89BKfAue4GwRFYB3E7
 UssIwnzdMvVyzCMwhBscGyiNZhhuKyJFDhvUZsuLY+c+nEVxhDqi+zk75uS5WFb/hDyB
 1jDZ7cxIP5ZhTGvYOEOUJ5aUzNXL6SMjHdGJ0X0scXdcc0EmTnuJeAIaX88lbtN+THvM
 LsopWvzAFE7oXbDgNwespQPPar4DooRsLonGWOgWah7v48j+13h08szh41JaRaDnnoue
 ItYAq6whStiHQnfBH8pVuP47gsOIu4e31D398fOCwdzJ3jzDi0sThC8+HkGuDDT0NMEC 3g== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3meyn5h2e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 20:20:08 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDJsrKe011789;
        Tue, 13 Dec 2022 20:20:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3meyyhg6j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 20:20:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDKK5UQ36110628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 20:20:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62FB958062;
        Tue, 13 Dec 2022 20:20:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 805D358054;
        Tue, 13 Dec 2022 20:20:04 +0000 (GMT)
Received: from sig-9-65-192-247.ibm.com (unknown [9.65.192.247])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 20:20:04 +0000 (GMT)
Message-ID: <7b388195aa5e10f1da934ed251809a6f21bf427e.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: susbsytem updates for v6.2
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 13 Dec 2022 15:20:04 -0500
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lOsr9YuEthwvn5bDQEn4nApY5vUhZzy-
X-Proofpoint-GUID: lOsr9YuEthwvn5bDQEn4nApY5vUhZzy-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212130175
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Aside from the one cleanup, the other changes are bug fixes:

Cleanup:
- Include missing iMac Pro 2017 in list of Macs with T2 security chip

Bugs:
- Improper instantiation of "encrypted" keys with user provided data
- Not handling delay in updating LSM label based IMA policy rules (-
ESTALE)
- IMA and integrity memory leaks on error paths
- CONFIG_IMA_DEFAULT_HASH_SM3 hash algorithm renamed

thanks,

Mimi

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.2

for you to fetch changes up to b6018af440a07bd0d74b58c4e18045f4a8dbfe6b:

  ima: Fix hash dependency to correct algorithm (2022-11-28 16:44:34 -0500)

----------------------------------------------------------------
integrity-v6.2

----------------------------------------------------------------
Aditya Garg (1):
      efi: Add iMac Pro 2017 to uefi skip cert quirk

GUO Zihua (3):
      ima: Simplify ima_lsm_copy_rule
      ima: Handle -ESTALE returned by ima_filter_rule_match()
      integrity: Fix memory leakage in keyring allocation error path

Huaxin Lu (1):
      ima: Fix a potential NULL pointer access in ima_restore_measurement_list

Nikolaus Voss (1):
      KEYS: encrypted: fix key instantiation with user-provided data

Roberto Sassu (1):
      ima: Fix memory leak in __ima_inode_hash()

Tianjia Zhang (1):
      ima: Fix hash dependency to correct algorithm

Xiu Jianfeng (1):
      ima: Fix misuse of dereference of pointer in template_desc_init_fields()

 Documentation/security/keys/trusted-encrypted.rst |  3 +-
 security/integrity/digsig.c                       |  6 ++-
 security/integrity/ima/Kconfig                    |  2 +-
 security/integrity/ima/ima_main.c                 |  7 +++-
 security/integrity/ima/ima_policy.c               | 51 ++++++++++++++++-------
 security/integrity/ima/ima_template.c             |  9 ++--
 security/integrity/platform_certs/load_uefi.c     |  1 +
 security/keys/encrypted-keys/encrypted.c          |  6 +--
 8 files changed, 59 insertions(+), 26 deletions(-)


