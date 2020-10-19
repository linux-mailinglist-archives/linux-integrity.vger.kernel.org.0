Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4227629249A
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 11:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgJSJab convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 05:30:31 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2985 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbgJSJab (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 05:30:31 -0400
Received: from lhreml717-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 4877FC634ACB4260299F;
        Mon, 19 Oct 2020 10:30:29 +0100 (IST)
Received: from fraeml703-chm.china.huawei.com (10.206.15.52) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Mon, 19 Oct 2020 10:30:29 +0100
Received: from lhreml722-chm.china.huawei.com (10.201.108.73) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 19 Oct 2020 11:30:28 +0200
Received: from lhreml722-chm.china.huawei.com ([10.201.108.73]) by
 lhreml722-chm.china.huawei.com ([10.201.108.73]) with mapi id 15.01.1913.007;
 Mon, 19 Oct 2020 10:30:27 +0100
From:   Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
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
        "nick.dusek@gmail.com" <nick.dusek@gmail.com>,
        "Dr. Greg" <greg@enjellic.com>, Luke Hinds <lhinds@redhat.com>
Subject: RE: [RFC PATCH 00/30] ima: Introduce IMA namespace
Thread-Topic: [RFC PATCH 00/30] ima: Introduce IMA namespace
Thread-Index: AQHWdXPBkpeRDLdh20+fyp1BiEOjYak+A3mAgBfGuwCABhxpgIABN8iAgAG3kgCACVyMsIA21JGg
Date:   Mon, 19 Oct 2020 09:30:27 +0000
Message-ID: <a75a6541991d4f8dbaa30e0af517b829@huawei.com>
References: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
         <20200818164943.va3um7toztazcfud@wittgenstein>
         <d77a6cd783319702fddd06783cb84fdeb86210a6.camel@linux.ibm.com>
         <20200906171413.GA8305@wind.enjellic.com>
         <CAKrSGQR3Pw=Rad2RgUuCHqr0r2Nc6x2nLoo2cVAkD+_8Vbmd7A@mail.gmail.com>
 <d405bab0d262b32fd16e85444791b6c49d820aa2.camel@linux.ibm.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.222.63]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Krzysztof Struczynski
> Sent: Monday, September 14, 2020 2:08 PM
> > When Roberto Sassu and Krzysztof Struczynski contacted me about the
> > status of Stefan Berger's patch set, based on Yuqiong Sun's work, I was
> > under the impression that they would be rebasing it on the latest
> > kernel and going forward from there.   Obviously things changed.  I
> > pointed out to them resolving the "IMA namespacing" issue would be the
> > first thing that needs to be addressed.  So here we are.
> >
> 
> The concept of the IMA namespace as a separate namespace, not attached to
> the user or mount namespace, remains the same as in the last set of
> Stefan's patches. The creation and configuration mechanism changed,
> partially because of the changes in the upstream kernel like extension of
> the CLONE_ flags, that facilitated other solutions. The main inspiration
> in this regard was the new time namespace.
> 
> The implemented mechanism is intended to make the configuration of the
> IMA
> namespace as similar as possible to the upstream IMA implementation and
> allows to configure the new IMA namespace before any process enters that
> namespace, so the very first actions can be measured/appraised/audited.
> 
> In this implementation many design points formulated by Stefan still stand.
> The significant difference in the presented design is the threat model.
> The actions of the host's root and any other user within the container are
> measured/appraised/audited according to the container's policy. However,
> every action that affects objects in the root namespace, is detected when
> processes from the root namespace access them.

Do you think that the above proposal addresses the aforementioned "IMA
namespacing" issue? If it doesn't, would you please clarify what are the
main, outstanding problems?
 
> > Definitely, let's have this discussion.

Shall we continue the discussion here, or in addition use a format similar
to the Stefan's "drawing board":
https://kernsec.org/wiki/index.php/IMA_Namespacing_design_considerations

Best regards,
Krzysztof Struczynski
