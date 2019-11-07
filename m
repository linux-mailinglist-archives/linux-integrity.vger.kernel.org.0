Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D079EF3A3B
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2019 22:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKGVMd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Nov 2019 16:12:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51254 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGVMc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Nov 2019 16:12:32 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id D7C8820B7192;
        Thu,  7 Nov 2019 13:12:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7C8820B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573161151;
        bh=Dq/RMVhen0d8e7vLNzh46Ixy8AtVy3mHTdjNkp6DDic=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=RsCmziqVUticNS68QSUKws2DrO/UoBxa18Xihwt7iTe2TWPIwRFs2LZFzAuuc81rf
         TgtkRW1ijozgN/gAv2RBqRE4lX95WRbLSiduik0gDhQnofP8Qw2TL36s8p3AloT1bt
         cHuoPTE1ia1FG49S/gVjrWY+89+JmgV+BNKG4WRs=
Subject: Re: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on key
 create or update
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
 <20191106190116.2578-2-nramas@linux.microsoft.com>
 <1573080189.5028.313.camel@linux.ibm.com>
 <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
 <1573098037.5028.325.camel@linux.ibm.com>
 <7ce84aa0-729e-c58e-f16a-25490b4e336d@linux.microsoft.com>
 <1573159988.5028.400.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f45593ae-823e-6d61-d14c-20726bd8cacc@linux.microsoft.com>
Date:   Thu, 7 Nov 2019 13:12:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573159988.5028.400.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/7/19 12:53 PM, Mimi Zohar wrote:

>>
>> The measurement decision is not based on whether the keyring is a
>> trusted one or an untrusted one. As long as the IMA policy allows
>> (through the "keyrings=" option) the key will be measured.
> 
> We should be able to measure all keys being loaded onto any keyring or
> onto a specific "keyring=".   This shouldn't be any different than any
> other policy rule.  Once you have this basic feature working, you
> would address loading keys during early boot.
Perfect - that's exactly how I have implemented it right now. Will 
continue to test it.

>> Do you want only trusted keyrings to be allowed in the measurement?
>> In my opinion, that decision should be deferred to whoever is setting up
>> the IMA policy.
> 
> Right, but it shouldn't be limited to just "trusted" keyrings.  This
> way you can first test loading keys onto any keyring.
Thank you.

> Queuing the keys should be independent of measuring the keys.
>   Initially you would start with just measuring the key.  From a high
> level it would look like:
> 
>      ima_post_key_create_or_update(...)
>      {
>         "measure key based on
>      policy(key, keyring, ...)"
>      }
> 
> This requires the IMA "keyring=" policy option support be defined
> first.
> 
> Subsequently you would add key queuing support, and then update
> ima_post_key_create_or_update().  It would look like:
> 
>          ima_post_key_create_or_update(...)
>          {
>              if (custom policy is loaded)
>                 "measure key based on policy(key, keyring, ...)"
>              else
>                  "queue key(key, keyring)"
>          }
> 
> Mimi

Yes - I have the above change working. Will continue testing.

thanks,
  -lakshmi
