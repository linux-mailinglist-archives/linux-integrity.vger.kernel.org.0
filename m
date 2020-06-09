Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FEB1F4455
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2020 20:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgFISDc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Jun 2020 14:03:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37326 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733193AbgFISDb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Jun 2020 14:03:31 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1AE4320B717B;
        Tue,  9 Jun 2020 11:03:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1AE4320B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591725809;
        bh=RcRx8d20bjJpLdKxUmDt/7K3aLBKNzYGLcu36Ac8y94=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HZqrRLQRrYDntNP1Jtw4oEaypC9lkwLUlI9j6+1PzvhOjT1Qc5LXxONmka95SLTCn
         3XUFK/fUKZXRBC9WtrfrgBuaRLu7C85Q64Vzi4k01hbp+a9ZcOYepI2+zI368Z2U07
         WLCodQHxPAE6p/ZbRNCcEjr8ia3didJ0LTwcNoQo=
Subject: Re: [PATCH v3] IMA: Add audit log for failure conditions
To:     Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20200608215343.4491-1-nramas@linux.microsoft.com>
 <518a51b7-6c8d-f55f-c73a-b15abae8e0af@linux.microsoft.com>
 <20200609171555.itbllvtgjdanbbk7@madcap2.tricolour.ca>
 <2006844.2enhIMKrvE@x2>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2e3bc793-0d29-5434-1da3-2bcc34ed9012@linux.microsoft.com>
Date:   Tue, 9 Jun 2020 11:03:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2006844.2enhIMKrvE@x2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/9/20 10:35 AM, Steve Grubb wrote:
>>
>> If it is added, it should be appended to the end of the record since it
>> is an existing record format, then in the case of res=1, errno= should
>> still be present (not swing in and out) and just contain zero.  (Or
>> another value if there is a non-fatal warning?)
> 
> This is not a searchable field, so it can go anywhere. If it is searchable,
> ausearch expects ordering of other searchable fields.
> 

Thank you for the clarification Steve.

I'll add "errno=" right after "cause=".

Also, "errno" will always be present - will be set to 0 if status is 
"success" (res=1) and a non-zero value for failure (res=0)

thanks,
  -lakshmi


