Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7CC1B2477
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUK6e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 06:58:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2071 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbgDUK6d (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 06:58:33 -0400
Received: from lhreml726-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 77D44663B228197638C8;
        Tue, 21 Apr 2020 11:58:32 +0100 (IST)
Received: from fraeml705-chm.china.huawei.com (10.206.15.54) by
 lhreml726-chm.china.huawei.com (10.201.108.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 21 Apr 2020 11:58:32 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 21 Apr 2020 12:58:31 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 21 Apr 2020 12:58:31 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: vfs_getxattr_alloc() problem
Thread-Topic: vfs_getxattr_alloc() problem
Thread-Index: AdYXttYwp+95NXWLRayeH298ep/JJw==
Date:   Tue, 21 Apr 2020 10:58:31 +0000
Message-ID: <a47df5af2e2d4bc4bc4757e956c882eb@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.65.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi

I found a problem in the calculation of the EVM digest.

If an xattr is in the security domain, vfs_getxattr() calls xattr_getsecurity(),
which is implemented by LSMs. vfs_getxattr_alloc() instead calls directly
the filesystem function to read xattrs.

The problem arises for example when you have a file with a portable
signature on the correct SELinux label (with \0) and you set security.selinux
manually:

setfattr -n security.selinux -v "system_u:object_r:bin_t:s0" cat

Although the length passed is 26 bytes (without \0), you get:

# attr -l cat
Attribute "selinux" has a 27 byte value for cat

which includes \0.

From user space, evmctl does not complain (the signature is ok) because
it calculates the EVM digest with \0, but EVM verification fails (because it
calculates the digest without \0).

Should this problem be fixed?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
