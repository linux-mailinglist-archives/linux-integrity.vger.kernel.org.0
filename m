Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62397374BC2
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 01:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhEEXOn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 19:14:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229465AbhEEXOm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 19:14:42 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145N3cgT056370;
        Wed, 5 May 2021 19:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zFk1WImFzRgie2JdWdewXOfGt2cRqQkUOaOzkku4/aQ=;
 b=kLg5xKzaZMVYk1S2oISLkwijbKku4CDINu3N+aO96p5SBdbbOZ+cxumP6+SvmfDzS4QK
 Wctm2zJPJKaLV1sW9X0wNasUTIu4SBXZne7Psq56uph4yL2ekryeEZIPDWhWPLxfT43U
 XJOHQ1koTqi+9a03Yn6608ruJXjNmxMxTVXtS+kKPo/XQs5YdzRpDShoImakAz05meYh
 axL7wQ4xTWH+g30RfMKv2mGvfxD2rOj/6pn/i+Ce1PQdWuSCyCfxV3e+CUJLqWxs4h1w
 2t+YcUYekiuSH/bhC6gtUBWvYKRBCuw09/XziE8wmzuyjmRpUMvBfrDUOQqgTcln32Tg XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38c2ngax2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 19:13:43 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 145N49UY062110;
        Wed, 5 May 2021 19:13:42 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38c2ngax26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 19:13:42 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 145N8AYT001739;
        Wed, 5 May 2021 23:13:42 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 38bee0shws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 23:13:41 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 145NDeSu26739170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 May 2021 23:13:40 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9266136053;
        Wed,  5 May 2021 23:13:40 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72AF313604F;
        Wed,  5 May 2021 23:13:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 May 2021 23:13:40 +0000 (GMT)
