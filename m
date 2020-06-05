Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3B41F01D4
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 23:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgFEVgY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 17:36:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37904 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgFEVgY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 17:36:24 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B08E720B7185;
        Fri,  5 Jun 2020 14:36:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B08E720B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591392984;
        bh=tSnjZ9WzP0jd/9ONy9pB1uG8pmrZd7Nd6pMK3U8G3C4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j58jeBpR0kcXUseKBLySEsy/s0CJ1AEVdtyeq8dwUJfDag8iMV00cQQpuKNVK3hWm
         gqDAM1S60XXnP0C/nlk2mYm1BlE/kJkm3jqgUIiro1n3zvsDwjcORxRMRRlHnmqPcX
         Tq54+lS9SoIkglIxBY6Jj+W+/XqXZBleQ5iMo1cM=
Subject: Re: [PATCH] IMA: Add log statements for failure conditions
To:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
References: <20200604163243.2575-1-nramas@linux.microsoft.com>
 <1591382782.5816.36.camel@linux.ibm.com>
 <CAHC9VhS-EP=Kk3GKRzAGAYa5mqupkLQCHz_m_DgoAKRWcSTgLA@mail.gmail.com>
 <8dfb3fa6-5c1f-d644-7d21-72a9448c52cc@linux.microsoft.com>
 <CAHC9VhS8gmrWxt75aHAE16PWAay7sUrffZiT0A8VLugwexK4Uw@mail.gmail.com>
 <48ff60f1-df93-5ce7-a254-8bfd1dba2ade@linux.microsoft.com>
 <1591392867.4615.20.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <755741f8-7f55-e40d-bb05-c05be2e02e9e@linux.microsoft.com>
Date:   Fri, 5 Jun 2020 14:36:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591392867.4615.20.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/20 2:34 PM, Mimi Zohar wrote:

>>
>> Maybe I can use the audit_msgno "AUDIT_INTEGRITY_PCR" with appropriate
>> strings for "op" and "cause".
>>
>> Mimi - please let me know if you think this audit_msgno would be ok to
>> use. I see this code used, for instance, for boot aggregate measurement.
>>
>> integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, boot_aggregate_name, op,
>> 		    audit_cause, result, 0);
> 
> Yes, AUDIT_INTEGRITY_PCR is also used for failures to add to the
> measurement list.
> 

thanks - i'll post an updated patch shortly.

  -lakshmi

