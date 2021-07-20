Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711F43CF9BB
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhGTL6I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 07:58:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3437 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGTL6I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 07:58:08 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GTdJN0CSYz6J7CM;
        Tue, 20 Jul 2021 20:27:16 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 14:38:43 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Tue, 20 Jul 2021 14:38:43 +0200
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
Subject: RE: [PATCH v3 2/3] ima: Return int in the functions to measure a
 buffer
Thread-Topic: [PATCH v3 2/3] ima: Return int in the functions to measure a
 buffer
Thread-Index: AQHXcX2Ei9vr21t1tkWOaZ1ebtrZQatKtK2AgAEtQtA=
Date:   Tue, 20 Jul 2021 12:38:43 +0000
Message-ID: <bd953894da3041d5969da645db2f982e@huawei.com>
References: <20210705090922.3321178-1-roberto.sassu@huawei.com>
         <20210705090922.3321178-3-roberto.sassu@huawei.com>
 <2f4920dbdb16156e1af5cf78f592a5cf07ec3176.camel@linux.ibm.com>
In-Reply-To: <2f4920dbdb16156e1af5cf78f592a5cf07ec3176.camel@linux.ibm.com>
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
> Sent: Monday, July 19, 2021 10:28 PM
> Hi Roberto,
> 
> On Mon, 2021-07-05 at 11:09 +0200, Roberto Sassu wrote:
> > ima_measure_critical_data() and process_buffer_measurement() currently
> > don't return a result. A caller wouldn't be able to know whether those
> > functions were executed successfully.
> 
> Missing is an explanation as to why these functions aren't currently
> returning a result.   The LSM/IMA hooks only return a negative result
> for failure to appraise a file's integrity, not measure a file.  Only
> failure to appraise a file's integrity results in preventing the file
> from being read/executed/mmaped.  Other failures are only audited.

Hi Mimi

ok, will add it.

> > This patch modifies the return type from void to int, and returns 0 if the
> > buffer has been successfully measured, a negative value otherwise.
> 
> Needed here is an explanation as to why ima_measure_critical_data() is
> special.

We don't want to unnecessarily calculate the digest twice.

> > Also, this patch does not modify the behavior of existing callers by
> > processing the returned value. For those, the return value is ignored.
> 
> I agree that the existing behavior shouldn't change, but will this
> result in the bots complaining?

If I remember correctly, I didn't get any error even with W=1.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> thanks,
> 
> Mimi

