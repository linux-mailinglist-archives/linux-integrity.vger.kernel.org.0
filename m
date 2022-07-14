Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C10657524F
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jul 2022 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239542AbiGNP6d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jul 2022 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiGNP6b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jul 2022 11:58:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EBA47B89;
        Thu, 14 Jul 2022 08:58:30 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EFlm7k028943;
        Thu, 14 Jul 2022 15:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=kXmdXReKKdFW2AYraqhD9Yzbo4c8roWakTadJ/BDm6E=;
 b=lCvUHziePSEmCW595qAtJHRxBSL8RXXYnQ43T5il0j2qB9WKCQg3QuJLtu4Xw8wHS0ZH
 QEQvbaLNMafreUnc56056nQoAajQ8VsoG7FvJoLWpxni0k903dpspwOoJ7E1XAo0aruH
 2Yu7FpM1Nkvq7c2C19e8y8SEZu/H48FvOlenSB+e5FaDPUYdxzVL0OifquiZi+iyxl66
 7xrgYxOi7Nyh4DUvR8MVAWAR12Q77DOntHtve0Fe3FkDK4E6scpvgeTAJ7zENWdHJ1CR
 YhRBhquwFfRzYH3UxWP927Azm9Z7jjpGWVZVAk5ahtNJDY657lHZlk2OHck8Is4xaRPV sQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hanyegbaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 15:58:29 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26EFpP9e016203;
        Thu, 14 Jul 2022 15:58:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3h71a8xnn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 15:58:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26EFwOps23003606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 15:58:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1CDE42041;
        Thu, 14 Jul 2022 15:58:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAC3B4203F;
        Thu, 14 Jul 2022 15:58:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.122.174])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jul 2022 15:58:23 +0000 (GMT)
Message-ID: <32baeee1b12e620693c10d89dac5a8c1de6d61a2.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v5.19
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Jul 2022 11:58:22 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CCHDKBfU3wm6pauBu8fIPHjR2HPp9sYb
X-Proofpoint-ORIG-GUID: CCHDKBfU3wm6pauBu8fIPHjR2HPp9sYb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_12,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Here are a number of fixes for recently found bugs.  Only "ima: fix
violation measurement list record" was introduced in the current
release.  The rest address existing bugs.

thanks,

Mimi

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.19-fix

for you to fetch changes up to 067d2521874135267e681c19d42761c601d503d6:

  ima: Fix potential memory leak in ima_init_crypto() (2022-07-13 10:13:58 -0400)

----------------------------------------------------------------
integrity-v5.19-fix

----------------------------------------------------------------
Coiby Xu (1):
      ima: force signature verification when CONFIG_KEXEC_SIG is configured

Huaxin Lu (1):
      ima: Fix a potential integer overflow in ima_appraise_measurement

Jianglei Nie (1):
      ima: Fix potential memory leak in ima_init_crypto()

Mimi Zohar (1):
      ima: fix violation measurement list record

Xiu Jianfeng (1):
      Revert "evm: Fix memleak in init_desc"

 include/linux/kexec.h                     |  6 ++++++
 kernel/kexec_file.c                       | 11 ++++++++++-
 security/integrity/evm/evm_crypto.c       |  7 ++-----
 security/integrity/ima/ima_appraise.c     |  3 ++-
 security/integrity/ima/ima_crypto.c       |  1 +
 security/integrity/ima/ima_efi.c          |  2 ++
 security/integrity/ima/ima_template_lib.c |  6 +++---
 7 files changed, 26 insertions(+), 10 deletions(-)

