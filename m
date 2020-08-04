Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C2123BDA6
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgHDP5Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 11:57:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54906 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgHDP5H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 11:57:07 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3CE6520B4908;
        Tue,  4 Aug 2020 08:57:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CE6520B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596556626;
        bh=VpAp+gwtX80StpLhWTSeWeTMwUZ22EUYNIZ2mT0WBts=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=siiuYorxFApiTutRO1Fq7FQ6URRgVvncZmVb1M/+HCPfxlM1sq1xVO/vR+KyX8BNQ
         7JSsbMLQy5Oj0jTbSONyrTgqXXo70xkMqsXXTt+G0HS4sTYu2Hvd+zVu5oSwXNpaIY
         DGOwjAUXj7JHYqoZw00cWBAMJFnxw5OPqArnMdvY=
Subject: Re: [PATCH v5 3/4] LSM: Define SELinux function to measure state and
 policy
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-4-nramas@linux.microsoft.com>
 <dfd6f9c8-d62a-d278-9b0e-6b1f5ad03d3e@gmail.com>
 <6371efa9-5ae6-05ac-c357-3fbe1a5a93d5@linux.microsoft.com>
 <CAEjxPJ789kmdDwy-6RaL7HuMFxKpQ9Hwxj9J-_-f62XDCNJUiA@mail.gmail.com>
 <f992901f-6dca-7d31-3426-5a74d36c2c8c@gmail.com>
 <d988a6d0-04e0-62f0-2705-4352b268ca55@linux.microsoft.com>
 <5c843a3d-713c-e71f-8d4f-c6e5f51422f1@gmail.com>
 <3e766eed-7a0b-afca-6139-ac43dea053d7@linux.microsoft.com>
 <0fa0b1f3-6226-c307-0f11-8b3a881a070e@gmail.com>
 <32da0a4a-252a-67d8-5dc8-173959f6ddb4@gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a66155ea-151d-cfd7-01f0-15ed6f18e26b@linux.microsoft.com>
Date:   Tue, 4 Aug 2020 08:57:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <32da0a4a-252a-67d8-5dc8-173959f6ddb4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/20 8:29 AM, Stephen Smalley wrote:

>>> Perhaps vmalloc would be better than using kmalloc? If there are 
>>> better options for such large buffer allocation, please let me know.
>>
>> kvmalloc() can be used to select whichever one is most appropriate.
> 
> Other option would be for ima to compute and save the hash(es) of the 
> payload and not the payload itself for later use.  I guess you won't 
> know at that point which hash algorithm is desired?
> 

I think IMA hash algorithm would be known at that point, but IMA policy 
is not loaded yet (which is why I need to queue up the buffer and 
process when policy is loaded).

I tried vmalloc and tested it with upto 16MB buffer (just made up a 
SELinux policy buffer of size 16MB) - that works fine.

I will try kvmalloc().

Also, I fixed the issue with LSM data not measured when using the IMA 
policy you had. Good catch.

Will post the updated patches today.

thanks,
  -lakshmi
