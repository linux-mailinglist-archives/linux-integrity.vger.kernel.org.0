Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9447833E034
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 22:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhCPVQU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 17:16:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232312AbhCPVQL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 17:16:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12GL3YsQ110195;
        Tue, 16 Mar 2021 17:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jDhcUxUBA+1jZUH7Ci97Hm4C5PT0ru3IyiJgwKrKpgQ=;
 b=Ql99LFvtU31FP9uJYPnCSE9TYxfQsdoNL+80XnV6mw++XubaQvLEBHQUSoClIdd+0PPu
 psn18xuTFPD6NU2p4dmChyEs13wqEdhpf/UbkzUepUNZn5rSTorBR7O+YwGDXuK/sHEB
 OzaFV9rj56VtTzSQoAZGh3OBsh2+jgLWaU8arINy9iSI58C9yY0Al9fKBD3tqc3JfZC2
 LXGPdNdoERlSqxwIp/1oIp33sBWKzNSaTsTGNaGdqOJeLZ2D0B87nalxhRXj4lluTPpL
 AirQlecH2DbUxfepixg66xiecvI+pVFlUj7XMofgbAdgdiYLCKyoyULHudyfBrXXj1T7 KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37b0aw7cau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 17:16:06 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12GL4QnT112755;
        Tue, 16 Mar 2021 17:16:05 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37b0aw7caa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 17:16:05 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12GLDmY9024499;
        Tue, 16 Mar 2021 21:16:04 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 378n1925d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 21:16:04 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12GLG3cf29557060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 21:16:03 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 351076E04E;
        Tue, 16 Mar 2021 21:16:03 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 803C36E059;
        Tue, 16 Mar 2021 21:16:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 16 Mar 2021 21:16:02 +0000 (GMT)
Subject: Re: [PATCH v12 00/10] Add support for x509 certs with NIST
 P384/256/192 keys
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org
References: <20210316210740.1592994-1-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <4657d697-7b5d-569f-aa8c-9277d69f76e4@linux.ibm.com>
Date:   Tue, 16 Mar 2021 17:16:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316210740.1592994-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_08:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Herbert,

   if you could queue patches 1-9 in a topic branch, that would be great!

Regards,

    Stefan


