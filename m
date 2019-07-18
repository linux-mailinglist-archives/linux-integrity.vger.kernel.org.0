Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD86D289
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfGRRJT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 13:09:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbfGRRJT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 13:09:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IH76Mx119783
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 13:09:18 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttvup86qe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 13:09:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 18 Jul 2019 18:09:15 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 18:09:13 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6IH9CrX55640078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 17:09:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63A9D11C064;
        Thu, 18 Jul 2019 17:09:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBB8011C069;
        Thu, 18 Jul 2019 17:09:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.122])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 17:09:11 +0000 (GMT)
Subject: Re: [PATCH v2] ima_evm_utils: erroneous "verification failed: 0
 (invalid padding)" message
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org
Date:   Thu, 18 Jul 2019 13:09:00 -0400
In-Reply-To: <20190718155929.jystftv4oemwx5r4@altlinux.org>
References: <1563327389-28193-1-git-send-email-zohar@linux.ibm.com>
         <20190717231446.au4kjxvrgkyajn2v@altlinux.org>
         <20190718155929.jystftv4oemwx5r4@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071817-4275-0000-0000-0000034E80A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071817-4276-0000-0000-0000385E9AAF
Message-Id: <1563469740.4539.313.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180180
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-07-18 at 18:59 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Thu, Jul 18, 2019 at 02:14:46AM +0300, Vitaly Chikunov wrote:
> > On Tue, Jul 16, 2019 at 09:36:29PM -0400, Mimi Zohar wrote:
> > > When keys are not provided, the default key is used to verify the file
> > > signature, resulting in this erroneous message.  Before using the default
> > > key to verify the file signature, verify the keyid is correct.
> > > 
> > > This patch adds the public key from the default x509 certificate onto the
> > > "public_keys" list.
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  src/evmctl.c    |  9 ++++++---
> > >  src/libimaevm.c | 17 +++++++----------
> > >  2 files changed, 13 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > index 61808d276419..65cc5bd12bad 100644
> > > --- a/src/evmctl.c
> > > +++ b/src/evmctl.c
> > > @@ -879,8 +879,10 @@ static int cmd_verify_ima(struct command *cmd)
> > >  	char *file = g_argv[optind++];
> > >  	int err;
> > >  
> > > -	if (params.keyfile)
> > > +	if (params.keyfile)	/* Support multiple public keys */
> > >  		init_public_keys(params.keyfile);
> > > +	else			/* assume read pubkey from x509 cert */
> > > +		init_public_keys("/etc/keys/x509_evm.der");
> > >  
> > >  	errno = 0;
> > >  	if (!file) {
> > > @@ -1602,9 +1604,10 @@ static int ima_measurement(const char *file)
> > >  		return -1;
> > >  	}
> > >  
> > > -	/* Support multiple public keys */
> > > -	if (params.keyfile)
> > > +	if (params.keyfile)	/* Support multiple public keys */
> > >  		init_public_keys(params.keyfile);
> > > +	else			/* assume read pubkey from x509 cert */
> > > +		init_public_keys("/etc/keys/x509_evm.der");
> > >  
> > >  	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
> > >  		ima_extend_pcr(pcr[entry.header.pcr], entry.header.digest,
> > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > index ae487f9fe36c..afd21051b09a 100644
> > > --- a/src/libimaevm.c
> > > +++ b/src/libimaevm.c
> > > @@ -302,6 +302,9 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
> > >  	X509 *crt = NULL;
> > >  	EVP_PKEY *pkey = NULL;
> > >  
> > > +	if (!keyfile)
> > > +		return NULL;
> > > +
> > >  	fp = fopen(keyfile, "r");
> > >  	if (!fp) {
> > >  		log_err("Failed to open keyfile: %s\n", keyfile);
> > > @@ -569,27 +572,21 @@ static int get_hash_algo_from_sig(unsigned char *sig)
> > >  int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig,
> > >  		int siglen)
> > >  {
> > > -	const char *key;
> > > -	int x509;
> > > +	const char *key = NULL;
> > >  	verify_hash_fn_t verify_hash;
> > >  
> > >  	/* Get signature type from sig header */
> > >  	if (sig[0] == DIGSIG_VERSION_1) {
> > >  		verify_hash = verify_hash_v1;
> > > +
> > >  		/* Read pubkey from RSA key */
> > > -		x509 = 0;
> > > +		if (!params.keyfile)
> > > +			key = "/etc/keys/pubkey_evm.pem";
> > 
> > There is only three code path reaching here:
> > 
> > 1. From cmd_ima_measurement - calls init_public_keys.
> > 2. From cmd_verify_ima - calls init_public_keys.
> > 3. From cmd_verify_evm - probably it should call init_public_keys too.
> > 
> > Otherwise this change looks, good. When `--key` is not specified load
> > default public key from x509_evm.der, but for signature v1 pass
> > pubkey_evm.pem into verify_hash_v1.
> > 
> > As a consequence, verify_hash_v2 should remove code handling `keyfile`
> > argument (maybe with argument itself) because it's now always NULL, and
> > just call find_keyid.
> 
> Btw, there is strange code in evmctl.c:cmd_convert():
> 
>         params.x509 = 0;
> 
>         inkey = g_argv[optind++];
>         if (!inkey) {
>                 inkey = params.x509 ? "/etc/keys/x509_evm.der" :
>                                       "/etc/keys/pubkey_evm.pem";
>         }
> 
> Assigning zero to params.x509 makes `params.x509 ? ... : ...` redundant.

Agreed.  The commit description that introduced this code is quite
brief, and makes no mention of this cmd_convert function.  The main
purpose of the commit is to calculate the EVM signature based on
different EVM metadata than what currently exists on the local
filesystem.  Even with Matthew's portable & immutable EVM signatures,
providing different EVM metadata is probably still needed.

For this release, let's just clean up the code, but not remove
cmd_convet().  For the next release, we'll consider deprecating or
removing this and other code.

Mimi

