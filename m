Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EEA38492
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfFGGqj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 02:46:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfFGGqj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 02:46:39 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1DF59CE7DD70E902315D;
        Fri,  7 Jun 2019 07:46:38 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 7 Jun
 2019 07:46:37 +0100
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
 <40275b34-c86e-7550-9eec-78a2b1d316f7@huawei.com>
 <1559861118.4278.182.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <b2e6f9c5-792c-8205-956d-468d059ea296@huawei.com>
Date:   Fri, 7 Jun 2019 08:46:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1559861118.4278.182.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/7/2019 12:45 AM, Mimi Zohar wrote:
> On Thu, 2019-06-06 at 10:09 +0200, Roberto Sassu wrote:
>> On 6/5/2019 9:10 PM, Mimi Zohar wrote:
>>> On Wed, 2019-06-05 at 11:12 -0700, Matthew Garrett wrote:
>>>> On Tue, Jun 4, 2019 at 4:39 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>> Matthew, what is a "profile"?  Could we rename this patch to something
>>>>> clearer?  Maybe something like "support for per policy rule template
>>>>> formats"?
>>>>
>>>> Sounds good to me. Could you also add an Inspired-By: Roberto Sassu
>>>> <roberto.sassu@huawei.com> ?
>>>
>>> Thanks, done.
>>
>> Thanks Matthew.
>>
>> If the patch it is not merged yet, please define and initialize the
>> template_name variable in ima_policy_show() as the same as in
>> ima_measurement_show().
> 
> The policy rule processing should prevent loading a custom policy with
> a template rule, without specifying a valid template name.  Why does
> ima_policy_show() need to initialize entry->template->name?

The last element of builtin_templates is reserved for a custom format
that can be specified with the ima_template_fmt= kernel option. This
last element has name length equal to zero. It can be found by
lookup_template_desc() if specified in a policy rule.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
