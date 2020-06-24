Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666B4207A31
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405450AbgFXRZW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 13:25:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47978 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405318AbgFXRZV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 13:25:21 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 362F920B7192;
        Wed, 24 Jun 2020 10:25:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 362F920B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593019520;
        bh=KXE68dak6HAQbc0ivKW2q2uYO1vn/u26qFcxRNMdIGw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jMY9CIcCXcVXasy+rbNwldyuIKL+RZvgrUPekmS9n7SxjrxGZeZxD3HKVvZgu9aAM
         DZgaikoIHUiNZ3yNZa7ecTm7TiG8pjbCZ1XfsKNvV3zcP5ZT+n7JY99fH4Q4oLWh1l
         r0GLdGg3gw6QvVHjpctF4j4hwQgBVLftgZcxfhe8=
Subject: Re: [PATCH v3 2/2] IMA: Add audit log for failure conditions
To:     Mimi Zohar <zohar@linux.ibm.com>, sgrubb@redhat.com,
        paul@paul-moore.com
Cc:     rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
References: <20200618211012.2823-1-nramas@linux.microsoft.com>
 <20200618211012.2823-2-nramas@linux.microsoft.com>
 <1592942295.5389.9.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <39d66bdc-55be-984a-42a0-34d0a011e0fb@linux.microsoft.com>
Date:   Wed, 24 Jun 2020 10:25:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1592942295.5389.9.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/23/20 12:58 PM, Mimi Zohar wrote:

Hi Steve\Paul,

>> Sample audit messages:
>>
>> [    6.303048] audit: type=1804 audit(1592506281.627:2): pid=1 uid=0
>> auid=4294967295 ses=4294967295 subj=kernel op=measuring_key
>> cause=ENOMEM comm="swapper/0" name=".builtin_trusted_keys" res=0
>> errno=-12
> 
> My only concern is that auditing -ENOMEM will put additional memory
> pressure on the system.  I'm not sure if this is a concern and, if so,
> how it should be handled.

Do you have any concerns with respect to adding audit messages in low 
memory conditions?

> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks Mimi

  -lakshmi
