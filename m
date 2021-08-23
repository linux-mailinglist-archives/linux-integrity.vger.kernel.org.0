Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD33F4EDA
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhHWRAX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 13:00:23 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:38878 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHWRAW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 13:00:22 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 59B7E72C8F8;
        Mon, 23 Aug 2021 19:59:38 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 1EEF14A46F1;
        Mon, 23 Aug 2021 19:59:38 +0300 (MSK)
Date:   Mon, 23 Aug 2021 19:59:37 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v3] Use secure heap for private keys and
 passwords
Message-ID: <20210823165937.n4rrmx2dwgje6sca@altlinux.org>
References: <20210822001055.1772873-1-vt@altlinux.org>
 <YSOhBXD/FUIa9QLz@glitch>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <YSOhBXD/FUIa9QLz@glitch>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Bruno,

On Mon, Aug 23, 2021 at 10:22:13AM -0300, Bruno Meneguele wrote:
> On Sun, Aug 22, 2021 at 03:10:55AM +0300, Vitaly Chikunov wrote:
> > After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> > secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >  src/evmctl.c | 148 +++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 121 insertions(+), 27 deletions(-)
> > 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 5f7c2b8..cebe9ec 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -59,6 +59,7 @@
> >  #include <assert.h>
> >  
> >  #include <openssl/asn1.h>
> > +#include <openssl/crypto.h>
> >  #include <openssl/sha.h>
> >  #include <openssl/pem.h>
> >  #include <openssl/hmac.h>
> > @@ -165,6 +166,24 @@ struct tpm_bank_info {
> >  static char *pcrfile[MAX_PCRFILE];
> >  static unsigned npcrfile;
> >  
> > +#if OPENSSL_VERSION_NUMBER <= 0x10100000
> > +#warning Your OpenSSL version is too old to have OPENSSL_secure_malloc, \
> > +	falling back to use plain OPENSSL_malloc.
> > +#define OPENSSL_secure_malloc	  OPENSSL_malloc
> > +#define OPENSSL_secure_free	  OPENSSL_free
> > +/*
> > + * Secure heap memory automatically cleared on free, but
> > + * OPENSSL_secure_clear_free will be used in case of fallback
> > + * to plain OPENSSL_malloc.
> > + */
> > +#define OPENSSL_secure_clear_free OPENSSL_clear_free
> > +#define OPENSSL_clear_free(ptr, num)		\
> > +	do {					\
> > +		OPENSSL_cleanse(ptr, num);	\
> > +		OPENSSL_free(ptr);		\
> > +	} while (0)
> > +#endif
> > +
> >  static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
> >  {
> >  	FILE *fp;
> > @@ -188,7 +207,9 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
> >  	return err;
> >  }
> >  
> > -static unsigned char *file2bin(const char *file, const char *ext, int *size)
> > +/* Return data in OpenSSL secure heap if 'secure' is true. */
> > +static unsigned char *file2bin(const char *file, const char *ext, int *size,
> > +			       int secure)
> >  {
> >  	FILE *fp;
> >  	size_t len;
> > @@ -215,7 +236,10 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
> >  	}
> >  	len = stats.st_size;
> >  
> > -	data = malloc(len);
> > +	if (secure)
> > +		data = OPENSSL_secure_malloc(len);
> > +	else
> > +		data = malloc(len);
> >  	if (!data) {
> >  		log_err("Failed to malloc %zu bytes: %s\n", len, name);
> >  		fclose(fp);
> > @@ -224,7 +248,10 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
> >  	if (fread(data, len, 1, fp) != 1) {
> >  		log_err("Failed to fread %zu bytes: %s\n", len, name);
> >  		fclose(fp);
> > -		free(data);
> > +		if (secure)
> > +			OPENSSL_secure_clear_free(data, len);
> > +		else
> > +			free(data);
> >  		return NULL;
> >  	}
> >  	fclose(fp);
> > @@ -872,7 +899,7 @@ static int verify_ima(const char *file)
> >  	int len;
> >  
> >  	if (sigfile) {
> > -		void *tmp = file2bin(file, "sig", &len);
> > +		void *tmp = file2bin(file, "sig", &len, 0);
> >  
> >  		if (!tmp) {
> >  			log_err("Failed reading: %s\n", file);
> > @@ -1001,7 +1028,7 @@ static int cmd_import(struct command *cmd)
> >  
> >  		if (!pkey)
> >  			return 1;
> > -		pub = file2bin(inkey, NULL, &len);
> > +		pub = file2bin(inkey, NULL, &len, 0);
> >  		if (!pub) {
> >  			EVP_PKEY_free(pkey);
> >  			return 1;
> > @@ -1040,9 +1067,9 @@ static int setxattr_ima(const char *file, char *sig_file)
> >  	int len, err;
> >  
> >  	if (sig_file)
> > -		sig = file2bin(sig_file, NULL, &len);
> > +		sig = file2bin(sig_file, NULL, &len, 0);
> >  	else
> > -		sig = file2bin(file, "sig", &len);
> > +		sig = file2bin(file, "sig", &len, 0);
> >  	if (!sig)
> >  		return 0;
> >  
> > @@ -1082,9 +1109,9 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
> >  	unsigned int mdlen;
> >  	char **xattrname;
> >  	unsigned char xattr_value[1024];
> > -	unsigned char *key;
> > +	unsigned char *key; /* @secure heap */
> >  	int keylen;
> > -	unsigned char evmkey[MAX_KEY_SIZE];
> > +	unsigned char *evmkey; /* @secure heap */
> >  	char list[1024];
> >  	ssize_t list_size;
> >  	struct h_misc_64 hmac_misc;
> > @@ -1096,21 +1123,30 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
> >  	pctx = HMAC_CTX_new();
> >  #endif
> >  
> > -	key = file2bin(keyfile, NULL, &keylen);
> > +	key = file2bin(keyfile, NULL, &keylen, 1);
> >  	if (!key) {
> >  		log_err("Failed to read a key: %s\n", keyfile);
> >  		return -1;
> >  	}
> >  
> > -	if (keylen > sizeof(evmkey)) {
> > +	evmkey = OPENSSL_secure_malloc(MAX_KEY_SIZE);
> > +	if (!evmkey) {
> > +		log_err("Failed to allocate %d bytes\n", MAX_KEY_SIZE);
> > +		goto out;
> > +	}
> > +
> > +	if (keylen > MAX_KEY_SIZE) {
> >  		log_err("key is too long: %d\n", keylen);
> >  		goto out;
> >  	}
> >  
> >  	/* EVM key is 128 bytes */
> >  	memcpy(evmkey, key, keylen);
> > -	if (keylen < sizeof(evmkey))
> > -		memset(evmkey + keylen, 0, sizeof(evmkey) - keylen);
> > +	if (keylen < MAX_KEY_SIZE)
> > +		memset(evmkey + keylen, 0, MAX_KEY_SIZE - keylen);
> > +
> > +	/* Shorten lifetime of key data. */
> > +	OPENSSL_cleanse(key, keylen);
> >  
> >  	if (lstat(file, &st)) {
> >  		log_err("Failed to stat: %s\n", file);
> > @@ -1147,12 +1183,15 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
> >  		goto out;
> >  	}
> >  
> > -	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), md, NULL);
> > +	err = !HMAC_Init_ex(pctx, evmkey, MAX_KEY_SIZE, md, NULL);
> >  	if (err) {
> >  		log_err("HMAC_Init() failed\n");
> >  		goto out;
> >  	}
> >  
> > +	/* Shorten lifetime of evmkey data. */
> > +	OPENSSL_cleanse(evmkey, MAX_KEY_SIZE);
> > +
> >  	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
> >  		err = lgetxattr(file, *xattrname, xattr_value, sizeof(xattr_value));
> >  		if (err < 0) {
> > @@ -1222,7 +1261,9 @@ out_ctx_cleanup:
> >  	HMAC_CTX_free(pctx);
> >  #endif
> >  out:
> > -	free(key);
> > +	if (evmkey)
> > +		OPENSSL_secure_clear_free(evmkey, MAX_KEY_SIZE);
> > +	OPENSSL_secure_clear_free(key, keylen);
> 
> Minor thing: considering you already OPENSSL_cleanse() both evmkey and
> key, is it necessary to call OPENSSL_secure_clear_free() instead of only
> OPENSSL_secure_free()?

There is already comment to explain this - it's to shorten key lifetime
on one execution path. Note there is possible `goto out` before
OPENSSL_cleanse calls.

Thanks,

> 
> But like I said, that's a minor thing :)
> 
> Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
> 
> -- 
> bmeneg 
> PGP Key: http://bmeneg.com/pubkey.txt


