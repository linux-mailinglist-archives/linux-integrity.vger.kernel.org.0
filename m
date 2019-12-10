Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED7119F4C
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 00:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLJXXC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 18:23:02 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43078 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJXXC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 18:23:02 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id C81CD20B7187;
        Tue, 10 Dec 2019 15:23:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C81CD20B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576020181;
        bh=IwjesaSjIEpWOT7ynG/Xbgg6ZKGL9pgenoKbV2q6g7U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AtFIj0pZTW3Hx8baUyJZNgJlKwVCHqk0JgEAfORoB1Ig+7wTL3Z+xEg252xhKXUHn
         WpKnz8MLoEOt4VMwiw1H/qzFioq46Zk6Rr4kaFBZ+fiPbk7bf2tQp13QHoEvAswMw4
         sJgAlHh3Wh83SR/ADhT6iy+dEOzCvUXUSaSx5d5s=
Subject: Re: [PATCH v10 5/6] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
 <20191204224131.3384-6-nramas@linux.microsoft.com>
 <1576017805.4579.44.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <07c231c9-509e-cd1f-9ea0-bfb20f9a0070@linux.microsoft.com>
Date:   Tue, 10 Dec 2019 15:23:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576017805.4579.44.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/10/19 2:43 PM, Mimi Zohar wrote:

>> +static bool ima_match_keyring(struct ima_rule_entry *rule,
>> +			      const char *keyring, const struct cred *cred)
>> +{
>> +	char *keyrings, *next_keyring, *keyrings_ptr;
>> +	bool matched = false;
>> +
>> +	/* If "keyrings=" is not specified all keys are measured. */
> 
> With the addiitonal "uid" support this isn't necessarily true any
> more.
> 
> Mimi

Will move the check for uid ahead of the check for keyrings.

if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
	return false;

> 
>> +	if (!rule->keyrings)
>> +		return true;
>> +
>> +	if (!keyring)
>> +		return false;
>> +
>> +	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
>> +		return false;
>> +

thanks,
  -lakshmi


