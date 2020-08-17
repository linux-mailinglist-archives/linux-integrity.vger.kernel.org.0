Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE4247B39
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 01:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgHQXph (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 19:45:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35252 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgHQXph (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 19:45:37 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 34CB320B4908;
        Mon, 17 Aug 2020 16:45:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 34CB320B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597707936;
        bh=ODLtHxuph/xu3RT5nAzZUsfuC4XcphwPvbtr8zOIZzg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e0vOwyRUKbxX3Qa2qnnDFomljqdWRcOMXJPHRiWMnZTHllxiWh7XdZHsR51MPESsz
         8HUgrN9PAhKC8Yj5RJtVtgv7vnWHio9/5Ue4vDH5+fbyQVHwIwmf8p+ehE7g0DYOXT
         R4YjmXC7WNa68PrUnwHBKoiWNHEZBHEiDOdB6Bj8=
Subject: Re: [PATCH 2/3] IMA: add policy to support measuring critical data
 from kernel components
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        nramas@linux.microsoft.com
References: <20200812193102.18636-1-tusharsu@linux.microsoft.com>
 <20200812193102.18636-3-tusharsu@linux.microsoft.com>
 <591b5f09c7df8ef0378866eaf3afde7a7cb4e82f.camel@linux.ibm.com>
 <5275268e-2ce8-0129-b11d-8419ac384262@linux.microsoft.com>
 <97d25609b6a87f104cc88a2ff8ae52d3f2e4e387.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <0d3a1cbc-9c11-37f3-6316-01f5b43909c1@linux.microsoft.com>
Date:   Mon, 17 Aug 2020 16:45:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <97d25609b6a87f104cc88a2ff8ae52d3f2e4e387.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-08-17 4:43 p.m., Mimi Zohar wrote:
> On Mon, 2020-08-17 at 15:27 -0700, Tushar Sugandhi wrote:
> 
>>> scripts/Lindent isn't as prevalent as it used to be, but it's still
>>> included in Documentation/process/coding-style.rst.  Use it as a guide.
>> Thanks for the pointer. We'll use scripts/Lindent going forward
> 
> Please don't change existing code to conform to it.  Use it as a
> guide/suggestion for new code.
> 
> Mimi
> 
> 
Will do.
Again, appreciate your feedback.
