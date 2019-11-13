Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5759BFB99E
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 21:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfKMUVh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 15:21:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48506 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMUVg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 15:21:36 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id DD93320B4901;
        Wed, 13 Nov 2019 12:21:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD93320B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573676496;
        bh=I1Mu3IDPJM1nVT/FAj7Eop98xKiNpHueYyROLn+JtY8=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=FDyysCgpCSLIzjLEawSdItTK0d6jAoV7kUCnvbf6SvkW9KXwnKHmpHL3Nv14ZZtcM
         aJtgBRqlWgy02GW8TU4xzGwuP61rn4fqkKZFuTADqOh3WgEBIvJIfQx7oTus9FXsBn
         55p8y97k/vEzvC4vMtEUjvBB3OW7mz2FOtN2W9MU=
Subject: Re: [PATCH v6 1/3] IMA: Add KEY_CHECK func to measure keys
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
 <20191113184658.2862-2-nramas@linux.microsoft.com>
 <1573676066.4843.18.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <320826aa-f744-f2ae-8693-a6ce9461d886@linux.microsoft.com>
Date:   Wed, 13 Nov 2019 12:21:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573676066.4843.18.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/13/2019 12:14 PM, Mimi Zohar wrote:

>> @@ -655,6 +655,13 @@ void process_buffer_measurement(const void *buf, int size,
>>   	int action = 0;
>>   	u32 secid;
>>   
>> +	/*
>> +	 * If IMA is not yet initialized or IMA policy is empty
>> +	 * then there is no need to measure.
>> +	 */
>> +	if (!ima_policy_flag)
>> +		return;
>> +
> 
> This addition has nothing to do with defining a new IMA hook and
> should be a separate patch.  This can be posted independently of this
> patch set.
> 
> Mimi

I'll move this change to a different patch,
but it has to be either part of this patch set or the above change alone 
needs to be taken before this patch set for the following reason:

The IMA hook gets called early in the boot process (for example, when 
builtin_trusted_keys are added). If the above check is not there, 
ima_get_action() is called and causes kernel panic (since IMA is not yet 
initialized).

thanks,
  -lakshmi


