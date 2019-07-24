Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156BF72360
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 02:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGXAUD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 20:20:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726633AbfGXAUD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 20:20:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6O0BPK6120768
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 20:20:02 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tx8vdfx9a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 23 Jul 2019 20:20:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 24 Jul 2019 01:20:00 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Jul 2019 01:19:59 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6O0JwMI29753436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 00:19:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01907A4053;
        Wed, 24 Jul 2019 00:19:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81837A404D;
        Wed, 24 Jul 2019 00:19:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.157])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Jul 2019 00:19:57 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] ima-evm-utils: log unknown keyid's as errors
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-integrity@vger.kernel.org
Date:   Tue, 23 Jul 2019 20:19:46 -0400
In-Reply-To: <20190723231316.rnngionrm4lrtyct@altlinux.org>
References: <1563460194-21569-1-git-send-email-zohar@linux.ibm.com>
         <1563460194-21569-2-git-send-email-zohar@linux.ibm.com>
         <20190723221801.ycvdj5eajlrozxf6@altlinux.org>
         <1563922756.4294.16.camel@linux.ibm.com>
         <20190723231316.rnngionrm4lrtyct@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072400-0012-0000-0000-00000335915C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072400-0013-0000-0000-0000216F2348
Message-Id: <1563927586.4294.20.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-07-24 at 02:13 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Tue, Jul 23, 2019 at 06:59:16PM -0400, Mimi Zohar wrote:
> > On Wed, 2019-07-24 at 01:18 +0300, Vitaly Chikunov wrote:
> > > On Thu, Jul 18, 2019 at 10:29:54AM -0400, Mimi Zohar wrote:
> > > > Each tima a new unknown key is encountered, emit a message of the format
> > > > "key #: <keyid> unknown".  The individual files using unknown keys are
> > > > then only logged in verbose mode.
> > > > 
> > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > ---
> > > >  src/libimaevm.c | 21 +++++++++++++++++----
> > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > > index 43eb4ef2412c..d2194a6ca0f8 100644
> > > > --- a/src/libimaevm.c
> > > > +++ b/src/libimaevm.c
> > > > @@ -402,13 +402,26 @@ static struct public_key_entry *public_keys = NULL;
> > > >  
> > > >  static EVP_PKEY *find_keyid(uint32_t keyid)
> > > >  {
> > > > -	struct public_key_entry *entry;
> > > > +	struct public_key_entry *entry, *tail = public_keys;
> > > 
> > > If user specified in `-k` filename that does not exist no key is added
> > > into public_keys and it remains NULL.
> > 
> > Right, just the keyid is added and an error message is emitted.
> > 
> > > 
> > > > +	int i = 1;
> > > >  
> > > >  	for (entry = public_keys; entry != NULL; entry = entry->next) {
> > > >  		if (entry->keyid == keyid)
> > > >  			return entry->key;
> > > > +		i++;
> > > > +		tail = entry;
> > > >  	}
> > > > -	return NULL;
> > > > +
> > > > +	/* add unknown keys to list */
> > > > +	entry = calloc(1, sizeof(struct public_key_entry));
> > > > +	if (!entry) {
> > > > +		perror("calloc");
> > > > +		return 0;
> > > > +	}
> > > > +	entry->keyid = keyid;
> > > > +	tail->next = entry;
> > > 
> > > In that case here is SIGSEGV when user try to ima_verify.
> > 
> > find_keyid() returns NULL, which is checked before being used.
> >  There's only one caller of this function.
> 
> find_keyid does not return since tail is NULL, thus there is null
> dereference in `tail->next`.
> 
> > Do you have a test case to reproduce this bug?
> 
>   ima-evm-utils/tests ((31b5f50...))$ rm sha1.txt
>   ima-evm-utils/tests ((31b5f50...))$ touch sha1.txt
>   ima-evm-utils/tests ((31b5f50...))$ evmctl ima_sign -k test-rsa1024.key -a sha1 --xattr-user sha1.txt
>   ima-evm-utils/tests ((31b5f50...))$ evmctl ima_verify -k /absent --xattr-user sha1.txt
>   Failed to open keyfile: /absent
>   Segmentation fault
> 
> 31b5f50 is head of your git next branch.
> 
> I temporary fixed like this:
> 
> -       tail->next = entry;
> +       if (tail)
> +               tail->next = entry;
> +       else
> +               public_keys = entry;

I see.  If you don't object, I'll fold this into the original patch. 

Mimi

