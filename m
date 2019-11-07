Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86CCF233B
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2019 01:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfKGAVY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 19:21:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35294 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfKGAVX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 19:21:23 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id C964720B7192;
        Wed,  6 Nov 2019 16:21:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C964720B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573086082;
        bh=eEEXoIsgjYfls0Ada3aH4Nvwgp+zX0ZpkvcRvWey2wE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Ybz76JqWo8S/SHKczbTAnnAXEvfdR+hU62S0BJ/UxhSd5gDkGnszsim7VpPJcygU7
         U8jVE5gwHgLRpjKITVm1b5P//2fZtD/6xm+wSHPTR4+CPJeG57p+hUnJ03jsiDDffc
         Wcd8Sc8rXFowL6qc3poi7EjfClSfg6d3kcmjgVjY=
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
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
Date:   Wed, 6 Nov 2019 16:21:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1573080189.5028.313.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/6/2019 2:43 PM, Mimi Zohar wrote:

>> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>> +				   unsigned long flags, bool create)
>> +{
>> +	if ((keyring != NULL) && (key != NULL))
>> +		return;
> 
> I would move the patch that defines the "keyring=" policy option prior
> to this one.  Include the call to process_buffer_measurement() in this
> patch.  A subsequent patch would add support to defer measuring the
> key, by calling a function named something like
> ima_queue_key_measurement().
> 
> Mimi

As I'd stated in the other response, I wanted to isolate all key related 
code in a separate C file and build it if and only if all CONFIG 
dependencies are met.

I can do the following:

=> Define the IMA hook in ima_asymmetric_keys.c instead of ima_main.c

=> In include/linux/ima.h declare the IMA hook if 
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled.
Else, NOP it.

#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
extern void ima_post_key_create_or_update(struct key *keyring,
					  struct key *key,
					  unsigned long flags,
                                           bool create);
#else
static inline void ima_post_key_create_or_update(struct key *keyring,
						 struct key *key,
						 unsigned long flags,
						 bool create) {}
#endif

Would that be acceptable?

thanks,
  -lakshmi


