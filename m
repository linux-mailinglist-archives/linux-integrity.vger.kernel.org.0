Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53BA38C05F
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 09:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhEUHI7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 03:08:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3092 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbhEUHIv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 03:08:51 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FmcnD1ghMz6842m;
        Fri, 21 May 2021 14:55:28 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 09:07:14 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 21 May 2021 09:07:14 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 00/12] evm: Improve usability of portable signatures
Thread-Topic: [PATCH v7 00/12] evm: Improve usability of portable signatures
Thread-Index: AQHXSNW+s9pGdic160Kc6WkU36Axf6rsoEOAgADsKvA=
Date:   Fri, 21 May 2021 07:07:14 +0000
Message-ID: <a316bc5ec316446c8b07134c33b06d77@huawei.com>
References: <20210514152753.982958-1-roberto.sassu@huawei.com>
 <2804f10fa77b58b4992f56ea36a36d4f1e3f4b24.camel@linux.ibm.com>
In-Reply-To: <2804f10fa77b58b4992f56ea36a36d4f1e3f4b24.camel@linux.ibm.com>
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
> Sent: Thursday, May 20, 2021 8:56 PM
> On Fri, 2021-05-14 at 17:27 +0200, Roberto Sassu wrote:
> > EVM portable signatures are particularly suitable for the protection of
> > metadata of immutable files where metadata is signed by a software vendor.
> > They can be used for example in conjunction with an IMA policy that
> > appraises only executed and memory mapped files.
> >
> > However, until now portable signatures can be properly installed only if
> > the EVM_ALLOW_METADATA_WRITES initialization flag is also set, which
> > disables metadata verification until an HMAC key is loaded. This will cause
> > metadata writes to be allowed even in the situations where they shouldn't
> > (metadata protected by a portable signature is immutable).
> >
> > The main reason why setting the flag is necessary is that the operations
> > necessary to install portable signatures and protected metadata would be
> > otherwise denied, despite being legitimate, due to the fact that the
> > decision logic has to avoid an unsafe recalculation of the HMAC that would
> > make the unsuccessfully verified metadata valid. However, the decision
> > logic is too coarse, and does not fully take into account all the possible
> > situations where metadata operations could be allowed.
> >
> > For example, if the HMAC key is not loaded and it cannot be loaded in the
> > future due the EVM_SETUP_COMPLETE flag being set, it wouldn't be a
> problem
> > to allow metadata operations, as they wouldn't result in an HMAC being
> > recalculated.
> >
> > This patch set extends the decision logic and adds the necessary exceptions
> > to use portable signatures without turning off metadata verification and
> > deprecates the EVM_ALLOW_METADATA_WRITES flag.
> 
> Thanks, Roberto.
> 
> Applied to: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
> integrity.git
> next-integrity-testing

Hi Mimi

could you please take the newer version of patch 5/12, which also adds
an exception for the INTEGRITY_UNKNOWN error (it occurs when xattrs
are not supported)?

https://lore.kernel.org/linux-integrity/6d7e059876b64f249b9a01d8b7696e29@huawei.com/T/#m58442ec12e47d9d457bef9b438809a6a132b7512

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
