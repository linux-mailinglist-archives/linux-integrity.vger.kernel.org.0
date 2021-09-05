Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60AD400DC0
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Sep 2021 03:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhIEBMB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Sep 2021 21:12:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38388 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230349AbhIEBMB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Sep 2021 21:12:01 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18513EQC046237;
        Sat, 4 Sep 2021 21:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/g7TD+qZZG3vVw5EqnKUVZOcGGdEoixsdHxN/0odzTM=;
 b=TTz7YOXAK7EE7p92BdymZ+DziBmle1BMNPDqA6XGWNjoIv+q90kv2soORcmK1KLoPhCb
 PJsdZW88kc3o06ZUfmaXYb/h8WlMHX2dlPtp6Gg+ruWxHzNV+QPGGmfdDivODVVrZJ+O
 TqR8BCvSXK4QJN/xJ4QRBkZtL0nLGWm3QefTXfuGXZcPbrw4UwZQcRuMAuFkj2n+RFkF
 73llFb9Sw44eVdWYwGugtw7FU1iwXYk/+DmNea70HkCB917+6ogKh+sQ/E+4jzjWd2P0
 ZFwbjLDWpl5jnLn1a4xwcIBtwNJwbfrZ/wAZZPA4KlxXa9aiExenBgI7NJL0wb5C3wmI 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3avjgx9a4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Sep 2021 21:10:53 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18515B4o055939;
        Sat, 4 Sep 2021 21:10:52 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3avjgx9a41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Sep 2021 21:10:52 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18512sde024140;
        Sun, 5 Sep 2021 01:10:52 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3av0e82s9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Sep 2021 01:10:52 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1851ApcD24117580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 Sep 2021 01:10:51 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33AF2BE059;
        Sun,  5 Sep 2021 01:10:51 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDAAEBE051;
        Sun,  5 Sep 2021 01:10:50 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun,  5 Sep 2021 01:10:50 +0000 (GMT)
