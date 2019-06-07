Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2FB392E1
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfFGRPk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 13:15:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34052 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbfFGRPk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 13:15:40 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B93C20B7186;
        Fri,  7 Jun 2019 10:15:39 -0700 (PDT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
 <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Message-ID: <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
Date:   Fri, 7 Jun 2019 10:15:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/7/19 7:14 AM, Ken Goldman wrote:

> 
> Why is this important?  What is gained by measuring the keys on the
> built-in keyring?  The IMA log already measures [a pointer to] the
> IMA keys used for signature verification.  Why does the service care 
> what keys were used to install the IMA keys?

By measuring the built-in keyring, the service knows whether or not the 
key(s) in "IMA keyring" are indeed trusted or not. So while the IMA key 
validates the file signatures on the client, the built-in key validates 
the IMA key(s).

By knowing what keys were used to install the IMA key(s) the service 
knows whether or not to trust the signature validation performed by IMA 
on the client.

> 
> I don't understand this reasoning.
> 
> To me, there is a difference between signed files and trusted files. 
> E.g., an old version may be signed, but it is no longer trusted. >
> In other words, the service wants to know all files that have run, not 
> just whether they are signed.

The service will receive the entire IMA log - the entries that show what 
system files were loaded, the IMA signature, etc. My change additionally 
provides measurement on the signer (which key(s) were used to install 
the keys in IMA keyring). Together this data enables the service to 
determine whether the files on the client were signed and who the signer 
is. The service can then decide whether the client is running files that 
are trusted.

> 
> Further, the service also wants to know files that were blocked from 
> running, either because of no signature, a signature with an untrusted 
> IMA key, or a bad signature.  I.e., the service needs the entire IMA 
> log, not just the keys used to install the keys used to locally verify 
> the signatures.

Like I have stated above, the change I am making is adding more data 
(information on built-in keys) to what IMA log already provides".

My proposal is not to replace the current IMA log with just data on 
"built-in keys".

Also, want to clarify that we do not want the service to also locally 
verify the signatures. To do that the service needs to maintain the 
signed file hashes of all the files and all the versions of each of 
those files - That is an high overhead approach.

Instead, we let the client do the signature validation and on the 
service just validate who signed those files.

> 
> While the built-in keys may change less frequently that the IMA keys, 
> both are likely to be stable.  I.e., is this proposal to provide an 
> additional security benefit, or is it to improve performance?

The proposal enables the service to validate that the file signature of 
the files on the client were created by "trusted signer". So it provides 
additional security benefit and at the same time reduces the maintenance 
overhead in the service - by enabling it to just keep track of "Known 
good trusted keys" which change less frequently.

I hope I have answered all of your questions\concerns.

Thanks,
  -lakshmi


