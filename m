Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F87E5678
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Oct 2019 00:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfJYW2h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 18:28:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41486 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfJYW2h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 18:28:37 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id CEB0B2010AC6;
        Fri, 25 Oct 2019 15:28:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CEB0B2010AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572042516;
        bh=V6ZSkzy97Ph9Iz78UInOh5o3ydNZF/8k2BxCyvk6lyQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=KHiPpw6dkWKNFofkiya6TL+ZsFpP4nBwS4CyMT4p+8dAJR7wh56P63jvGCra7uDmP
         uoop4pQgCcZztR0hto1QHsJg1K1yHQzXiiowcK+YFuYA/qPG8V19d/ItFH94Rn+8vb
         BtJVzxKRY4VfGbqn8hlB5Yp0Ll4AcWQ/wuxWfh8c=
Subject: Re: [PATCH v2 1/4] KEYS: Defined an ima hook for measuring keys on
 key create or update
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191023233950.22072-1-nramas@linux.microsoft.com>
 <20191023233950.22072-2-nramas@linux.microsoft.com>
 <1572032428.4532.72.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c1de8055-89a7-25dd-d99a-427e2c2c4c59@linux.microsoft.com>
Date:   Fri, 25 Oct 2019 15:28:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1572032428.4532.72.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/25/2019 12:40 PM, Mimi Zohar wrote:

>> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>> +				   unsigned long flags, bool create)
>> +{
>> +	const struct public_key *pk;
>> +
>> +	if (key->type != &key_type_asymmetric)
>> +		return;
>> +
>> +	if (!ima_initialized)
>> +		return;
> 
> There's no reason to define a new variable to determine if IMA is
> initialized.  Use ima_policy_flag.  

Please correct me if I am wrong -

ima_policy_flag will be set to 0 if IMA is not yet initialized
OR
IMA is initialized, but ima_policy_flag could be still set to 0 (say, 
due to the configured policy).

In the latter case the measurement request should be a NOP immediately.

  -lakshmi

