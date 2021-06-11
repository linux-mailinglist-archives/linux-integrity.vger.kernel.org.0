Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3A3A3F4A
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Jun 2021 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFKJqE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Jun 2021 05:46:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3206 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhFKJqD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Jun 2021 05:46:03 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1bKC0QxMz6L777;
        Fri, 11 Jun 2021 17:34:39 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 11:44:03 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 11 Jun 2021 11:44:03 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "Stephen Smalley" <stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        Stefan Berger <stefanb@linux.ibm.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Size mismatch between vfs_getxattr_alloc() and vfs_getxattr()
Thread-Topic: Size mismatch between vfs_getxattr_alloc() and vfs_getxattr()
Thread-Index: AddepfVXRzZV65zDQYWfY30E1Ui8ng==
Date:   Fri, 11 Jun 2021 09:44:03 +0000
Message-ID: <ee75bde9a17f418984186caa70abd33b@huawei.com>
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

Hello

the ima-evm-utils tool discovered an issue doing signature
verification of xattrs.

On kernel side, EVM reads the xattr value with
vfs_getxattr_alloc(), which gets the value directly from the
xattr handler.

On user side, ima-evm-utils reads the value with the
lgetxattr() system call, which gets the value from LSMs.

There is a corner case, where security.selinux is set directly
with setfattr without adding \0 at the end.

In this case, the kernel and the user see different values
due to the fact that the former gets the raw value from the
xattr handler, and the latter gets the value normalized by
SELinux (which adds \0).

I found that originally also lgetxattr() was getting the value
from the xattr handler. This changed with:

commit 4bea58053f206be9a89ca35850f9ad295dac2042
Author: David P. Quigley <dpquigl@tycho.nsa.gov>
Date:   Mon Feb 4 22:29:40 2008 -0800

    VFS: Reorder vfs_getxattr to avoid unnecessary calls to the LSM

which directly calls LSMs for security.* xattrs.

Given that this patch is there for a long time, I would ask
if it makes sense to fix this issue. The way I would do it
is to check if the size returned by the xattr handler is the
same of the size returned by LSMs. If not, I would get
the value from the xattr handler.

Although this change does not check the xattr content,
it is sufficient to fix the issue.

Any opinion?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

