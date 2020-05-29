Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8C1E76B5
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2020 09:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgE2Hdh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 May 2020 03:33:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgE2Hdh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 May 2020 03:33:37 -0400
Received: from lhreml714-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id BC01CA0D3522520D419B;
        Fri, 29 May 2020 08:33:35 +0100 (IST)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml714-chm.china.huawei.com (10.201.108.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 29 May 2020 08:33:35 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 29 May 2020 09:33:34 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Fri, 29 May 2020 09:33:34 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Silviu Vlasceanu" <Silviu.Vlasceanu@huawei.com>
Subject: RE: Oops at boot with linux-next kernel with IMA boot options
Thread-Topic: Oops at boot with linux-next kernel with IMA boot options
Thread-Index: AQHWNQWdtGASKXj1EUeXcoX7+5fwg6i9kOcAgAAmYdD///FwgIABAtrA
Date:   Fri, 29 May 2020 07:33:34 +0000
Message-ID: <22f1132ebc9d4c2e8fc354efb1845984@huawei.com>
References: <s5htv00m5sb.wl-tiwai@suse.de>      <s5hk10wm2x3.wl-tiwai@suse.de>
        <4de686af78e94893b3578f6970d783d5@huawei.com> <s5hblm8lyz0.wl-tiwai@suse.de>
In-Reply-To: <s5hblm8lyz0.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.22.111]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Takashi Iwai [mailto:tiwai@suse.de]
> On Thu, 28 May 2020 19:36:55 +0200,
> Roberto Sassu wrote:
> >
> > > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > > owner@vger.kernel.org] On Behalf Of Takashi Iwai
> > > On Thu, 28 May 2020 17:35:16 +0200,
> > > Takashi Iwai wrote:
> > > >
> > > > Hi Roberto,
> > > >
> > > > it seems that the recent changes in IMA in linux-next caused a
> > > > regression: namely it triggers an Oops when booting with the options
> > > >   ima_policy=tcb ima_template_fmt='d-ng|n-ng|d|ng'
> > >
> > > And further experiment revealed that passing only
> ima_template_fmt=d
> > > is enough for triggering the bug.  Other formats don't matter.
> > >
> > > (snip)
> > > > It's a KVM instance without any TPM stuff, just passed the options
> > > > above.  I could trigger the same bug on a bare metal, too.
> > > >
> > > > Then I performed bisection and it spotted the commit:
> > > > 6f1a1d103b48b1533a9c804e7a069e2c8e937ce7
> > > >   ima: Switch to ima_hash_algo for boot aggregate
> > > >
> > > > Actually reverting this commit fixed the Oops again.
> > >
> > > So, looking at the fact above (triggered by "d") and this bisection
> > > result, it seems that the issue is specific to ima_eventdigest_init().
> > > The difference from others is that this has a check by
> > > ima_template_hash_algo_allowed(), and currently the check allows only
> > > SHA1 and MD5, while now SHA256 is assigned as default.  So I tested
> > > adding SHA256 there like below, and it seems working.
> > >
> > > Hopefully I'm heading to a right direction...
> >
> > Hi Takashi
> >
> > boot_aggregate is the only entry for which there is no file descriptor.
> > The file descriptor is used to recalculate the digest if it is not SHA1
> > or MD5. For boot_aggregate, we should use instead
> > ima_calc_boot_aggregate(). I will provide a patch.
> >
> > I see that the .file member of event_data in
> > ima_add_boot_aggregate() is not initialized. Can you please try
> > to set .file to NULL?
> 
> Tested and it didn't help.  The field was already zero-initialized via
> C99-style initialization, I believe.

Found the issue.

ima_evendigest_init() returns an error and after that IMA is not
initialized. Unfortunately, ima_must_appraise() does not check
ima_policy_flag, so the kernel crashes when ima_match_policy()
tries to evaluate the policy which is not loaded (ima_rules = NULL).

if you add at the beginning of ima_must_appraise()

if (!ima_policy_flag)
	return 0;

the kernel should not crash.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Takashi
> 
> >
> > Thanks
> >
> > Roberto
> >
> > HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
> > Managing Director: Li Peng, Li Jian, Shi Yanli
> >
> > > thanks,
> > >
> > > Takashi
> > >
> > > --- a/security/integrity/ima/ima_template_lib.c
> > > +++ b/security/integrity/ima/ima_template_lib.c
> > > @@ -13,7 +13,8 @@
> > >
> > >  static bool ima_template_hash_algo_allowed(u8 algo)
> > >  {
> > > -	if (algo == HASH_ALGO_SHA1 || algo == HASH_ALGO_MD5)
> > > +	if (algo == HASH_ALGO_SHA1 || algo == HASH_ALGO_SHA256 ||
> > > +	    algo == HASH_ALGO_MD5)
> > >  		return true;
> > >
> > >  	return false;
> >
