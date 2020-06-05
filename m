Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71DE1F0150
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 23:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFEVJK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 17:09:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57316 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFEVJK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 17:09:10 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 921A220B7185;
        Fri,  5 Jun 2020 14:09:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 921A220B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591391349;
        bh=i39FaZtY2X+kPAkTUw9+JdMbvXH6kXdMemItCH/9QYg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H8+UL+o0s1ovdZmsSenHvljW70R+sD7tC/FyO+IktV1H/0jkcnoL6TxRShse5RtBx
         TnDqTHhp0IPI4e4ox1kS+pXCGj5yrduev0crKSSIqJkIltRXf7V5s8ws0KXQWa3NHv
         HfNSFN/I5lFhmpQ2uW1B5fGVjDejG/lq5j/4PZrE=
Subject: Re: [PATCH] IMA: Add log statements for failure conditions
To:     Paul Moore <paul@paul-moore.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        tusharsu@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
References: <20200604163243.2575-1-nramas@linux.microsoft.com>
 <1591382782.5816.36.camel@linux.ibm.com>
 <CAHC9VhS-EP=Kk3GKRzAGAYa5mqupkLQCHz_m_DgoAKRWcSTgLA@mail.gmail.com>
 <8dfb3fa6-5c1f-d644-7d21-72a9448c52cc@linux.microsoft.com>
 <CAHC9VhS8gmrWxt75aHAE16PWAay7sUrffZiT0A8VLugwexK4Uw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <48ff60f1-df93-5ce7-a254-8bfd1dba2ade@linux.microsoft.com>
Date:   Fri, 5 Jun 2020 14:09:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS8gmrWxt75aHAE16PWAay7sUrffZiT0A8VLugwexK4Uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/20 1:49 PM, Paul Moore wrote:

> 
>> Since a pr_xyz() call was already present, I just wanted to change the
>> log level to keep the code change to the minimum. But if audit log is
>> the right approach for this case, I'll update.
> 
> Generally we reserve audit for things that are required for various
> security certifications and/or "security relevant".  From what you
> mentioned above, it seems like this would fall into the second
> category if not the first.
> 
> Looking at your patch it doesn't look like you are trying to record
> anything special so you may be able to use the existing
> integrity_audit_msg(...) helper.  Of course then the question comes
> down to the audit record type (the audit_msgno argument), the
> operation (op), and the comm/cause (cause).
> 
> Do you feel that any of the existing audit record types are a good fit for this?
> 

Maybe I can use the audit_msgno "AUDIT_INTEGRITY_PCR" with appropriate 
strings for "op" and "cause".

Mimi - please let me know if you think this audit_msgno would be ok to 
use. I see this code used, for instance, for boot aggregate measurement.

integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, boot_aggregate_name, op,
		    audit_cause, result, 0);

thanks,
  -lakshmi
