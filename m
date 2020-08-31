Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273CC2576BF
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgHaJo0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 05:44:26 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbgHaJoZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 05:44:25 -0400
Received: from lhreml727-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6D646A6DED6AE900DFEB;
        Mon, 31 Aug 2020 10:44:21 +0100 (IST)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml727-chm.china.huawei.com (10.201.108.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Mon, 31 Aug 2020 10:44:21 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 31 Aug 2020 11:44:20 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Mon, 31 Aug 2020 11:44:20 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH 02/11] evm: Load EVM key in ima_load_x509() to avoid
 appraisal
Thread-Topic: [PATCH 02/11] evm: Load EVM key in ima_load_x509() to avoid
 appraisal
Thread-Index: AQHWRYodp/NjA9peNES6j1M1Cdu/PKlDKc4AgA9AvsA=
Date:   Mon, 31 Aug 2020 09:44:20 +0000
Message-ID: <a4bf0f73e0854cf18d942330a7543d9d@huawei.com>
References: <20200618160133.937-1-roberto.sassu@huawei.com>
         <20200618160133.937-2-roberto.sassu@huawei.com>
 <8a1773d7707639d275fff138736d57472e26ade5.camel@linux.ibm.com>
In-Reply-To: <8a1773d7707639d275fff138736d57472e26ade5.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.205.186]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Friday, August 21, 2020 8:45 PM
> On Thu, 2020-06-18 at 18:01 +0200, Roberto Sassu wrote:
> > Public keys do not need to be appraised by IMA as the restriction on the
> > IMA/EVM keyrings ensures that a key is loaded only if it is signed with a
> > key in the primary or secondary keyring.
> >
> > However, when evm_load_x509() is loaded, appraisal is already enabled
> and
> > a valid IMA signature must be added to the EVM key to pass verification.
> >
> > Since the restriction is applied on both IMA and EVM keyrings, it is safe
> > to disable appraisal also when the EVM key is loaded. This patch calls
> > evm_load_x509() inside ima_load_x509() if CONFIG_IMA_LOAD_X509 is
> defined.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/iint.c         | 2 ++
> >  security/integrity/ima/ima_init.c | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > index e12c4900510f..4765a266ba96 100644
> > --- a/security/integrity/iint.c
> > +++ b/security/integrity/iint.c
> > @@ -212,7 +212,9 @@ int integrity_kernel_read(struct file *file, loff_t
> offset,
> >  void __init integrity_load_keys(void)
> >  {
> >  	ima_load_x509();
> > +#ifndef CONFIG_IMA_LOAD_X509
> >  	evm_load_x509();
> > +#endif
> >  }
> >
> >  static int __init integrity_fs_init(void)
> > diff --git a/security/integrity/ima/ima_init.c
> b/security/integrity/ima/ima_init.c
> > index 4902fe7bd570..9d29a1680da8 100644
> > --- a/security/integrity/ima/ima_init.c
> > +++ b/security/integrity/ima/ima_init.c
> > @@ -106,6 +106,10 @@ void __init ima_load_x509(void)
> >
> >  	ima_policy_flag &= ~unset_flags;
> >  	integrity_load_x509(INTEGRITY_KEYRING_IMA,
> CONFIG_IMA_X509_PATH);
> > +
> > +	/* load also EVM key to avoid appraisal */
> > +	evm_load_x509();
> > +
> >  	ima_policy_flag |= unset_flags;
> >  }
> >  #endif
> 
> As much as possible IMA and EVM should remain independent of each
> other.   Modifying integrity_load_x509() doesn't help.  This looks like
> a good reason for calling another EVM function from within IMA.

Can I add your Reviewed-by?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
