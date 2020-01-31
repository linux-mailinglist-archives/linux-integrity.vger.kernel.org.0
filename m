Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38C214EF72
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2020 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgAaPVu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jan 2020 10:21:50 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728860AbgAaPVt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jan 2020 10:21:49 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 5C4899BEC3CCF11B7645;
        Fri, 31 Jan 2020 15:21:47 +0000 (GMT)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 31 Jan 2020 15:21:47 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 31 Jan 2020 16:21:46 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Fri, 31 Jan 2020 16:21:46 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH 8/8] ima: switch to ima_hash_algo for boot aggregate
Thread-Topic: [PATCH 8/8] ima: switch to ima_hash_algo for boot aggregate
Thread-Index: AQHV1TQ/cbv5dz78j0O1U+btlk5ShagE6FxQ
Date:   Fri, 31 Jan 2020 15:21:46 +0000
Message-ID: <acb84e249d524ee5a6feddfacc674531@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
 <20200127170443.21538-9-roberto.sassu@huawei.com>
In-Reply-To: <20200127170443.21538-9-roberto.sassu@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: Roberto Sassu
> Sent: Monday, January 27, 2020 6:05 PM
> To: zohar@linux.ibm.com; jarkko.sakkinen@linux.intel.com;
> james.bottomley@hansenpartnership.com; linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org; linux-kernel@vger.kernel.org;
> Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>; Roberto Sassu
> <roberto.sassu@huawei.com>
> Subject: [PATCH 8/8] ima: switch to ima_hash_algo for boot aggregate

I will remove this patch from the patch set.

[PATCH v3 1/2] ima: support calculating the boot aggregate based on non-SHA1 algorithms
[PATCH v3 2/2] ima: support calculating the boot_aggregate based on different TPM banks

by Mimi will provide similar functionality.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