On 3/16/21 5:07 PM, Stefan Berger wrote:
> This series of patches adds support for x509 certificates signed by a CA
> that uses NIST P384, P256 or P192 keys for signing. It also adds support for
> certificates where the public key is one of this type of a key. The math
> for ECDSA signature verification is also added as well as the math for fast
> mmod operation for NIST P384.
>
> Since self-signed certificates are verified upon loading, the following
> script can be used for testing of NIST P256 keys:
>
> k=$(keyctl newring test @u)
>
> while :; do
> 	for hash in sha1 sha224 sha256 sha384 sha512; do
> 		openssl req \
> 			-x509 \
> 			-${hash} \
> 			-newkey ec \
> 			-pkeyopt ec_paramgen_curve:prime256v1 \
> 			-keyout key.pem \
> 			-days 365 \
> 			-subj '/CN=test' \
> 			-nodes \
> 			-outform der \
> 			-out cert.der
> 		keyctl padd asymmetric testkey $k < cert.der
> 		if [ $? -ne 0 ]; then
> 			echo "ERROR"
> 			exit 1
> 		fi
> 	done
> done
>
> Ecdsa support also works with restricted keyrings where an RSA key is used
> to sign a NIST P384/256/192 key. Scripts for testing are here:
>
> https://github.com/stefanberger/eckey-testing
>
> The ECDSA signature verification will be used by IMA Appraisal where ECDSA
> file signatures stored in RPM packages will use substantially less space
> than if RSA signatures were to be used.
>
> Further, a patch is added that allows kernel modules to be signed with a NIST
> P384 key.
>
> Testing was also done with a Pkcs11 device using an ECC key for module
> signing:
>    https://github.com/stefanberger/eckey-testing/wiki/Using-Pkcs11-Device-(SoftHSM)-for-Signing-Linux-Kernel-Modules
>
>     Stefan and Saulo
>
> v11->v12:
>    - Added Jarkko's Acked-by's
>
> v10->v11:
>    - Addressed Jarkko's comments
>    - Split off OID definitions from first patch into own patch
>    - Renamed OID_id_secp384r1 to OID_id_ansip384r1 (spec name) in 09/10
>
> v9->v10:
>    - rearranged order of patches to have crypto patches first
>    - moved hunk from patch 3 to patch 2 to avoid compilation warning due to
>      unused symbol
>
> v8->v9:
>    - Appended Saulo's patches
>    - Appended patch to support kernel modules signed with NIST p384 key. This
>      patch requires Nayna's series here: https://lkml.org/lkml/2021/2/18/856
>
> v7->v8:
>    - patch 3/4: Do not determine key algo using parse_OID in public_key.c
>      but do this when parsing the certificate. This addresses an issue
>      with certain build configurations where OID_REGISTRY is not available
>      as 'Reported-by: kernel test robot <lkp@intel.com>'.
>
> v6->v7:
>    - Moved some OID defintions to patch 1 for bisectability
>    - Applied R-b's
>    
> v5->v6:
>    - moved ecdsa code into its own module ecdsa_generic built from ecdsa.c
>    - added script-generated test vectors for NIST P256 & P192 and all hashes
>    - parsing of OID that contain header with new parse_oid()
>
> v4->v5:
>    - registering crypto support under names ecdsa-nist-p256/p192 following
>      Hubert Xu's suggestion in other thread
>    - appended IMA ECDSA support patch
>
> v3->v4:
>    - split off of ecdsa crypto part; registering akcipher as "ecdsa" and
>      deriving used curve from digits in parsed key
>
> v2->v3:
>    - patch 2 now includes linux/scatterlist.h
>
> v1->v2:
>    - using faster vli_sub rather than newly added vli_mod_fast to 'reduce'
>      result
>    - rearranged switch statements to follow after RSA
>    - 3rd patch from 1st posting is now 1st patch
>
>
> Saulo Alessandre (4):
>    crypto: Add NIST P384 curve parameters
>    crypto: Add math to support fast NIST P384
>    ecdsa: Register NIST P384 and extend test suite
>    x509: Add OID for NIST P384 and extend parser for it
>
> Stefan Berger (6):
>    oid_registry: Add OIDs for ECDSA with SHA224/256/384/512
>    crypto: Add support for ECDSA signature verification
>    x509: Detect sm2 keys by their parameters OID
>    x509: Add support for parsing x509 certs with ECDSA keys
>    ima: Support EC keys for signature verification
>    certs: Add support for using elliptic curve keys for signing modules
>
>   certs/Kconfig                             |  22 ++
>   certs/Makefile                            |  14 +
>   crypto/Kconfig                            |  10 +
>   crypto/Makefile                           |   6 +
>   crypto/asymmetric_keys/pkcs7_parser.c     |   4 +
>   crypto/asymmetric_keys/public_key.c       |   4 +-
>   crypto/asymmetric_keys/x509_cert_parser.c |  49 ++-
>   crypto/asymmetric_keys/x509_public_key.c  |   4 +-
>   crypto/ecc.c                              | 281 +++++++++-----
>   crypto/ecc.h                              |  28 +-
>   crypto/ecc_curve_defs.h                   |  32 ++
>   crypto/ecdsa.c                            | 376 +++++++++++++++++++
>   crypto/ecdsasignature.asn1                |   4 +
>   crypto/testmgr.c                          |  18 +
>   crypto/testmgr.h                          | 424 ++++++++++++++++++++++
>   include/crypto/ecdh.h                     |   1 +
>   include/keys/asymmetric-type.h            |   6 +
>   include/linux/oid_registry.h              |  10 +-
>   lib/oid_registry.c                        |  24 ++
>   security/integrity/digsig_asymmetric.c    |  30 +-
>   20 files changed, 1240 insertions(+), 107 deletions(-)
>   create mode 100644 crypto/ecdsa.c
>   create mode 100644 crypto/ecdsasignature.asn1
>
