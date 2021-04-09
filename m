Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA035A128
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 16:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhDIOfl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 10:35:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232990AbhDIOfl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 10:35:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139EXaI0085427;
        Fri, 9 Apr 2021 10:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=oj488HEf7RPPYjulmvJ2vG21D298AQH7SaGsElt1NvY=;
 b=IeQQcV5xXmmpHOOLkbdVAdJpbTdFJD/+bORZdab2P3jdYJWEtLjaQKUwr30jKCNJfMPw
 R6Px7emagEopHDvrg+6PKKCs7uQJJ/GC3S27gF5IGhGU1loCiEfJmOcPVwSEeq5uemlU
 a94V5PJJVf3YZC+LOx8iFh+MTt21NUscW7iC4mD9W7TQAzv2SaO2yLifghJPPMjVS+Od
 jx6EcA+bFGYGMPHrABcOcsrp+A+2lYZWkdT07aDINEq73FGABB2VR91wsSp4D8+ZhHmM
 +rukwZoha+LNmyw9+wenIq57FflCXugmDlnjrTYKoYLvCq6Lc+I1MzUpt92WwsqiiJg9 Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37trdq8t3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 10:35:20 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 139EZGO4094867;
        Fri, 9 Apr 2021 10:35:19 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37trdq8t1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 10:35:19 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 139EXj0j022369;
        Fri, 9 Apr 2021 14:35:17 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbwahfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:35:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 139EZEmo45154730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 14:35:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EDD94C046;
        Fri,  9 Apr 2021 14:35:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E17C4C059;
        Fri,  9 Apr 2021 14:35:12 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.63.3])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 14:35:12 +0000 (GMT)
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
Subject: [PATCH v4 0/3] ima: kernel build support for loading the kernel module signing key
Date:   Fri,  9 Apr 2021 10:35:04 -0400
Message-Id: <20210409143507.191443-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m9hJgK75bCvlDCQEcTTShVGaAQQdyQX1
X-Proofpoint-GUID: q488RcEmc2np1Skacn4GiR-D3S_ezGPJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_06:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090110
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
trusted IMA keyring.

v4:
* Updated Jarkko's Reviewed-by and Stefan's Ack-by. 
* Fixed a bug where size was miscalculated for the case when only
IMA_APPRAISE_MODSIG is enabled. Thanks Mimi for noticing it.

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
 certs/system_certificates.S   | 13 ++++++++-
 certs/system_keyring.c        | 50 ++++++++++++++++++++++++++++-------
 include/keys/system_keyring.h |  7 +++++
 init/Kconfig                  |  6 ++---
 security/integrity/digsig.c   |  2 ++
 8 files changed, 76 insertions(+), 18 deletions(-)

-- 
2.29.2
