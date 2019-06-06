Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA736E37
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfFFILj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 04:11:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbfFFILj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 04:11:39 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 12616B8CD41A40F69CC8;
        Thu,  6 Jun 2019 09:11:38 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 6 Jun
 2019 09:11:37 +0100
Subject: Re: [PATCH V4] IMA: Allow profiles to define the desired IMA template
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.vnet.ibm.com>, <prsriva02@gmail.com>,
        <bauerman@linux.ibm.com>, Matthew Garrett <mjg59@google.com>
References: <20190604203859.181156-1-matthewgarrett@google.com>
 <1559691534.4278.14.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <94b77c75-21c0-065a-892a-5f8a5f6eca15@huawei.com>
Date:   Thu, 6 Jun 2019 10:11:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1559691534.4278.14.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/2019 1:38 AM, Mimi Zohar wrote:
> Hi Matthew,
> 
> On Tue, 2019-06-04 at 13:38 -0700, Matthew Garrett wrote:
>> Admins may wish to log different measurements using different IMA
>> templates. Add support for overriding the default template on a per-rule
>> basis.
>>
>> Signed-off-by: Matthew Garrett <mjg59@google.com>
>> ---
>>   Remove mention of template format from the documentation, and avoid
>>   attempting to assign to template_desc if we weren't provided a pointer
>>   in the first place.
> 
> Thanks!  I've pushed this patch out, for now, to the next-queued-
> testing branch.  This will allow others to rebase their patch sets -
> kexec command line measurement, the appended signatures, and the VFS
> file hashes - on top of it.
> 
> Roberto, any chance you would be interested in adding the template
> field format support?

I would publish first the fixes and the digest lists patch set.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
