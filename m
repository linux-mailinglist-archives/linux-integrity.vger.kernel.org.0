Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9933F3F7D51
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Aug 2021 22:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbhHYUpw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 16:45:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242667AbhHYUpw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 16:45:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17PKag0A189045;
        Wed, 25 Aug 2021 16:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RaqARarNKISvLre59wbZpYt8/bsGEWy7u65EJvNCIEg=;
 b=Mq37kDyveiZxo5aESrEY3M4MYEJAPdKjc5EMYXsttFbtCnkxQjEN+YAHXykJ1fpuXgs9
 9yAPoLf7whg8KvAiKYV4cJrcIEEyLtowT6TOrvu/b0/ehTAghYxBOouUCDgfNo8O8I5y
 6A1dbWWTQk7AQZU52yuu2oKhpkaDkagTMFFtMWEkSLmWkrH1jrVUHhahmVvBHNcBDQnJ
 U0Lny6JVpCvvgCg2HN1q0TIcHy1yp/RvTuEZGhTpqQdSytYWy+fx2g9uyl7Zt077LH/j
 L881DRf2ls9hd+wUTZQCwwaorMLH3FUTev9q/XQ1j8Aivb1011S016/H+p7x1Zsynu/N Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3anu6x3gg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 16:45:03 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17PKawOM190692;
        Wed, 25 Aug 2021 16:45:03 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3anu6x3gf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 16:45:02 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17PKckKf027573;
        Wed, 25 Aug 2021 20:45:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3ajrrhfy3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 20:45:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17PKiwXK49873404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 20:44:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87AE55204E;
        Wed, 25 Aug 2021 20:44:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.60.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7625B5204F;
        Wed, 25 Aug 2021 20:44:57 +0000 (GMT)
Message-ID: <73a9da5381a42f9e05d5f4b5424ac84924753fbc.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3] Use secure heap for private keys and
 passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 25 Aug 2021 16:44:56 -0400
In-Reply-To: <20210825184137.rv2pb2zieekvvlyd@altlinux.org>
References: <20210822001055.1772873-1-vt@altlinux.org>
         <0c5c0851cd07f861ebf79bc0ac90e57d71317985.camel@linux.ibm.com>
         <20210825184137.rv2pb2zieekvvlyd@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B87WY-rEvJnvi50vHB2Z3zN3s9vWNZpM
X-Proofpoint-ORIG-GUID: xpbQH2Gz9CBY5ow_v2bOQCiEvMstLpoi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-25_07:2021-08-25,2021-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108250119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-25 at 21:41 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Wed, Aug 25, 2021 at 07:39:30AM -0400, Mimi Zohar wrote:
> > Hi Vitaly,
> > 
> > On Sun, 2021-08-22 at 03:10 +0300, Vitaly Chikunov wrote:
> > > After CRYPTO_secure_malloc_init OpenSSL will store private keys 
> > 
> > ^and passwords
> 
> No, it meant openssl automatically will handle private keys (and other
> internal private data) in secure heap.
> 
> Handling of passwords in openssl's secure heap we do ourselves. I can
> extend commit message about this.

Ah, nice!   Please expand the patch description, adding what you said
here.

Also, you might want to include that since OPENSSL_secure_malloc_init()
is called from evmctl.c, any application linking with libimaevm would
not be using secure heap.

> 
> > > in
> > > secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> > > 
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > 
> > Initially we started out discussing ways of protecting passwords, which
> > this patch does.  Thank you!  I'm not sure, however, it is protecting
> > the private keys.  Does read_priv_pkey()  also use the secure heap or
> > is PEM_read_PrivateKey() already safe?
> 
> After CRYPTO_secure_malloc_init call all openssl API functions that
> handle private keys and passwords should use secure heap. So, in that
> regard we don't need to add anything.

Ok

> > 
> > > ---
> > >  src/evmctl.c | 148 +++++++++++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 121 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > 
> > > @@ -188,7 +207,9 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
> > >  	return err;
> > >  }
> > > 
> > > -static unsigned char *file2bin(const char *file, const char *ext, int *size)
> > > +/* Return data in OpenSSL secure heap if 'secure' is true. */
> > > +static unsigned char *file2bin(const char *file, const char *ext, int *size,
> > > +			       int secure)
> > >  {
> > 
> > The only caller of file2bin() that sets "secure" is evm_calc_hmac(),
> > but evm_calc_hmac() is a debugging tool, not meant for setting the real
> > security.evm xattr.
> 
> I can undo file2bin change if you wish, but for uniformity I would have
> it changed. We can add comment that it is handling only test & debugging
> data, thus not using security measures. May also output some warning at
> runtime.

Either way is fine, but somehow please document it.

thanks,

Mimi

