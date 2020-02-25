Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CD16C2A8
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 14:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgBYNpF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 08:45:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729781AbgBYNpF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 08:45:05 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PDfd48119684
        for <linux-integrity@vger.kernel.org>; Tue, 25 Feb 2020 08:45:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1b8ky8f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 25 Feb 2020 08:45:04 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 25 Feb 2020 13:45:02 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Feb 2020 13:45:00 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PDj0OR44499140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 13:45:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07954AE055;
        Tue, 25 Feb 2020 13:45:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92565AE053;
        Tue, 25 Feb 2020 13:44:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.229.165])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 13:44:59 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
Date:   Tue, 25 Feb 2020 08:44:58 -0500
In-Reply-To: <63ba8482-0085-f2d3-dbb9-70bb81990f07@rosalinux.ru>
References: <63ba8482-0085-f2d3-dbb9-70bb81990f07@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022513-0008-0000-0000-000003564AAE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022513-0009-0000-0000-00004A776684
Message-Id: <1582638298.10443.196.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_04:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=4 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-02-16 at 14:10 +0300, Mikhail Novosyolov wrote:
> LibreSSL in most cases can be used as a drop-in replacement of OpenSSL.
> Commit 07d799cb6c37 "ima-evm-utils: Preload OpenSSL engine via '--engine' option"
> added OpenSSL-specific functions: "engines" were removed from LibreSSL long ago.
> Instead of requiring to attach GOST support via an external library ("engine"),
> LibreSSL has build-in implementation of GOST.

OpenSSL had a builtin support for GOST, which was dropped.  From the
OpenSSL news "Changes between 1.0.2h and 1.1.0":

    The GOST engine was out of date and therefore it has been removed. An up
    to date GOST engine is now being maintained in an external repository.
    See:     https://wiki.openssl.org/index.php/Binaries    .  Libssl still retains
    support for GOST ciphersuites (these are only activated if a GOST engine
    is present).

Please update the patch description to reflect the reason for OpenSSL
dropping GOST builtin support, while LibreSSL continues to build it
in.

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

Removing "engine support" is one logical change.  This sounds like it
is a separate issue and should be addressed in its own patch.

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
> ---
>  README          |  2 +-
>  src/evmctl.c    | 15 ++++++++++++++-
>  src/libimaevm.c |  2 ++
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/README b/README
> index 3603ae8..f843bbe 100644
> --- a/README
> +++ b/README
> @@ -58,7 +58,7 @@ OPTIONS
>        --smack        use extra SMACK xattrs for EVM
>        --m32          force EVM hmac/signature for 32 bit target system
>        --m64          force EVM hmac/signature for 64 bit target system
> -      --engine e     preload OpenSSL engine e (such as: gost)
> +      --engine e     preload OpenSSL engine e (such as: gost) (not valid for LibreSSL)
>    -v                 increase verbosity level
>    -h, --help         display this help and exit
>  
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 3d2a10b..f6507c1 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -62,7 +62,10 @@
>  #include <openssl/hmac.h>
>  #include <openssl/err.h>
>  #include <openssl/rsa.h>
> +/* LibreSSL removed engines */
> +#ifndef LIBRESSL_VERSION_NUMBER
>  #include <openssl/engine.h>
> +#endif

According to the LibreSSL wiki, both OpenSSL and LibreSSL may be
installed on the same system in separate directories.  Instead of
using LIBRESSL_VERSION_NUMBER, consider defining an autotools option.

thanks,

Mimi

>  
>  #ifndef XATTR_APPAARMOR_SUFFIX
>  #define XATTR_APPARMOR_SUFFIX "apparmor"
> @@ -1849,7 +1852,9 @@ static void usage(void)
>          "      --selinux      use custom Selinux label for EVM\n"
>          "      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
>          "      --list         measurement list verification\n"
> +#ifndef LIBRESSL_VERSION_NUMBER /* LibreSSL removed engines */
>          "      --engine e     preload OpenSSL engine e (such as: gost)\n"
> +#endif
>          "  -v                 increase verbosity level\n"
>          "  -h, --help         display this help and exit\n"
>          "\n");
> @@ -1902,7 +1907,9 @@ static struct option opts[] = {
>      {"selinux", 1, 0, 136},
>      {"caps", 2, 0, 137},
>      {"list", 0, 0, 138},
> +#ifndef LIBRESSL_VERSION_NUMBER
>      {"engine", 1, 0, 139},
> +#endif
>      {"xattr-user", 0, 0, 140},
>      {}
>  
> @@ -1947,7 +1954,9 @@ static char *get_password(void)
>  int main(int argc, char *argv[])
>  {
>      int err = 0, c, lind;
> +#ifndef LIBRESSL_VERSION_NUMBER
>      ENGINE *eng = NULL;
> +#endif
>  
>  #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>      OPENSSL_init_crypto(
> @@ -2065,7 +2074,8 @@ int main(int argc, char *argv[])
>          case 138:
>              measurement_list = 1;
>              break;
> -        case 139: /* --engine e */
> +#ifndef LIBRESSL_VERSION_NUMBER
> +        case 139: /* --engine e, only in OpenSSL, not in LibreSSL */
>              eng = ENGINE_by_id(optarg);
>              if (!eng) {
>                  log_err("engine %s isn't available\n", optarg);
> @@ -2078,6 +2088,7 @@ int main(int argc, char *argv[])
>              }
>              ENGINE_set_default(eng, ENGINE_METHOD_ALL);
>              break;
> +#endif
>          case 140: /* --xattr-user */
>              xattr_ima = "user.ima";
>              xattr_evm = "user.evm";
> @@ -2108,6 +2119,7 @@ int main(int argc, char *argv[])
>          }
>      }
>  
> +#ifndef LIBRESSL_VERSION_NUMBER
>      if (eng) {
>          ENGINE_finish(eng);
>          ENGINE_free(eng);
> @@ -2115,6 +2127,7 @@ int main(int argc, char *argv[])
>          ENGINE_cleanup();
>  #endif
>      }
> +#endif
>      ERR_free_strings();
>      EVP_cleanup();
>      BIO_free(NULL);
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 7c17bf4..050ea78 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -71,8 +71,10 @@ static const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>      [PKEY_HASH_SHA384]    = "sha384",
>      [PKEY_HASH_SHA512]    = "sha512",
>      [PKEY_HASH_SHA224]    = "sha224",
> +#ifndef LIBRESSL_VERSION_NUMBER
>      [PKEY_HASH_STREEBOG_256] = "md_gost12_256",
>      [PKEY_HASH_STREEBOG_512] = "md_gost12_512",
> +#endif
>  };
>  
>  /* Names that are primary for the kernel. */

