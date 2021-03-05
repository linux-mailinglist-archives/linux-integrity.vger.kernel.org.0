Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA032DF85
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 03:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhCECQL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 21:16:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35206 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCECQL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 21:16:11 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id EFBB720B83EA;
        Thu,  4 Mar 2021 18:16:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFBB720B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614910571;
        bh=dGClVZSWh1vOWuqKK+kmRRTz3BP6KBr6F9jkg/DovAQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eOctrEkJQpKD2OCl02KhvpAbAZD5+WdQz0e80RcPAdzTCa9m4w99d98uOqEUXIikR
         e4ptjjgDdswukrI/SwEJTY40hhLwpblF5hu2Hv9OyCpHqsDZzlZtYHdDYgq9ScVEfX
         KwHzVIDR+YYDtgls4u89P/mjxI9G1bi94URh8nKg=
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
To:     Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210212163709.3139-1-nramas@linux.microsoft.com>
 <87273030-2303-e791-4e5d-25373faf0880@linux.microsoft.com>
 <CAHC9VhT4pnsFTL3N8pZgrgpqzgCU+Odd4V=SGvTA9QcKAGwasw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <22cf077f-02b2-2454-bc63-0c9327042ba5@linux.microsoft.com>
Date:   Thu, 4 Mar 2021 18:16:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT4pnsFTL3N8pZgrgpqzgCU+Odd4V=SGvTA9QcKAGwasw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/4/21 5:45 PM, Paul Moore wrote:
> On Thu, Mar 4, 2021 at 2:20 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
>> On 2/12/21 8:37 AM, Lakshmi Ramasubramanian wrote:
>>
>> Hi Paul,
>>
>>> SELinux stores the configuration state and the policy capabilities
>>> in kernel memory.  Changes to this data at runtime would have an impact
>>> on the security guarantees provided by SELinux.  Measuring this data
>>> through IMA subsystem provides a tamper-resistant way for
>>> an attestation service to remotely validate it at runtime.
>>>
>>> Measure the configuration state and policy capabilities by calling
>>> the IMA hook ima_measure_critical_data().
>>>
>>
>> I have addressed your comments on the v2 patch for selinux measurement
>> using IMA. Could you please let me know if there are any other comments
>> that I need to address in this patch?
> 
> The merge window just closed earlier this week, and there were a
> handful of bugs that needed to be addressed before I could look at
> this patch.  If I don't get a chance to review this patch tonight, I
> will try to get to it this weekend or early next week.
> 

Thanks Paul.

  -lakshmi

