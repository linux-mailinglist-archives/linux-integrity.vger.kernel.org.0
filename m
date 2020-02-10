Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73857158188
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBJRja (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 12:39:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727922AbgBJRja (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 12:39:30 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AHc7p9082777
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2020 12:39:29 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tn50p0f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2020 12:39:29 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 10 Feb 2020 17:39:27 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Feb 2020 17:39:23 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01AHdMvC46792966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 17:39:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F2EBA4054;
        Mon, 10 Feb 2020 17:39:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8103A405B;
        Mon, 10 Feb 2020 17:39:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.79])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Feb 2020 17:39:20 +0000 (GMT)
Subject: Re: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Feb 2020 12:39:20 -0500
In-Reply-To: <CY4PR0401MB36523805F71721000F188F2FC3190@CY4PR0401MB3652.namprd04.prod.outlook.com>
References: <20200207092219.115056-1-tianjia.zhang@linux.alibaba.com>
         <20200207092219.115056-2-tianjia.zhang@linux.alibaba.com>
         <20200210031717.GA5198@sol.localdomain>
         <1a623251-e83a-3b70-9fbd-8e929a23f7d8@linux.ibm.com>
         <7a496bb15f264eab920bf081338d67af@MN2PR20MB2973.namprd20.prod.outlook.com>
         <CY4PR0401MB36523805F71721000F188F2FC3190@CY4PR0401MB3652.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021017-0028-0000-0000-000003D946FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021017-0029-0000-0000-0000249DB387
Message-Id: <1581356360.5585.830.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_06:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100132
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-10 at 17:01 +0000, Van Leeuwen, Pascal wrote:
> > -----Original Message-----
> > From: linux-crypto-owner@vger.kernel.org <linux-crypto-owner@vger.kernel.org> On Behalf Of James Bottomley
> > Sent: Monday, February 10, 2020 5:40 PM
> > To: Ken Goldman <kgold@linux.ibm.com>; Eric Biggers <ebiggers@kernel.org>; Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > Cc: herbert@gondor.apana.org.au; davem@davemloft.net; zohar@linux.ibm.com; dmitry.kasatkin@gmail.com; jmorris@namei.org;
> > serge@hallyn.com; linux-crypto@vger.kernel.org; linux-integrity@vger.kernel.org; linux-security-module@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
> >
> > <<< External Email >>>
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the
> > sender/sender address and know the content is safe.
> >
> >
> > On Mon, 2020-02-10 at 11:30 -0500, Ken Goldman wrote:
> > > On 2/9/2020 10:17 PM, Eric Biggers wrote:
> > > > According to https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Ftools.ietf.org%2Fid%2Fdraft-oscca-cfrg-sm3-
> > 01.html&amp;data=01%7C01%7Cpvanleeuwen%40verimatrix.com%7C3a51d0c133dd4b00fd9a08d7ae47d6d6%7Cdcb260f9022d449586
> > 02eae51035a0d0%7C0&amp;sdata=0nQ6tWMdVR5uB0MTCgdMXiOmkvTvGEKDTLcMXdzyZpg%3D&amp;reserved=0
> > > > ,
> > > > SM3 always produces a 256-bit hash value.  E.g., it says:
> > > >
> > > >     "SM3 produces an output hash value of 256 bits long"
> > > >
> > > > and
> > > >
> > > >     "SM3 is a hash function that generates a 256-bit hash value."
> > > >
> > > > I don't see any mention of "SM3-256".
> > > >
> > > > So why not just keep it as "sm3" and change hash_info.c instead?
> > > > Since the name there is currently wrong, no one can be using it
> > > > yet.
> > >
> > > Question:  Is 256 bits fundamental to SM3?
> >
> > No.
> >
> Well, the current specification surely doesn't define anything else and is
> already over a decade old. So what would be the odds that they add a
> different blocksize variant _now_ AND still call that SM3-something?
> 
> > >   Could there ever be a
> > > variant in the future that's e.g., 512 bits?
> >
> > Yes, SM3 like SHA-3 is based on a 512  bit input blocks.  However,
> > what's left of the standard:
> >
> SM3 is based on 512 bit input blocks, like _SHA-2_.
> The SHA-3 variants use block sizes between 576 and 1152 bits,
> depending on the output (digest) size.
> 
> The -xxx is referring to output (digest) size, not block size by the way.
> And SHA-3 is indeed defined for 512 bit output size, amongst others.
> 
> > https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.ietf.org%2Farchive%2Fid%2Fdraft-sca-cfrg-sm3-
> > 02.txt&amp;data=01%7C01%7Cpvanleeuwen%40verimatrix.com%7C3a51d0c133dd4b00fd9a08d7ae47d6d6%7Cdcb260f9022d44958602
> > eae51035a0d0%7C0&amp;sdata=9pfgM0bG%2Bp0zUavsknwn9vquWqPsqzPENV2okmgCOqE%3D&amp;reserved=0
> >
> > Currently only defines a 256 output (via compression from the final 512
> > bit output).
> >
> Yes. Although that is not the original (Chinese) specification.
> 
> > In theory, like SHA-3, SM3 could support 384 and 512
> > output variants.  However, there's no evidence anyone is working on
> > adding this.
> >
> Hmm ... not without changing the word width (as for SHA-512) and/or
> increasing the number of rounds plus other tweaking, I would say.
> It's not as straightforward as you are suggesting (crypto rarely is).
> I would even go as far as saying that is highly unlikely to happen.

So in terms of this discussion, does this mean you don't see a problem
with renaming "sm3-256" to "sm3" in crypto/hash_info.c?  If that's the
case, please add your Reviewed-by tag to the 1/2.

thanks,

Mimi

