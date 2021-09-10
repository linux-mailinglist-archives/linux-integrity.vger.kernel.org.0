Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E66406DCD
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Sep 2021 16:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhIJO4Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Sep 2021 10:56:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229749AbhIJO4Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Sep 2021 10:56:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AEXRSg181218;
        Fri, 10 Sep 2021 10:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9c8oQo10XofWDvJ0s/mVVE148AxZQsmIm+H1ubSxxQg=;
 b=hNeq3vMRuZhC959OUqZrmsqAVt6+00pOAsdpXatTQj4tLumFV2UdnvU0BimQhB+9DWXI
 ncPD8cla72omwOGlnmpIjBg4cy7Tfh3JvbS9O22bfe4ypHedHiigDjBNmLGvHKFabdIi
 u3uVGOGnHqTv9K9Q4HbCmHVLy0rhsoBiqPLNLzIn1MXW7DuLiW+PRbw2xpY4hw/EK3aK
 fX+zng63DAX/mKFh6oDpDi98ST/vq1k88d66Nq3BWj1V30hLc9g76LV9kCfzcRrmf7h0
 yY34KO6VY9mSWFLF0pG7O1N6JDSbKbDdg9BDOy8kF9wRVjm7VtH0RDOyif2cZ8rQZx70 +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b01ryawh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 10:55:11 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18AEXjgs185263;
        Fri, 10 Sep 2021 10:55:11 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b01ryawgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 10:55:10 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18AErRGZ013302;
        Fri, 10 Sep 2021 14:55:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3axcnqhbt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 14:55:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18AEt6m949938922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 14:55:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4C7911C05E;
        Fri, 10 Sep 2021 14:55:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADDBB11C054;
        Fri, 10 Sep 2021 14:55:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.55.253])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Sep 2021 14:55:05 +0000 (GMT)
Message-ID: <413f31067da8a63ecd76228e86505a9f4e5599f8.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4] evmctl: Use secure heap for private
 keys and passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Bruno Meneguele <bmeneg@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Fri, 10 Sep 2021 10:55:04 -0400
In-Reply-To: <20210904105054.3388329-1-vt@altlinux.org>
References: <20210904105054.3388329-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0l_bQwwCK2CiipGFvtj0wyUR3jDQbUD7
X-Proofpoint-GUID: 7ohyjwWz7-MYUziHVs-eZ8SpAoT73Pgc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_06:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-09-04 at 13:50 +0300, Vitaly Chikunov wrote:
> After CRYPTO_secure_malloc_init OpenSSL will automatically store private
> keys in secure heap. OPENSSL_secure_malloc(3):
> 
>   If a secure heap is used, then private key BIGNUM values are stored
>   there. This protects long-term storage of private keys, but will not
>   necessarily put all intermediate values and computations there.
> 
> Additionally, we try to keep user passwords in secure heap too.
> This facility is only available since OpenSSL_1_1_0-pre1.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
> Cc: Stefan Berger <stefanb@linux.ibm.com>

Thanks, it looks good!  Just a few questions inline below.

