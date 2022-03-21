Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA54E301E
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Mar 2022 19:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiCUSjh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Mar 2022 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbiCUSje (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Mar 2022 14:39:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A882513D72;
        Mon, 21 Mar 2022 11:38:06 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LGYZot030368;
        Mon, 21 Mar 2022 18:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=ynd1VaU6isawdUuAeHBM2vaeCiIL3/aGKa8zxkUPI3Q=;
 b=p8EU+x6lVJ1HLWC2LoL2Aj3q7/0pwlUkxCo4Mo91ZbBMwFmreEtwIPqeVOODFVdAcVP/
 s86jmVlZnMQ9xHA9YP3rt8GLkcr8Ixkiv2tj6HTzk4t+BrA3x7ovmWNNuMxeIImSnXhU
 QFU81TqeqG70FLBAyCh2+czs+DdnzpOO8bVhFknmQtI/oVG5kyaF/+29yJfTtuwXohKW
 dat8oGz+ya9SysoBdXjTHdU5FYpTjS1WdzgROP9E/EH0LApEnas5KEJJu9h8L6iAdw/F
 tg/wEMVa8fO8wv1gIgxeaqdCBotaQoa1eN1XgXxS0cZSJhvuCxDdRKB3QRDz6rcWuZRW Uw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3exf1v35h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 18:38:04 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22LIXhQo023268;
        Mon, 21 Mar 2022 18:38:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3ew6ehuxs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 18:38:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22LIQLkP34341242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 18:26:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 930F25204F;
        Mon, 21 Mar 2022 18:38:00 +0000 (GMT)
Received: from sig-9-65-71-84.ibm.com (unknown [9.65.71.84])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 15BBB5204E;
        Mon, 21 Mar 2022 18:37:59 +0000 (GMT)
Message-ID: <a47c4a2bdc27d1a66ae09b9a07a851d6b27e6a5c.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem fixes for v5.18
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 21 Mar 2022 14:37:53 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3pdYNm80vdPHcLaNowjmsiY1BBvGa548
X-Proofpoint-GUID: 3pdYNm80vdPHcLaNowjmsiY1BBvGa548
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_07,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=929
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Except for extending the "encrypted" key type to support user provided
data, the rest is code cleanup, __setup() usage bug fix, and a trivial
change.

thanks,

Mimi


The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.18

for you to fetch changes up to 4a48b4c428dc92b5e0b19de83e7eb8d530dddd48:

  MAINTAINERS: add missing security/integrity/platform_certs (2022-02-28 21:08:54 -0500)

----------------------------------------------------------------
integrity-v5.18

----------------------------------------------------------------
Austin Kim (1):
      ima: Fix trivial typos in the comments

Mimi Zohar (4):
      MAINTAINERS: add missing "security/integrity" directory
      ima: rename IMA_ACTION_FLAGS to IMA_NONACTION_FLAGS
      ima: define ima_max_digest_data struct without a flexible array variable
      MAINTAINERS: add missing security/integrity/platform_certs

Randy Dunlap (1):
      EVM: fix the evm= __setup handler return value

Stefan Berger (1):
      ima: Return error code obtained from securityfs functions

Yael Tzur (1):
      KEYS: encrypted: Instantiate key with user-provided decrypted data

 Documentation/security/keys/trusted-encrypted.rst | 25 ++++++--
 MAINTAINERS                                       | 11 ++++
 security/integrity/evm/evm_main.c                 |  2 +-
 security/integrity/ima/ima_api.c                  | 12 ++--
 security/integrity/ima/ima_fs.c                   | 31 +++++++---
 security/integrity/ima/ima_init.c                 |  5 +-
 security/integrity/ima/ima_main.c                 |  9 +--
 security/integrity/ima/ima_policy.c               |  4 +-
 security/integrity/ima/ima_template_lib.c         |  7 +--
 security/integrity/integrity.h                    | 14 ++++-
 security/keys/Kconfig                             | 19 ++++--
 security/keys/encrypted-keys/encrypted.c          | 71 +++++++++++++++++------
 12 files changed, 146 insertions(+), 64 deletions(-)

