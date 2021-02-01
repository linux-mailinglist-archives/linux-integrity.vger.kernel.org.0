Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4030AAFA
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 16:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhBAPUQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 10:20:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229879AbhBAPUG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 10:20:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111F21ah133736;
        Mon, 1 Feb 2021 10:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=RQF4tHHRRFsyJSBzF0Vt8eelPuqjXdFzwfuXoysqLaE=;
 b=U7uePaK9FMrdTlg7vg/OzdPAsGGX9+/R3dDejIbKqwj/5btlLUbEKrcRV/oP+K8OBAHr
 IAOx3W9O1UxrCRjxOI6SE6uoQQzhO0SSYZ8bpxJo/DuUsck2CcHIRyLw6wEIcL5/Cg2S
 5A0Bw8w1VcfYESItQEfSLLObqbe/4J2UZke+8kzFbg+mYjGr2I8Iwu591JDhymfdjNLR
 B2CmiZRjAN1EEEkU7/f6KXALKe6ESBQlW2lNGprM2Zkde2UOJpIfSQ/D68DKPq81kled
 Z8cVIoLI+03Ek6caHSMnuMiCSu5DjoYdXKMOvYrRhwgl5gFZ60laFSvjMgqJjWeM7JPZ GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ekv2rryg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 10:19:19 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111F2ARe134879;
        Mon, 1 Feb 2021 10:19:19 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ekv2rry0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 10:19:18 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111FC4A3030139;
        Mon, 1 Feb 2021 15:19:18 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 36cy39b5ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 15:19:18 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111FJGHQ7864694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 15:19:16 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DF7D6E04C;
        Mon,  1 Feb 2021 15:19:16 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A44AE6E050;
        Mon,  1 Feb 2021 15:19:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 15:19:15 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 0/4] Add support for x509 certs with NIST p256 and p192 keys
Date:   Mon,  1 Feb 2021 10:19:06 -0500
Message-Id: <20210201151910.1465705-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_05:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010077
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

v6->v7:
  - Moved some OID defintions to patch 1 for bisectability
  - Applied R-b's
  
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

