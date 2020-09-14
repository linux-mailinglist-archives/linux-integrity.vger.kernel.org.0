Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA152693A7
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Sep 2020 19:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgINRit convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Sep 2020 13:38:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2815 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgINM0L (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Sep 2020 08:26:11 -0400
Received: from lhreml706-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 18FBB84829DDE50B4086;
        Mon, 14 Sep 2020 13:07:55 +0100 (IST)
Received: from fraeml709-chm.china.huawei.com (10.206.15.37) by
 lhreml706-chm.china.huawei.com (10.201.108.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 14 Sep 2020 13:07:54 +0100
Received: from lhreml722-chm.china.huawei.com (10.201.108.73) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 14 Sep 2020 14:07:54 +0200
Received: from lhreml722-chm.china.huawei.com ([10.201.108.73]) by
 lhreml722-chm.china.huawei.com ([10.201.108.73]) with mapi id 15.01.1913.007;
 Mon, 14 Sep 2020 13:07:53 +0100
From:   Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Luke Hinds <lhinds@redhat.com>,
        "Dr. Greg" <greg@enjellic.com>
CC:     Christian Brauner <christian.brauner@ubuntu.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
        "sunyuqiong1988@gmail.com" <sunyuqiong1988@gmail.com>,
        "mkayaalp@cs.binghamton.edu" <mkayaalp@cs.binghamton.edu>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "James Morris" <jmorris@namei.org>,
        "christian@brauner.io" <christian@brauner.io>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "jannh@google.com" <jannh@google.com>,
        "nick.dusek@gmail.com" <nick.dusek@gmail.com>
Subject: RE: [RFC PATCH 00/30] ima: Introduce IMA namespace
Thread-Topic: [RFC PATCH 00/30] ima: Introduce IMA namespace
Thread-Index: AQHWdXPBkpeRDLdh20+fyp1BiEOjYak+A3mAgBfGuwCABhxpgIABN8iAgAG3kgCACVyMsA==
Date:   Mon, 14 Sep 2020 12:07:53 +0000
Message-ID: <9ed6fa28510c464a97d4283f6d5b21c5@huawei.com>
References: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
         <20200818164943.va3um7toztazcfud@wittgenstein>
         <d77a6cd783319702fddd06783cb84fdeb86210a6.camel@linux.ibm.com>
         <20200906171413.GA8305@wind.enjellic.com>
         <CAKrSGQR3Pw=Rad2RgUuCHqr0r2Nc6x2nLoo2cVAkD+_8Vbmd7A@mail.gmail.com>
 <d405bab0d262b32fd16e85444791b6c49d820aa2.camel@linux.ibm.com>
In-Reply-To: <d405bab0d262b32fd16e85444791b6c49d820aa2.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.217.147]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Tuesday, September 8, 2020 4:03 PM
> > > Candidly, given the politics of security technology being viewed as
> > > 'constraining' user rights, I think that a lot of forthcoming security
> > > technology may end up being out of tree moving forward.
> > >
> >
> > I think it's prudent to look forward and plan diligently, but I would
> > not want perfect to be the enemy of good.
> 
> Agreed.  This isn't an abstract problem, but one that has already come
> up and, hopefully, has been addressed appropriately.
> 
> >
> > I approach this more from a user's perspective. We are using IMA in
> > https://keylime.dev to measure a host and would like to measure
> > within a container too. It's the most common request we hear from our
> > users.
> >
> > Perhaps we all collaborate on a proposal extending Stefans work here:
> > https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerati
> > ons
> >
> > I have seen around 3-4 patches now get submitted, so work has been
> > done before, and as above, users are present too. We could then have
> > some consensus on how this should look and later patches might have
> > more success at landing.
> >
> > Would anyone be interested in this and have recommendations on how we
> > could approach this?
> 
> When Roberto Sassu and Krzysztof Struczynski contacted me about the
> status of Stefan Berger's patch set, based on Yuqiong Sun's work, I was
> under the impression that they would be rebasing it on the latest
> kernel and going forward from there.   Obviously things changed.  I
> pointed out to them resolving the "IMA namespacing" issue would be the
> first thing that needs to be addressed.  So here we are.
> 

The concept of the IMA namespace as a separate namespace, not attached to
the user or mount namespace, remains the same as in the last set of
Stefan's patches. The creation and configuration mechanism changed,
partially because of the changes in the upstream kernel like extension of
the CLONE_ flags, that facilitated other solutions. The main inspiration
in this regard was the new time namespace.

The implemented mechanism is intended to make the configuration of the IMA
namespace as similar as possible to the upstream IMA implementation and
allows to configure the new IMA namespace before any process enters that
namespace, so the very first actions can be measured/appraised/audited.

In this implementation many design points formulated by Stefan still stand.
The significant difference in the presented design is the threat model.
The actions of the host's root and any other user within the container are
measured/appraised/audited according to the container's policy. However,
every action that affects objects in the root namespace, is detected when
processes from the root namespace access them.

Best regards,
Krzysztof

> Definitely, let's have this discussion.
> 
> Mimi

