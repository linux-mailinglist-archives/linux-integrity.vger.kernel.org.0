Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103AE11DBED
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 02:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfLMB7Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 20:59:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48632 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfLMB7Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 20:59:16 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 61D2F20B7187;
        Thu, 12 Dec 2019 17:59:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61D2F20B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576202355;
        bh=YxXTmKallgLBW7/eDWy6Lx19SJtawJZqEYTFJolyfhY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CNuTiTMqkeQ2MswdQVXysPfvcdmZ2cNrJnYYqac+2rU02Wh60moR8u+XAW6oERWIe
         v2fUa6G0XMEN6ITGO38tGW8Vl6yhrvEshMCKRT4PYPb6zoMhiQ3eEZbGWXgU6IIiQk
         dXAYW0MEXYLtWnF6XiHmz0Dw4ImpveaIdcZU597w=
Subject: Re: [PATCH v3 1/2] IMA: Define workqueue for early boot "key"
 measurements
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191213004250.21132-1-nramas@linux.microsoft.com>
 <20191213004250.21132-2-nramas@linux.microsoft.com>
 <1576202134.4579.189.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6e0dad33-66f9-4807-d08d-ff30396cec5e@linux.microsoft.com>
Date:   Thu, 12 Dec 2019 17:59:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576202134.4579.189.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/12/19 5:55 PM, Mimi Zohar wrote:
>> +/*
>> + * ima_process_queued_keys() - process keys queued for measurement
>> + *
>> + * This function sets ima_process_keys to true and processes queued keys.
>> + * From here on keys will be processed right away (not queued).
>> + */
>> +void ima_process_queued_keys(void)
>> +{
>> +	struct ima_key_entry *entry, *tmp;
>> +	LIST_HEAD(temp_ima_keys);
>> +
>> +	if (ima_process_keys)
>> +		return;
>> +
>> +	/*
>> +	 * To avoid holding the mutex when processing queued keys,
>> +	 * transfer the queued keys with the mutex held to a temp list,
>> +	 * release the mutex, and then process the queued keys from
>> +	 * the temp list.
>> +	 *
>> +	 * Since ima_process_keys is set to true, any new key will be
>> +	 * processed immediately and not be queued.
>> +	 */
>> +	INIT_LIST_HEAD(&temp_ima_keys);
>> +
>> +	mutex_lock(&ima_keys_mutex);
> 
> Don't you need a test here, before setting ima_process_keys?
> 
> 	if (ima_process_keys)
> 		return;
> 
> Mimi

That check is done before the comment - at the start of 
ima_process_queued_keys().

+void ima_process_queued_keys(void)
+{
+	struct ima_key_entry *entry, *tmp;
+	LIST_HEAD(temp_ima_keys);
+
+	if (ima_process_keys)
+		return;

thanks,
  -lakshmi
