Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E361CF535
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgELNEa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 09:04:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgELNE3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 09:04:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CD2G0A056223;
        Tue, 12 May 2020 13:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=boOY3CvcqQO7NPUstrQQuok4LQP9n5pK2U+XHjDtKrc=;
 b=ggHqjCOPf2nPIMYn/yL42kYZ47vr4vq+XJj6Zvv/M8vmZ9J8HYbZ2/z86clTatR5kSG4
 LWlg24zMFiCwlqSnGP2oHjlr6DvfgQm+wgn5H1rnp3NQRoY4j6usfcx/rmfRLtwLNZZw
 pv6REuyepHKeQfLygHK5NKMUD8/FSl4dZ53cL4L/DF+niobsgCds9lm9lZA0VoONt0ps
 lC2O6Q/ukxvmmsqpr20jbIwyZT6tYSVdzVmJ5nW21U5dOISiDN/6H6Ip+t5qwDyUTfmu
 fd6KALzk6NQMuA9jCrvJNi5CwJNAY9bfb/F73zMt151wEiP2jGiwtH3K10i240PxYkKP MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30x3gmjuf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 13:04:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CD2XJW142283;
        Tue, 12 May 2020 13:04:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30xbgjhp42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 13:04:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04CD4Htx012919;
        Tue, 12 May 2020 13:04:17 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 06:04:17 -0700
Date:   Tue, 12 May 2020 16:04:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [bug report] evm: Check also if *tfm is an error pointer in
 init_desc()
Message-ID: <20200512130410.GB2056@kadam>
References: <20200512104809.GA262740@mwanda>
 <267804d00f2e457186509a6ae40c9c7f@huawei.com>
 <20200512123414.GA2056@kadam>
 <7fbab163eb76459a82ebe94c577a4954@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fbab163eb76459a82ebe94c577a4954@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=2 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=2
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120098
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 12, 2020 at 12:45:06PM +0000, Roberto Sassu wrote:
> > From: owner-linux-security-module@vger.kernel.org [mailto:owner-linux-
> > security-module@vger.kernel.org] On Behalf Of Dan Carpenter
> > Sent: Tuesday, May 12, 2020 2:34 PM
> > On Tue, May 12, 2020 at 11:31:53AM +0000, Roberto Sassu wrote:
> > > > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > > > Sent: Tuesday, May 12, 2020 12:48 PM
> > > >
> > > > Hello Roberto Sassu,
> > > >
> > > > The patch 53de3b080d5e: "evm: Check also if *tfm is an error pointer
> > > > in init_desc()" from Apr 27, 2020, leads to the following static
> > > > checker warning:
> > > >
> > > > 	security/integrity/evm/evm_crypto.c:119 init_desc()
> > > > 	error: '*tfm' dereferencing possible ERR_PTR()
> > > >
> > > > security/integrity/evm/evm_crypto.c
> > > >     89
> > > >     90                  tfm = &evm_tfm[hash_algo];
> > > >     91                  algo = hash_algo_name[hash_algo];
> > > >     92          }
> > > >     93
> > > >     94          if (IS_ERR_OR_NULL(*tfm)) {
> > > >
> > > > This used to be a "if (!*tfm)" check.
> > > >
> > > >     95                  mutex_lock(&mutex);
> > > >     96                  if (*tfm)
> > > >     97                          goto out;
> > > >
> > > > Then we test again with the lock held.  But in the new code if "*tfm"
> > > > is an error pointer then we jump directly to the unlock and crash on the
> > > > next line.  I can't see how the commit would fix anything.
> > >
> > > Hello Dan
> > >
> > > you are right. The fix should be applied in both places.
> > >
> > > if (!IS_ERR_OR_NULL(*tfm))
> > > 	goto out;
> > 
> > No.  I was wrong.
> > 
> > >
> > > >     98                  *tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
> > > >     99                  if (IS_ERR(*tfm)) {
> > > >    100                          rc = PTR_ERR(*tfm);
> > > >    101                          pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
> > > >    102                          *tfm = NULL;
> > > >    103                          mutex_unlock(&mutex);
> > > >    104                          return ERR_PTR(rc);
> > > >    105                  }
> > > >    106                  if (type == EVM_XATTR_HMAC) {
> > > >    107                          rc = crypto_shash_setkey(*tfm, evmkey,
> > evmkey_len);
> > > >    108                          if (rc) {
> > > >    109                                  crypto_free_shash(*tfm);
> > > >    110                                  *tfm = NULL;
> > > >    111                                  mutex_unlock(&mutex);
> > > >    112                                  return ERR_PTR(rc);
> > > >    113                          }
> > > >    114                  }
> > > >    115  out:
> > > >    116                  mutex_unlock(&mutex);
> > > >    117          }
> > > >    118
> > > >    119          desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
> > > >                                                                      ^^^^
> > > > I don't understand how using *tfm outside of a lock is safe at all
> > > > anyway.
> > >
> > > I think the purpose of the mutex is just to  prevent two concurrent
> > > allocations. Later, it should not be a problem, as *tfm is never freed.
> > >
> > 
> > Actually by the time we take the lock then *tfm is either valid or NULL
> > so this code works.  It's confusing though.
> 
> static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
> {
>         return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
> }
> 
> CPU#1			CPU#2
> 			*tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
> unlikely(!ptr)
> 			*tfm = NULL;
> IS_ERR_VALUE((unsigned long)ptr);
> 
> desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
> 
> Could this happen?

Yeah.  Huh.  That's true.  Good eyes.

I feel like this would be more clear as well if we used a temporary
variable instead of working directly on "*tfm".

regards,
dan carpenter
