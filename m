Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B735B110570
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfLCTpN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Dec 2019 14:45:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45824 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLCTpN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Dec 2019 14:45:13 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 55ED620B7185;
        Tue,  3 Dec 2019 11:45:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 55ED620B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575402312;
        bh=Ls9gfcdbAPHKGld7l6/oP5ZuS+qkiikvIWnUExXg588=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZtGEgS5e17IvkRkOmW1pS5ev781eHSFwaQ7kQEot0AFEeeBaOV3oLZWGvgfYpB7bN
         tZrYMNOmmU5eHBo3II1BYGL0ter0oSp7y1mjIzQcS0LGCO9hj6Jgb/v+gldEcoU2JM
         q94ngUXI3xn2S2UY0lzwDFr79sQwo9/KlYGc02NA=
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-6-nramas@linux.microsoft.com>
 <1575375945.5241.16.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>
Date:   Tue, 3 Dec 2019 11:45:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575375945.5241.16.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 12/3/2019 4:25 AM, Mimi Zohar wrote:

> 
> A keyring can be created by any user with any keyring name, other than
>   ones dot prefixed, which are limited to the trusted builtin keyrings.
>   With a policy of "func=KEY_CHECK template=ima-buf keyrings=foo", for
> example, keys loaded onto any keyring named "foo" will be measured.
>   For files, the IMA policy may be constrained to a particular uid/gid.
>   An additional method of identifying or constraining keyring names
> needs to be defined.
> 
> Mimi
> 

Are you expecting a functionality like the following?

  => Measure keys added to keyring "foo", but exclude certain keys 
(based on some key identifier)

Sample policy might look like below:

action=MEASURE func=KEY_CHECK keyrings=foo|bar
action=DONT_MEASURE key_magic=blah

So a key with key_magic "blah" will not be measured even though it is 
added to the keyring "foo". But any other key added to "foo" will be 
measured.

What would the constraining field in the key may be - Can it be SHA256 
hash of the public key? Or, some other unique identifier?

Could you please clarify?

thanks,
  -lakshmi
