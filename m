Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C710C116
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Nov 2019 01:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfK1Ao3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 19:44:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59684 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfK1Ao3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 19:44:29 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6AB9720B7185;
        Wed, 27 Nov 2019 16:44:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AB9720B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574901868;
        bh=i45B9K6gVEFEes7FGLuQ9jYlPqhzKWyb3Cu2Dwz50MQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xg9GNm45D60C+1lHv95rf09FhgFgasrx8uaOEEbCT6ewMV3l5IisnA0yQyyAlr2Cm
         jKqcnwQSUCdd3rxD4IollqF7uIV9leFHlvoGIMnx1CB+1xudRcLTwqjq1Foyoqdl4r
         ViIuxUNiaQZqSrL8PnBgxvEmLbnvMILJj3zG4yPs=
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-6-nramas@linux.microsoft.com>
 <1574880741.4793.292.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <18b30666-7c44-f81e-8515-189052007e47@linux.microsoft.com>
Date:   Wed, 27 Nov 2019 16:44:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1574880741.4793.292.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/27/19 10:52 AM, Mimi Zohar wrote:

Hi Mimi,

>> +static bool ima_match_keyring(struct ima_rule_entry *rule,
>> +			      const char *keyring)
>> +{
>> +	/*
>> +	 * "keyrings=" is specified in the policy in the format below:
>> +	 *   keyrings=.builtin_trusted_keys|.ima|.evm
>> +	 *
>> +	 * Each keyring name in the option is separated by a '|' and
>> +	 * the last keyring name is null terminated.
>> +	 *
>> +	 * The given keyring is considered matched only if
>> +	 * the whole keyring name matched a keyring name specified
>> +	 * in the "keyrings=" option.
>> +	 */
>> +	p = strstr(rule->keyrings, keyring);
>> +	if (p) {
>> +		/*
>> +		 * Found a substring match. Check if the character
>> +		 * at the end of the keyring name is | (keyring name
>> +		 * separator) or is the terminating null character.
>> +		 * If yes, we have a whole string match.
>> +		 */
>> +		p += strlen(keyring);
>> +		if (*p == '|' || *p == '\0')
>> +			return true;
>> +	}
>> +
> 
> Using "while strsep()" would simplify this code, removing the need for
> such a long comment.
> 
> Mimi

strsep() modifies the source string (replaces the delimiter with '\0' 
and also updates the source string pointer). I am not sure it can be 
used for our scenario. Please correct me if I am wrong.

Initial IMA policy:
-------------------
measure func=KEY_CHECK 
keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist template=ima-buf

Policy after adding a key to .ima keyring:
------------------------------------------
measure func=KEY_CHECK keyrings=.evm|.builtin_trusted_keys|.blacklist 
template=ima-buf

Policy after adding a key to a keyring that is not listed in the policy:
------------------------------------------------------------------------
measure func=KEY_CHECK keyrings= template=ima-buf

********************************************************************************

Please see the description from the man page for strsep():

http://man7.org/linux/man-pages/man3/strsep.3.html

char *strsep(char **stringp, const char *delim);

This function finds the first token in the string *stringp, that is 
delimited by one of the bytes in the string delim.  This token is 
terminated by overwriting the delimiter with a null byte ('\0'), and 
*stringp is updated to point past the token.

thanks,
  -lakshmi
