Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040024E718
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2019 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFUL1s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Jun 2019 07:27:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbfFUL1s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Jun 2019 07:27:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LBMOFD109416
        for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2019 07:27:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8x5wrjgg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Jun 2019 07:27:47 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Jun 2019 12:27:45 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Jun 2019 12:27:42 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5LBRfrt59244790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 11:27:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B02C4C040;
        Fri, 21 Jun 2019 11:27:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8F6A4C044;
        Fri, 21 Jun 2019 11:27:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.152])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jun 2019 11:27:40 +0000 (GMT)
Subject: Re: [PATCH v5 01/11] ima-evm-utils: Make sure sig buffer is always
 MAX_SIGNATURE_SIZE
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 21 Jun 2019 07:27:30 -0400
In-Reply-To: <20190621112225.sf6rtxzc2pu4oyfh@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
         <20190618135623.6861-2-vt@altlinux.org>
         <1561066938.4057.18.camel@linux.ibm.com>
         <20190621065913.a3plltlinylkdkeb@altlinux.org>
         <1561115292.4057.70.camel@linux.ibm.com>
         <20190621112225.sf6rtxzc2pu4oyfh@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19062111-0012-0000-0000-0000032B30EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062111-0013-0000-0000-000021645A85
Message-Id: <1561116450.4057.81.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=941 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210097
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-06-21 at 14:22 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Fri, Jun 21, 2019 at 07:08:12AM -0400, Mimi Zohar wrote:
> > On Fri, 2019-06-21 at 09:59 +0300, Vitaly Chikunov wrote:
> > > On Thu, Jun 20, 2019 at 05:42:18PM -0400, Mimi Zohar wrote:
> > > > On Tue, 2019-06-18 at 16:56 +0300, Vitaly Chikunov wrote:
> > > > > Fix off-by-one error of the output buffer passed to sign_hash().
> > > > > 
> > > > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > > > ---
> > > > >  src/evmctl.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > > > index 15a7226..03f41fe 100644
> > > > > --- a/src/evmctl.c
> > > > > +++ b/src/evmctl.c
> > > > > @@ -510,7 +510,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
> > > > >  static int sign_evm(const char *file, const char *key)
> > > > >  {
> > > > >  	unsigned char hash[MAX_DIGEST_SIZE];
> > > > > -	unsigned char sig[MAX_SIGNATURE_SIZE];
> > > > > +	unsigned char sig[MAX_SIGNATURE_SIZE + 1];
> > > > >  	int len, err;
> > > > > 
> > > > >  	len = calc_evm_hash(file, hash);
> > > > > @@ -519,7 +519,7 @@ static int sign_evm(const char *file, const char *key)
> > > > >  		return len;
> > > > > 
> > > > >  	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
> > > > > -	assert(len < sizeof(sig));
> > > > > +	assert(len <= MAX_SIGNATURE_SIZE);
> > > > >  	if (len <= 1)
> > > > >  		return len;
> > > > > 
> > > > 
> > > > A similar problem occurs in sign_ima.  Without these changes
> > > > sign_hash() succeeds, returning a length of 520 for
> > > > sha256/streebog256. 
> > > 
> > > I will add it. Also, I found more similar errors and will fix them together.
> > 
> > The first byte of sig is reserved for the type of signature.  The
> > remaining buffer is for the signature itself.  The existing
> > "assert(len < sizeof(sig))" is therefore correct.  The sig size being
> > returned is less than 1023, so why is this change needed?
> 
> Well, it looked more straightforward to check explicit
> MAX_SIGNATURE_SIZE instead of relying on that '<' accounts for
> that additional byte.
> 
> Main fix is of course this:
> 
> > > > > -       unsigned char sig[MAX_SIGNATURE_SIZE];
> > > > > +       unsigned char sig[MAX_SIGNATURE_SIZE + 1];

That is the question.  Why does the buffer need to be
"MAX_SIGNATURE_SIZE + 1", making it 1025 bytes?  MAX_SIGNATURE_SIZE -
1 is large enough for the signature.

Mimi

> 
> I will revert all that `assert(len <= MAX_SIGNATURE_SIZE)` back to
> `assert(len < sizeof(sig))`.
> 
> Thanks,
> 

