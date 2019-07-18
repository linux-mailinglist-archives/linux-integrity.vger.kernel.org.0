Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88B6D175
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 17:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGRP7b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 11:59:31 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:36380 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRP7b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 11:59:31 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C3BEA72CCD5;
        Thu, 18 Jul 2019 18:59:29 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id B38C74A4A29;
        Thu, 18 Jul 2019 18:59:29 +0300 (MSK)
Date:   Thu, 18 Jul 2019 18:59:29 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] ima_evm_utils: erroneous "verification failed: 0
 (invalid padding)" message
Message-ID: <20190718155929.jystftv4oemwx5r4@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <1563327389-28193-1-git-send-email-zohar@linux.ibm.com>
 <20190717231446.au4kjxvrgkyajn2v@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190717231446.au4kjxvrgkyajn2v@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Thu, Jul 18, 2019 at 02:14:46AM +0300, Vitaly Chikunov wrote:
> On Tue, Jul 16, 2019 at 09:36:29PM -0400, Mimi Zohar wrote:
> > When keys are not provided, the default key is used to verify the file
> > signature, resulting in this erroneous message.  Before using the default
> > key to verify the file signature, verify the keyid is correct.
> > 
> > This patch adds the public key from the default x509 certificate onto the
> > "public_keys" list.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  src/evmctl.c    |  9 ++++++---
> >  src/libimaevm.c | 17 +++++++----------
> >  2 files changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 61808d276419..65cc5bd12bad 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -879,8 +879,10 @@ static int cmd_verify_ima(struct command *cmd)
> >  	char *file = g_argv[optind++];
> >  	int err;
> >  
> > -	if (params.keyfile)
> > +	if (params.keyfile)	/* Support multiple public keys */
> >  		init_public_keys(params.keyfile);
> > +	else			/* assume read pubkey from x509 cert */
> > +		init_public_keys("/etc/keys/x509_evm.der");
> >  
> >  	errno = 0;
> >  	if (!file) {
> > @@ -1602,9 +1604,10 @@ static int ima_measurement(const char *file)
> >  		return -1;
> >  	}
> >  
> > -	/* Support multiple public keys */
> > -	if (params.keyfile)
> > +	if (params.keyfile)	/* Support multiple public keys */
> >  		init_public_keys(params.keyfile);
> > +	else			/* assume read pubkey from x509 cert */
> > +		init_public_keys("/etc/keys/x509_evm.der");
> >  
> >  	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
> >  		ima_extend_pcr(pcr[entry.header.pcr], entry.header.digest,
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index ae487f9fe36c..afd21051b09a 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -302,6 +302,9 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
> >  	X509 *crt = NULL;
> >  	EVP_PKEY *pkey = NULL;
> >  
> > +	if (!keyfile)
> > +		return NULL;
> > +
> >  	fp = fopen(keyfile, "r");
> >  	if (!fp) {
> >  		log_err("Failed to open keyfile: %s\n", keyfile);
> > @@ -569,27 +572,21 @@ static int get_hash_algo_from_sig(unsigned char *sig)
> >  int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig,
> >  		int siglen)
> >  {
> > -	const char *key;
> > -	int x509;
> > +	const char *key = NULL;
> >  	verify_hash_fn_t verify_hash;
> >  
> >  	/* Get signature type from sig header */
> >  	if (sig[0] == DIGSIG_VERSION_1) {
> >  		verify_hash = verify_hash_v1;
> > +
> >  		/* Read pubkey from RSA key */
> > -		x509 = 0;
> > +		if (!params.keyfile)
> > +			key = "/etc/keys/pubkey_evm.pem";
> 
> There is only three code path reaching here:
> 
> 1. From cmd_ima_measurement - calls init_public_keys.
> 2. From cmd_verify_ima - calls init_public_keys.
> 3. From cmd_verify_evm - probably it should call init_public_keys too.
> 
> Otherwise this change looks, good. When `--key` is not specified load
> default public key from x509_evm.der, but for signature v1 pass
> pubkey_evm.pem into verify_hash_v1.
> 
> As a consequence, verify_hash_v2 should remove code handling `keyfile`
> argument (maybe with argument itself) because it's now always NULL, and
> just call find_keyid.

Btw, there is strange code in evmctl.c:cmd_convert():

        params.x509 = 0;

        inkey = g_argv[optind++];
        if (!inkey) {
                inkey = params.x509 ? "/etc/keys/x509_evm.der" :
                                      "/etc/keys/pubkey_evm.pem";
        }

Assigning zero to params.x509 makes `params.x509 ? ... : ...` redundant.

Thanks,


