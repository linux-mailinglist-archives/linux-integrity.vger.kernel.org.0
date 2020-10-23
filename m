Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12308297959
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Oct 2020 00:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbgJWWja (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Oct 2020 18:39:30 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33990 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbgJWWja (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Oct 2020 18:39:30 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 94A3D20B4905;
        Fri, 23 Oct 2020 15:39:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94A3D20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603492770;
        bh=W48y8fN41s3Ow8rUzA4GEP94qdn+mWCG/MId+XkTzjY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=scj+tqLjOp8aKxtj5PVUw3cTA5Tuc8eG/pXUEkRrGouBsI8G/w/nzrEDdck2n34Xh
         f58jkd3vI4cdP9S7FQ0cwXFVwT/tG9DiQgwa6FD4HhfYGvhSXyXGnr+clAjtthc+MR
         HBqM15TQzxFHPuJj05+cy4mtTJOn4twScoD+l1us=
Subject: Re: [PATCH v4 2/6] IMA: conditionally allow empty rule data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
 <20200923192011.5293-3-tusharsu@linux.microsoft.com>
 <7d9822da396a92645482e37a8c8590902323c5ef.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <acdb1f9f-0c5f-1fdf-d53d-95ebafdd4b62@linux.microsoft.com>
Date:   Fri, 23 Oct 2020 15:39:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7d9822da396a92645482e37a8c8590902323c5ef.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-10-22 1:38 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:
>> ima_match_rule_data() permits the func to pass empty func_data.
>> For instance, for the following func, the func_data keyrings= is
>> optional.
>>      measure func=KEY_CHECK keyrings=.ima
>>
>> But a new func in future may want to constrain the func_data to
>> be non-empty.  ima_match_rule_data() should support this constraint
>> and it shouldn't be hard-coded in ima_match_rule_data().
>>
>> Update ima_match_rule_data() to conditionally allow empty func_data
>> for the func that needs it.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Policy rules may constrain what is measured, but that decision should
> be left to the system owner or admin.
> 
> Mimi
> 
Agreed. As you mentioned in the patch 5/6 of this series,
I will get rid of this patch.

~Tushar
