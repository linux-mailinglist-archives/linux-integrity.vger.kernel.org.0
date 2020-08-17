Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0A2477D4
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 22:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgHQUCG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 16:02:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33380 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgHQUCF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 16:02:05 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B3EC120B4908;
        Mon, 17 Aug 2020 13:02:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3EC120B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597694524;
        bh=2kp5ghcCRtPQbyIOLyk13l3Yu40CQWzri5r/ljwsKFI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qJLxntGY2OBmUXuS9DE9TZ1ZeZ092XacdCovENDukXqHHICp1STvVr5gd3P+UV39a
         +iWdeupLAIUUvtyJUXauD8cEY6+zO8foXTTPi9Cjm8ooDHwvKuCzTu7pZi8vbH3zEI
         gX1AvW3zwmS5CnVh4HuvPZPM7C6uYZiBhg5qgL/w=
Subject: Re: [PATCH v3 0/4] IMA: verify measurement of certificate imported
 into a keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        ltp@lists.linux.it
Cc:     linux-integrity@vger.kernel.org
References: <20200817130916.27634-1-pvorel@suse.cz>
 <bc89bf8e0c40e6d66c86b42f55f9bf69ec7e335e.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <cdf45ba0-287b-8fa1-d067-1c6c4f386939@linux.microsoft.com>
Date:   Mon, 17 Aug 2020 13:02:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bc89bf8e0c40e6d66c86b42f55f9bf69ec7e335e.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/17/20 12:18 PM, Mimi Zohar wrote:

> On Mon, 2020-08-17 at 15:09 +0200, Petr Vorel wrote:
>> Hi Mimi, Lakshmi,
>>
>> changes v2->v3:
>> fixed regression in my third commit.
>> (please verify it on installed LTP, or at least run make install in
>> testcases/kernel/security/integrity/ima/datafiles/ima_keys/)
> 
> I did, but nothing changed.  I probably need to set an environment
> variable.
> 
> After building and installing LTP, it's finding the file, but some of
> the issues still exist:
> 
> ima_keys 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> ima_keys 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
> ima_keys 1 TINFO: verify key measurement for keyrings and templates specified in IMA policy
> grep: Unmatched ( or \(
> ima_keys 1 TPASS: specified keyrings were measured correctly
> ima_keys 2 TINFO: verify measurement of certificate imported into a keyring
> keyctl_session_to_parent: Operation not permitted
> ima_keys 2 TPASS: logged certificate matches the original
> 
> IMA policy:
> measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
> measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
> 

I think I see the problem

keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
		sed "s/\./\\\./g" | cut -d'=' -f2; done | sort -u

The above line generates the list of keyrings (read from the IMA policy) 
with a newline after the first policy entry with "keyrings=". Please see 
below:

ima_keys 1 TINFO: \.ima|\.builtin_trusted_keys
key_import_test

When this is checked in the "do-done" loop grep returns "mismatched (" 
due to the newline.

I tried with "(" removed from the following line and that fixes the problem:

grep -E "($templates)*($keyrings)" $ASCII_MEASUREMENTS | while read line

But a better fix might be to remove the "newline" in $keyrings. I'll try 
that.

Regarding the following error:
keyctl_session_to_parent: Operation not permitted

The following line in test2() can be removed. Not sure if this is needed.
	keyctl new_session > /dev/null

thanks,
  -lakshmi
