Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE75A6B168
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2019 23:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfGPVzM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 17:55:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728235AbfGPVzM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 17:55:12 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6GLj6DK108857
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 17:55:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tsmx7n039-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 17:55:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 16 Jul 2019 22:55:08 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Jul 2019 22:55:07 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6GLt6KB53412014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 21:55:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58549A4053;
        Tue, 16 Jul 2019 21:55:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC0ABA4040;
        Tue, 16 Jul 2019 21:55:05 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jul 2019 21:55:05 +0000 (GMT)
Subject: Re: [PATCH 1/2] ima_evm_utils: erroneous "verification failed: 0
 (invalid padding)" message
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 16 Jul 2019 17:55:05 -0400
In-Reply-To: <20190716213724.bay6dt5sjwdpucmb@altlinux.org>
References: <1563287417-31780-1-git-send-email-zohar@linux.ibm.com>
         <20190716213724.bay6dt5sjwdpucmb@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071621-4275-0000-0000-0000034DE0F1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071621-4276-0000-0000-0000385DF47C
Message-Id: <1563314105.4539.248.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160259
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-17 at 00:37 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, Jul 16, 2019 at 10:30:16AM -0400, Mimi Zohar wrote:
> > When keys are not provided, the default key is used to verify the file
> > signature, resulting in this erroneous message.  Before using the default
> > key to verify the file signature, verify the keyid is correct.
> 
> 1. What is default key when keys are not provided?

The defaults was either "/etc/keys/x509_evm.der" for DIGSIG_VERSION_1
or "/etc/keys/pubkey_evm.pem" for DIGSIG_VERSION_2.

> 2. I don't see keyid verification in the patch.

Since no keys were provided, this patch loads the default key onto the
list of public_keys.  The normal find_keyid() is then called.

> 3. Now we have so complicated keyfile handling.

It would definitely be simpler to remove support for these default
keys, but I'm hesitant to remove it.

> 
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  src/libimaevm.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index ae487f9fe36c..472ab53c7b42 100644
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
> > @@ -569,27 +572,25 @@ static int get_hash_algo_from_sig(unsigned char *sig)
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
> >  	} else if (sig[0] == DIGSIG_VERSION_2) {
> >  		verify_hash = verify_hash_v2;
> > +
> >  		/* Read pubkey from x509 cert */
> > -		x509 = 1;
> > +		if (!params.keyfile)
> > +			init_public_keys("/etc/keys/x509_evm.der");
> 
> Also, in "ima-evm-utils: Preload public keys for ima_verify" I call
> init_public_keys in cmd_verify_ima() which calls this verify_hash().
> 
> So there will be double calling of init_public_keys().

init_public_keys() will only be called once, either there or here.  It
depends on whether params.keyfile is defined or not.

> 
> ps. Btw, I think we should remove this verify_hash_fn_t indirect call
> trick and replace it with two normal calls in each if branch.
> 
> verify_hash() calling verify_hash() obscures cscope, and with direct
> calls it will be easier to parse. I may send patch for this.
> 
> Thanks,

Agreed, every time I come back to this code it takes me a few minutes
to remember.

Mimi

> 
> 
> >  	} else
> >  		return -1;
> >  
> > -	/* Determine what key to use for verification*/
> > -	key = params.keyfile ? : x509 ?
> > -			"/etc/keys/x509_evm.der" :
> > -			"/etc/keys/pubkey_evm.pem";
> > -
> >  	return verify_hash(file, hash, size, sig, siglen, key);
> >  }
> >  
> > -- 
> > 2.7.5

