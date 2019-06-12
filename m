Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0A42C9C
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502225AbfFLQrV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 12:47:21 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37388 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502210AbfFLQrV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 12:47:21 -0400
Received: from [10.91.6.157] (unknown [131.107.159.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5A85320B7186;
        Wed, 12 Jun 2019 09:47:20 -0700 (PDT)
From:   Jordan Hand <jorhand@linux.microsoft.com>
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi <nramas@linux.microsoft.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        James Bottomley <jejb@linux.ibm.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
 <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
 <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
 <1560255756.4464.111.camel@linux.ibm.com>
 <1560273181.4464.226.camel@linux.ibm.com>
Message-ID: <b3fbbe78-423f-b48d-b32c-ede3841bf936@linux.microsoft.com>
Date:   Wed, 12 Jun 2019 09:47:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560273181.4464.226.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/11/19 10:13 AM, Mimi Zohar wrote:
>>
>> The design of IMA from the very beginning has been to allow the system
>> owner to decide which keys to trust.  This is the reason that the root
>> of trust pivots from the pre-boot keys to the keys embedded in the
>> Linux kernel.  When software packages contain both the file data and
>> file signatures, the system owner will be able to pick and choose
>> which public keys to sign and load onto the IMA keyring.
>>
>> This patch set might not be limiting which public keys may be loaded
>> onto the builtin/secondary keyrings, but by virtue of including this
>> information in the measurement list, the attestation service (eg. TNC)
>> will be able to deny access.  IMA walks a fine line in enforcing and
>> measuring file integrity.  This patch set breaches that fine line and
>> by so doing, brings back the fears of trusted computing.


I don't understand why measuring the keyring is more restrictive. 
Currently the signature of a file can already be measured. This means 
that the service can maintain a list of allowable keys and see if the 
files are signed with any of those keys. So effectively it is already 
possible for a service to deny access to the machine based on the keys 
it trusts.

I also think validating the keys in the keyring is less restrictive than 
file-hash validation. You can say "I trust any file that the signer 
trusts". In file-hash validation you're saying "I only trust the files 
that I trust".

> 
> Many attempts over the years were made to update grub to support
> secure & trusted boot.  Richard Stallman (grudgingly) added the secure
> boot callbacks, which are also being used for trusted boot.  The code
> to actually do the signature verification though, as far as I'm aware,
> is still not part of grub.
> 
> It also took a really long time and effort to convince Stallman that
> TPMs aren't totally bad.  He's added an addendum to the wiki.[1]
>   Let's try not to upset Stallman too much.

I do understand the desire to avoid taking a step backward by pushing 
too hard. As I said above, I don't see this as more restrictive than the 
existing measurements. But you have more understanding of the history 
here so let me know if I'm missing something.

-Jordan

> 
> Mimi
> 
> [1] https://www.gnu.org/philosophy/can-you-trust.en.html
> 
