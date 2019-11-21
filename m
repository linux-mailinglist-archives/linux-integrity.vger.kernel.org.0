Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683E8104815
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 02:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKUBcH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Nov 2019 20:32:07 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36142 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUBcH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Nov 2019 20:32:07 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id B20AD20B7185;
        Wed, 20 Nov 2019 17:32:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B20AD20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574299926;
        bh=aeBFIDmsoWny0EYr1/a2SoKWD35gPHAfNwnYfOwZy7Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VSgxdqIy4KDeltAbZ9SUt6xRmyYcz3BkhjsQtC5Ai/DXDZ6w50YFDseA96Olnm/UX
         dn2GPLUE1DKos9EyIOZANzpP5kpa8t1WPU9wxySlRHqbYfu1tf1oPy5w0AZLP5bLaN
         x7Wdx4RK8aO2jvomC2xBu0tHWMYb7MVjx5U1zhlg=
Subject: Re: [PATCH v8 2/5] IMA: Define an IMA hook to measure keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-3-nramas@linux.microsoft.com>
 <ED63593E-BE9B-40B7-B7FD-9DE772DC2EB1@oracle.com>
 <98eeec95-cc19-2900-b96e-eadaac1b4a68@linux.microsoft.com>
 <1574299330.4793.158.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <21c08fdf-43d7-67e0-1cb5-66bdbce1b6ad@linux.microsoft.com>
Date:   Wed, 20 Nov 2019 17:32:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574299330.4793.158.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/20/19 5:22 PM, Mimi Zohar wrote:

>> I had the following check in process_buffer_measurement() as part of my
>> patch, but removed it since it is being upstreamed separately (by Mimi)
>>
>>    if (!ima_policy_flag)
>>    	return;
> 
> Did you post it as a separate patch?  I can't seem to find it.
> 
> Mimi

No - I removed the above change from my patch since you mentioned it's 
being upstreamed separately.

I didn't realize you wanted me to include the above change alone in a 
separate patch (in my patch set). Sorry - I guess I misunderstood.

I can do that when I send an update - I expect to by the end of this week.

thanks,
  -lakshmi
