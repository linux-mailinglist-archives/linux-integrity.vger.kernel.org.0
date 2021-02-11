Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1531938E
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 20:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBKT4A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 14:56:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231384AbhBKTzh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 14:55:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11BJhWpi179856;
        Thu, 11 Feb 2021 14:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vki/6+etHLmQVpbccfshCvsGN2NJbiZZtM7j5DeRRZ8=;
 b=kS/gX+J06qfDu3SG1nDjYjerUzUE2q9IcMbdM2gKnxzvr31i0WBCzNWxjRRMdqqOLpns
 y20opszNQftUlD4SvunSuWvoyoN1FC+6ko3QCQtAKZzOcF6Wm7QPPW1bry1tM29LENJd
 9oYsGGOog7+Iph5O6jYR0D5RitW0Gg8dnVp1HiUCHa5DZuzLSZohs4m6zzI+bR8Q6xU9
 9SPGC8AiGZ4K8vvmGfxSpyD8ZDTP13CRtJW8+ye4e7PPVMiQ/yp6u5x/dnNpgsBMLftP
 Bkq7p3wfvBTLPK/vGgELWd66SZeVC2nS9k1DUDduAei6Ug6YOg3DypvcVelFEkZr1e4e lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nb05r7xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:54:55 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11BJjSaP190965;
        Thu, 11 Feb 2021 14:54:55 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nb05r7x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 14:54:55 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11BJpct6030236;
        Thu, 11 Feb 2021 19:54:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 36hjr8b5qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 19:54:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11BJsd5J38076762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:54:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E680A4203F;
        Thu, 11 Feb 2021 19:54:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BA2042041;
        Thu, 11 Feb 2021 19:54:48 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com.com (unknown [9.160.81.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Feb 2021 19:54:48 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 0/5] ima: kernel build support for loading the kernel module signing key
Date:   Thu, 11 Feb 2021 14:54:30 -0500
Message-Id: <20210211195435.135582-1-nayna@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110153
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
and is loaded onto .builtin_trusted_key keyring, only when the kernel
module signing key is loaded onto the .ima keyring.

* Enable module signing at build time for IMA_APPRAISE_MODSIG as well

Nayna Jain (5):
  keys: cleanup build time module signing keys
  keys: generate self-signed module signing key using CSR
  ima: update kernel module signing process during build
  keys: define build time generated ephemeral kernel CA key
  ima: enable loading of build time generated key to .ima keyring

 Makefile                      |  9 ++--
 certs/Kconfig                 |  2 +-
 certs/Makefile                | 77 ++++++++++++++++++++++++++++++++---
 certs/system_certificates.S   | 16 +++++++-
 certs/system_keyring.c        | 56 +++++++++++++++++++------
 include/keys/system_keyring.h |  9 +++-
 init/Kconfig                  |  6 +--
 security/integrity/digsig.c   |  4 ++
 8 files changed, 151 insertions(+), 28 deletions(-)

-- 
2.18.1
