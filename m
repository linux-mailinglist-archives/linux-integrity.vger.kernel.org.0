Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CA3EEB9A
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Aug 2021 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhHQL0o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Aug 2021 07:26:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231515AbhHQL0n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Aug 2021 07:26:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HB2nSh184130;
        Tue, 17 Aug 2021 07:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=n72+iHJJFhniLTy+qA/Q7KFxEbXzST5TkOV1jvrETo8=;
 b=IH39FpXhQCUN+AUCnNSzGOsYGGx23OlQKiPVvr2FLe2wFrb0BqpaoHbb0dZt3pUstQDQ
 AsJXeO9QEKVI8h2Wux8jzWgvxDIqrVs6EBegpXr8wALH8nuhHeILm7U4ZxW1oYwGeTEp
 4zx/IzUG86vYpfaG6dHCRrAfYTL445rSonSaFUbkBvh1cPVBo55wNJ+aPh9sc7W02pG0
 fMl6/F5DkHnZlIfmiDw+rmJzZZpf6v4nIkmvAYYsjLDS4xu8mpodnVdpCSV64Sbsiyjg
 yMVul0nZLQnRhJKqvz+JaAIRb74tsJFDTMwf5VVpMdPhNEUZhoD038Sm8pD2FCoYw9Zn 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aetr7610h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Aug 2021 07:26:10 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17HBQ9TK097712;
        Tue, 17 Aug 2021 07:26:09 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aetr760yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Aug 2021 07:26:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17HBCuuS021773;
        Tue, 17 Aug 2021 11:26:07 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3ae5f8cs1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Aug 2021 11:26:07 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17HBQ4bl51970520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 11:26:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A72F211C07B;
        Tue, 17 Aug 2021 11:26:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DBE011C06F;
        Tue, 17 Aug 2021 11:26:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.53.55])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Aug 2021 11:26:03 +0000 (GMT)
Message-ID: <ee5f3cc1b8917b2c67a68738a8eb3584c4661349.camel@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils] libimaevm: make SHA-256 the default
 hash algorithm
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Bruno Meneguele <bmeneg@redhat.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "kgold@linux.ibm.com" <kgold@linux.ibm.com>
Date:   Tue, 17 Aug 2021 07:26:02 -0400
In-Reply-To: <2fb236f1-2a10-02e4-f796-6865d3411c2f@viveris.fr>
References: <20210816205835.76183-1-bmeneg@redhat.com>
         <2fb236f1-2a10-02e4-f796-6865d3411c2f@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YrmMGUSiKmypqTpfTwqiye26UwCbVUyJ
X-Proofpoint-ORIG-GUID: 2jPBRnwGtTn9W_Fceq8QxXXNska3Nz7P
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_03:2021-08-16,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-08-17 at 07:42 +0000, THOBY Simon wrote:
> Hi Bruno,
> 
> On 8/16/21 10:58 PM, Bruno Meneguele wrote:
> > The SHA-1 algorithm is considered a weak hash algorithm and there has been
> > some movement within certain distros to drop its support completely or at
> > least drop it from the default behavior. ima-evm-utils uses it as the
> > default algorithm in case the user doesn't explicitly ask for another
> > through the --hashalgo/-a option. With that, make SHA-256 the default hash
> > algorithm instead.
> 
> I'm really happy to see that patch!
> I contributed to the patchset https://lore.kernel.org/linux-integrity/20210816081056.24530-1-Simon.THOBY@viveris.fr/T/#m8372b2b55dc8e1517e37624829fc8cb4361baf4d
> because I ran into exactly this issue of (hashing files with SHA1 because of
> the "insecure" default of evmctl).
> So I'm definitely in favor of switching the default hash to sha256.
> 
> That said, considering that CONFIG_IMA (in the kernel) doesn't depend
> on CONFIG_CRYPTO_SHA256, isn't there a risk that files hashes/signed with
> this patch could break on a kernel where that option wasn't selected?
> (I also don't know how frequent kernels without CONFIG_CRYPTO_SHA256
> may be - given that CONFIG_ENCRYPTED_KEYS require SHA256, probably
> not so much)
> I guess this boils down to: "do we know of any distribution not selecting
> CRYPTO_SHA256?". If we don't, then the backward compatibility impact should
> be nearly void. If we do, some decision must be taken.
> 
> > 
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> > ---
> > Changelog:
> >   v1: add ima-evm-utils to the [PATCH] part of the subject
> > 
> >  README          | 2 +-
> >  src/evmctl.c    | 2 +-
> >  src/libimaevm.c | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/README b/README
> > index 87cd3b5cd7da..0dc02f551673 100644
> > --- a/README
> > +++ b/README
> > @@ -41,7 +41,7 @@ COMMANDS
> >  OPTIONS
> >  -------
> >  
> > -  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512
> > +  -a, --hashalgo     sha1, sha224, sha256 (default), sha384, sha512
> >    -s, --imasig       make IMA signature
> >    -d, --imahash      make IMA hash
> >    -f, --sigfile      store IMA signature in .sig file instead of xattr
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index a8065bbe124a..e0e55bc0b122 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -2496,7 +2496,7 @@ static void usage(void)
> >  
> >  	printf(
> >  		"\n"
> > -		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512, streebog256, streebog512\n"
> > +		"  -a, --hashalgo     sha1, sha224, sha256 (default), sha384, sha512, streebog256, streebog512\n"
> >  		"  -s, --imasig       make IMA signature\n"
> >  		"  -d, --imahash      make IMA hash\n"
> >  		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index 8e9615796153..f6c72b878d88 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -88,7 +88,7 @@ static const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
> >  struct libimaevm_params imaevm_params = {
> >  	.verbose = LOG_INFO,
> >  	.x509 = 1,
> > -	.hash_algo = "sha1",
> > +	.hash_algo = "sha256",
> >  };
> >  
> >  static void __attribute__ ((constructor)) libinit(void);
> > 
> 
> No comments on the code change, it looks alright to me.

Agreed with Simon's comments above.

Currently the default hash algorithm may be modified by supplying "
--hashalgo" on the command.  We also know that whatever default hash
algorithm chosen now, will change in the future.  Instead of hard
coding the default hash algorithm, does it make more sense to make it a
build time config option (e.g. DEFAULT_HASH_ALGO)? 

thanks,

Mimi

