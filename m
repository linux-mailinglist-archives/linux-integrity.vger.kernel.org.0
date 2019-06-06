Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11D36E30
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 10:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfFFIJX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 04:09:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32985 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfFFIJW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 04:09:22 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 286B8DFA2A49A69ACBD0;
        Thu,  6 Jun 2019 09:09:21 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 6 Jun
 2019 09:09:19 +0100
Subject: Re: [PATCH V4] IMA: Allow profiles to define the desired IMA template
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <mjg59@google.com>
CC:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>,
        "Thiago Jung Bauermann" <bauerman@linux.ibm.com>
References: <20190604203859.181156-1-matthewgarrett@google.com>
 <1559691534.4278.14.camel@linux.ibm.com>
 <CACdnJuvva4n5dDfoUhzZ9RAxzR=Wou4SuLfe8DCGp4f53cXM3w@mail.gmail.com>
 <1559761830.4278.30.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <40275b34-c86e-7550-9eec-78a2b1d316f7@huawei.com>
Date:   Thu, 6 Jun 2019 10:09:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1559761830.4278.30.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/2019 9:10 PM, Mimi Zohar wrote:
> On Wed, 2019-06-05 at 11:12 -0700, Matthew Garrett wrote:
>> On Tue, Jun 4, 2019 at 4:39 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>> Matthew, what is a "profile"?  Could we rename this patch to something
>>> clearer?  Maybe something like "support for per policy rule template
>>> formats"?
>>
>> Sounds good to me. Could you also add an Inspired-By: Roberto Sassu
>> <roberto.sassu@huawei.com> ?
> 
> Thanks, done.

Thanks Matthew.

If the patch it is not merged yet, please define and initialize the
template_name variable in ima_policy_show() as the same as in
ima_measurement_show().

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
