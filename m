Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EECEB36D
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 16:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfJaPIx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 11:08:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43196 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfJaPIx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 11:08:53 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 45D1420B7192;
        Thu, 31 Oct 2019 08:08:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45D1420B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572534532;
        bh=b552znnqsYND51xMigIZXtf6qqgljQrlCIE5HH5S2i4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sLIJtvbXJ37ifCWsEv5uQlJL6ydCzZ9r2nzBqntNvkOn9VL478bTvghdzjppI4LuT
         UbPE4B0JlPjWQ9wbW2NU/QsZjG0jVfrgvrb1FByefyTItfAZ2W9Ysyoz66iP0xgKDE
         cTysNaCkTLXtdQrV8mMQrn74ShsmcxWzjk39quP0=
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key
 create or update
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-2-nramas@linux.microsoft.com>
 <1572523831.5028.43.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b83bd7ef-ce7f-e750-e30b-30d5a6469a28@linux.microsoft.com>
Date:   Thu, 31 Oct 2019 08:08:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572523831.5028.43.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/31/19 5:10 AM, Mimi Zohar wrote:

> On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
>> Asymmetric keys used for verifying file signatures or certificates
>> are currently not included in the IMA measurement list.
>>
>> This patch defines a new IMA hook namely ima_post_key_create_or_update()
>> to measure asymmetric keys.
> 
> It's not enough for the kernel to be able to compile the kernel after
> applying all the patches in a patch set.  After applying each patch,
> the kernel should build properly, otherwise it is not bi-sect safe.
>   Refer to "3) Separate your changes" of
> "Documentation/process/submitting-patches.rst.

I started with kernel version 5.3 for this patch set.
I applied Nayna's process_buffer_measurement() patch and then built my 
changes on top of that.
This patch has no other dependency as far as I know.

Are you seeing a build break after applying this patch alone?

(PATCH v3 1/9) KEYS: Defined an IMA hook to measure keys on key create 
or update
> 
> This patch should also define the new "func".
> 

Ok - I'll make that change.

thanks,
  -lakshmi
