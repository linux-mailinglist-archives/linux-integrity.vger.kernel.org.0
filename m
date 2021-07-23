Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A073D3A84
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhGWMKw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 08:10:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3464 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhGWMKr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 08:10:47 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWTMZ4ylGz6D8pR;
        Fri, 23 Jul 2021 20:36:26 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 14:51:18 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 23 Jul 2021 14:51:18 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>
CC:     "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "prsriva02@gmail.com" <prsriva02@gmail.com>,
        "tusharsu@linux.microsoft.com" <tusharsu@linux.microsoft.com>,
        "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH v4 1/3] ima: Introduce ima_get_current_hash_algo()
Thread-Topic: [PATCH v4 1/3] ima: Introduce ima_get_current_hash_algo()
Thread-Index: AQHXf6A1hrAsK8Tx4UeeGS+/T0PiuqtQYXkAgAAh6bA=
Date:   Fri, 23 Jul 2021 12:51:18 +0000
Message-ID: <1009506a3b1a451ba75e1d7b89497cf8@huawei.com>
References: <20210723085304.1760138-1-roberto.sassu@huawei.com>
         <20210723085304.1760138-2-roberto.sassu@huawei.com>
 <676e9af54eb252c26410788e6105c149c57b2c15.camel@linux.ibm.com>
In-Reply-To: <676e9af54eb252c26410788e6105c149c57b2c15.camel@linux.ibm.com>
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
> Sent: Friday, July 23, 2021 2:49 PM
> On Fri, 2021-07-23 at 10:53 +0200, Roberto Sassu wrote:
> > Buffer measurements, unlike file measurements, are not accessible after the
> > measurement is done, as buffers are not suitable for use with the
> > integrity_iint_cache structure (there is no index, for files it is the
> > inode number). In the subsequent patches, the measurement (digest) will be
> > returned directly by the functions that perform the buffer measurement,
> > ima_measure_critical_data() and process_buffer_measurement().
> >
> > A caller of those functions also needs to know the algorithm used to
> > calculate the digest. Instead of adding the algorithm as a new parameter to
> > the functions, this patch provides it separately with the new function
> > ima_get_current_hash_algo().
> >
> > Since the hash algorithm does not change after the IMA setup phase, there
> > is no risk of races (obtaining a digest calculated with a different
> > algorithm than the one returned).
> 
> Perfect explaination for annotating ima_hash_algo like:
> 
> int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
> 
> Assuming you don't object, I'll include this change in this patch.

Sure, thanks.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi
> 
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

