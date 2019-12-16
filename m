Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224C9121F1D
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 00:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLPXoZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 18:44:25 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45634 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLPXoZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 18:44:25 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6E5CD2010C1C;
        Mon, 16 Dec 2019 15:44:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E5CD2010C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576539864;
        bh=v5ySPrq9nS0TP3DG/YFkg11gHzXyB5+qOATmjONPkzY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DEWC96GWlm1rmf8iZGKVARcV1CMiTMzpqJmtFN6rYjBPdPjX9Sd4kBdSGhXqd+nQx
         1KHVEhjEbHK4HhLIEggNaGO+Q+LQB/Ofr2S5GTmM+iiKbvyetFqdpisBdEuQR5W0X2
         IG/r/XGUV9drWoHuSNG1dXzQME1MUvtyAaIi6PaU=
Subject: Re: [PATCH v4 1/2] IMA: Define workqueue for early boot "key"
 measurements
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
 <20191213171827.28657-2-nramas@linux.microsoft.com>
 <1576499400.4579.305.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <0223b52e-50d6-ebce-840c-0364b24b1b30@linux.microsoft.com>
Date:   Mon, 16 Dec 2019 15:44:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576499400.4579.305.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/16/2019 4:30 AM, Mimi Zohar wrote:

>> +
>> +		if (!list_empty(&ima_keys)) {
>> +			list_for_each_entry_safe(entry, tmp, &ima_keys, list)
>> +				list_move_tail(&entry->list, &temp_ima_keys);
>> +			process = true;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&ima_keys_mutex);
>> +
>> +	if (!process)
>> +		return;
> 
> The new changes - checking if the list is empty and this test - are
> unnecessary, as you implied earlier.
> 
> Mimi

Do you want me to remove this check? I feel it is safer to have this 
check - use a local flag "process" to return if no keys were moved to 
the temp list. Would like to leave it as is - if you don't mind.

thanks,
  -lakshmi


