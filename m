Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5D3B5BA2
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jun 2021 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhF1JyS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 05:54:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3325 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhF1JyR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 05:54:17 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GD2gH5Vd0z6N4QG;
        Mon, 28 Jun 2021 17:41:31 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 11:51:49 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Mon, 28 Jun 2021 11:51:49 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH 03/12] digest_lists: Basic definitions
Thread-Topic: [RFC][PATCH 03/12] digest_lists: Basic definitions
Thread-Index: AQHXaeMP1hrQEcpfKUiTvUrYdI7FlqsnkBuAgAGHhID//+c5gIAAIpgw///qPACAACIkMA==
Date:   Mon, 28 Jun 2021 09:51:49 +0000
Message-ID: <ae8418b544884467bbc5f7b4664b7e42@huawei.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
 <20210625165614.2284243-4-roberto.sassu@huawei.com>
 <YNhYu3BXh7f9GkVk@kroah.com> <860717cce60f47abb3c9dc3c1bd32ab7@huawei.com>
 <YNmMX4EODT0c4zqk@kroah.com> <4acc7e8f15834b83b310b9e2ff9ba3d2@huawei.com>
 <YNmXIk7orQavkEME@kroah.com>
In-Reply-To: <YNmXIk7orQavkEME@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Monday, June 28, 2021 11:32 AM
> On Mon, Jun 28, 2021 at 09:27:05AM +0000, Roberto Sassu wrote:
> > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > Sent: Monday, June 28, 2021 10:46 AM
> > > On Mon, Jun 28, 2021 at 08:30:32AM +0000, Roberto Sassu wrote:
> > > > > > +struct compact_list_hdr {
> > > > > > +	__u8 version;
> > > > >
> > > > > You should never need a version, that way lies madness.
> > > >
> > > > We wanted to have a way to switch to a new format, if necessary.
> > >
> > > Then just add a new ioctl if you need that in the future, no need to try
> > > to cram it into this one.
> >
> > Given that digest lists are generated elsewhere, it would be still
> > unclear when the ioctl() would be issued. Maybe the kernel needs
> > to parse both v1 and v2 digest lists (I expect that v1 cannot be easily
> > converted to v2, if they are signed).
> >
> >  It would be also unpractical if digest lists are loaded at kernel
> > initialization time (I didn't send the patch yet).
> 
> Then that is up to your api design, I do not know.  But note that
> "version" fields almost always never work, so be careful about assuming
> that this will solve any future issues.
> 
> > > > > > +	__le16 type;
> > > > > > +	__le16 modifiers;
> > > > > > +	__le16 algo;
> > > > > > +	__le32 count;
> > > > > > +	__le32 datalen;
> > > > >
> > > > > Why are user/kernel apis specified in little endian format?  Why would
> > > > > that matter?  Shouldn't they just be "native" endian?
> > > >
> > > > I thought this would make it clear that the kernel always expects the
> > > > digest lists to be in little endian.
> > >
> > > Why would a big endian system expect the data from userspace to be in
> > > little endian?  Shouldn't this always just be "native" endian given that
> > > this is not something that is being sent to hardware?
> >
> > The digest list might come from a system with different endianness.
> 
> Ok, I have no idea what digests really are used for then.  So stick with
> little endian and be sure to properly convert within the kernel as
> needed.

The most intuitive use case is to extend secure boot to the OS.

The kernel might be configured to accept only digest lists signed
with a trusted key.

Once the database is populated, execution and mmap can be denied
if the calculated file or metadata digest is not found in the database
(the file has not been released by the vendor).

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> greg k-h
