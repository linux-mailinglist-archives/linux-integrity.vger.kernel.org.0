Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9731F1EE
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 23:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhBRWBR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 17:01:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbhBRWBQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 17:01:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11ILjtFA033525;
        Thu, 18 Feb 2021 17:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/0bFhNo6+plZGlXa5zDgt9wzfo5s8AWNpxKzDS4Ea9k=;
 b=DX7EdlPWwOeuBiUhZ1vTRup2MKtiy43mrUWu2Vg4dCsu9RXzaZThXSAa/SXop1q1d81s
 W/AYg5a+CreSzl4iqjYQWg/th1VqEAEa8DAKiSSTs4YRH8AnRzbhIcOIXlVJL2MJdqb5
 pQjYIB4VDnz7arNF1/Jw2AWwkmeBk2M+61brqf+FS3nyH1Vpt1DU5fT1lHYjh5Yi3CkX
 7YFYTMc/utl80/H2woR6Hh6oMw1AsUHvHZ2w7n5PJoe9k5OPC1OcyeyAd/P/2lT9XydW
 mVZqFMdRm1jJg28tS435cqrRxFxNl6/H/XX1MtniXHwBDLgIag36uyJTwdF/bykhp2rZ 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t0ekrb6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:35 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11ILkQAq039610;
        Thu, 18 Feb 2021 17:00:34 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36t0ekrb3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 17:00:34 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ILriVv000870;
        Thu, 18 Feb 2021 22:00:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 36p6d8jmn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Feb 2021 22:00:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11IM0PNO45941154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:00:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B8364C066;
        Thu, 18 Feb 2021 22:00:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E3984C05E;
        Thu, 18 Feb 2021 22:00:22 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.211.90.194])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Feb 2021 22:00:22 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2 0/5] ima: kernel build support for loading the kernel module signing key
Date:   Thu, 18 Feb 2021 17:00:06 -0500
Message-Id: <20210218220011.67625-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_09:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180178
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
the builtin or secondary keyrings.  This series of patches enables IMA
verification of signed kernel modules by:

* Defining a kernel CA key. The CA key signs the kernel module signing key
and is loaded onto the .builtin_trusted_key keyring, only when the kernel
module signing key is loaded onto the .ima keyring.

* Enable module signing at build time for IMA_APPRAISE_MODSIG as well

v2:

* Include feedback from Stefan - corrected the Fixes commit id in Patch 1
and cleaned Patch 5/5.
* Fix the issue reported by kernel test bot.
* Include Jarkko's feedback on patch description.

Nayna Jain (5):
  keys: cleanup build time module signing keys
  keys: generate self-signed module signing key using CSR
  ima: update kernel module signing process during build
  keys: define build time generated ephemeral kernel CA key
  ima: enable loading of build time generated key on .ima keyring

 Makefile                      |  9 ++--
 certs/Kconfig                 |  2 +-
 certs/Makefile                | 77 ++++++++++++++++++++++++++++++++---
 certs/system_certificates.S   | 16 +++++++-
 certs/system_keyring.c        | 55 +++++++++++++++++++------
 include/keys/system_keyring.h |  9 +++-
 init/Kconfig                  |  6 +--
 security/integrity/digsig.c   |  4 ++
 8 files changed, 150 insertions(+), 28 deletions(-)

-- 
2.29.2
