Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE24F972D
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKLRdP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:33:15 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54742 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfKLRdO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:33:14 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id E33CE20B7192;
        Tue, 12 Nov 2019 09:33:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E33CE20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573579994;
        bh=xx3ca2mXIh+U41lW7vrWoqUfcbvWxR0SGNsgcT5S7rQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ihsqak0bLJndwzANhp76UsG97Hw8N5zkHSYUgQNSBqH5uaKe4zhsSGhcTI4aSzrfZ
         llZhqlHI/ZBf3975h27sna5oO6Quw6VZYGw7q3jlajWWtvl3dHgNCyTs5PDK34s0I9
         F0cKkM52WI/odNdT07zuS7tw5BcpqtoMn3CTp5ZI=
Subject: Re: [PATCH] ima: avoid appraise error for hash calc interrupt
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Patrick Callaghan <patrickc@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
References: <20191111192348.30535-1-patrickc@linux.ibm.com>
 <e3f520ce-a290-206d-8097-b852123357ca@linux.microsoft.com>
 <1573578841.17949.48.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c6a57c24-2f30-f252-0f42-8d748ede65af@linux.microsoft.com>
Date:   Tue, 12 Nov 2019 09:33:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573578841.17949.48.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/12/2019 9:14 AM, Mimi Zohar wrote:

> On Mon, 2019-11-11 at 14:29 -0800, Lakshmi Ramasubramanian wrote:
>> On 11/11/19 11:23 AM, Patrick Callaghan wrote:
>>
>>> -		if (rbuf_len == 0)
>>> +		if (rbuf_len == 0) {	/* unexpected EOF */
>>> +			rc = -EINVAL;
>>>    			break;
>>> +		}
>>>    		offset += rbuf_len;
>>
>> Should there be an additional check to validate that (offset + rbuf_len)
>> is less than i_size before calling cypto_shash_update (since rbuf_len is
>> one of the parameters for this call)?
> 
> The "while" statement enforces that.
> 
> Mimi

Yes - but that check happens after the call to crypto_shash_update().

Perhaps integrity_kernel_read() will never return (rbuf_len) that will
  => violate the check in the "while" statement.
  => number of bytes read that is greater than the memory allocated for 
rbuf even in error conditions.

Just making sure.

thanks,
  -lakshmi

> 
>>
>>                  if ((rbuf_len == 0) || (offset + rbuf_len >= i_size)) {
>>                           rc = -EINVAL;
>>                           break;
>>                  }
>>                  offset += rbuf_len;
>>
>>>    	       rc = crypto_shash_update(shash, rbuf, rbuf_len);

