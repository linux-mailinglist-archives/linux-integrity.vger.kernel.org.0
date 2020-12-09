Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D672D4703
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Dec 2020 17:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgLIQpY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Dec 2020 11:45:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54020 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbgLIQpY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Dec 2020 11:45:24 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B9GY67R127148;
        Wed, 9 Dec 2020 11:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=00N5LhFLJA82L68Z1bf9seewC3//1hF3H5n/gq8BThI=;
 b=MaVHgDmjkGDTOOXxvZH3boAYuTcRgQl2bA2NZ0QVFEdnG6qNgLgYuEYF2w/+Q1L8Ru5U
 AukCJAYwJH5aL67RqpHgSV2was2CbBDlvMWRn4Rbt7ux3myRdc6QjjyG6+DbHAfkh4Kn
 j6McEMIgPA1ZVuGOANEW+kpIJbuZnJHeVMBfvK6K/CNoZcL8UhByKx8KYN9zxEYXG/gW
 H+/MYlbb/9kxKhI7qjiL8ctaOYxsR9QvAXBADddgufez2lpk5sX0+8n9NnRZq4vg5In5
 RQljC1noVEwkROIxGmrS8vJS2dg1+36pA3TOgtESg9JYVHBKTFLt7rqQZcsLNA3HUjKW FQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35avffa55s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 11:44:41 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B9Ggj74028786;
        Wed, 9 Dec 2020 16:44:38 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8q432-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 16:44:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B9GhLiM53215698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 16:43:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABB38A405E;
        Wed,  9 Dec 2020 16:43:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 184B9A4055;
        Wed,  9 Dec 2020 16:43:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.48])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Dec 2020 16:43:19 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Elaine Palmer <erpalmer@us.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, sumit.garg@linaro.org,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Subject: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust source (update)
Date:   Wed,  9 Dec 2020 11:42:49 -0500
Message-Id: <20201209164249.715178-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_13:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=1 impostorscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Elaine Palmer <erpalmer@us.ibm.com>

Update trusted key documentation with additional comparisons between
discrete TPMs and TEE.

Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
---
 .../security/keys/trusted-encrypted.rst       | 73 +++++++++++++++++--
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 16042c8ff8ae..90c02105ab89 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -14,12 +14,14 @@ convenience, and are integrity verified.
 Trust Source
 ============
 
-Trust Source provides the source of security for the Trusted Keys, on which
-basis Trusted Keys establishes a Trust model with its user. A Trust Source could
-differ from one system to another depending on its security requirements. It
-could be either an off-chip device or an on-chip device. Following section
-demostrates a list of supported devices along with their security properties/
-guarantees:
+A trust source provides the source of security for Trusted Keys.  This
+section lists currently supported trust sources, along with their security
+considerations.  Whether or not a trust source is sufficiently safe depends
+on the strength and correctness of its implementation, as well as the threat
+environment for a specific use case.  Since the kernel doesn't know what the
+environment is, and there is no metric of trust, it is dependent on the
+consumer of the Trusted Keys to determine if the trust source is sufficiently
+safe.
 
   *  Root of trust for storage
 
@@ -116,6 +118,59 @@ guarantees:
          Provides no protection by itself, relies on the underlying platform for
          features such as tamper resistance.
 
+  *  Provisioning - the trust source's unique and verifiable cryptographic
+     identity is provisioned during manufacturing
+
+     (1) TPM
+
+         The unique and verifiable cryptographic identity is the endorsement
+         key (EK) or its primary seed.  A review of the generation of the EK
+         and its accompanying certificate is part of the Common Criteria
+         evaluation of the product's lifecycle processes (ALC_*).  See "TCG
+         Protection Profile for PC Client Specific TPM 2"
+
+     (2) TEE
+
+         A protection profile for TEEs does not yet exist.  Therefore, the
+         provisioning process that generates the Hardware Unique Key is not
+         evaluated by an independent third party and is highly dependent on
+         the manufacturing environment.
+
+
+  *  Cryptography
+
+     (1) TPM
+
+         As part of the TPM's mandatory Common Criteria evaluation, the
+         correctness of the TPM's implementation of cryptographic algorithms,
+         the protection of keys, and the generation of random numbers, and other
+         security-relevant functions must be documented, reviewed, and tested by
+         an independent third party evaluation agency.  It must meet the
+         requirements of FIPS 140-2, FIPS 140-3, or ISO/IEC 19790:2012.
+
+     (2) TEE
+
+         Evaluations of cryptographic modules within TEEs are not required, but
+         some are available for specific implementations within TEEs.
+
+
+  *  Interfaces and APIs
+
+     (1) TPM
+
+         TPMs have well-documented, standardized interfaces and APIs.
+
+     (2) TEE
+
+         Unless TEEs implement functionality such as a virtual TPM, they have
+         custom interfaces and APIs.
+
+
+  *  Threat model
+
+     The strength and appropriateness of a particular TPM or TEE for a given
+     purpose must be assessed when using them to protect security-relevant data.
+
 
 Key Generation
 ==============
@@ -123,8 +178,10 @@ Key Generation
 Trusted Keys
 ------------
 
-New keys are created from trust source generated random numbers, and are
-encrypted/decrypted using trust source storage root key.
+New keys are created from random numbers generated in the trust source. They
+are encrypted/decrypted using a child key in the storage key hierarchy.
+Encryption and decryption of the child key must be protected by a strong
+access control policy within the trust source.
 
   *  TPM (hardware device) based RNG
 
-- 
2.18.4

