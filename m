Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209D736D886
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Apr 2021 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhD1Nru (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Apr 2021 09:47:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229891AbhD1Nru (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Apr 2021 09:47:50 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SDgv8O053765;
        Wed, 28 Apr 2021 09:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=bf9BBbPeFXKuiKcBeXxCk4jCC0U8NP/nP/3H/f4nBPQ=;
 b=V74cuykNaTqTyesy14nmt1wB0PGPm5jKor+XN13i6qd3acKmBST390WmS6jvmDkTipLq
 BVUvEp4u+XRLRrljA85zOMh/MsC7vzVhm18KQfH2HgfmMedz3ns1Vx5TYd+pwHBVn5DD
 Sf50YJvhW5zR3tS68p/zk2Df6gLLvyN2QYD7L12UN2eJhwhKKvkgsjXKo/crAFDxwQb1
 LyREHkuAwKIZn68rqSTNiYdEkWvIjxjlgJsgnVtADhTcwxOBuN2Ci/kN9VVOlxTOltee
 02USdt2xGvdWy/OWauBMnIaQYtXcDzUY6o6s6P3PgRyDVdxfc9gnHJpD68gyRV1Cah91 5g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38773cumbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 09:47:04 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13SDiPWT004591;
        Wed, 28 Apr 2021 13:47:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 384ay8hx2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 13:47:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13SDkZRG27984140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 13:46:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B34CA4040;
        Wed, 28 Apr 2021 13:46:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CE9EA4051;
        Wed, 28 Apr 2021 13:46:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.157.95])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Apr 2021 13:46:58 +0000 (GMT)
Message-ID: <33e5687f1e4c7becdc41136704fa239f81b82fec.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.13
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 28 Apr 2021 09:46:57 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: geuAQ_Svz5hAq3ibwK8RLQX-ZKC6rKvb
X-Proofpoint-ORIG-GUID: geuAQ_Svz5hAq3ibwK8RLQX-ZKC6rKvb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_06:2021-04-28,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

In addition to loading the kernel module signing key onto the builtin
keyring, load it onto the IMA keyring as well.  In addition are six
trivial changes and bug fixes.

thanks,

Mimi

The following changes since commit 92063f3ca73aab794bd5408d3361fd5b5ea33079:

  integrity: double check iint_cache was initialized (2021-03-22 14:54:11 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.13

for you to fetch changes up to 781a5739489949fd0f32432a9da17f7ddbccf1cc:

  ima: ensure IMA_APPRAISE_MODSIG has necessary dependencies (2021-04-26 21:54:23 -0400)

----------------------------------------------------------------
integrity-v5.13

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      ima: Fix fall-through warnings for Clang

Jiele Zhao (2):
      ima: Fix function name error in comment.
      integrity: Add declarations to init_once void arguments.

Li Huafei (1):
      ima: Fix the error code for restoring the PCR value

Mimi Zohar (2):
      ima: without an IMA policy loaded, return quickly
      Merge branch 'ima-module-signing-v4' into next-integrity

Nayna Jain (4):
      keys: cleanup build time module signing keys
      ima: enable signing of modules with build time generated key
      ima: enable loading of build time generated key on .ima keyring
      ima: ensure IMA_APPRAISE_MODSIG has necessary dependencies

 Makefile                              |  6 ++---
 certs/Kconfig                         |  2 +-
 certs/Makefile                        | 10 +++++++
 certs/system_certificates.S           | 14 +++++++++-
 certs/system_keyring.c                | 50 ++++++++++++++++++++++++++++-------
 include/keys/system_keyring.h         |  7 +++++
 init/Kconfig                          |  6 ++---
 security/integrity/digsig.c           |  2 ++
 security/integrity/iint.c             |  2 +-
 security/integrity/ima/ima_main.c     |  9 ++++++-
 security/integrity/ima/ima_policy.c   |  2 ++
 security/integrity/ima/ima_template.c |  4 +--
 12 files changed, 92 insertions(+), 22 deletions(-)



