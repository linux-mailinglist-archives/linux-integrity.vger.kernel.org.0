Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F4FF974B
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLRhG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:37:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:56106 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLRhG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:37:06 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 429E120B7192;
        Tue, 12 Nov 2019 09:37:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 429E120B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573580225;
        bh=AbHGTjnr1+XUMKOaFlFkqwntd1AbBfp5gYhZSRBVodI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=U/rns4ebG+7yUqDs/+yzXw6P37LYIpWncSswT88joWHNO+4vkIW04lsS3Cy5nCh0m
         wm1hByodfr7QBkdu6buiflDs6vsZeIimjzqovg1VMDLvxmRW6mgv8BLaVJ0Hx0h0/R
         Z9RydnaRcKcQevWgwyJIdS0aNlHozTiH0IT6jngg=
Subject: Re: [PATCH v5 01/10] IMA: Added KEYRING_CHECK func in IMA policy to
 measure keys
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
 <20191111193303.12781-2-nramas@linux.microsoft.com>
 <1573578296.17949.41.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <19065ce4-ba91-634b-e2a2-4ae947188d9d@linux.microsoft.com>
Date:   Tue, 12 Nov 2019 09:37:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1573578296.17949.41.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/12/2019 9:04 AM, Mimi Zohar wrote:

> On Mon, 2019-11-11 at 11:32 -0800, Lakshmi Ramasubramanian wrote:
>> IMA policy needs to support a func to enable measurement of
>> asymmetric keys.
>>
>> This patch defines a new IMA policy func namely KEYRING_CHECK to
>> measure asymmetric keys.
> 
> This new feature measures "keys" based on policy, not "keyrings".
>   Please change the name to KEY_CHECK.

Good point - I will change the func name to KEY_CHECK.

  -lakshmi

