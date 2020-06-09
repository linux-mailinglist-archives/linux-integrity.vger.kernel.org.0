Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234031F3FF6
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2020 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgFIP6E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jun 2020 11:58:04 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53034 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbgFIP6D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jun 2020 11:58:03 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B053620B717B;
        Tue,  9 Jun 2020 08:58:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B053620B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591718282;
        bh=WkMSWOBEMcZxCr/lBlsLlRkLTBokiJBDduFX5I7V3BE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FCzHnhd2K9TkZSTHvhIULaVL/CIXp/M9Cz+mcJlcIDvHz1yKNqHML4uG+5BsQVbMo
         9tEEprfz663FYe5ivH9HowLfjACAJEkC0vyZfj0lZYoPoqb/PMUQHdq0InTZhUbN5c
         hE1nDELVH9dr+dHBRBElhv8WfzJbWlCe/Rxa8Rfc=
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
To:     Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com
Cc:     zohar@linux.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200608215343.4491-1-nramas@linux.microsoft.com>
 <27448076.Og45N0Lxmj@x2>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ada45440-aefd-a4b2-2a3b-c012872e86cb@linux.microsoft.com>
Date:   Tue, 9 Jun 2020 08:58:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <27448076.Og45N0Lxmj@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/9/20 8:40 AM, Steve Grubb wrote:

> On Monday, June 8, 2020 5:53:43 PM EDT Lakshmi Ramasubramanian wrote:
>> The final log statement in process_buffer_measurement() for failure
>> condition is at debug level. This does not log the message unless
>> the system log level is raised which would significantly increase
>> the messages in the system log. Change this log message to an audit
>> message for better triaging failures in the function.
>>
>> ima_alloc_key_entry() does not log a message for failure condition.
>> Add an audit message for failure condition in this function.
>>
>> Sample audit messages:
> 
> Wouldn't it be better to have an IMA_ERROR record type?

type "1804" is AUDIT_INTEGRITY_PCR which is used for failures to add to 
the measurement list.

> 
>> [    8.051937] audit: type=1804 audit(1591633422.365:8): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0
>> op=measuring_keys cause=hashing_error(-22)
> 
> The audit system uses a name=value scheme to express information. This last
> field has something in parenthesis that may need to be interpreted. In its
> current form, we can't do this. It would require writing code to special case
> this event, go to this field, find the first parenthesis, find the second,
> extract what's between, and look it up.
> 
> It would be better if that number in parenthesis was normalized to the
> expected way we do audit events so nothing special has to be made.

The number in parenthesis is the error code (such as ENOMEM, EINVAL, 
etc.) IMA uses this format for reporting TPM errors in one of the audit 
messages (In ima_add_template_entry()). I followed the same pattern.

Would it be better if the value for "cause" is formatted as

    cause=hashing_error_-22

    cause=alloc_entry_-12

thanks,
  -lakshmi

