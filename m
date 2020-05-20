Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4844B1DB951
	for <lists+linux-integrity@lfdr.de>; Wed, 20 May 2020 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgETQbC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 May 2020 12:31:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbgETQbC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 May 2020 12:31:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KG35TQ126175;
        Wed, 20 May 2020 12:30:18 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 313x64bxdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 12:30:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04KGQVQC018299;
        Wed, 20 May 2020 16:30:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 313xas400e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 16:30:16 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04KGUErm61210678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 16:30:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3E9FAE072;
        Wed, 20 May 2020 16:30:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74800AE06E;
        Wed, 20 May 2020 16:30:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.138.181])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 May 2020 16:30:13 +0000 (GMT)
Message-ID: <1589992212.5111.293.camel@linux.ibm.com>
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Date:   Wed, 20 May 2020 12:30:12 -0400
In-Reply-To: <85a96cad-dc04-a617-abfa-fb9427412e52@rosalinux.ru>
References: <85a96cad-dc04-a617-abfa-fb9427412e52@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_10:2020-05-20,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=52 cotscore=-2147483648 malwarescore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200131
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mikhail,

On Wed, 2019-12-04 at 01:41 +0300, Mikhail Novosyolov wrote:
> From 4ae52f3cfb459c59e2e48f0d30c20c3763c8a0e7 Mon Sep 17 00:00:00 2001
> From: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
> Date: Wed, 4 Dec 2019 01:07:50 +0300
> Subject: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
> 
> LibreSSL in most cases can be used as a drop-in replacement of OpenSSL.
> Commit 07d799cb6c37 "ima-evm-utils: Preload OpenSSL engine via '--engine' option"
> added OpenSSL-specific functions: "engines" were removed from LibreSSL long ago.
> Instead of requiring to attach GOST support via an external library ("engine"),
> LibreSSL has build-in implementation of GOST.
> 
> Commit ebbfc41ad6ba "ima-evm-utils: try to load digest by its alias" is also not OK
> for LibreSSL because LibreSSL uses different digest names:
> md_gost12_256 -> streebog256
> md_gost12_512 -> streebog512
> 
> Example how it works when linked with LibreSSL:
> $ libressl dgst -streebog256 testfile
> streebog256(a)= 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
> $ evmctl -v ima_hash -a streebog256 testfile
> hash(streebog256): 04123f539a213e97c802cc229d474c6aa32a825a360b2a933a949fd925208d9ce1bb
> $ evmctl -v ima_hash -a md_gost12_256 testfile
> EVP_get_digestbyname(md_gost12_256) failed
> 
> TODO: it would be nice to map
> md_gost12_256 <-> streebog256
> md_gost12_512 <-> streebog512
> in evmctl CLI arguements to make the same commands work on systems both
> where evmctl is linked with LibreSSL and with OpenSSL.
> 
> Fixes: 07d799cb6c37 ("ima-evm-utils: Preload OpenSSL engine via '--engine' option")
> Fixes: ebbfc41ad6ba ("ima-evm-utils: try to load digest by its alias")
> Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>

Since you posted this patch, I've added support for calculating the
boot_aggregate.  Could you verify that this patch still works?

As I mentioned in response to Patrick Uiterwijk's support for Intel's
TSS2, "testing ima-evm-utils support for multiple crypto and TSS
packages requires building a matrix.  As I'm new to travis, the travis
code is in the next-testing-travis branch, but will not be upstreamed
at this point."

From .travis.yml:
matrix:
   include:
     - env: TSS=ibmtss SSL=openssl
     - env: TSS=ibmtss SSL=libressl;
     - env: TSS=tpm2-tss SSL=openssl

I might have set up libressl incorrectly. (Refer to tests/install-
libressl.sh).  Here's the report:

libtool: link: ranlib .libs/libimaevm.a
libtool: link: ( cd ".libs" && rm -f "libimaevm.la" && ln -s "../libimaevm.la" "libimaevm.la" )
/bin/bash ../libtool  --tag=CC   --mode=link gcc  -g -O2 -g -O1 -Wall -Wstrict-prototypes -pipe   -o evmctl evmctl-evmctl.o evmctl-utils.o  evmctl-pcr_tsspcrread.o  -lcrypto -lkeyutils libimaevm.la 
libtool: link: gcc -g -O2 -g -O1 -Wall -Wstrict-prototypes -pipe -o .libs/evmctl evmctl-evmctl.o evmctl-utils.o evmctl-pcr_tsspcrread.o  -lcrypto -lkeyutils ./.libs/libimaevm.so
evmctl-evmctl.o: In function `main':
/home/travis/build/linux-integrity/ima-evm-utils/src/evmctl.c:2353: undefined reference to `ERR_free_strings'
/home/travis/build/linux-integrity/ima-evm-utils/src/evmctl.c:2354: undefined reference to `EVP_cleanup'
./.libs/libimaevm.so: undefined reference to `ERR_load_crypto_strings'
collect2: error: ld returned 1 exit status
Makefile:500: recipe for target 'evmctl' failed
make[3]: Leaving directory '/home/travis/build/linux-integrity/ima-evm-utils/src'
Makefile:378: recipe for target 'all' failed
make[2]: Leaving directory '/home/travis/build/linux-integrity/ima-evm-utils/src'
make[3]: *** [evmctl] Error 1
make[2]: *** [all] Error 2
Makefile:515: recipe for target 'all-recursive' failed
make[1]: Leaving directory '/home/travis/build/linux-integrity/ima-evm-utils'
make[1]: *** [all-recursive] Error 1
Makefile:381: recipe for target 'all' failed
make: *** [all] Error 2
The command "autoreconf -i && ./configure && make -j$(nproc) && sudo make install && VERBOSE=1 make check;" exited with 2.

thank,

Mimi
