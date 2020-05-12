Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022F71CF473
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 14:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgELMed (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 08:34:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55434 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELMed (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 08:34:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CCX6TC041887;
        Tue, 12 May 2020 12:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9MAr3psiqSgFLC1S1xXi7fK1PR6Chlfg507XTQKalmw=;
 b=miVL9cpwgaON2aqqh186gwHnjLhlHpv53T5ysmJZGK53/ximMC1dm7r11XCTvhMKVCH/
 OL/g1LohWi2UqSouLmdoJGV7lPYNdKlQbH7ioRy5SGWfSzvrtARx0qgjRZsaBajnK4ke
 1J0wFmcqateR98II6ZhDwZnz82Ha1k1S7F2y7p8GRYe/y3z3GQSL1tSgmkyT+tT4o/rj
 D6Lk2e1PxqhMqgaBg3/tflg0zp5TeTncqElWD5SpbZNxdbENnRiI/2xuZpE+M8+9DC5U
 THXFNiSuBhU4TL1TQJKLWnD2J6zLqtLCL0E70IMFVISzDF90JGJsWS0bheatiVnmI46Y dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30x3gsjn4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 12:34:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CCWXpX047194;
        Tue, 12 May 2020 12:34:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30xbgjf02j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 12:34:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CCYLXi032637;
        Tue, 12 May 2020 12:34:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 05:34:20 -0700
Date:   Tue, 12 May 2020 15:34:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Re: [bug report] evm: Check also if *tfm is an error pointer in
 init_desc()
Message-ID: <20200512123414.GA2056@kadam>
References: <20200512104809.GA262740@mwanda>
 <267804d00f2e457186509a6ae40c9c7f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267804d00f2e457186509a6ae40c9c7f@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=2 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120094
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 12, 2020 at 11:31:53AM +0000, Roberto Sassu wrote:
> > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > Sent: Tuesday, May 12, 2020 12:48 PM
> > 
> > Hello Roberto Sassu,
> > 
> > The patch 53de3b080d5e: "evm: Check also if *tfm is an error pointer
> > in init_desc()" from Apr 27, 2020, leads to the following static
> > checker warning:
> > 
> > 	security/integrity/evm/evm_crypto.c:119 init_desc()
> > 	error: '*tfm' dereferencing possible ERR_PTR()
> > 
> > security/integrity/evm/evm_crypto.c
> >     89
> >     90                  tfm = &evm_tfm[hash_algo];
> >     91                  algo = hash_algo_name[hash_algo];
> >     92          }
> >     93
> >     94          if (IS_ERR_OR_NULL(*tfm)) {
> > 
> > This used to be a "if (!*tfm)" check.
> > 
> >     95                  mutex_lock(&mutex);
> >     96                  if (*tfm)
> >     97                          goto out;
> > 
> > Then we test again with the lock held.  But in the new code if "*tfm"
> > is an error pointer then we jump directly to the unlock and crash on the
> > next line.  I can't see how the commit would fix anything.
> 
> Hello Dan
> 
> you are right. The fix should be applied in both places.
> 
> if (!IS_ERR_OR_NULL(*tfm))
> 	goto out;

No.  I was wrong.

> 
> >     98                  *tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
> >     99                  if (IS_ERR(*tfm)) {
> >    100                          rc = PTR_ERR(*tfm);
> >    101                          pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
> >    102                          *tfm = NULL;
> >    103                          mutex_unlock(&mutex);
> >    104                          return ERR_PTR(rc);
> >    105                  }
> >    106                  if (type == EVM_XATTR_HMAC) {
> >    107                          rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
> >    108                          if (rc) {
> >    109                                  crypto_free_shash(*tfm);
> >    110                                  *tfm = NULL;
> >    111                                  mutex_unlock(&mutex);
> >    112                                  return ERR_PTR(rc);
> >    113                          }
> >    114                  }
> >    115  out:
> >    116                  mutex_unlock(&mutex);
> >    117          }
> >    118
> >    119          desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
> >                                                                      ^^^^
> > I don't understand how using *tfm outside of a lock is safe at all
> > anyway.
> 
> I think the purpose of the mutex is just to  prevent two concurrent
> allocations. Later, it should not be a problem, as *tfm is never freed.
> 

Actually by the time we take the lock then *tfm is either valid or NULL
so this code works.  It's confusing though.

regards,
dan carpenter

