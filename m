Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2C309F7A
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 00:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhAaXd6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Jan 2021 18:33:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhAaXdx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Jan 2021 18:33:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10VNX9hu103073;
        Sun, 31 Jan 2021 18:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kv9UZKQxGHcWZCbXo58TjMf1KJPsQMzbU/+ItkdKJwE=;
 b=YVd62iJYbchCjTIYOS+yehZm7dp+IkQW52C7lD1OhagbWVJN7uOZNU3qKMVD3FxOSyV+
 21DP8O1NpFYxRRAh3DxVl0HxSULjagwLK2QWbqq6ZKf9/RmiZPWVY+HHEVV9CS0wVvqd
 pE923VUGMICKTOFkwZGcHxBD+VOiaYiQXTmzLFgOU0tlw+yaFxkJTBSbwrGhc4BavGgM
 sAYMY1QLeOuvwgXL+e1mBXNzvD6TyHmliJWw5kJ3IPoSNH/MWO64BI7t1ANALMVMrwyW
 n3JzhnwRTDk6+9tFThn+7YW8loQQabXYFJgeZlGkkxO0MQPdl+NGjkpNNjLPfU3zLshO hA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36e58b0xd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 18:33:09 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10VNMd5c009297;
        Sun, 31 Jan 2021 23:33:08 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 36cy38tht1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 23:33:08 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10VNX5Jc24969638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 23:33:05 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40805BE051;
        Sun, 31 Jan 2021 23:33:05 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEEB1BE04F;
        Sun, 31 Jan 2021 23:33:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 31 Jan 2021 23:33:04 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 0/4]  Add support for x509 certs with NIST p256 and p192 keys
Date:   Sun, 31 Jan 2021 18:32:57 -0500
Message-Id: <20210131233301.1301787-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-31_08:2021-01-29,2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310137
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series of patches adds support for x509 certificates signed by a CA
that uses NIST p256 or p192 keys for signing. It also adds support for
certificates where the public key is a NIST p256 or p192 key. The math
for ECDSA signature verification is also added.

Since self-signed certificates are verified upon loading, the following
script can be used for testing:

k=$(keyctl newring test @u)

while :; do
	for hash in sha1 sha224 sha256 sha384 sha512; do
		openssl req \
			-x509 \
			-${hash} \
			-newkey ec \
			-pkeyopt ec_paramgen_curve:prime256v1 \
			-keyout key.pem \
			-days 365 \
			-subj '/CN=test' \
			-nodes \
			-outform der \
			-out cert.der
		keyctl padd asymmetric testkey $k < cert.der
		if [ $? -ne 0 ]; then
			echo "ERROR"
			exit 1
		fi
	done
done

It also works with restricted keyrings where an RSA key is used to sign
a NIST P256/P192 key. Scripts for testing are here:

https://github.com/stefanberger/eckey-testing

The ECDSA signature verification will be used by IMA Appraisal where ECDSA
file signatures stored in RPM packages will use substantially less space
than if RSA signatures were to be used.

   Stefan

v5->v6:
  - moved ecdsa code into its own module ecdsa_generic built from ecdsa.c
  - added script-generated test vectors for NIST P256 & P192 and all hashes
  - parsing of OID that contain header with new parse_oid()

v4->v5:
  - registering crypto support under names ecdsa-nist-p256/p192 following
    Hubert Xu's suggestion in other thread
  - appended IMA ECDSA support patch

v3->v4:
  - split off of ecdsa crypto part; registering akcipher as "ecdsa" and
    deriving used curve from digits in parsed key

v2->v3:
  - patch 2 now includes linux/scatterlist.h

v1->v2:
  - using faster vli_sub rather than newly added vli_mod_fast to 'reduce'
    result
  - rearranged switch statements to follow after RSA
  - 3rd patch from 1st posting is now 1st patch

Stefan Berger (4):
  crypto: Add support for ECDSA signature verification
  x509: Detect sm2 keys by their parameters OID
  x509: Add support for parsing x509 certs with ECDSA keys
  ima: Support EC keys for signature verification

 crypto/Kconfig                            |  10 +
 crypto/Makefile                           |   6 +
 crypto/asymmetric_keys/public_key.c       |  19 ++
 crypto/asymmetric_keys/x509_cert_parser.c |  44 ++-
 crypto/ecc.c                              |  13 +-
 crypto/ecc.h                              |  28 ++
 crypto/ecdsa.c                            | 361 ++++++++++++++++++++++
 crypto/ecdsasignature.asn1                |   4 +
 crypto/testmgr.c                          |  12 +
 crypto/testmgr.h                          | 267 ++++++++++++++++
 include/keys/asymmetric-type.h            |   6 +
 include/linux/oid_registry.h              |   7 +
 lib/oid_registry.c                        |  13 +
 security/integrity/digsig_asymmetric.c    |  29 +-
 14 files changed, 790 insertions(+), 29 deletions(-)
 create mode 100644 crypto/ecdsa.c
 create mode 100644 crypto/ecdsasignature.asn1

-- 
2.29.2

