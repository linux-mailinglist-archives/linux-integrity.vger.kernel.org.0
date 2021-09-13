Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B089C409B3A
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhIMRxY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 13:53:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231684AbhIMRxY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 13:53:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DFOwBn017995;
        Mon, 13 Sep 2021 13:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uYMEMIW6tVD0ZisfLg2PUWwz6n9nF7YnHGylhph5HSk=;
 b=MpkxhJ0a54uOVP7XKLO753n178ToU5l0xRavT3CEyoeb7NV5CCIY8yMPHVridKXbkKG6
 ONFgI/6W0bzxcmzHFp6FdUEtRtvk1LoM6sJafYddZh5O9E1wKaiVhKzppFPgo0/oNKts
 qBHmLCYvtFRlzMOKxEr5AAYMPLoPqb9q9n3px95P9A/hHCFijUWGkHdsPiu5818JV47P
 +8FWEDzOO9DkcpfwfGAgTCbdJP42Hcb5ypKPYJ32XYjY5GwFCrF7r5Yak/wyVDBbGLDX
 BAidg7UO3p/c5jMC0GvGXEOEBgpzD8vXnhGcf0x5xNgazBVB4/nbrPjvUlGnBBtanryd cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b23hdnq60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 13:52:05 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18DHCwPn015318;
        Mon, 13 Sep 2021 13:52:05 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b23hdnq4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 13:52:05 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DHpUAP014329;
        Mon, 13 Sep 2021 17:52:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3b0m39jkyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 17:52:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DHq0Qv34210212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 17:52:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 216CD5204E;
        Mon, 13 Sep 2021 17:52:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.52])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 43A3552052;
        Mon, 13 Sep 2021 17:51:59 +0000 (GMT)
Message-ID: <a5fce02a7ed3758c2aa13e0700b071d4b8d8213b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4] evmctl: Use secure heap for private
 keys and passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 13 Sep 2021 13:51:58 -0400
In-Reply-To: <20210910181307.dmpx5463c3t2etax@altlinux.org>
References: <20210904105054.3388329-1-vt@altlinux.org>
         <413f31067da8a63ecd76228e86505a9f4e5599f8.camel@linux.ibm.com>
         <20210910181307.dmpx5463c3t2etax@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lzNg512ZtO-vTS71phA99inKZzgdLB0N
