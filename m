Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E19C372A60
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 14:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhEDMwF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 08:52:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230187AbhEDMwB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 08:52:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 144CXJ8D011282;
        Tue, 4 May 2021 08:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RwjPJIXDaZ5lR8VGBoDTgeYJGqLmhDNAEdFjyuhqMU0=;
 b=omNoT6e0KeEDQMoB0Qd8f+AiStMl1prgWz8MakVbjy3nRyXb1KLJrdFFCYTndXFxIKtQ
 zuQxf/PRDhJjq7tawAPHuevZsnfd5AEMDQzaxWlVxnuT5hwr0cG7Kf4szY3JlNWFawXV
 rBVJkBfWmpjD3pWt6W/21pD297XT7vwP6Hdh5fCaAlESTv7oJNLW3RJLHOkO+w9dDUlX
 Ch9f5MTUhqAROuwZBlFsV8gnOKQlkUWpdu/Jn7rTytTqUFP6RK/oFDy3/c4xyLcUCJ9m
 AIJ1qN10X17xLI6NZoH86M523x6xqbEnc1tC57ELL0eAEvHgD/iLsiLc8Gb61CuOCJdw Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38b63ds0mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 08:51:05 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 144CXSKK012535;
        Tue, 4 May 2021 08:51:04 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38b63ds0m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 08:51:04 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 144CR7CI000739;
        Tue, 4 May 2021 12:51:04 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 388xm8wasd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 12:51:04 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 144Cp3lH47710574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 May 2021 12:51:03 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9953AE05F;
        Tue,  4 May 2021 12:51:03 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8717AE05C;
        Tue,  4 May 2021 12:51:03 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 May 2021 12:51:03 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter0@gmail.com>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-2-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <3caf1395-78ef-936f-4c8a-dbd56d0b6fea@linux.ibm.com>
Date:   Tue, 4 May 2021 08:51:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210504043357.4093409-2-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9fwQBBABTq8o57f-8XH09ugynOI7E7R1
X-Proofpoint-GUID: 9A5Y-JkCBfOvT1cYmHwKw-JTf9Eu1ENt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_07:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040093
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/4/21 12:33 AM, Vitaly Chikunov wrote:
> Allow user to set signature's keyid using `--keyid' option. Keyid should
> correspond to SKID in certificate, when keyid is calculated using SHA-1
> in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> certificate (the way public key is presented to the kernel), thus making
> signatures not verifiable. This may happen when certificate is using non
> SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> As a last resort user may specify arbitrary keyid using the new option.
>
> This commit creates backward compatible ABI change for libimaevm,
> because of adding additional parameter to imaevm_params - older
> libimaevm can work with newer client.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> Reported-by: Elvira Khabirova <lineprinter0@gmail.com>
> ---
>   README                 |  1 +
>   src/evmctl.c           | 14 ++++++++++++++
>   src/imaevm.h           |  1 +
>   src/libimaevm.c        |  8 +++++---
>   tests/sign_verify.test |  1 +
>   5 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/README b/README
> index 321045d..8cd66e0 100644
> --- a/README
> +++ b/README
> @@ -48,6 +48,7 @@ OPTIONS
>         --xattr-user   store xattrs in user namespace (for testing purposes)
>         --rsa          use RSA key type and signing scheme v1
>     -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
> +      --keyid val    overwrite signature keyid with a value (for signing)
>     -o, --portable     generate portable EVM signatures
>     -p, --pass         password for encrypted signing key
>     -r, --recursive    recurse into directories (sign)
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 1815f55..7983299 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2446,6 +2446,7 @@ static void usage(void)
>   		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
>   		"      --rsa          use RSA key type and signing scheme v1\n"
>   		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
> +		"      --keyid val    overwrite signature keyid with a value (for signing)\n"
>   		"  -o, --portable     generate portable EVM signatures\n"
>   		"  -p, --pass         password for encrypted signing key\n"
>   		"  -r, --recursive    recurse into directories (sign)\n"
> @@ -2525,6 +2526,7 @@ static struct option opts[] = {
>   	{"xattr-user", 0, 0, 140},
>   	{"ignore-violations", 0, 0, 141},
>   	{"pcrs", 1, 0, 142},
> +	{"keyid", 1, 0, 143},
>   	{}
>   
>   };
> @@ -2569,6 +2571,8 @@ int main(int argc, char *argv[])
>   {
>   	int err = 0, c, lind;
>   	ENGINE *eng = NULL;
> +	unsigned long int keyid;
> +	char *eptr;
>   
>   #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>   	OPENSSL_init_crypto(
> @@ -2713,6 +2717,16 @@ int main(int argc, char *argv[])
>   			}
>   			pcrfile[npcrfile++] = optarg;
>   			break;
> +		case 143:
> +			errno = 0;
> +			keyid = strtoul(optarg, &eptr, 16);
> +			if (errno || eptr - optarg != strlen(optarg) ||
> +			    keyid > UINT_MAX || keyid == 0) {
> +				log_err("Invalid keyid value.\n");
> +				exit(1);
> +			}
> +			imaevm_params.keyid = keyid;
> +			break;
>   		case '?':
>   			exit(1);
>   			break;
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 4503919..9f38059 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -196,6 +196,7 @@ struct libimaevm_params {
>   	const char *hash_algo;
>   	const char *keyfile;
>   	const char *keypass;
> +	uint32_t keyid;		/* keyid overriding value, unless 0. */
>   };
>   
>   struct RSA_ASN1_template {
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index fa6c278..481d29d 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -45,6 +45,7 @@
>   #include <sys/param.h>
>   #include <sys/stat.h>
>   #include <asm/byteorder.h>
> +#include <arpa/inet.h>
>   #include <unistd.h>
>   #include <dirent.h>
>   #include <string.h>
> @@ -894,7 +895,6 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>   	const EVP_MD *md;
>   	size_t sigsize;
>   	const char *st;
> -	uint32_t keyid;
>   
>   	if (!hash) {
>   		log_err("sign_hash_v2: hash is null\n");
> @@ -932,8 +932,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
>   		return -1;
>   	}
>   
> -	calc_keyid_v2(&keyid, name, pkey);
> -	hdr->keyid = keyid;
> +	if (imaevm_params.keyid)
> +		hdr->keyid = htonl(imaevm_params.keyid);


Nit: Since existing code uses __be32_to_cpup I would use __cpu_to_be32 here.


> +	else
> +		calc_keyid_v2(&hdr->keyid, name, pkey);
>   
>   	st = "EVP_PKEY_CTX_new";
>   	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 288e133..2c21812 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -359,6 +359,7 @@ sign_verify  rsa1024  sha256  0x0301 --rsa
>   sign_verify  rsa1024  md5     0x030201:K:0080
>   sign_verify  rsa1024  sha1    0x030202:K:0080
>   sign_verify  rsa1024  sha224  0x030207:K:0080
> +expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
>   sign_verify  rsa1024  sha256  0x030204:K:0080
>     try_different_keys
>     try_different_sigs


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

