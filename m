Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6483B79F0
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 23:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbhF2VhH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 17:37:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235631AbhF2VhD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 17:37:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TLXZxW157827;
        Tue, 29 Jun 2021 17:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fle6/XLlT/XEz9K53LS/zKddDIKGzsiUGG2+Bqg9wjc=;
 b=cExVkQPZdQLLrhlQ3dCJnZpGCntx+E49Gy9g/ZWLsRw+38yVs8kkDw4coeO0bAQna7nt
 0SwVsSlibpBC2uvDmJgJjcWsicVPumJwn1V3p/W1OqFpNrPV1tGOH6tjjl+4lFldqDyz
 8tWBKxKmll0JG9m/k39j4Zf06qhF6+Dvn55NkI2LLWe24Vto3gceXET5eoYIcC0CAnoO
 9cTz2XBZKaOrk7NVV7P9JehTAjVyW40dMnZCe6Zd0L9ncXRBD/ax8/t/fUMn3FMeotAJ
 QLDk77FT5XgHK3kwjMRlJ18FKinTomqYOiv3lEn2DFo0AB8/JVoeOqEPyjrdluOUPCjy MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39g8uvm45y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 17:34:31 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15TLYUOU164126;
        Tue, 29 Jun 2021 17:34:30 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39g8uvm45s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 17:34:30 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TLVN9e003535;
        Tue, 29 Jun 2021 21:34:29 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 39duvdau3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 21:34:29 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TLYQIL39059780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 21:34:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6A7DAC060;
        Tue, 29 Jun 2021 21:34:26 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC28CAC05B;
        Tue, 29 Jun 2021 21:34:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 21:34:26 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 0/2] Add support for ECDSA-signed kernel modules
Date:   Tue, 29 Jun 2021 17:34:19 -0400
Message-Id: <20210629213421.60320-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SOYPRvhy9pjFpVECL0pddFdN_7y7qKjL
X-Proofpoint-GUID: U-RAcScL2xWwRstF-v6rK06gMMd0tlkt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_14:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290132
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

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

  Stefan

v8:
  - Removed R-b tags and reordered Cc tags

v7:
  - Changed Kconfig reference to kernel version from 5.11 to 5.13
  - Redirecting stderr of openssl to NULL device to address kernel robot
    detected issue
  - Replaced $(CONFIG_MODULE_SIG_KEY) with "certs/signing_key.pem" following
    Linus's suggestion

v6:
  - Patch 2/4 is fixing V4's 1/2 and 4/4 is fixing V4's 2/2. Both fixup
    patches to be squashed.

v5:
  - do not touch the key files if openssl is not installed; likely
    addresses an issue pointed out by kernel test robot

v4:
  - extending 'depends on' with MODULES to (IMA_APPRAISE_MODSIG && MODULES)
  
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
 certs/Makefile                        | 21 +++++++++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 3 files changed, 55 insertions(+)

-- 
2.31.1

