Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5415222
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfEFQ5w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 12:57:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726517AbfEFQ5w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 12:57:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46GqS5d123356
        for <linux-integrity@vger.kernel.org>; Mon, 6 May 2019 12:57:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2saq79n0xa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 12:57:50 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 May 2019 17:57:49 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 17:57:46 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46GvjDh39846052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 16:57:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA920A4051;
        Mon,  6 May 2019 16:57:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04B1CA4040;
        Mon,  6 May 2019 16:57:45 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.95.145])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 16:57:44 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 0/3] ima: addressing mmap/mprotect concerns
Date:   Mon,  6 May 2019 12:57:01 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19050616-0016-0000-0000-00000278E759
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050616-0017-0000-0000-000032D58D35
Message-Id: <1557161824-6623-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=889 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Igor Zhbanov's "Should mprotect(..., PROT_EXEC) be checked by IMA?"
thread raised concerns about IMA's handling of mmap/mprotect. [1]  The
kernel calls deny_write_access() to prevent a file already opened for
write from being executed and also prevents files being executed from
being opened for write.  For some reason this does not extend to files
being mmap'ed execute.  This is a known, well described problem.[2]
Jordan Glover commented that the proposed minor LSM "SARA" addresses
this issue.[3]

This patch set attempts to address some the IMA mmap/mprotect concerns
without locking the mmap'ed files.

Mimi

[1] https://lore.kernel.org/linux-integrity/cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru/
[2] ]https://pax.grsecurity.net/docs/mprotect.txt
[3] https://sara.smeso.it/en/latest/

Mimi Zohar (3):
  ima: verify mprotect change is consistent with mmap policy
  ima: prevent a file already mmap'ed write to be mmap'ed execute
  ima: prevent a file already mmap'ed read|execute to be mmap'ed write

 include/linux/ima.h               |  6 +++--
 security/integrity/ima/ima_main.c | 53 ++++++++++++++++++++++++++++++++++++---
 security/security.c               |  9 +++++--
 3 files changed, 61 insertions(+), 7 deletions(-)

-- 
2.7.5

