Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1152032531E
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Feb 2021 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhBYQJU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 11:09:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6703 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233606AbhBYQJM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 11:09:12 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PG5Jg4122439;
        Thu, 25 Feb 2021 11:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wpz8NHETQCbFhFjtri/D/klfQs3phOaYfi4hlo/KAZ4=;
 b=o605OWpoTEomoAeEWbp7B3VqRiZkaQPNf0KAcnYwTd0RAuKEaFAQrD8l0C87nOdOpAmn
 MnbSzAaZT91g8njhyo3SdlwnnFOmmb2ZFt5h3jYyxq7Y+4ggB/GuaJPXdglOc7brLIna
 efHIQSALoVg2AbwmmDbLIQ3HyqLy1zktQgPbODEYm3Trx0jDUXUt+wxs1GrjnEUtXxjr
 KkGOPKTOrObLdIjWisK18Is6iydk/4R5LTb+r7dK+x5Lqh2/ALtE8b+uiktCDelu8NuL
 CwEWxWgK99iZi8wbdPwnnjvXJKx0jAA2n+KlOLrxO7Y1D6lZp2I7Z0n5F/1fBDuROrDj fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xf3q843t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:08:20 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11PG5LNV122527;
        Thu, 25 Feb 2021 11:08:19 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36xf3q843a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:08:19 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11PG2BNY026958;
        Thu, 25 Feb 2021 16:08:19 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 36tt29yvcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 16:08:19 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11PG8IWR14287282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Feb 2021 16:08:18 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEAB46E04E;
        Thu, 25 Feb 2021 16:08:17 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 717506E053;
        Thu, 25 Feb 2021 16:08:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Feb 2021 16:08:17 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v9 0/9] Add support for x509 certs with NIST P384/256/192 keys
Date:   Thu, 25 Feb 2021 11:07:53 -0500
Message-Id: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_09:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102250127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This series of patches adds support for x509 certificates signed by a CA
that uses NIST P384, P256 or P192 keys for signing. It also adds support for
certificates where the public key is one of this type of a key. The math
for ECDSA signature verification is also added as well as the math for fast
mmod operation for NIST P384.

Since self-signed certificates are verified upon loading, the following
script can be used for testing of NIST P256 keys:

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

Ecdsa support also works with restricted keyrings where an RSA key is used
to sign a NIST P384/256/192 key. Scripts for testing are here:

https://github.com/stefanberger/eckey-testing

The ECDSA signature verification will be used by IMA Appraisal where ECDSA
file signatures stored in RPM packages will use substantially less space
than if RSA signatures were to be used.

Further, a patch is added that allows kernel modules to be signed with a NIST
p384 key.

   Stefan and Saulo

v8->v9:
  - Appended Saulo's patches
  - Appended patch to support kernel modules signed with NIST p384 key. This
    patch requires Nayna's series here: https://lkml.org/lkml/2021/2/18/856

v7->v8:
  - patch 3/4: Do not determine key algo using parse_OID in public_key.c
    but do this when parsing the certificate. This addresses an issue
    with certain build configurations where OID_REGISTRY is not available
    as 'Reported-by: kernel test robot <lkp@intel.com>'.

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



Saulo Alessandre (4):
  x509: Add OID for NIST P384 and extend parser for it
  crypto: Add NIST P384 curve parameters
  crypto: Add math to support fast NIST P384
  ecdsa: Register NIST P384 and extend test suite

Stefan Berger (5):
  crypto: Add support for ECDSA signature verification
  x509: Detect sm2 keys by their parameters OID
  x509: Add support for parsing x509 certs with ECDSA keys
  ima: Support EC keys for signature verification
  certs: Add support for using elliptic curve keys for signing modules

 certs/Kconfig                             |  22 ++
 certs/Makefile                            |  14 +
 crypto/Kconfig                            |  10 +
 crypto/Makefile                           |   6 +
 crypto/asymmetric_keys/pkcs7_parser.c     |   4 +
 crypto/asymmetric_keys/public_key.c       |   4 +-
 crypto/asymmetric_keys/x509_cert_parser.c |  49 ++-
 crypto/asymmetric_keys/x509_public_key.c  |   4 +-
 crypto/ecc.c                              | 281 +++++++++-----
 crypto/ecc.h                              |  31 +-
 crypto/ecc_curve_defs.h                   |  32 ++
 crypto/ecdsa.c                            | 400 ++++++++++++++++++++
 crypto/ecdsasignature.asn1                |   4 +
 crypto/testmgr.c                          |  18 +
 crypto/testmgr.h                          | 424 ++++++++++++++++++++++
 include/crypto/ecdh.h                     |   1 +
 include/keys/asymmetric-type.h            |   6 +
 include/linux/oid_registry.h              |  10 +-
 lib/oid_registry.c                        |  13 +
 security/integrity/digsig_asymmetric.c    |  30 +-
 20 files changed, 1256 insertions(+), 107 deletions(-)
 create mode 100644 crypto/ecdsa.c
 create mode 100644 crypto/ecdsasignature.asn1

-- 
2.29.2

