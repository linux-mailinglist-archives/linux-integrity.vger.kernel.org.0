Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFA05F359B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Oct 2022 20:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJCS1X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Oct 2022 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJCS1W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Oct 2022 14:27:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222812E6A9;
        Mon,  3 Oct 2022 11:27:19 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293HM78G030805;
        Mon, 3 Oct 2022 18:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=ZCu/P1XmHl6fcKfQ+R4WbT1BU0+smgIEhLwbpCZSzrw=;
 b=riy1VPC39gJQtML+/ForMivMBt8C2HVAw2qhtgpnV9gM4SNN2gen7FyxMqSPFXn7gjJk
 aKYchrH++qbmq2cOJ92ejCiZDIZzAeRUdam4h+wtY6RHzWw7H6wDuJWnvrO7DGHWIbFl
 fWIT2PaqpnoJ61ADB/wTi/QOHUfr+pE54t4Xqgx507lHHo0FhEo86IXeE7gTPiSmBXnP
 3JBLxxDTAbsXCvBDGJRf3HX1MYwobbdUOfwDJT76qe9nFPLV3yee13RXrtesTtaW+ziJ
 50tRViJFWm3w68FUhOTLSwlovLyAnr/+9f+qoix/BryGgPNSTQs0I0LrdW+NsUhvPbCf aQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k02u04b52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 18:27:18 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 293IKxps018310;
        Mon, 3 Oct 2022 18:27:18 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 3jxd69evqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 18:27:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 293IRG4C16122374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Oct 2022 18:27:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0E195803F;
        Mon,  3 Oct 2022 18:27:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0C8058061;
        Mon,  3 Oct 2022 18:27:16 +0000 (GMT)
Received: from sig-9-65-200-240.ibm.com (unknown [9.65.200.240])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Oct 2022 18:27:16 +0000 (GMT)
Message-ID: <fc8f279ee3ac05e8adbaf10974bf8eda57824f57.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: susbsytem updates for v6.1
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 03 Oct 2022 14:27:16 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JccGLjbXGvTQOZUhSPMWg_BuCWVL0fG6
X-Proofpoint-GUID: JccGLjbXGvTQOZUhSPMWg_BuCWVL0fG6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210030109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Just two bug fixes.

Thanks,

Mimi

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.1

for you to fetch changes up to bab715bdaa9ebf28d99a6d1efb2704a30125e96d:

  efi: Correct Macmini DMI match in uefi cert quirk (2022-09-30 13:47:27 -0400)

----------------------------------------------------------------
integrity-v6.1

----------------------------------------------------------------
Mimi Zohar (1):
      ima: fix blocking of security.ima xattrs of unsupported algorithms

Orlando Chamberlain (1):
      efi: Correct Macmini DMI match in uefi cert quirk

 security/integrity/ima/ima_appraise.c         | 12 ++++++++----
 security/integrity/platform_certs/load_uefi.c |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

