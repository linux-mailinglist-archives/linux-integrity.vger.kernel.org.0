Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED72F442BC0
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Nov 2021 11:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhKBKn5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 06:43:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46808 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhKBKn4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 06:43:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A29vE4D009433;
        Tue, 2 Nov 2021 10:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=RV9146lUgGEB1B0syahFH3GzBDRrCnmWJRzULRbR1HA=;
 b=p8bjRfa6K5GuvychzYRvKmf105GWjU/fKy5GDu0uHweN+o6XsjWSG28VfL3m/dEsoP84
 lZldnyMyhKhyVsd26eFRY8mHAy/uwx9GgN9BQgl+xyypizN4oPXKs4qvbvS2KLmdX+kC
 L9lN0HcpVxqeuS4kyF6WJA8vpnQNAX6T2zVdLnHADZxGSmv7N/LU3yuA+LjTQHACFuTb
 j4ZO3Dh41M5KVJQDJT0udOZbD+nS1bOV08iSCoYCbU+1PlXTD47esQu30zQ778+DmdQ6
 ds/+M6EI+HUu3VNjunxE1rCGzlHvJ1QqXFqq+XVaG5KIXHbxltWVs+3Lc7ZNhk8zWAOd pg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c2mvmhn8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 10:41:16 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A2AWkfk018281;
        Tue, 2 Nov 2021 10:41:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3c0wpaj8uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 10:41:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A2AYl9C63963464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Nov 2021 10:34:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4640D4204B;
        Tue,  2 Nov 2021 10:41:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BDE242049;
        Tue,  2 Nov 2021 10:41:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.31])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Nov 2021 10:41:09 +0000 (GMT)
Message-ID: <3f066f52d4937414a9e01c7f46a714e988e6196a.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.16
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 02 Nov 2021 06:41:09 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yAPBFttUDV_2EqfXij9qVp3x_j7EBggC
X-Proofpoint-ORIG-GUID: yAPBFttUDV_2EqfXij9qVp3x_j7EBggC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_06,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020062
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Other than the new gid IMA policy rule support and the RCU locking fix,
the couple of remaining changes are minor/trivial (e.g.
__ro_after_init, replacing strscpy).

thanks,

Mimi

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.16

for you to fetch changes up to 32ba540f3c2a7ef61ed5a577ce25069a3d714fc9:

  evm: mark evm_fixmode as __ro_after_init (2021-10-28 18:52:49 -0400)

----------------------------------------------------------------
integrity-v5.16

----------------------------------------------------------------
Alex Henrie (1):
      ima: fix uid code style problems

Austin Kim (1):
      evm: mark evm_fixmode as __ro_after_init

Curtis Veit (1):
      ima: add gid support

Petr Vorel (2):
      ima_policy: Remove duplicate 'the' in docs comment
      ima: Use strscpy instead of strlcpy

liqiong (1):
      ima: fix deadlock when traversing "ima_default_rules".

 Documentation/ABI/testing/ima_policy |   8 +-
 security/integrity/evm/evm_main.c    |   2 +-
 security/integrity/ima/ima_api.c     |   2 +-
 security/integrity/ima/ima_policy.c  | 243 ++++++++++++++++++++++++++++-------
 4 files changed, 208 insertions(+), 47 deletions(-)

