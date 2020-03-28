Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 345581965A0
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Mar 2020 12:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgC1LSE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 28 Mar 2020 07:18:04 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2613 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbgC1LSD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 28 Mar 2020 07:18:03 -0400
Received: from lhreml716-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 1E5EA897947A474E9415;
        Sat, 28 Mar 2020 11:18:02 +0000 (GMT)
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1713.5; Sat, 28 Mar 2020 11:18:01 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 28 Mar 2020 12:18:01 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Sat, 28 Mar 2020 12:18:00 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "matthewgarrett@google.com" <matthewgarrett@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: Immutable metadata
Thread-Topic: Immutable metadata
Thread-Index: AdYE5l5uAUZNHIlESc2JQvQGvX4yuw==
Date:   Sat, 28 Mar 2020 11:18:00 +0000
Message-ID: <ff12bbbd945545a988ef84d6e4d3b83d@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.3.111]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Matthew, Mimi

I have a question about portable signatures. Is there any particular reason
why a write to a file is not denied by IMA if metadata are immutable?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