Subject: Re: [PATCH ima-evm-utils v4] evmctl: Use secure heap for private keys
 and passwords
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Bruno Meneguele <bmeneg@redhat.com>
References: <20210904105054.3388329-1-vt@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <cee7b810-e9fd-9924-a8dd-9cc1e3211bd7@linux.ibm.com>
Date:   Sat, 4 Sep 2021 21:10:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210904105054.3388329-1-vt@altlinux.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tdPi1ECVfMfz1Wr9yZeYlAUGVkqv5yUV
X-Proofpoint-ORIG-GUID: C471u1zWiCVxAOqSb0wNfmRT7GwH5CzF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-04_09:2021-09-03,2021-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109050005
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/4/21 6:50 AM, Vitaly Chikunov wrote:
> After CRYPTO_secure_malloc_init OpenSSL will automatically store private
> keys in secure heap. OPENSSL_secure_malloc(3):
>
>    If a secure heap is used, then private key BIGNUM values are stored
>    there. This protects long-term storage of private keys, but will not
>    necessarily put all intermediate values and computations there.
>
> Additionally, we try to keep user passwords in secure heap too.
> This facility is only available since OpenSSL_1_1_0-pre1.
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> ---
> Change since v3:
> - Undo secure heap handling from (file2bin and) calc_evm_hmac since this
>    is debugging tool only. Add comment about this.
> - Since there is only code removals and new comments I keep Reviewed-by
>    tag.
>
>   src/evmctl.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 85 insertions(+), 12 deletions(-)
>
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 5f7c2b8..7bd20f8 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -59,6 +59,7 @@
>   #include <assert.h>
>   
>   #include <openssl/asn1.h>
> +#include <openssl/crypto.h>
>   #include <openssl/sha.h>
>   #include <openssl/pem.h>
>   #include <openssl/hmac.h>
> @@ -165,6 +166,24 @@ struct tpm_bank_info {
>   static char *pcrfile[MAX_PCRFILE];
>   static unsigned npcrfile;
>   
> +#if OPENSSL_VERSION_NUMBER <= 0x10100000
> +#warning Your OpenSSL version is too old to have OPENSSL_secure_malloc, \
> +	falling back to use plain OPENSSL_malloc.
> +#define OPENSSL_secure_malloc	  OPENSSL_malloc
> +#define OPENSSL_secure_free	  OPENSSL_free
> +/*
> + * Secure heap memory automatically cleared on free, but
> + * OPENSSL_secure_clear_free will be used in case of fallback
> + * to plain OPENSSL_malloc.
> + */
> +#define OPENSSL_secure_clear_free OPENSSL_clear_free
> +#define OPENSSL_clear_free(ptr, num)		\
> +	do {					\
> +		OPENSSL_cleanse(ptr, num);	\
> +		OPENSSL_free(ptr);		\
> +	} while (0)
> +#endif
> +
>   static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
>   {
>   	FILE *fp;
> @@ -1072,6 +1091,7 @@ static int cmd_setxattr_ima(struct command *cmd)
>   
>   #define MAX_KEY_SIZE 128
>   
> +/* This function is debugging tool and should not be used for real private data. */
>   static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
>   {
>           const EVP_MD *md;
> @@ -2596,15 +2616,41 @@ static struct option opts[] = {
>   
>   };
>   
> +/*
> + * Copy password from optarg into secure heap, so it could be
> + * freed in the same way as a result of get_password().
> + */
> +static char *optarg_password(char *optarg)
> +{


Mimi applied my patch that takes the password from an environment 
variable to the next-testing branch. The code there 
(imaevm_params.keypass  = getenv("..."))would have to change as well 
calling this function here. Even though the man page of getenv says that 
'The caller must take care not to modify this string, since that would 
change the environment of the process' we should be able to overwrite 
the env variable's password value just like here. Maybe for this purpose 
rename this function to dup_password() ?


> +	size_t len;
> +	char *keypass;
> +
> +	if (!optarg)
> +		return NULL;
> +	len = strlen(optarg);
> +	keypass = OPENSSL_secure_malloc(len + 1);
> +	if (keypass)
> +		memcpy(keypass, optarg, len + 1);
> +	else
> +		log_err("OPENSSL_secure_malloc(%zu) failed\n", len + 1);
> +	/*
> +	 * This memset does not add real security, just increases
> +	 * the chance of password being obscured in ps output.
> +	 */
> +	memset(optarg, 'X', len);
> +	return keypass;
> +}
> +
> +/* Read from TTY into secure heap. */
>   static char *get_password(void)
>   {
>   	struct termios flags, tmp_flags;
>   	char *password, *pwd;
> -	int passlen = 64;
> +	const int passlen = 64;
>   
> -	password = malloc(passlen);
> +	password = OPENSSL_secure_malloc(passlen);
>   	if (!password) {
> -		perror("malloc");
> +		log_err("OPENSSL_secure_malloc(%u) failed\n", passlen);
>   		return NULL;
>   	}
>   
> @@ -2614,8 +2660,8 @@ static char *get_password(void)
>   	tmp_flags.c_lflag |= ECHONL;
>   
>   	if (tcsetattr(fileno(stdin), TCSANOW, &tmp_flags) != 0) {
> -		perror("tcsetattr");
> -		free(password);
> +		log_err("tcsetattr: %s\n", strerror(errno));
> +		OPENSSL_secure_free(password);
>   		return NULL;
>   	}
>   
> @@ -2624,13 +2670,15 @@ static char *get_password(void)
>   
>   	/* restore terminal */
>   	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
> -		perror("tcsetattr");
> -		free(password);
> -		return NULL;
> +		log_err("tcsetattr: %s\n", strerror(errno));
> +		/*
> +		 * Password is already here, so there is no reason
> +		 * to stop working on this petty error.
> +		 */
>   	}
>   
>   	if (pwd == NULL) {
> -		free(password);
> +		OPENSSL_secure_free(password);
>   		return NULL;
>   	}
>   
> @@ -2643,6 +2691,7 @@ int main(int argc, char *argv[])
>   	ENGINE *eng = NULL;
>   	unsigned long keyid;
>   	char *eptr;
> +	char *keypass = NULL; /* @secure heap */
>   
>   #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>   	OPENSSL_init_crypto(
> @@ -2651,6 +2700,17 @@ int main(int argc, char *argv[])
>   #endif
>   			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
>   #endif
> +#if OPENSSL_VERSION_NUMBER > 0x10100000
> +	/*
> +	 * This facility is available since OpenSSL_1_1_0-pre1.


Shouldn't the comparison then not include 0x10100000?

#if OPENSSL_VERSION_NUMBER >= 0x10100000



> +	 * 'Heap size' 8192 is chosen to be big enough, so that any single key
> +	 * data could fit. 'Heap minsize' 64 is just to be efficient for small
> +	 * buffers.
> +	 */
> +	if (!CRYPTO_secure_malloc_init(8192, 64))
> +		log_err("CRYPTO_secure_malloc_init() failed\n");
> +#endif
> +
>   	g_argv = argv;
>   	g_argc = argc;
>   
> @@ -2682,10 +2742,18 @@ int main(int argc, char *argv[])
>   			imaevm_params.hash_algo = optarg;
>   			break;
>   		case 'p':
> +			if (keypass)
> +				OPENSSL_secure_clear_free(keypass,
> +							  strlen(keypass));
>   			if (optarg)
> -				imaevm_params.keypass = optarg;
> +				keypass = optarg_password(optarg);
>   			else
> -				imaevm_params.keypass = get_password();
> +				keypass = get_password();
> +			if (!keypass) {
> +				log_err("Cannot read password\n");
> +				goto quit;
> +			}
> +			imaevm_params.keypass = keypass;
>   			break;
>   		case 'f':
>   			sigfile = 1;
> @@ -2841,7 +2909,9 @@ int main(int argc, char *argv[])
>   		if (err < 0)
>   			err = 125;
>   	}
> -
> +quit:
> +	if (keypass)
> +		OPENSSL_secure_clear_free(keypass, strlen(keypass));
>   	if (eng) {
>   		ENGINE_finish(eng);
>   		ENGINE_free(eng);
> @@ -2849,6 +2919,9 @@ int main(int argc, char *argv[])
>   		ENGINE_cleanup();
>   #endif
>   	}
> +#if OPENSSL_VERSION_NUMBER > 0x10100000
same comment here
> +	CRYPTO_secure_malloc_done();
> +#endif
>   	ERR_free_strings();
>   	EVP_cleanup();
>   	BIO_free(NULL);
