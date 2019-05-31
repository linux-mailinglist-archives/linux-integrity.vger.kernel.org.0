Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59586311D5
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2019 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfEaP7F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 May 2019 11:59:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbfEaP7E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 May 2019 11:59:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VFprhp133805
        for <linux-integrity@vger.kernel.org>; Fri, 31 May 2019 11:59:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2su69tatwb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 31 May 2019 11:59:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 31 May 2019 16:59:01 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 May 2019 16:58:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4VFwvWP47317246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 15:58:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43EA54204C;
        Fri, 31 May 2019 15:58:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 918214204D;
        Fri, 31 May 2019 15:58:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.109])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 May 2019 15:58:56 +0000 (GMT)
Subject: [GIT PULL] integrity subsystem fixes for v5.2
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Date:   Fri, 31 May 2019 11:58:45 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19053115-4275-0000-0000-0000033AAF0C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053115-4276-0000-0000-0000384AB4C7
Message-Id: <1559318325.4280.13.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310099
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Included in this pull request are four bug fixes, which are not
specific to 5.2.  The first two are related to the architecture
specific IMA policy support.  The other two patches, one is related to
EVM signatures, based on additional hash algorithms, and the other is
related to displaying the IMA policy.
 
At least Scott's patch should have been included in the last open
window, but I sent the v5.2 pull request a bit earlier than normal.

thanks,

Mimi

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-fixes-for-5.2-rc

for you to fetch changes up to 8cdc23a3d9ec0944000ad43bad588e36afdc38cd:

  ima: show rules with IMA_INMASK correctly (2019-05-29 23:18:25 -0400)

----------------------------------------------------------------
Petr Vorel (1):
      ima: fix wrong signed policy requirement when not appraising

Roberto Sassu (2):
      evm: check hash algorithm passed to init_desc()
      ima: show rules with IMA_INMASK correctly

Scott Wood (1):
      x86/ima: Check EFI_RUNTIME_SERVICES before using

 arch/x86/kernel/ima_arch.c          |  5 +++++
 security/integrity/evm/evm_crypto.c |  3 +++
 security/integrity/ima/ima_policy.c | 28 ++++++++++++++++------------
 3 files changed, 24 insertions(+), 12 deletions(-)

