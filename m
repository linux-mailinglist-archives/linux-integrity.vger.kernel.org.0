Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E669F34E8D3
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Mar 2021 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhC3NSg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 09:18:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55310 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232053AbhC3NSF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 09:18:05 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UD4TDD014690;
        Tue, 30 Mar 2021 09:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=AILIEiIY4WodSOw/hWAlTDcRZuWl/prYle+ozI4+n88=;
 b=NsJwNENV2eFOdKfww8PX5VeEj6BFm+Sac8zGCCkUwpRKTO1ekQbgRyYcKjM4FvDLjhXu
 y1pHBpenp9jo0Zb+nyLenlegVBsFZE4yG7wyhoO206mFMBFLl5INDK3cwJpmFvfhaG1G
 lprA6+X1uSWjGBfnLV1BKq5FJdF4r+Ij8LHOcZXgYo6F6QEaMbBbmbn2FwjdE+DaqgyM
 Xj7vxGvUzhg4h48rvprC86UcHG4GuyqfHQ4l9+XR+ZS6BCXWFX6Lj7ecdnh5WoZnCzmT
 vOFfr+Wv7fL0LALZ3X12uwHEMgdIK6FadzzsgXULg5Zl11qK1JdaYyjwLsRYHZPoRMB0 LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jpmfbx5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 09:16:55 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12UD4eTL015827;
        Tue, 30 Mar 2021 09:16:55 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jpmfbx4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 09:16:55 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12UDCkV3030171;
        Tue, 30 Mar 2021 13:16:53 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 37hvb81eq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Mar 2021 13:16:53 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12UDGoqN34865432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 13:16:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 514884C052;
        Tue, 30 Mar 2021 13:16:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2C2D4C040;
        Tue, 30 Mar 2021 13:16:47 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.103.158])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Mar 2021 13:16:47 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v3 0/3] ima: kernel build support for loading the kernel module signing key
Date:   Tue, 30 Mar 2021 09:16:33 -0400
Message-Id: <20210330131636.21711-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U9UpW_m77sQPNhMv4vi7oXi1iYqgZq7O
X-Proofpoint-ORIG-GUID: yuRN93kD96vRjM_KjjcEEAuNcK3EkjrY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-30_04:2021-03-30,2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1011 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300094
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Kernel modules are currently only signed when CONFIG_MODULE_SIG is enabled.
The kernel module signing key is a self-signed CA only loaded onto the
.builtin_trusted_key keyring.  On secure boot enabled systems with an arch
specific IMA policy enabled, but without MODULE_SIG enabled, kernel modules
are not signed, nor is the kernel module signing public key loaded onto the
IMA keyring.

In order to load the the kernel module signing key onto the IMA trusted
keyring ('.ima'), the certificate needs to be signed by a CA key either on
the builtin or secondary keyrings. The original version of this patch set
created and loaded a kernel-CA key onto the builtin keyring. The kernel-CA
key signed the kernel module signing key, allowing it to be loaded onto the
IMA trusted keyring.

However, missing from this version was support for the kernel-CA to sign the
hardware token certificate. Adding that support would add additional
complexity.

Since the kernel module signing key is embedded into the Linux kernel at
build time, instead of creating and loading a kernel-CA onto the builtin
trusted keyring, this version makes an exception and allows the 
self-signed kernel module signing key to be loaded directly onto the 
trusted IMA keyring

v3:

* Fix the "Fixes" tag as suggested by Stefan for Patch 1/3.
* Revert back the CA signed module signing key to only self-signed.
* Allow self signed key as exception only for build time generated
module signing key onto .ima keyring.

v2:

* Include feedback from Stefan - corrected the Fixes commit id in Patch 1
and cleaned Patch 5/5.
* Fix the issue reported by kernel test bot.
* Include Jarkko's feedback on patch description.

Nayna Jain (3):
  keys: cleanup build time module signing keys
  ima: enable signing of modules with build time generated key
  ima: enable loading of build time generated key on .ima keyring

 Makefile                      |  6 ++---
 certs/Kconfig                 |  2 +-
 certs/Makefile                |  8 ++++++
 certs/system_certificates.S   | 13 +++++++++-
 certs/system_keyring.c        | 47 +++++++++++++++++++++++++++--------
 include/keys/system_keyring.h |  7 ++++++
 init/Kconfig                  |  6 ++---
 security/integrity/digsig.c   |  2 ++
 8 files changed, 73 insertions(+), 18 deletions(-)

-- 
2.29.2
