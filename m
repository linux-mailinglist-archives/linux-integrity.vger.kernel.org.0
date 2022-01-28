Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF149FD73
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jan 2022 17:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiA1QBc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jan 2022 11:01:32 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17829 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiA1QBb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jan 2022 11:01:31 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JlhxM6DMnz9sVV;
        Sat, 29 Jan 2022 00:00:07 +0800 (CST)
Received: from dggpeml100024.china.huawei.com (7.185.36.115) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 00:01:29 +0800
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 29 Jan 2022 00:01:28 +0800
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.021;
 Fri, 28 Jan 2022 17:01:26 +0100
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
Thread-Index: AQHYEcpHUD88EJ3n70C3otG2igs7kax0bcMAgAAWmYCAACQEgIAAM52AgABVhoCAAwr2kIAAN1aAgAAnvPA=
Date:   Fri, 28 Jan 2022 16:01:26 +0000
Message-ID: <0a2e84d1bed84733b81f3edd91403006@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
         <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
         <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
         <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
         <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
         <c1bfe53abaf24feacb676ce940edcb8899924ffc.camel@linux.ibm.com>
         <ee116b29c27740119d98bc64e55f61e7@huawei.com>
 <9714e2824b35d12ee2f8ad70d65d8c9230be86e4.camel@linux.ibm.com>
In-Reply-To: <9714e2824b35d12ee2f8ad70d65d8c9230be86e4.camel@linux.ibm.com>
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
> Sent: Friday, January 28, 2022 3:34 PM
> On Fri, 2022-01-28 at 10:24 +0000, Roberto Sassu wrote:
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
> >
> >
> > is it still necessary to call ima_init_template_list() in
> > template_setup()? I saw it is called in init_ima().
> 
> All of these options are at __setup().

Yes. ima_init_template_list() should be called before
lookup_template_desc().

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua

> thanks,
> 
> Mimi

