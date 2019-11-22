Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B4D10768C
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Nov 2019 18:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKVRjV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Nov 2019 12:39:21 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43986 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfKVRjV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Nov 2019 12:39:21 -0500
Received: from [10.137.112.108] (unknown [131.107.159.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id BF34120B7185;
        Fri, 22 Nov 2019 09:39:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF34120B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574444360;
        bh=th0wzuyVrms4b9xRmbzJla44RrgFTx8H9hlEQvPgqWA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dAMlWhxiKVH9zV+qIudhm6vSJ8w65YCVIGmf8Kf1/ai3xaK8gXE7+nZKUvM3HLHoS
         fOn/dhjtnEdaLqrM5Bcvm2RkEhnhf0V0TQQU7vtiefsZ9ysiAITSZWh7epUJATHsME
         GURUq7CFMHcRDe/KoXSj22KgCJcmqR0Zzykh1B/I=
Subject: Re: IMA: Data included in the key measurement
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, dhowells@redhat.com
Cc:     James Morris <jamorris@linuxonhyperv.com>
References: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
 <1574354333.3277.27.camel@HansenPartnership.com>
 <b4257d08-f6cf-19a0-f6f0-99c962ededac@linux.microsoft.com>
 <1574439451.3331.14.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <19554a75-06c3-f234-f27e-25f65dbecd1f@linux.microsoft.com>
Date:   Fri, 22 Nov 2019 09:39:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574439451.3331.14.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/22/19 8:17 AM, James Bottomley wrote:

Thanks for the info James. I'll investigate further.

  -lakshmi

> On Thu, 2019-11-21 at 17:15 -0800, Lakshmi Ramasubramanian wrote:
>> On 11/21/19 8:38 AM, James Bottomley wrote:
>>
>> Hi James,
>>
>>> You're making the assumption that the public key and the
>>> certificate are isomorphic.  That's only true if you trust the
>>> issuer (which you obviously do, since it's you [microsoft]) but
>>> nothing in X.509 prevents the issuer from issuing multiple
>>> certificates with the same public key and different
>>> properties.  Even in your use case, I would think
>>> attesting to whether the certificate had expired or not would be
>>> useful.
>>
>> I agree attesting the x509 certificate and not just the public key
>> is the right approach. But in the kernel the certificate is not
>> stored - only the key extracted from the certificate is stored
>> (please correct me  if I am wrong).
> 
> It depends what you mean by "store".  The built in certificates are
> available in the system_certificate_list array; IMA tends to expect
> public keys as X.509 certificates.  In the actual keyring key, we get
> the subject + serial/skid, the subtype the keyids and the signature.
> It does seem we don't set the key expiry to the expiry date of the
> cert, though.  And before loading we do verify the key chain (depending
> on how we were loaded).
> 
>> When IMA, for instance, verifies the file signature only the public
>> key (the data in "struct public_key") of the corresponding IMA key is
>> used - the certificate is not used.
> 
> Once you've performed the certificate verification, we only need
> certain parameters for signature verification, so we store them.
> However, what we verify depends on the signature algorithm. For pkcs1,
> obviously we can only check the signature and nothing else, so the cert
> and the public key become isomorphic here.  For pkcs7, which is what
> IMA mostly uses, we do check some of the parameters.
> 
>> In my key measurement implementation, IMA hook is called when
>> key_create_or_update() function has successfully added\updated a key
>> in a keyring. At that point, I do not have the corresponding x509
>> certificate.
> 
> It sounds like you might be hooking into the wrong place ... we
> definitely pass in the whole certificate for public key load.
> 
>> Please let me know if the kernel indeed stores the x509 certificate
>> also and it can be queried when the corresponding key is added to a
>> keyring. I'll make the changes to measure the x509 cert instead of
>> just the public key.
> 
> If you measure at time of insertion you should be able to measure the
> entire key because it's inserted as a complete certificate.  If there's
> additional data you need to retrieve after the load, we might be able
> to store it in addition to the data we already save from the
> certificate.
> 
> James


