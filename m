Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F33876B1A6
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 00:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfGPWNy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 18:13:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728566AbfGPWNx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 18:13:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6GMCNrM103751
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 18:13:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tsmyengjr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 18:13:50 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 16 Jul 2019 23:13:48 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Jul 2019 23:13:45 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6GMDilf40567104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 22:13:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9A3011C054;
        Tue, 16 Jul 2019 22:13:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D6F211C04A;
        Tue, 16 Jul 2019 22:13:44 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jul 2019 22:13:44 +0000 (GMT)
Subject: Re: [PATCH 2/2] ima_evm_utils: limit duplicate "Failed to open
 keyfile" messages
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 16 Jul 2019 18:13:43 -0400
In-Reply-To: <20190716214948.6ycejuln6q376ngc@altlinux.org>
References: <1563287417-31780-1-git-send-email-zohar@linux.ibm.com>
         <1563287417-31780-2-git-send-email-zohar@linux.ibm.com>
         <20190716214948.6ycejuln6q376ngc@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071622-0028-0000-0000-000003852519
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071622-0029-0000-0000-000024454855
Message-Id: <1563315223.4539.255.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160261
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-17 at 00:49 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, Jul 16, 2019 at 10:30:17AM -0400, Mimi Zohar wrote:
> > Unlike the user provided list of public keys, we don't know which
> > default public key file to use until verify_hash().  As a result, the
> > "Failed to open keyfile" message may be repeated multiple times.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  src/libimaevm.c | 33 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index 472ab53c7b42..793643331f4b 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -296,18 +296,49 @@ err:
> >  	return err;
> >  }
> >  
> > +/*
> > + * Keep track of missing keyfile names.
> > + *
> > + * Return 1 for found, return 0 for not found.
> > + */
> > +static int lookup_keyfile_name(const char *keyfile_name)
> > +{
> > +	struct keyfile_name_entry {
> > +		struct keyfile_name_entry *next;
> > +		char name[];
> > +	} *entry;
> > +	static struct keyfile_name_entry *keyfile_names = NULL;
> > +
> > +	for (entry = keyfile_names; entry != NULL; entry = entry->next) {
> > +		if (strcmp(entry->name, keyfile_name) == 0)
> > +			return 1;
> > +	}
> > +
> > +	entry = malloc(sizeof(struct keyfile_name_entry) +
> > +			strlen(keyfile_name) + 1);
> > +	if (entry) {
> > +		strcpy(entry->name, keyfile_name);
> > +		entry->next = keyfile_names;
> > +		keyfile_names = entry;
> > +	}
> > +	return 0;
> > +}
> > +
> >  EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
> >  {
> >  	FILE *fp;
> >  	X509 *crt = NULL;
> >  	EVP_PKEY *pkey = NULL;
> > +	int found;
> >  
> >  	if (!keyfile)
> >  		return NULL;
> >  
> >  	fp = fopen(keyfile, "r");
> >  	if (!fp) {
> > -		log_err("Failed to open keyfile: %s\n", keyfile);
> > +		found = lookup_keyfile_name(keyfile);
> > +		if (!found)
> > +			log_err("Failed to open keyfile: %s\n", keyfile);
> >  		return NULL;
> 
> 
> Now filename list is decoupled from keys themselves. Also we have key
> list creation in init_public_keys(). Maybe we should just always call
> init_public_keys for verify operations?

Initially, I tried that.  The code snippet, below, would be called
once.  The problem is that only during verify_hash() do we know which
default public key file to use.

if (params.keyfile)
    params.keyfile = <default key file>
		
init_public_keys(params.keyfile);

Mimi

> 
> Thanks,
> 
> >  	}
> >  
> > -- 
> > 2.7.5
> 

