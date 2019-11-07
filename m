Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CDAF3768
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2019 19:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfKGSmh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Nov 2019 13:42:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54996 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfKGSmh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Nov 2019 13:42:37 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0142220B7192;
        Thu,  7 Nov 2019 10:42:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0142220B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573152156;
        bh=IIgQX9NCafdzdKDo68gnRTo2ABhXlMLZcXZGDGbYSCo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kyb8YsJHumSyLq3rC7RM6o3mGIu3AVQWDCrlcnyVYtfYPHWkv+eJuLBSFC405C9T3
         7Jk3GCscYZavGCi1Rjs4+R1pLaWhEcUk3LhLrP4fO6jBQylW6mXz4hpORlSCvHVGQw
         RuyPFSx2n2sxVy4qNUTvAnCh4hvVxn6CLoWPg/wI=
Subject: Re: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on key
 create or update
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
 <20191106190116.2578-2-nramas@linux.microsoft.com>
 <1573080189.5028.313.camel@linux.ibm.com>
 <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
 <1573098037.5028.325.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7ce84aa0-729e-c58e-f16a-25490b4e336d@linux.microsoft.com>
Date:   Thu, 7 Nov 2019 10:42:55 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1573098037.5028.325.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/6/2019 7:40 PM, Mimi Zohar wrote:

>>> I would move the patch that defines the "keyring=" policy option prior
>>> to this one.  Include the call to process_buffer_measurement() in this
>>> patch.  A subsequent patch would add support to defer measuring the
>>> key, by calling a function named something like
>>> ima_queue_key_measurement().
>>>
>>> Mimi
>>
>> As I'd stated in the other response, I wanted to isolate all key related
>> code in a separate C file and build it if and only if all CONFIG
>> dependencies are met.
> 
> The basic measuring of keys shouldn't be any different than any other
> policy rule, other than it is a key and not a file.  This is the
> reason that I keep saying start out with the basics and then add
> support to defer measuring keys on the trusted keyrings.

I'll make the changes, rearrange the patches and send an updated set.

I do have a few questions since I am still not fully understanding the 
requirements you are targeting. Appreciate if you could please clarify.

As you already know, I am using the "public key" of the given asymmetric 
key as the "buffer" to measure in process_buffer_measurement().

The measurement decision is not based on whether the keyring is a 
trusted one or an untrusted one. As long as the IMA policy allows 
(through the "keyrings=" option) the key will be measured.

Do you want only trusted keyrings to be allowed in the measurement?
In my opinion, that decision should be deferred to whoever is setting up 
the IMA policy.

> Only the queueing code needed for measuring keys on the trusted
> keyrings would be in a separate file.
> 
> Mimi

The decision to process key immediately or defer (queue) is based on 
whether IMA has been initialized or not. Keyring is not used for this 
decision.

Could you please clarify how queuing is related to keyring's 
trustworthiness?

The check for whether the key is an asymmetric one or not, and 
extracting the "public key" if it is an asymmetric key needs to be in a 
separate file to handle the CONFIG dependencies in IMA.

thanks,
  -lakshmi

