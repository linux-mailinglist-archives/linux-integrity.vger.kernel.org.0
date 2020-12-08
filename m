Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D502D2C23
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 14:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgLHNm5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 08:42:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728659AbgLHNm5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 08:42:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8DWYE4068582;
        Tue, 8 Dec 2020 08:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=EDAm5/fnmeIQrRn85FkoqnvTE4Brsv2neYbmvkm699s=;
 b=Q3NZY3guNCCrbiAOzYZMeNVy+vGNpe0NBXR6GIRoaZPMqy469h7zodzeR59UEmT2K5nI
 86GGC0gqpkq0XB6LAfozXzNvnl1jaakWvUBymju4eJkRk/kylwq47LyR07kKpx5l1AoC
 vWKaMxzb1qKcjbA+DF6Yqa8IxnU09y5d9OFy6NTavQgCINuaCFAVPXoyHsBocP59dc8h
 3CfOUTDNqyfVy91+kvMxYXDdJTH5J5qf2SYllH6U32Ed2yx1+C6dmiAccw4yVb4qrq/j
 /MY+zW5t5YpNF223iwsecjbOMQ2V05kLy4CzKdlf8DMeRlFxgBrgCxytZAQlbryeiUwO qQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a62702pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 08:37:01 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8DSLuO030992;
        Tue, 8 Dec 2020 13:36:59 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3581u83kgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 13:36:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8DavV924903970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 13:36:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C9AD42041;
        Tue,  8 Dec 2020 13:36:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C5B64204B;
        Tue,  8 Dec 2020 13:36:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.221.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 13:36:55 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [ima-evm-utils][PATCH 0/2] support verifying EVM portable signatures
Date:   Tue,  8 Dec 2020 08:36:37 -0500
Message-Id: <20201208133639.538269-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=875 spamscore=0 phishscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the new kernel "evm: Improve usability of portable signatures" patch,
start updating ima-evm-utils.

Mimi


Mimi Zohar (2):
  Add support for verifying portable EVM signatures
  tests: add test to verify EVM portable and immutable signatures

 src/evmctl.c           | 25 +++++++++++++++++++++++--
 tests/sign_verify.test | 11 ++++++++---
 2 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.18.4

