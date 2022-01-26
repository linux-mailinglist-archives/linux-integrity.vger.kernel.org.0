Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300CE49CC8E
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbiAZOnf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:43:35 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30309 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiAZOne (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:43:34 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JkRJy01tTzbk7s;
        Wed, 26 Jan 2022 22:42:42 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 22:43:32 +0800
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 22:43:31 +0800
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.021;
 Wed, 26 Jan 2022 15:43:29 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangweiyang <wangweiyang2@huawei.com>,
        Xiujianfeng <xiujianfeng@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
Thread-Topic: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
Thread-Index: AQHYEcpHUD88EJ3n70C3otG2igs7kax0bcMAgAAWmYCAACQEgIAAM52AgABVhoCAABLMsIAACyCAgAARgzA=
Date:   Wed, 26 Jan 2022 14:43:29 +0000
Message-ID: <220a8c9f3ab34f2183c0a88941c145d0@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
         <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
         <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
         <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
         <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
         <c1bfe53abaf24feacb676ce940edcb8899924ffc.camel@linux.ibm.com>
         <173fffb6cde54ae4ac7676d18a84c79f@huawei.com>
 <6f0890f135b61c41d81b03bf084ebab1b3e551e1.camel@linux.ibm.com>
In-Reply-To: <6f0890f135b61c41d81b03bf084ebab1b3e551e1.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.63.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Wednesday, January 26, 2022 3:35 PM
> On Wed, 2022-01-26 at 13:24 +0000, Roberto Sassu wrote:
> > > From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> > > Sent: Wednesday, January 26, 2022 1:48 PM
> > > On Wed, 2022-01-26 at 15:41 +0800, Guozihua (Scott) wrote:
> > > >
> > > >
> > > > The main issue lies in ima_template_desc_current called by hash_setup,
> > > > which does not just read ima_template global variable, but also tries to
> > > > set it if that hasn't been done already. Causing ima_template_setup to quit.
> > >
> > > Right, which calls ima_init_template_list().  So part of the solution
> > > could be to conditionally call ima_init_template_list()
> > > in ima_template_setup().
> > >
> > > -       if (ima_template)
> > > -               return 1;
> > > -
> > > -       ima_init_template_list();
> > > +       if (!ima_template
> > > +               ima_init_template_list();
> > >
> > > Roberto, what do you think?
> >
> > Hi Mimi
> >
> > I think we wanted to prevent to set a digest algorithm
> > incompatible with the chosen template.
> >
> > If we have in the kernel command line:
> >
> > ima_template=ima ima_hash=sha256
> >
> > ima_hash_algo would be set to HASH_ALGO_SHA1 despite
> > the user choice and the template would be set to 'ima'.
> >
> > In the opposite case:
> >
> > ima_hash=sha256 ima_template=ima
> >
> > if the default template is 'ima', then ima_hash_algo would be
> > set to HASH_ALGO_SHA1. Otherwise, it would be
> > HASH_ALGO_SHA256. If we allow the template to be set after
> > the digest algorithm is evaluated, the template selection will
> > be rejected if the algorithm is incompatible with the template.
> 
> The only time that would occur is in the unlikely case that the
> template is being set to "ima".   That sounds reasonable.  In fact we
> should consider preventing the template format being set to "ima".

Ok.

> > I'm trying to remember why we still have the digest recalculation
> > in ima_eventdigest_init(). Maybe the only possibility is if we
> > set the template from the policy?
> 
> The recalculation was relatively recently added in commit 6cc7c266e5b4
> ("ima: Call ima_calc_boot_aggregate() in ima_eventdigest_init()").

There is also recalculation for the file digest:

        hash.hdr.algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
            ima_hash_algo : HASH_ALGO_SHA1;
        result = ima_calc_file_hash(event_data->file, &hash.hdr);

I understood that Jonathan already applied the patch. If it is possible
to make a new patch according to your suggestion, I would ask Zihua
to do that.

Jonathan, would it be fine for you to discard this patch?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua

> thanks,
> 
> Mimi

