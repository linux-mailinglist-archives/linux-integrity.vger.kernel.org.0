Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216EE367399
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 21:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbhDUToB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 15:44:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243318AbhDUToA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 15:44:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LJYHK5088535;
        Wed, 21 Apr 2021 15:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ohvVcyYEL73URsRq6+D7RQKD6s9Yf7ykxc76CjqSvmI=;
 b=kiYngL8I2buuIcrPwDNVxsaORxeKCDYIeD0u+WCfDXevM9iXnH6GfOc8QQI5uyTEmBMP
 mw4KAshmRntC/boLce6Hr0IllW1iewA/t09mnhMBJ0w/Qfc7269hBCTRqR2VuQBtfl0L
 NjvXfK6+0nNJ27stArGzn+sRkW/hdn+bL7XHrvq4MrkCsTgHrkZ/SjI9PJoYj+aJdNr8
 inW8j7e5icsB2PI87WjkgtdjR+ttWM3/e1pjdW1GXyLDJPpwFTgTEjuk+YEEnDmqv594
 Z2QxAEBpw04BqxQprRsABzbmbMrTvPaid1r9VffCUeJJQG5cVX41SjXE7Pc7H1jivB+z vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382sbr9tcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 15:43:26 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13LJYIbJ088590;
        Wed, 21 Apr 2021 15:43:25 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 382sbr9tc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 15:43:25 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13LJgaqR024705;
        Wed, 21 Apr 2021 19:43:24 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3813tavx90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 19:43:24 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13LJhNBv35193186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 19:43:23 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA4FC78064;
        Wed, 21 Apr 2021 19:43:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E9057805E;
        Wed, 21 Apr 2021 19:43:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 21 Apr 2021 19:43:22 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/2] Add support for ECDSA-signed kernel modules
Date:   Wed, 21 Apr 2021 15:43:17 -0400
Message-Id: <20210421194319.1489291-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5Vfl1bcSoiVlAuJTqW9cXXPZnzVEmVIF
X-Proofpoint-GUID: 8WFnDblBUpBfo-Os64COY2oo4IAdbP6_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210134
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series adds support for ECDSA-signed kernel modules. It also
attempts to address a kbuild issue where a developer created an ECDSA
key for signing kernel modules and then builds an older version of the
kernel, when bisecting the kernel for example, that does not support
ECDSA keys.

The first patch addresses the kbuild issue of needing to delete that
ECDSA key if it is in certs/signing_key.pem and trigger the creation
of an RSA key. However, for this to work this patch would have to be
backported to previous versions of the kernel but would also only work
for the developer if he/she used a stable version of the kernel to which
this patch was applied. So whether this patch actually achieves the
wanted effect is not always guaranteed.

The 2nd patch adds the support for the ECSDA-signed kernel modules.

This patch depends on the ECDSA support series currently queued here:
https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/?h=ecc

  Stefan

v3:
  - added missing OIDs for ECDSA signed hashes to pkcs7_sig_note_pkey_algo
  - added recommendation to use string hash to Kconfig help text

v2:
  - Adjustment to ECDSA key detector string in 2/2
  - Rephrased cover letter and patch descriptions with Mimi



Stefan Berger (2):
  certs: Trigger creation of RSA module signing key if it's not an RSA
    key
  certs: Add support for using elliptic curve keys for signing modules

 certs/Kconfig                         | 26 ++++++++++++++++++++++++++
 certs/Makefile                        | 14 ++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 3 files changed, 48 insertions(+)

-- 
2.29.2

