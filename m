Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE203971DC
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 12:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhFAKyz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 06:54:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhFAKyy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 06:54:54 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151AYUmg127868;
        Tue, 1 Jun 2021 06:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=O6+15U1jHDaRO3zTydJwOiJvWDq2cPKa9PSHST/xjSk=;
 b=NvlAGPkuNCWKwTpQeXlHBORgYaEJytqC0qD+YR+d6Frg6g3O/9k6FHVUM424IiX6G6d8
 FNdxt8hNuxuZ4d2FjPtgM4ufCFZvYCgFDR3ssFLFsgNAoyUJcLvW4dJOol0Nat32eQ7q
 fQ4ibtytJqVp+Xn3dQIhJ0R1YaZMVY0D+WNyDd/vEbHT8BlZ3t2lGWXiGZhvnjq39IA6
 FOr9/+VQmV13r+hA1u5DnQ68B06VfdSq7bGQJUxn6I2pVNjI+cldLFFgXX9QCvppKCpI
 PDlbUdnbI/jOuATRtb8t+dVMnp/+tslUb7DptRdr7ZspFXS0sckL6J6t4cgK+QZsXUlK qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38whsjjt25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:53:06 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 151AYkwQ129583;
        Tue, 1 Jun 2021 06:53:04 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38whsjjt16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:53:04 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 151AqhiG006938;
        Tue, 1 Jun 2021 10:53:03 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 38ud89eapb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 10:53:03 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 151Ar2U825493960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 10:53:02 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC741124058;
        Tue,  1 Jun 2021 10:53:02 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABD55124054;
        Tue,  1 Jun 2021 10:53:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 10:53:02 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 0/2] Add support for ECDSA-signed kernel modules
Date:   Tue,  1 Jun 2021 06:52:43 -0400
Message-Id: <20210601105245.213767-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tcDuMc0YbD4VCkjjrn3drxagZ1DALczs
X-Proofpoint-ORIG-GUID: _pFMB0HBMRkDlTYOyHjkLqwrYnjFMI3B
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_05:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010071
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

v5:
  - Added Jarkko's and Mimi's tags

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
 certs/Makefile                        | 14 ++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 3 files changed, 48 insertions(+)

-- 
2.29.2

