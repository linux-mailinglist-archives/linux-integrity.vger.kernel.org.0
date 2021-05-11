Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164F337A8FD
	for <lists+linux-integrity@lfdr.de>; Tue, 11 May 2021 16:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhEKOWh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 10:22:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3061 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhEKOWg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 10:22:36 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FffvS4G8Sz6wkkD;
        Tue, 11 May 2021 22:10:12 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 16:21:28 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Tue, 11 May 2021 16:21:28 +0200
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
Thread-Index: AQHXQaKHvFPvOA7oV0m5qAvk17yFuareOl6AgAAjMeA=
Date:   Tue, 11 May 2021 14:21:28 +0000
Message-ID: <c281b39bdbaa4b5ab921a2e9cece83b4@huawei.com>
References: <20210505112935.1410679-1-roberto.sassu@huawei.com>
         <20210505113329.1410943-4-roberto.sassu@huawei.com>
 <735bae46f0772b40ef6ecfb3c6fe0267b3ebbee8.camel@linux.ibm.com>
In-Reply-To: <735bae46f0772b40ef6ecfb3c6fe0267b3ebbee8.camel@linux.ibm.com>
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
> Sent: Tuesday, May 11, 2021 4:12 PM
> Hi Roberto,
> 
> On Wed, 2021-05-05 at 13:33 +0200, Roberto Sassu wrote:
> > With the patch to allow xattr/attr operations if a portable signature
> > verification fails, cp and tar can copy all xattrs/attrs so that at the
> > end of the process verification succeeds.
> >
> > However, it might happen that the xattrs/attrs are already set to the
> > correct value (taken at signing time) and signature verification succeeds
> > before the copy has completed. For example, an archive might contains files
> > owned by root and the archive is extracted by root.
> >
> > Then, since portable signatures are immutable, all subsequent operations
> > fail (e.g. fchown()), even if the operation is legitimate (does not alter
> > the current value).
> >
> > This patch avoids this problem by reporting successful operation to user
> > space when that operation does not alter the current value of xattrs/attrs.
> 
> I must be missing something.  If both the IMA and EVM status flags are
> reset after xattr or attr modification, do we really need to prevent
> any metadata - same or different - changes?  Both evm_protect_xattr()
> and evm_inode_setattr() would need to be modified to allow
> INTEGRITY_PASS_IMMUTABLE.

Hi Mimi

yes, given that the IMA and EVM flags are reset, it should not be
a problem to allow changes. However, I think it is useful to keep
the current behavior. For example, it would prevent an accidental
change of the SELinux label during the relabeling process.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi

