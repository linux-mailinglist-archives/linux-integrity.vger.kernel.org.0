Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3A431C23
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Oct 2021 15:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhJRNjN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Oct 2021 09:39:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232986AbhJRNgR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Oct 2021 09:36:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IDRqwT029706;
        Mon, 18 Oct 2021 09:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JDAp/QbIUWGCikoHHAVy/7phqz6YT5n7K/jogqJx72k=;
 b=W6cSZlLC8ZL82ktWHjvmUt2m2MwyVnapxep0BkpttuI2YOqPzfW7edsFxIqBUcXx1AQ/
 GC67ImNcgwRwVj8p7sZtKS8ymdLmAxGbQ0Q7r0KGZn0neUvffCS7dzd0p8/k6phJs9cq
 oYkq9m4YnG2gkXNSvsaTyBulCbnu1vywh/UNVVUnbacB+ExQMhgnNtaTC8WGjpgVaPG1
 7i/HJ1fHKmQFm1NGpENVwRJLgcb7rkreRrGeBTxsNJZhs5AWQjcNd9mBEXw60Zp1Bqif
 +TCRSsoxExq60HJq9IRaKLV9BcZVhe13vjtiuZVRG/b05oW2NHucb6BVeTnb+yjlh+bG EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bs7yg30xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 09:33:45 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19ID761B001790;
        Mon, 18 Oct 2021 09:33:45 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bs7yg30x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 09:33:44 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19IDE1JB024045;
        Mon, 18 Oct 2021 13:33:43 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3bqpcap83r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 13:33:43 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19IDWgLh13369606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Oct 2021 13:32:42 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E605A7807F;
        Mon, 18 Oct 2021 13:32:41 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68BF8780A5;
        Mon, 18 Oct 2021 13:32:38 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.92.132])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 18 Oct 2021 13:32:38 +0000 (GMT)
Message-ID: <af8c2098c4cfe23b941a191f7b4ec0e3a5251760.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] crypto: use SM3 instead of SM3_256
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Mon, 18 Oct 2021 09:32:37 -0400
In-Reply-To: <dbac037710d711959d5ce0969f80ea0dd18a176e.camel@kernel.org>
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
         <20211009130828.101396-2-tianjia.zhang@linux.alibaba.com>
         <7035153d58e220473fe3cd17c9f574f2d91c740b.camel@linux.ibm.com>
         <dbac037710d711959d5ce0969f80ea0dd18a176e.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SW8QK8L-lxQ-ruyGXMnXT-K1EUevH8uK
X-Proofpoint-GUID: lEph34QWP6JE0R4eJ-ufOwZ10GN16i8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_05,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110180084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-10-18 at 16:27 +0300, Jarkko Sakkinen wrote:
> On Mon, 2021-10-18 at 09:05 -0400, James Bottomley wrote:
> > On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
> > [...]
> > > diff --git a/include/uapi/linux/hash_info.h
> > > b/include/uapi/linux/hash_info.h
> > > index 74a8609fcb4d..1355525dd4aa 100644
> > > --- a/include/uapi/linux/hash_info.h
> > > +++ b/include/uapi/linux/hash_info.h
> > > @@ -32,7 +32,7 @@ enum hash_algo {
> > >         HASH_ALGO_TGR_128,
> > >         HASH_ALGO_TGR_160,
> > >         HASH_ALGO_TGR_192,
> > > -       HASH_ALGO_SM3_256,
> > > +       HASH_ALGO_SM3,
> > >         HASH_ALGO_STREEBOG_256,
> > >         HASH_ALGO_STREEBOG_512,
> > >         HASH_ALGO__LAST
> > 
> > This is another one you can't do: all headers in UAPI are exports
> > to userspace and the definitions constitute an ABI.  If you simply
> > do a rename, every userspace program that uses the current
> > definition will immediately break on compile.  You could add
> > HASH_ALGO_SM3, but you can't remove HASH_ALGO_SM3_256
> > 
> > James
> 
> So: shouldn't then also the old symbol continue to work also
> semantically?

Yes, that's the point: you can add a new definition ... in this case an
alias for the old one, but you can't remove a definition that's been
previously exported.

James


