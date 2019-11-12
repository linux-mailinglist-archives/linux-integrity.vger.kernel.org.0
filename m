Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614A8F979E
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLRwI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:52:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33206 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLRwH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:52:07 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id E903520B7192;
        Tue, 12 Nov 2019 09:52:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E903520B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573581127;
        bh=Jcp/YO3SspfDKgJoO3RRfV+kVHMZ5IyQDdrldDugjb8=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=h9gRFLTdCHkWiZZpaIZZLVs6gLOjysxtk2VmX9uZz63lNOHDvsQN/fTSOM3LfXGGr
         Vam8/eaCZh9DfKdol5xgniDq3w8rZTyghrl83u1/dTvr9hfYmg1xgZg/LkLtvGm2DN
         mo2agU24Na2Ah8sAxALjQh2VDYWYyye8XP21HSPg=
Subject: Re: [PATCH v5 0/10] KEYS: Measure keys when they are created or
 updated
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
 <b135b1ac-add6-aea4-cab3-3e9c12796b6a@linux.microsoft.com>
 <1573578526.17949.47.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c364ba52-8a99-d661-d306-b90419e989b1@linux.microsoft.com>
Date:   Tue, 12 Nov 2019 09:52:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573578526.17949.47.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/12/2019 9:08 AM, Mimi Zohar wrote:

> On Mon, 2019-11-11 at 11:41 -0800, Lakshmi Ramasubramanian wrote:
>> On 11/11/2019 11:32 AM, Lakshmi Ramasubramanian wrote:
>>
>> Hi Mimi,
>>
>>> Problem Statement:
> 
> The above line isn't needed.
Will update.

> I've commented on patches 1 - 4.  There's still so much wrong with
> this patch set.  Limiting the scope of the patch set sounds like
> really a good idea.
> 
> Mimi

I'll address your comments and send an update - I'll split this into 2 
patch sets.

thanks,
  -lakshmi

