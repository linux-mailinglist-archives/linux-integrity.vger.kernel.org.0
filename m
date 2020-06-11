Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322FE1F5FC6
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 03:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFKB6u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Jun 2020 21:58:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60518 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFKB6u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Jun 2020 21:58:50 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A075F20B4778;
        Wed, 10 Jun 2020 18:58:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A075F20B4778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591840729;
        bh=SsTVZBh2D/vQVCutF3NIO1NFhSrgKFvMj7qY5w+FzX0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C44Ru02XgtXX2MZZ6J/6SDqT/vOeGLQ0cXUboIHol7ScoaBL4hGy3iGND3Ym1tjBJ
         V+Yi+naaUWIFCADSqiK/AM9lvEXXHEyhQAOwhJyiX2ifCN7PO6slvq+CtJ6q5C74Iz
         xcmQvKFBpTFis7JOenbSd+2Pqvq3yyeWSE7/oKI0=
Subject: Re: [PATCH 1/2] integrity: Add errno field in audit message
To:     Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, sgrubb@redhat.com, rgb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20200611000400.3771-1-nramas@linux.microsoft.com>
 <CAHC9VhTZb_evUcdygs6MHP73Bi_r3esxV6+Ko6VDpncfmLYEZw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5cc042be-a3cf-ae39-c4f5-e474d02c0613@linux.microsoft.com>
Date:   Wed, 10 Jun 2020 18:58:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTZb_evUcdygs6MHP73Bi_r3esxV6+Ko6VDpncfmLYEZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/10/20 6:45 PM, Paul Moore wrote:

Hi Paul,

> I'm sorry I didn't get a chance to mention this before you posted this
> patch, but for the past several years we have been sticking with a
> policy of only adding new fields to the end of existing records;
> please adjust this patch accordingly.  Otherwise, this looks fine to
> me.
> 
>>          audit_log_untrustedstring(ab, get_task_comm(name, current));
>>          if (fname) {
>>                  audit_log_format(ab, " name=");
>> --

Steve mentioned that since this new field "errno" is not a searchable 
entry, it can be added anywhere in the audit log message.

But I have no problem moving this to the end of the audit record.

thanks,
  -lakshmi


