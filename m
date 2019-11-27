Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0010A89F
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 03:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfK0CJK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Nov 2019 21:09:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58922 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfK0CJK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Nov 2019 21:09:10 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5534820B7185;
        Tue, 26 Nov 2019 18:09:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5534820B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574820549;
        bh=Ie1xSJ1/5sqVUEbyENfv1rfOxps/a2dGL+tHgWZBWxM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=faogmiWbIjF6VvlXYwKJvg/78V1MAfEHdbHLQ4AHo7/dp8pgxSMWgZiu4eUtS9UQI
         6FBZZyYRMzTWbFqMQF+uBY4/poj9fatavTjRf+Hgd4Qwc3m/wa4zmboQmh4fhmYtRU
         X/BHeA+ZrJD6CHsRcTSmfTJnWl1HyLJ959RuHiNY=
Subject: Re: [PATCH v0] IMA: Check IMA policy flag
To:     Mimi Zohar <zohar@linux.ibm.com>, eric.snowberg@oracle.com,
        linux-integrity@vger.kernel.org
References: <20191121171444.2797-1-nramas@linux.microsoft.com>
 <5a43ec9d-af82-9a31-3546-76e8328ff213@linux.microsoft.com>
 <1574706618.4793.218.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6b51b7ff-ac8b-7cd9-1d0c-1358eab0fb6f@linux.microsoft.com>
Date:   Tue, 26 Nov 2019 18:09:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1574706618.4793.218.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/25/19 10:30 AM, Mimi Zohar wrote:

>>
>> Please let me know if the above change would be accepted as a standalone
>> patch (like the one in this patch),
>> or, I should include this change as one of the patches in the "Key
>> Measurement" patch set?
> 
> As I'm not planning on sending a pull request this open window, so
> that it doesn't get lost/forgotten, please include it as the first
> patch in this patch set.
> 
> Mimi
> 

I have included the change to check ima_policy_flag in 
process_buffer_measurement() as the 1st patch (PATCH v9 1/6) in the 
updated patch set I posted today.

thanks,
  -lakshmi
