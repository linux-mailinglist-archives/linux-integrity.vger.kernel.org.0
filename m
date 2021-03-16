Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B951033DCE7
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 19:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhCPSvC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 14:51:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57650 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbhCPSum (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 14:50:42 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4ED2C209C349;
        Tue, 16 Mar 2021 11:50:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4ED2C209C349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615920642;
        bh=qZXvyF9z8cK+AXTYqRjmf2/evfbpSRHkkFrN82m3Fek=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e86hwaU7ikakOjNPp9/hz0fx2LchoHIZ+MXkd6Auadd0dtYhbgKpb9HUQVyIkqzAo
         T3yH/JWBjKhKOUjB9KR3MrjmD8RtACzlBIAm/BsmqhsUXqwIdmeq7MRvKdhFPtS/nf
         m3PRAmHjfqECWRRvsYcRIMYrLyKCb/cChqQ0HyeU=
Subject: Re: [PATCH v2] IMA: Allow only ima-buf template for key measurement
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
References: <20210314233646.2925-1-nramas@linux.microsoft.com>
 <YFC7j4+wA8xorNgu@pevik>
 <deeb4320-a064-fd0f-bc1e-8e52be079ff9@linux.microsoft.com>
 <YFDpFL3CSwMfZ6wo@pevik>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5cbe66e7-aebf-e75a-cd9a-d0a69e8a1edd@linux.microsoft.com>
Date:   Tue, 16 Mar 2021 11:50:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFDpFL3CSwMfZ6wo@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/16/21 10:21 AM, Petr Vorel wrote:
Hi Petr,

> 
>>> Just a double check does it always work without template=ima-buf for all kernel versions?
>>> Or only for kernels with dea87d0889dd ("ima: select ima-buf template for buffer measurement")
>>> i.e. v5.11-rc1 or backport?
>> The above change is required. Prior to this change, template has to be
>> specified in the policy, otherwise the default template would be used.
> The default template is ima-ng, right?
Yes: ima-ng is the default template.

>>From what you write I understand that "measure func=KEY_CHECK
> keyrings=.ima|.evm" will work only on newer kernel, thus we should always use
> template=ima-buf as the policy example so that it's working also on that few
> kernels between <v5.6,v5.10> (which have IMA key functionality, but not
> dea87d0889dd), right?
Yes: In the kernels between v5.6 and v5.10, ima-buf template needs to be 
specified in the policy for KEY_CHECK.

> 
> But we should mention that in the README.md.
> 
Agreed - will update the README.md

thanks,
  -lakshmi
