Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF449607
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 01:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFQXmR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 19:42:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55832 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfFQXmR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 19:42:17 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id D31CE2007677;
        Mon, 17 Jun 2019 16:42:15 -0700 (PDT)
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
 <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
 <7da97815-a09a-de6f-dbf2-7d2c96a077bb@linux.ibm.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Message-ID: <ec8d559b-d78d-4e89-579a-837725928118@linux.microsoft.com>
Date:   Mon, 17 Jun 2019 16:42:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7da97815-a09a-de6f-dbf2-7d2c96a077bb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/17/19 10:04 AM, Ken Goldman wrote:

> How will it know that?  It will know about the keys in the built-in 
> keyring, but how does that say whether an IMA key is trusted?

The parameter CONFIG_INTEGRITY_TRUSTED_KEYRING is enabled so that key(s) 
added to the IMA keyring must be signed by a key in the system trusted 
keyring. So by knowing what keys are present in the "Built-In Trusted 
Keyring", we can know if the IMA keys are trusted or not.

>> By knowing what keys were used to install the IMA key(s) the service 
>> knows whether or not to trust the signature validation performed by 
>> IMA on the client.
> 
> How does that happen?
> 
> In order to trust the IMA validation, it has to attest to the code doing 
> the validation, and to the IMA keys.
> 
> It already knows which IMA keys were used from the IMA log, assuming the 
> IMA code is attested.

Yes - from the IMA log the service knows which IMA keys were used.
And, by knowing the keys in built-in trusted keyring, the service can 
know whether those IMA keys are trusted (because the IMA keys have to be 
signed by the key(s) in built-in trusted keyring: by enabling 
CONFIG_INTEGRITY_TRUSTED_KEYRING).

Since, the built-in keys change much less often than the IMA keys, it is 
much less maintenance overhead in the service to attest the built-in 
keys compared to attesting the IMA keys.

Due to the requirement that the IMA keys must be signed by built-in key, 
attesting the built-in key effectively attests the IMA keys as well.

> How does knowing the keys on the built-in keyring tell which files were 
> signed?  How does it tell who the signer is?
> 
> That information (whether signed and what signed it) comes from the IMA 
> log, right?
The IMA log tells the service which files were signed and which IMA key 
was used to sign those files.

My proposal does not alter (remove) any data that is currently supported 
in the IMA log. It is only adding more information in the IMA log - the 
information on the signer of the IMA signer key(s).

> How would your design help to know whether the files being run are 
> trusted?  I think that has to come out-of-band.
> 
> E.g., I can know that libfoo.so.1.2.3 is signed and who the signer is, 
> but I may not trust anything older than libfoo.2.0.0.

You are right - the fact that file older than, for example, libfoo 2.0.0 
is trusted or not is not something my proposal covers. That is not the 
goal of this proposal.

IMA log currently just conveys libfoo.1.5.6 is signed and provides 
information on the signer. Whether that version is trusted or not needs 
to be verified by the service outside of IMA.

>> Like I have stated above, the change I am making is adding more data 
>> (information on built-in keys) to what IMA log already provides".
> 
> Understood.  I'm trying to learn the usefulness of that data.

My proposal is adding information on the signer of the IMA signer key - 
that signer information is in the "Built-In Trusted Keys".

That data, in addition to the current IMA log, provides information to 
the service to determine if the IMA keys used by the clients are trusted 
or not.

> Doesn't it needs those hashes anyway, to determine whether the file is 
> trusted.  To me "signed with a trusted key" does not equal "trusted".
I agree - a file that has valid signature may not be trusted because 
that version of the file was, for instance, buggy.

The goal of my proposal is not to help the service determine whether a 
file is trusted or not - that has to be done outside of IMA.

The goal of my proposal is to convey whether the file was signed with a 
trusted key.

> We already know who signed from the IMA keys in the IMA log.
> 
> How does knowing who was authorized to install IMA keys help?  The 
> attestor still has to know out of band which IMA keys to trust, and 
> which files to trust.

By building the kernel with CONFIG_INTEGRITY_TRUSTED_KEYRING we are 
mandating that the IMA key is signed by built-in key.

So by knowing who authorized (signed) the IMA key, the service is able 
to know whether to trust the IMA key or not.

Information on the IMA key is already available in the IMA log. But 
since IMA keys change much more frequently than the "Built-In Keys", it 
is more overhead for the service to keep track of all valid IMA keys 
compared to doing the same for "Built-In keys".

Hence my proposal to include the "Built-In keys" in the IMA measurement.

Thanks,
  -lakshmi