X-Proofpoint-ORIG-GUID: wtu24kYGDKPwgS66hrDNgeggoPb23ZFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130048
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Fri, 2021-09-10 at 21:13 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Fri, Sep 10, 2021 at 10:55:04AM -0400, Mimi Zohar wrote:
> > On Sat, 2021-09-04 at 13:50 +0300, Vitaly Chikunov wrote:
> > > After CRYPTO_secure_malloc_init OpenSSL will automatically store private
> > > keys in secure heap. OPENSSL_secure_malloc(3):
> > > 
> > >   If a secure heap is used, then private key BIGNUM values are stored
> > >   there. This protects long-term storage of private keys, but will not
> > >   necessarily put all intermediate values and computations there.
> > > 
> > > Additionally, we try to keep user passwords in secure heap too.
> > > This facility is only available since OpenSSL_1_1_0-pre1.
> > > 
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
> > > Cc: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Thanks, it looks good!  Just a few questions inline below.
> > 
> > > ---
> > > Change since v3:
> > > - Undo secure heap handling from (file2bin and) calc_evm_hmac since this
> > >   is debugging tool only. Add comment about this.
> > > - Since there is only code removals and new comments I keep Reviewed-by
> > >   tag.
> > > 
> > >  src/evmctl.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 85 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > index 5f7c2b8..7bd20f8 100644
> > > --- a/src/evmctl.c
> > > +++ b/src/evmctl.c
> > > @@ -59,6 +59,7 @@
> > >  #include <assert.h>
> > > 
> > >  #include <openssl/asn1.h>
> > > +#include <openssl/crypto.h>
> > >  #include <openssl/sha.h>
> > >  #include <openssl/pem.h>
> > >  #include <openssl/hmac.h>
> > > @@ -165,6 +166,24 @@ struct tpm_bank_info {
> > >  static char *pcrfile[MAX_PCRFILE];
> > >  static unsigned npcrfile;
> > > 
> > > +#if OPENSSL_VERSION_NUMBER <= 0x10100000
> > > +#warning Your OpenSSL version is too old to have OPENSSL_secure_malloc, \
> > > +	falling back to use plain OPENSSL_malloc.
> > > +#define OPENSSL_secure_malloc	  OPENSSL_malloc
> > > +#define OPENSSL_secure_free	  OPENSSL_free
> > > +/*
> > > + * Secure heap memory automatically cleared on free, but
> > > + * OPENSSL_secure_clear_free will be used in case of fallback
> > > + * to plain OPENSSL_malloc.
> > > + */
> > > +#define OPENSSL_secure_clear_free OPENSSL_clear_free
> > > +#define OPENSSL_clear_free(ptr, num)		\
> > > +	do {					\
> > > +		OPENSSL_cleanse(ptr, num);	\
> > > +		OPENSSL_free(ptr);		\
> > > +	} while (0)
> > > +#endif
> > > +
> > >  static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
> > >  {
> > >  	FILE *fp;
> > > @@ -1072,6 +1091,7 @@ static int cmd_setxattr_ima(struct command *cmd)
> > > 
> > >  #define MAX_KEY_SIZE 128
> > > 
> > > +/* This function is debugging tool and should not be used for real private data. */
> > >  static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
> > >  {
> > >          const EVP_MD *md;
> > > @@ -2596,15 +2616,41 @@ static struct option opts[] = {
> > > 
> > >  };
> > > 
> > > +/*
> > > + * Copy password from optarg into secure heap, so it could be
> > > + * freed in the same way as a result of get_password().
> > > + */
> > 
> > The reason given for copying the password to secure heap is technically
> > correct, but could we also include the reason that providing the
> > password on the command line is unsafe?  Perhaps a modified version of
> > the comment, below, should be included at the beginning of the function
> > comment.
> > 
> > > +static char *optarg_password(char *optarg)
> > > +{
> > > +	size_t len;
> > > +	char *keypass;
> > > +
> > > +	if (!optarg)
> > > +		return NULL;
> > > +	len = strlen(optarg);
> > > +	keypass = OPENSSL_secure_malloc(len + 1);
> > > +	if (keypass)
> > > +		memcpy(keypass, optarg, len + 1);
> > > +	else
> > > +		log_err("OPENSSL_secure_malloc(%zu) failed\n", len + 1);
> > > +	/*
> > > +	 * This memset does not add real security, just increases
> > > +	 * the chance of password being obscured in ps output.
> > > +	 */
> > > +	memset(optarg, 'X', len);
> > > +	return keypass;
> > > +}
> > > +
> > > +/* Read from TTY into secure heap. */
> > >  static char *get_password(void)
> > >  {
> > >  	struct termios flags, tmp_flags;
> > >  	char *password, *pwd;
> > > -	int passlen = 64;
> > > +	const int passlen = 64;
> > > 
> > > -	password = malloc(passlen);
> > > +	password = OPENSSL_secure_malloc(passlen);
> > >  	if (!password) {
> > > -		perror("malloc");
> > > +		log_err("OPENSSL_secure_malloc(%u) failed\n", passlen);
> > >  		return NULL;
> > >  	}
> > > 
> > > @@ -2614,8 +2660,8 @@ static char *get_password(void)
> > >  	tmp_flags.c_lflag |= ECHONL;
> > > 
> > >  	if (tcsetattr(fileno(stdin), TCSANOW, &tmp_flags) != 0) {
> > > -		perror("tcsetattr");
> > > -		free(password);
> > > +		log_err("tcsetattr: %s\n", strerror(errno));
> > > +		OPENSSL_secure_free(password);
> > >  		return NULL;
> > >  	}
> > > 
> > > @@ -2624,13 +2670,15 @@ static char *get_password(void)
> > > 
> > >  	/* restore terminal */
> > >  	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
> > > -		perror("tcsetattr");
> > > -		free(password);
> > > -		return NULL;
> > > +		log_err("tcsetattr: %s\n", strerror(errno));
> > > +		/*
> > > +		 * Password is already here, so there is no reason
> > > +		 * to stop working on this petty error.
> > > +		 */
> > >  	}
> > > 
> > >  	if (pwd == NULL) {
> > > -		free(password);
> > > +		OPENSSL_secure_free(password);
> > >  		return NULL;
> > >  	}
> > > 
> > > @@ -2643,6 +2691,7 @@ int main(int argc, char *argv[])
> > >  	ENGINE *eng = NULL;
> > >  	unsigned long keyid;
> > >  	char *eptr;
> > > +	char *keypass = NULL; /* @secure heap */
> > > 
> > >  #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
> > >  	OPENSSL_init_crypto(
> > > @@ -2651,6 +2700,17 @@ int main(int argc, char *argv[])
> > >  #endif
> > >  			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
> > >  #endif
> > > +#if OPENSSL_VERSION_NUMBER > 0x10100000
> > > +	/*
> > > +	 * This facility is available since OpenSSL_1_1_0-pre1.
> > > +	 * 'Heap size' 8192 is chosen to be big enough, so that any single key
> > > +	 * data could fit. 'Heap minsize' 64 is just to be efficient for small
> > > +	 * buffers.
> > > +	 */
> > 
> > Assuming we aren't guaranteed that the heap size is allocated, should
> > we check (e.g. OPENSSL_secure_actual_size())?
> 
> We guaranteed that secure heap is allocated by return value of
> CRYPTO_secure_malloc_init.
> 
> OPENSSL_secure_actual_size tell if OPENSSL_secure_malloc is actually
> provided bigger memory fragment than we requested (to reduce
> fragmentation). Why care about it?

We wouldn't care, assuming we're guaranteed the heap size requested was
allocated and not the minimum heap size.  Hm, wondering what would be
the purpose of the minimum heap size ...

> 
> > 
> > > +	if (!CRYPTO_secure_malloc_init(8192, 64))
> > > +		log_err("CRYPTO_secure_malloc_init() failed\n");
> > 
> > Either change the test to "!= 1" or also log "and 2 if successful but
> > the heap could not be protected by memory mapping."
> 
> Why should we care about implementation details of successful
> allocation? If they don't think it's secure heap they should not return
> success. And they say about its return value "and 2 if successful but",
> so it's successful.

If you're correct, then there is no reason ever for returning 2. 
Without documentation or digging into OpenSSL, this makes no sense to
me.  Perhaps "secure heap" has some kernel dependency, requires HW, or
something else entirely.  Not that there is much we could or would do,
but simply ignoring it just seems wrong.

> 
> 
> > 
> > > +#endif
> > > +
> > >  	g_argv = argv;
> > >  	g_argc = argc;
> > > 
> > > @@ -2682,10 +2742,18 @@ int main(int argc, char *argv[])
> > >  			imaevm_params.hash_algo = optarg;
> > >  			break;
> > >  		case 'p':
> > > +			if (keypass)
> > > +				OPENSSL_secure_clear_free(keypass,
> > > +							  strlen(keypass));
> > 
> > Is this test needed in case the pasword is provided multiple times?  
> 
> It does not care, it just frees memory so there is no leaks. (Perhaps.
> it will be cleaned on CRYPTO_secure_malloc_done anyway). I can remove
> this check, but why. Then we don't need to free() most of allocations,
> because exit will care about all memory. But we free them anyway.
> 
> > If so, why not skip subsequent passwords?
> 
> Old code favored last specified password and I'm just adding secure heap to
> it. I don't see that preference to first of last password is better for
> UX.

Ok

> > 
> > >  			if (optarg)
> > > -				imaevm_params.keypass = optarg;
> > > +				keypass = optarg_password(optarg);
> > >  			else
> > > -				imaevm_params.keypass = get_password();
> > > +				keypass = get_password();
> > > +			if (!keypass) {
> > > +				log_err("Cannot read password\n");
> > > +				goto quit;
> > > +			}
> > > +			imaevm_params.keypass = keypass;
> > >  			break;
> > >  		case 'f':
> > >  			sigfile = 1;
> > > @@ -2841,7 +2909,9 @@ int main(int argc, char *argv[])
> > >  		if (err < 0)
> > >  			err = 125;
> > >  	}
> > > -
> > > +quit:
> > 
> > Stefan's patch introduced "error:".
> > 
> > > +	if (keypass)
> > > +		OPENSSL_secure_clear_free(keypass, strlen(keypass));
> > >  	if (eng) {
> > >  		ENGINE_finish(eng);
> > >  		ENGINE_free(eng);
> > 
> > and stores the the engine in imaevm_params.
> 
> OK I will wait when his patches will appear in git, so we do not collide
> with each other.
> 
> > 
> > > @@ -2849,6 +2919,9 @@ int main(int argc, char *argv[])
> > >  		ENGINE_cleanup();
> > >  #endif
> > >  	}
> > > +#if OPENSSL_VERSION_NUMBER > 0x10100000
> > > +	CRYPTO_secure_malloc_done();
> > > +#endif
> > >  	ERR_free_strings();
> > >  	EVP_cleanup();
> > >  	BIO_free(NULL);
> > 
> > What was the conclusion in terms of reading the password stored in the
> > environment variable?
> 
> I will add handling for it similar to password from optarg.

thanks,

Mimi

