Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFCBE743D
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2019 15:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfJ1O6i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Oct 2019 10:58:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42786 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfJ1O6h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Oct 2019 10:58:37 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id AD8EF2010AC5;
        Mon, 28 Oct 2019 07:58:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD8EF2010AC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572274716;
        bh=+4i7snc8+CJH6rwfZpPIV08+c2Slr7iBUhUCuWfrlls=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=j0UFvLFAwzPt56V4SalGwYBFPyo5AY8x+FDt/QbWoI7weuCwz94pbxHS2dxcBywsO
         /Au8gNVv1GfwxnunbQq+3l5z+IcOX8CI0/1qn/lWU1D3WD4s1o3bl2iSeln9CRJSRq
         DIjRAtjUzDkwRDz3GalJJ9ckMbiYvrkixtFgKYFE=
Subject: Re: [PATCH v2 1/4] KEYS: Defined an ima hook for measuring keys on
 key create or update
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
 <20191023233950.22072-2-nramas@linux.microsoft.com>
 <1572032428.4532.72.camel@linux.ibm.com>
 <c1de8055-89a7-25dd-d99a-427e2c2c4c59@linux.microsoft.com>
 <1572187644.4532.211.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1d7730ff-9847-c6be-4f4f-8cf1e90a71f2@linux.microsoft.com>
Date:   Mon, 28 Oct 2019 07:58:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572187644.4532.211.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/27/19 7:47 AM, Mimi Zohar wrote:

>>> There's no reason to define a new variable to determine if IMA is
>>> initialized.  Use ima_policy_flag.
>>
>> Please correct me if I am wrong -
>>
>> ima_policy_flag will be set to 0 if IMA is not yet initialized
>> OR
>> IMA is initialized, but ima_policy_flag could be still set to 0 (say,
>> due to the configured policy).
>>
>> In the latter case the measurement request should be a NOP immediately.
> 
> I'm not sure.  The builtin keys most likely will be loaded prior to a
> custom IMA policy containing "keyring" rules are defined.
> 
> Mimi

I am not sure if I described it clearly - let me clarify:

Say, we use ima_policy_flag to determine whether to
measure the key immediately or
queue the key for measurement and, measure when IMA is initialized.

We can incorrectly keep queuing keys in the case when IMA is 
initialized, but due to the way IMA policy is configured ima_policy_flag 
is still 0.

That's why I feel a separate boolean flag would be needed to know 
whether IMA is initialized or not.

If IMA is initialized, ima_policy_flag will dictate whether to measure 
the key or not.

thanks,
  -lakshmi