Subject: Re: [PATCH v4 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210505064843.111900-1-vt@altlinux.org>
 <20210505064843.111900-3-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <ed882d26-47a8-9b45-6c96-83d2f64982f2@linux.ibm.com>
Date:   Wed, 5 May 2021 19:13:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210505064843.111900-3-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cs1Snbck5U55GcEn-eW7Ht4aWEObTnmu
X-Proofpoint-ORIG-GUID: Ye96nccRDvLMEuXHHoL_t9AL1viCXOjI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_11:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050159
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/5/21 2:48 AM, Vitaly Chikunov wrote:
> Allow user to specify `--keyid @/path/to/cert.pem' to extract keyid from
> SKID of the certificate file. PEM or DER format is auto-detected.
>
> `--keyid' option is reused instead of adding a new option (like possible
> `--cert') to signify to the user it's only keyid extraction and nothing
> more.
>
> This commit creates ABI change for libimaevm, due to adding new function
> ima_read_keyid(). Newer clients cannot work with older libimaevm.
> Together with previous commit it creates backward-incompatible ABI
> change, thus soname should be incremented on release.
>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>   README                 |  1 +
>   src/evmctl.c           | 22 ++++++++++---
>   src/imaevm.h           |  1 +
>   src/libimaevm.c        | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/sign_verify.test |  1 +
>   5 files changed, 105 insertions(+), 5 deletions(-)
>
> diff --git a/README b/README
> index 8cd66e0..0e1f6ba 100644
> --- a/README
> +++ b/README
> @@ -49,6 +49,7 @@ OPTIONS
>         --rsa          use RSA key type and signing scheme v1
>     -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
>         --keyid val    overwrite signature keyid with a value (for signing)
> +                     val is a x509 cert file if prefixed with '@'
>     -o, --portable     generate portable EVM signatures
>     -p, --pass         password for encrypted signing key
>     -r, --recursive    recurse into directories (sign)
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 8ae5488..6a60599 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -42,6 +42,7 @@
>   #include <sys/param.h>
>   #include <sys/stat.h>
>   #include <sys/ioctl.h>
> +#include <arpa/inet.h>
>   #include <fcntl.h>
>   #include <unistd.h>
>   #include <stdlib.h>
> @@ -57,12 +58,14 @@
>   #include <termios.h>
>   #include <assert.h>
>   
> +#include <openssl/asn1.h>
>   #include <openssl/sha.h>
>   #include <openssl/pem.h>
>   #include <openssl/hmac.h>
>   #include <openssl/err.h>
>   #include <openssl/rsa.h>
>   #include <openssl/engine.h>
> +#include <openssl/x509v3.h>
>   #include "hash_info.h"
>   #include "pcr.h"
>   #include "utils.h"
> @@ -2447,6 +2450,7 @@ static void usage(void)
>   		"      --rsa          use RSA key type and signing scheme v1\n"
>   		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
>   		"      --keyid val    overwrite signature keyid with a value (for signing)\n"
> +		"                     val is a x509 cert file if prefixed with '@'\n"
>   		"  -o, --portable     generate portable EVM signatures\n"
>   		"  -p, --pass         password for encrypted signing key\n"
>   		"  -r, --recursive    recurse into directories (sign)\n"
> @@ -2572,7 +2576,6 @@ int main(int argc, char *argv[])
>   	int err = 0, c, lind;
>   	ENGINE *eng = NULL;
>   	unsigned long keyid;
> -	char *eptr;
>   
>   #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>   	OPENSSL_init_crypto(
> @@ -2718,10 +2721,19 @@ int main(int argc, char *argv[])
>   			pcrfile[npcrfile++] = optarg;
>   			break;
>   		case 143:
> -			errno = 0;
> -			keyid = strtoul(optarg, &eptr, 16);
> -			if (errno || eptr - optarg != strlen(optarg) ||
> -			    keyid == ULONG_MAX || keyid > UINT_MAX ||
> +			if (optarg[0] == '@') {
> +				keyid = ima_read_keyid(optarg + 1, NULL);
> +			} else {
> +				char *eptr;
> +
> +				errno = 0;
> +				keyid = strtoul(optarg, &eptr, 16);
> +				if (eptr - optarg != strlen(optarg) || errno) {
> +					log_err("Invalid keyid value.\n");
> +					exit(1);
> +				}
> +			}
> +			if (keyid == ULONG_MAX || keyid > UINT_MAX ||
>   			    keyid == 0) {
>   				log_err("Invalid keyid value.\n");
>   				exit(1);
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 9f38059..eab7f32 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -219,6 +219,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
>   void calc_keyid_v1(uint8_t *keyid, char *str, const unsigned char *pkey, int len);
>   void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
>   int key2bin(RSA *key, unsigned char *pub);
> +unsigned long ima_read_keyid(const char *certfile, uint32_t *keyid);
>   
>   int sign_hash(const char *algo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig);
>   int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig, int siglen);
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 481d29d..a22d9bb 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -57,6 +57,7 @@
>   #include <openssl/pem.h>
>   #include <openssl/evp.h>
>   #include <openssl/x509.h>
> +#include <openssl/x509v3.h>
>   #include <openssl/err.h>
>   
>   #include "imaevm.h"
> @@ -748,6 +749,90 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
>   	X509_PUBKEY_free(pk);
>   }
>   
> +enum keyid_file_type {
> +	KEYID_FILE_PEM_KEY = 0,
> +	KEYID_FILE_UNK_CERT,
> +};
> +
> +/*
> + * @is_cert: 1 - this is a x509 cert file (maybe PEM, maybe DER encoded);
This probably change since you wrote it. Is this file_type now?
> + *           0 - this is a PEM encoded private key file with possible appended
> + *           x509 cert.
> + */
> +static unsigned long _ima_read_keyid(const char *certfile, uint32_t *keyid,
> +				     enum keyid_file_type file_type)
> +{
> +	uint32_t keyid_raw;
> +	const ASN1_OCTET_STRING *skid;
> +	int skid_len;
> +	X509 *x = NULL;
> +	FILE *fp;
> +
> +	if (!(fp = fopen(certfile, "r"))) {
> +		log_err("read keyid: %s: Cannot open: %s\n", certfile,
> +			strerror(errno));
> +		return -1;
> +	}
> +	if (!PEM_read_X509(fp, &x, NULL, NULL)) {
> +		if (ERR_GET_REASON(ERR_peek_last_error()) == PEM_R_NO_START_LINE) {
> +			ERR_clear_error();
> +			if (file_type == KEYID_FILE_PEM_KEY) {
> +				log_debug("%s: x509 certificate not found\n",
> +					  certfile);
> +				fclose(fp);
> +				return -1;
> +			}
> +			rewind(fp);
> +			d2i_X509_fp(fp, &x);
> +		}
> +		if (!x) {
> +			ERR_print_errors_fp(stderr);
> +			log_err("read keyid: %s: Error reading x509 certificate\n",
> +				certfile);
> +			fclose(fp);
> +			return -1;
> +		}
> +	}
> +	fclose(fp);
> +
> +	if (!(skid = X509_get0_subject_key_id(x))) {
> +		log_err("read keyid: %s: SKID not found\n", certfile);
> +		goto err_free;
> +	}
> +	skid_len = ASN1_STRING_length(skid);
> +	if (skid_len < sizeof(keyid_raw)) {
> +		log_err("read keyid: %s: SKID too short (len %d)\n", certfile,
> +			skid_len);
> +		goto err_free;
> +	}
> +	memcpy(&keyid_raw, ASN1_STRING_get0_data(skid) + skid_len
> +	       - sizeof(keyid_raw), sizeof(keyid_raw));
> +	if (keyid)
> +		memcpy(keyid, &keyid_raw, sizeof(*keyid));


If keyid is supposed to be in native format then you have to apply 
ntohl() to it..


> +	log_info("keyid %04x (from %s)\n", ntohl(keyid_raw), certfile);
> +	return ntohl(keyid_raw);

I thought this should return 0  ?


> +
> +err_free:
> +	X509_free(x);
> +	return -1;
> +}
> +
> +/**
> + * ima_read_keyid() - Read 32-bit keyid from the cert file.
> + * @certfile:	File possibly containing certificate in DER/PEM format.
> + * @keyid:	Output keyid in network order.
> + *
> + * Try to read keyid from Subject Key Identifier (SKID) of certificate.
> + * Autodetect if cert is in PEM or DER encoding.
> + *
> + * Return: -1 (ULONG_MAX) on error;
> + *         32-bit keyid as unsigned integer in host order.
That's confusing, two times the same result, one time in host order, on 
time in network order. Why not just one return value in host order?
> + */
> +unsigned long ima_read_keyid(const char *certfile, uint32_t *keyid)
> +{
> +	return _ima_read_keyid(certfile, keyid, KEYID_FILE_UNK_CERT);
> +}
> +
>   static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
>   {
>   	FILE *fp;
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 2c21812..52ea33a 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -360,6 +360,7 @@ sign_verify  rsa1024  md5     0x030201:K:0080
>   sign_verify  rsa1024  sha1    0x030202:K:0080
>   sign_verify  rsa1024  sha224  0x030207:K:0080
>   expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
> +expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204:K:0080 OPTS=--keyid=@test-rsa1024.cer
>   sign_verify  rsa1024  sha256  0x030204:K:0080
>     try_different_keys
>     try_different_sigs