> ---
> Change since v3:
> - Undo secure heap handling from (file2bin and) calc_evm_hmac since this
>   is debugging tool only. Add comment about this.
> - Since there is only code removals and new comments I keep Reviewed-by
>   tag.
> 
>  src/evmctl.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 85 insertions(+), 12 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 5f7c2b8..7bd20f8 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -59,6 +59,7 @@
>  #include <assert.h>
> 
>  #include <openssl/asn1.h>
> +#include <openssl/crypto.h>
>  #include <openssl/sha.h>
>  #include <openssl/pem.h>
>  #include <openssl/hmac.h>
> @@ -165,6 +166,24 @@ struct tpm_bank_info {
>  static char *pcrfile[MAX_PCRFILE];
>  static unsigned npcrfile;
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
>  static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
>  {
>  	FILE *fp;
> @@ -1072,6 +1091,7 @@ static int cmd_setxattr_ima(struct command *cmd)
> 
>  #define MAX_KEY_SIZE 128
> 
> +/* This function is debugging tool and should not be used for real private data. */
>  static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
>  {
>          const EVP_MD *md;
> @@ -2596,15 +2616,41 @@ static struct option opts[] = {
> 
>  };
> 
> +/*
> + * Copy password from optarg into secure heap, so it could be
> + * freed in the same way as a result of get_password().
> + */

The reason given for copying the password to secure heap is technically
correct, but could we also include the reason that providing the
password on the command line is unsafe?  Perhaps a modified version of
the comment, below, should be included at the beginning of the function
comment.

> +static char *optarg_password(char *optarg)
> +{
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
>  static char *get_password(void)
>  {
>  	struct termios flags, tmp_flags;
>  	char *password, *pwd;
> -	int passlen = 64;
> +	const int passlen = 64;
> 
> -	password = malloc(passlen);
> +	password = OPENSSL_secure_malloc(passlen);
>  	if (!password) {
> -		perror("malloc");
> +		log_err("OPENSSL_secure_malloc(%u) failed\n", passlen);
>  		return NULL;
>  	}
> 
> @@ -2614,8 +2660,8 @@ static char *get_password(void)
>  	tmp_flags.c_lflag |= ECHONL;
> 
>  	if (tcsetattr(fileno(stdin), TCSANOW, &tmp_flags) != 0) {
> -		perror("tcsetattr");
> -		free(password);
> +		log_err("tcsetattr: %s\n", strerror(errno));
> +		OPENSSL_secure_free(password);
>  		return NULL;
>  	}
> 
> @@ -2624,13 +2670,15 @@ static char *get_password(void)
> 
>  	/* restore terminal */
>  	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
> -		perror("tcsetattr");
> -		free(password);
> -		return NULL;
> +		log_err("tcsetattr: %s\n", strerror(errno));
> +		/*
> +		 * Password is already here, so there is no reason
> +		 * to stop working on this petty error.
> +		 */
>  	}
> 
>  	if (pwd == NULL) {
> -		free(password);
> +		OPENSSL_secure_free(password);
>  		return NULL;
>  	}
> 
> @@ -2643,6 +2691,7 @@ int main(int argc, char *argv[])
>  	ENGINE *eng = NULL;
>  	unsigned long keyid;
>  	char *eptr;
> +	char *keypass = NULL; /* @secure heap */
> 
>  #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>  	OPENSSL_init_crypto(
> @@ -2651,6 +2700,17 @@ int main(int argc, char *argv[])
>  #endif
>  			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
>  #endif
> +#if OPENSSL_VERSION_NUMBER > 0x10100000
> +	/*
> +	 * This facility is available since OpenSSL_1_1_0-pre1.
> +	 * 'Heap size' 8192 is chosen to be big enough, so that any single key
> +	 * data could fit. 'Heap minsize' 64 is just to be efficient for small
> +	 * buffers.
> +	 */

Assuming we aren't guaranteed that the heap size is allocated, should
we check (e.g. OPENSSL_secure_actual_size())?

> +	if (!CRYPTO_secure_malloc_init(8192, 64))
> +		log_err("CRYPTO_secure_malloc_init() failed\n");

Either change the test to "!= 1" or also log "and 2 if successful but
the heap could not be protected by memory mapping."

> +#endif
> +
>  	g_argv = argv;
>  	g_argc = argc;
> 
> @@ -2682,10 +2742,18 @@ int main(int argc, char *argv[])
>  			imaevm_params.hash_algo = optarg;
>  			break;
>  		case 'p':
> +			if (keypass)
> +				OPENSSL_secure_clear_free(keypass,
> +							  strlen(keypass));

Is this test needed in case the pasword is provided multiple times?  
If so, why not skip subsequent passwords?

>  			if (optarg)
> -				imaevm_params.keypass = optarg;
> +				keypass = optarg_password(optarg);
>  			else
> -				imaevm_params.keypass = get_password();
> +				keypass = get_password();
> +			if (!keypass) {
> +				log_err("Cannot read password\n");
> +				goto quit;
> +			}
> +			imaevm_params.keypass = keypass;
>  			break;
>  		case 'f':
>  			sigfile = 1;
> @@ -2841,7 +2909,9 @@ int main(int argc, char *argv[])
>  		if (err < 0)
>  			err = 125;
>  	}
> -
> +quit:

Stefan's patch introduced "error:".

> +	if (keypass)
> +		OPENSSL_secure_clear_free(keypass, strlen(keypass));
>  	if (eng) {
>  		ENGINE_finish(eng);
>  		ENGINE_free(eng);

and stores the the engine in imaevm_params.

> @@ -2849,6 +2919,9 @@ int main(int argc, char *argv[])
>  		ENGINE_cleanup();
>  #endif
>  	}
> +#if OPENSSL_VERSION_NUMBER > 0x10100000
> +	CRYPTO_secure_malloc_done();
> +#endif
>  	ERR_free_strings();
>  	EVP_cleanup();
>  	BIO_free(NULL);

What was the conclusion in terms of reading the password stored in the
environment variable?

thanks,

Mimi

