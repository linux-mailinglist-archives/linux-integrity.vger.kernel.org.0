Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2AA2CEA
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 04:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfH3CoH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 22:44:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52284 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfH3CoH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 22:44:07 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id A033E20B7186;
        Thu, 29 Aug 2019 19:44:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A033E20B7186
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Cc:     jamorris@linux.microsoft.com, sashal@kernel.org,
        kgoldman@us.ibm.com
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
 <1567041083.6115.133.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
Date:   Thu, 29 Aug 2019 19:43:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567041083.6115.133.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


>> Without this patch set, to attest the clients one needs to maintain
>> an "allowed list" of file hashes of all versions of all client binaries
>> that are deployed on the clients in the enterprise.  That is a huge
>> operational challenge in a large scale environment of clients with
>> heterogenous builds. This also limits scalability and agility of
>> rolling out frequent client binary updates.
> 
> The purpose of the ima-sig template, which includes the file signature
> and header containing the keyid, is to avoid needing to maintain a
> white list as you described.

If the service were to validate the signature in the ima-sig template, 
it needs to have the hash of the file. Using the keyid in ima-sig pick 
the key, calculate the signed hash and compare it with the signed hash 
in the ima-sig template. Correct?

Or, it has to maintain the signed hash of the file and compare it with 
the signed hash in the ima-sig template.

In both the cases, the service needs to have the hash or signed hash for 
all the client files (for all versions of that file). This the 
maintenance overhead we are trying to avoid.

> The concern isn't on the client side, but the server side.  Once the
> ability of including measurements of keys on the builtin and/or
> secondary keyrings on the client side exists, the attestation servers
> can start requiring it.  Providing a means of disabling it on the
> client side doesn't address this problem.

But, wouldn't this problem exist for any new measure we add on the 
client side? Why is it particularly an issue for measuring trusted keys?

> 
> No, there is no need for maintaining a binary hash white list.  The
> attestation server requires a set of trusted keys used to sign
> software.
> 
> The only reason for measuring the keys on the builtin and/or secondary
> keyrings is to prevent system owners from signing and running
> applications on their own systems.
> 
> Since you obviously disagree, I'd really like to hear other people's thoughts.

Actually I am agreeing with you - the reason we want to measure the keys 
in the trusted keyring is to ensure that the system binaries running on 
the client are signed by trusted keys only. Please see below:

We let IMA verify the integrity of the system files on the client using 
IMA key(s). The IMA key(s) are themselves signed by "Trusted Key(s)" - 
unsigned IMA key or IMA key signed by keys not in the trusted keyring 
are not even allowed to be added to the IMA keyring.

And, on the server we validate the "Trusted Keyring" contains only 
known\trusted keys.

Through the above process - the server does not need to know the signed 
file hash. It only needs to keep a list of trusted keys and verify if 
the keys reported by the client is in that trusted keys set.

Please let me know if that answers your questions.

Thanks,
  -lakshmi
