Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108F5883D0
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Aug 2022 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiHBVz1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Aug 2022 17:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiHBVzY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Aug 2022 17:55:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE0B860;
        Tue,  2 Aug 2022 14:55:22 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272LgH9P039301;
        Tue, 2 Aug 2022 21:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=ZUClRZRQuq6EHCQYU3U7eESI9G+COXc+kz0j9F8+w1g=;
 b=NYX16b5v/Ik53UW5vVD1mBaAwu2L9PYG79Su+y18Q32HUeUbrF9DnsQbB5dcur0LaRB/
 fdmNXstdkYjpBaryOHFVq4AR99MsI9llSKtjKwdxP/unqjXOhCTPqrSoInyFUIvc/y1R
 8wi0fb9IarzbvnjIc2drzp4Ee/Z7ytpNz2nLTGhWmYvJG/z0jgEX8nC8MmZDsVoEm3OK
 bxytzrQ6tBQ0gMkwKTSIFpn4ODt72aDMfZacg+idgqzr9iTjfrxIF53NMCMVcXuxXhXc
 89aV2ukb+G5BIZj6CaWNbRsuOEFYwmt/fvM9WmjynStw0ihCkE6ZzFo/83wnxRlFJHmp WA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hqc2kra3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 21:55:21 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 272Lq03L010575;
        Tue, 2 Aug 2022 21:55:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3hmv98k2ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 21:55:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 272LtGB427459938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Aug 2022 21:55:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D78EAE045;
        Tue,  2 Aug 2022 21:55:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54324AE055;
        Tue,  2 Aug 2022 21:55:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.57.126])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Aug 2022 21:55:15 +0000 (GMT)
Message-ID: <04e413ed5db93479848f1127a1a664a03df3bd2b.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v6.0
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 02 Aug 2022 17:55:14 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gLgRNN1iMUuPKo54JaUixhbD-BzHAcuN
X-Proofpoint-ORIG-GUID: gLgRNN1iMUuPKo54JaUixhbD-BzHAcuN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=768 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2208020100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Aside from the one EVM cleanup patch, all the other changes are kexec
related.

On different architectures different keyrings are used to verify the
kexec'ed kernel image signature.  Here are a number of preparatory
cleanup patches and the patches themselves for making the keyrings -
builtin_trusted_keyring, .machine, .secondary_trusted_keyring, and
.platform - consistent across the different architectures.

The root of trust for the different keyrings was described in the cover
letter and is retained in the merge message.

Note: Stephen is carrying a merge conflict patch with
commit 68b8e9713c8e ("x86/setup: Use rng seeds from setup_data").

thanks,

Mimi

The following changes since commit 067d2521874135267e681c19d42761c601d503d6:

  ima: Fix potential memory leak in ima_init_crypto() (2022-07-13 10:13:58 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.0

for you to fetch changes up to 88b61b130334212f8f05175e291c04adeb2bf30b:

  Merge remote-tracking branch 'linux-integrity/kexec-keyrings' into next-integrity (2022-07-26 15:58:49 -0400)

----------------------------------------------------------------
integrity-v6.0

----------------------------------------------------------------
Coiby Xu (3):
      kexec: clean up arch_kexec_kernel_verify_sig
      kexec, KEYS: make the code in bzImage64_verify_sig generic
      arm64: kexec_file: use more system keyrings to verify kernel image signature

Michal Suchanek (1):
      kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification

Mimi Zohar (1):
      Merge remote-tracking branch 'linux-integrity/kexec-keyrings' into next-integrity

Naveen N. Rao (2):
      kexec_file: drop weak attribute from functions
      kexec: drop weak attribute from functions

Xiu Jianfeng (1):
      evm: Use IS_ENABLED to initialize .enabled

 arch/arm64/include/asm/kexec.h        | 18 +++++++-
 arch/arm64/kernel/kexec_image.c       | 11 +----
 arch/powerpc/include/asm/kexec.h      | 14 ++++++
 arch/s390/include/asm/kexec.h         | 14 ++++++
 arch/s390/kernel/machine_kexec_file.c | 18 +++++---
 arch/x86/include/asm/kexec.h          | 12 +++++
 arch/x86/kernel/kexec-bzimage64.c     | 20 +--------
 include/linux/kexec.h                 | 82 +++++++++++++++++++++++++++++-----
 kernel/kexec_core.c                   | 27 ------------
 kernel/kexec_file.c                   | 83 +++++++++++++----------------------
 security/integrity/evm/evm_main.c     | 52 ++++++++++------------
 11 files changed, 195 insertions(+), 156 deletions(-)

