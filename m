Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC00A37A9F7
	for <lists+linux-integrity@lfdr.de>; Tue, 11 May 2021 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhEKO4P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 10:56:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3062 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhEKO4L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 10:56:11 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ffgf63p4gz6wkjh;
        Tue, 11 May 2021 22:43:42 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 16:54:58 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Tue, 11 May 2021 16:54:58 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v6 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Topic: [PATCH v6 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Index: AQHXQaKHvFPvOA7oV0m5qAvk17yFuareOl6AgAAjMeD//+TqAIAAInMw
Date:   Tue, 11 May 2021 14:54:58 +0000
Message-ID: <0d0fcd3619e64bb9aaf1656ef066d043@huawei.com>
References: <20210505112935.1410679-1-roberto.sassu@huawei.com>
         <20210505113329.1410943-4-roberto.sassu@huawei.com>
         <735bae46f0772b40ef6ecfb3c6fe0267b3ebbee8.camel@linux.ibm.com>
         <c281b39bdbaa4b5ab921a2e9cece83b4@huawei.com>
 <1a5d2a37be31f7971374c01ed8e799e003c96f9d.camel@linux.ibm.com>
In-Reply-To: <1a5d2a37be31f7971374c01ed8e799e003c96f9d.camel@linux.ibm.com>
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

> From: Mimi Zohar [mailto:zohar@linux.ibm.com]
> Sent: Tuesday, May 11, 2021 4:41 PM
> On Tue, 2021-05-11 at 14:21 +0000, Roberto Sassu wrote:
> > >
> > > On Wed, 2021-05-05 at 13:33 +0200, Roberto Sassu wrote:
> > > > With the patch to allow xattr/attr operations if a portable signature
> > > > verification fails, cp and tar can copy all xattrs/attrs so that at the
> > > > end of the process verification succeeds.
> > > >
> > > > However, it might happen that the xattrs/attrs are already set to the
> > > > correct value (taken at signing time) and signature verification succeeds
> > > > before the copy has completed. For example, an archive might contains
> files
> > > > owned by root and the archive is extracted by root.
> > > >
> > > > Then, since portable signatures are immutable, all subsequent operations
> > > > fail (e.g. fchown()), even if the operation is legitimate (does not alter
> > > > the current value).
> > > >
> > > > This patch avoids this problem by reporting successful operation to user
> > > > space when that operation does not alter the current value of
> xattrs/attrs.
> > >
> > > I must be missing something.  If both the IMA and EVM status flags are
> > > reset after xattr or attr modification, do we really need to prevent
> > > any metadata - same or different - changes?  Both evm_protect_xattr()
> > > and evm_inode_setattr() would need to be modified to allow
> > > INTEGRITY_PASS_IMMUTABLE.
> >
> > yes, given that the IMA and EVM flags are reset, it should not be
> > a problem to allow changes. However, I think it is useful to keep
> > the current behavior. For example, it would prevent an accidental
> > change of the SELinux label during the relabeling process.
> 
> I understand we might want to prevent accidental or malicious changes,
> but that isn't the purpose of this patch set.  The patch description
> would also need to be updated to reflect the real purpose.

We would be changing the expectation that metadata changes
are denied, which was defined with the original patches.

I would prefer to keep the current behavior, but if your suggestion
is to allow metadata changes, I will modify the patch set.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi

