Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628FAF9776
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLRnh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:43:37 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58426 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLRnh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:43:37 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 840AA20B7192;
        Tue, 12 Nov 2019 09:43:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 840AA20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573580616;
        bh=gL4GwRpk0PWlTJzGrB0LKNSqKfDDLY5JhTDv2wWXNMA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=AuhgNldHUcVqizdampYRLQUgbO6DPog4DHUBXWaX0gH+eRJQ99Qj4d49IqQ2RzHAi
         e1xFa4p0QttxJ6T8q6E04jo/vkXCVCLPSUpYMm2MnE0cNrGZHyvfZtpI2J0ofXStZJ
         CIftdHy5V2cIeqjLpdfRBEKky7AJoxxmt5qTc6oU=
Subject: Re: [PATCH v5 02/10] IMA: Added keyrings= option in IMA policy to
 only measure keys added to the specified keyrings.
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
 <20191111193303.12781-3-nramas@linux.microsoft.com>
 <1573578305.17949.42.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1f940f9d-fb1b-a0a4-b5f4-3f3532dbc041@linux.microsoft.com>
Date:   Tue, 12 Nov 2019 09:43:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573578305.17949.42.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/12/2019 9:05 AM, Mimi Zohar wrote:

> The C maximum line length is 80 characters.  The subject line is even
> less than that (~50).  The Subject line here could be "ima: add
> support to limit measuring keys".
I'll update the subject line for the patches - limit to max 50 chars.

> 
> On Mon, 2019-11-11 at 11:32 -0800, Lakshmi Ramasubramanian wrote:
>> IMA policy needs to support measuring only those keys linked to
>> a specific set of keyrings.
> 
> Patch descriptions should be written in the imperative.  For example,
> "Limit measuring keys to those keys being loaded onto a specific
> keyring."
Will update.

> 
>>
>> This patch defines a new IMA policy option namely "keyrings=" that
>> can be used to specify a set of keyrings. If this option is specified
>> in the policy for func=KEYRING_CHECK then only the keys linked to
>> the keyrings given in "keyrings=" option are measured.
> 
> This description does not seem to match the code, which for some
> reason isn't included in this patch, nor in 3/10.  Please
> combine/squash patches 2 & 3.  Missing from the combined patch is the
> keyring matching code in ima_match_rules().

This patch defines "keyrings=" option in the IMA policy and adds the 
related field in ima_rule_entry struct.

The code for updating the new field in ima_rule_entry is in patch #4
[PATCH v5 04/10] IMA: Updated IMA policy functions to return keyrings 
option read from the policy

I'll update the description for this patch (#2).

  -lakshmi
