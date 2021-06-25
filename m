Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF63B4312
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 14:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFYMYU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 08:24:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhFYMYT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 08:24:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PCC23A191507;
        Fri, 25 Jun 2021 08:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=BT4/H6SZkHxuTiVEN9caH6rOt61lkun899XQoMsdxuU=;
 b=UMFanZ0k3ZgyejDGH2I00Hn0y7Ahm3w72vrFYoKFnL5d56Kl0gFyfuOisNyxEg1DpH+6
 9Kvp8HADXbefJsbnaPwIwWmN6aPVX5FTK9tUYQHS9tNdDfkfZyNQ7goCyohyFmF2Rdfz
 Xruui8N4JC4NKNXyPS13CeXLRy07EGBoDtbJ59P8NOgKt4jm4t/oLlF6E5PC14iH1fVd
 RRe+CKmR+QYUQiqplPYyUOFIwEVT89806nU8v4flxG5yqRp+ZEUCjMgbs0Udji7OQ/E8
 YeDfEelxTPrsZnKRFBqsUIvmjxBoNhHpEh04pYGIVFb2Q3CgJJsa9pO3LLu4Rp31cDcu tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39dd1mvep4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:21:54 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15PCF6b6005810;
        Fri, 25 Jun 2021 08:21:53 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39dd1mvemp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:21:53 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15PCDiQj023562;
        Fri, 25 Jun 2021 12:21:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3997uhb13r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 12:21:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15PCLm8q29753642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:21:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 906484204B;
        Fri, 25 Jun 2021 12:21:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5760142041;
        Fri, 25 Jun 2021 12:21:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.9.226])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jun 2021 12:21:47 +0000 (GMT)
Message-ID: <004b55594ab1d944e42dd7fd0d87df47b3c09114.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 25 Jun 2021 08:21:46 -0400
In-Reply-To: <20210511115630.795208-2-vt@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
         <20210511115630.795208-2-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uVvcOBoDMQn4xAMUKQfMVeiB2pDsgXar
X-Proofpoint-ORIG-GUID: nnKOvmhKnnXTFYt2RDAKowZBXQV70QSn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_04:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-05-11 at 14:56 +0300, Vitaly Chikunov wrote:
> Allow user to set signature's keyid using `--keyid' option. Keyid should
> correspond to SKID in certificate, when keyid is calculated using SHA-1
> in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> certificate (the way public key is presented to the kernel), thus making
> signatures not verifiable. This may happen when certificate is using non
> SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> As a last resort user may specify arbitrary keyid using the new option.
> 
> This commit creates ABI change for libimaevm, because of adding
> additional parameter to imaevm_params - newer libimaevm cannot work
> with older clients.

Thank you for highlighting the ABI change.

> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> Reported-by: Elvira Khabirova <lineprinter0@gmail.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  README                 |  1 +
>  src/evmctl.c           | 15 +++++++++++++++
>  src/imaevm.h           |  1 +
>  src/libimaevm.c        |  8 +++++---
>  tests/sign_verify.test |  1 +
>  5 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/README b/README
> index 321045d..8cd66e0 100644
> --- a/README
> +++ b/README
> @@ -48,6 +48,7 @@ OPTIONS
>        --xattr-user   store xattrs in user namespace (for testing purposes)
>        --rsa          use RSA key type and signing scheme v1
>    -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
> +      --keyid val    overwrite signature keyid with a value (for signing)
>    -o, --portable     generate portable EVM signatures
>    -p, --pass         password for encrypted signing key
>    -r, --recursive    recurse into directories (sign)
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 7a6f202..d853d34 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2514,6 +2514,7 @@ static void usage(void)
>  		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
>  		"      --rsa          use RSA key type and signing scheme v1\n"
>  		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
> +		"      --keyid val    overwrite signature keyid with a value (for signing)\n"
>  		"  -o, --portable     generate portable EVM signatures\n"
>  		"  -p, --pass         password for encrypted signing key\n"
>  		"  -r, --recursive    recurse into directories (sign)\n"
> @@ -2594,6 +2595,7 @@ static struct option opts[] = {
>  	{"ignore-violations", 0, 0, 141},
>  	{"pcrs", 1, 0, 142},
>  	{"verify-bank", 2, 0, 143},
> +	{"keyid", 1, 0, 144},
>  	{}
> 
>  };
> @@ -2638,6 +2640,8 @@ int main(int argc, char *argv[])
>  {
>  	int err = 0, c, lind;
>  	ENGINE *eng = NULL;
> +	unsigned long keyid;
> +	char *eptr;
> 
>  #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>  	OPENSSL_init_crypto(
> @@ -2785,6 +2789,17 @@ int main(int argc, char *argv[])
>  		case 143:
>  			verify_bank = optarg;
>  			break;
> +		case 144:
> +			errno = 0;
> +			keyid = strtoul(optarg, &eptr, 16);
> +			if (errno || eptr - optarg != strlen(optarg) ||

Before using eptr, shouldn't there be a null test?  It's unclear what
verifying the resulting string length against the user provided length
provides.   Requiring the optarg value to be prefixed with "0x" would
simplify the strlen test.  The length would be 2 * sizeof uint + 2.  
(The subsequent patch wouldn't need a contrived prefix.)

> +			    keyid == ULONG_MAX || keyid > UINT_MAX ||

Why are both of these tests required?  When ULONG_MAX and UINT_MAX
aren't the same, wouldn't ULONG_MAX always be bigger than UINT_MAX?

> +			    keyid == 0) {
> +				log_err("Invalid keyid value.\n");
> +				exit(1);
> +			}
> +			imaevm_params.keyid = keyid;
> +			break;
>  		case '?':
>  			exit(1);
>  			break;
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 4503919..9f38059 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -196,6 +196,7 @@ struct libimaevm_params {
>  	const char *hash_algo;
>  	const char *keyfile;
>  	const char *keypass;
> +	uint32_t keyid;		/* keyid overriding value, unless 0. */

If keyid is suppose to be big endiran format, please annotate it in the
comment.

>  };
> 
>  struct RSA_ASN1_template {
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index fa6c278..481d29d 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -45,6 +45,7 @@
>  #include <sys/param.h>
>  #include <sys/stat.h>
>  #include <asm/byteorder.h>
> +#include <arpa/inet.h>
>  #include <unistd.h>
>  #include <dirent.h>
>  #include <string.h>
> @@ -894,7 +895,6 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>  	const EVP_MD *md;
>  	size_t sigsize;
>  	const char *st;
> -	uint32_t keyid;
> 
>  	if (!hash) {
>  		log_err("sign_hash_v2: hash is null\n");
> @@ -932,8 +932,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>  		return -1;
>  	}
> 
> -	calc_keyid_v2(&keyid, name, pkey);
> -	hdr->keyid = keyid;
> +	if (imaevm_params.keyid)
> +		hdr->keyid = htonl(imaevm_params.keyid);
> +	else
> +		calc_keyid_v2(&hdr->keyid, name, pkey);
> 
At what point should imaevm_params.keyid be converted to big endian -
on usage or setting it?

Mimi

>  	st = "EVP_PKEY_CTX_new";
>  	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 3d7aa51..eccf5fa 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -365,6 +365,7 @@ sign_verify  rsa1024  sha256  0x0301 --rsa
>  sign_verify  rsa1024  md5     0x030201:K:0080
>  sign_verify  rsa1024  sha1    0x030202:K:0080
>  sign_verify  rsa1024  sha224  0x030207:K:0080
> +expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
>  sign_verify  rsa1024  sha256  0x030204:K:0080
>    try_different_keys
>    try_different_sigs


