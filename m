Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93352F252E
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2019 03:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbfKGCUN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 21:20:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48800 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfKGCUM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 21:20:12 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id D31A720B7192;
        Wed,  6 Nov 2019 18:20:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D31A720B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573093211;
        bh=ANqKC9zirBL5qVf7a2LGzuVHY9L9E5urFo/RJfIMoL0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=BE4ywyGSSwGkBhjWTxO594+Es8EzO/EXt+Y1G9pwAUUyBvB2ZFoEfbTWUxWLGo42i
         +B+7AcJrTK+tuf3gs7iqJIK6dubUMt+Z3EDhtVRDr9gic04bFgdGTlFojGXvJsG/e/
         D2tQ23Cd2VtkBCbZxj4xrj0eWlCzaluhj8R8n0us=
Subject: Re: [PATCH v4 08/10] IMA: Defined functions to queue and dequeue keys
 for measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
 <20191106190116.2578-9-nramas@linux.microsoft.com>
 <1573080281.5028.314.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b9f293d8-6e58-4d56-1917-5819f0b8931a@linux.microsoft.com>
Date:   Wed, 6 Nov 2019 18:20:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573080281.5028.314.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/6/19 2:44 PM, Mimi Zohar wrote:

Hi Mimi,

>> +
>> +	if (ima_initialized) {
> 
> ima_initialized is being set in ima_init(), before a custom policy is
> loaded.  I would think that is too early.  ima_update_policy() is
> called after loading a custom policy.  Please see how to detect when a
> custom policy is loaded.

ima_init_policy() is called before ima_initialized flag is set.

As far as I understand ima_init_policy() loads custom policies as well. 
So custom policies (such as arch specific policies, secure boot 
policies, etc.) are loaded before the queued keys are processed.

But if CONFIG_IMA_WRITE_POLICY is enabled, the policy can be updated 
anytime. This scenario is not handled in my implementation.

Please correct me if my understanding is wrong.

thanks,
  -lakshmi



