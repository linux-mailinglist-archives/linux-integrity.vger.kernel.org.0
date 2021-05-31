Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE133956E1
	for <lists+linux-integrity@lfdr.de>; Mon, 31 May 2021 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhEaIZ7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 May 2021 04:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230424AbhEaIZt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 May 2021 04:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622449449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fXjydIuPLasc98t5ZRJ2Ggut8vJHEkKuJARXoS1eQrE=;
        b=IO11y9Pkda62uLZOUHNYkJ9i2xHxjLqZKNV909HQVapKKVskrc+YNDr49rjSDR6uFQ5daY
        AwbLb2qu7ua3eLrkt6hF9VFNTw1dE/8vElzHAkpd/XmjQnhr1oP/id2fvyN+6lFTOEuya0
        jZcle63XpWDu3WMuPf0zb6qX9hEcIf0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-_l0MfklcPg-D6Mi6XdCrGw-1; Mon, 31 May 2021 04:24:07 -0400
X-MC-Unique: _l0MfklcPg-D6Mi6XdCrGw-1
Received: by mail-ed1-f70.google.com with SMTP id c24-20020aa7c7580000b029038fd7468047so2537788eds.20
        for <linux-integrity@vger.kernel.org>; Mon, 31 May 2021 01:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fXjydIuPLasc98t5ZRJ2Ggut8vJHEkKuJARXoS1eQrE=;
        b=DSiaoIPBMVPTUVfNL30erWipQKCadIeo6lJ9QakVHYYdzuVw3V2EO37N+RC+MCROA+
         6S3NxrIw8dL6/F7KuvLeIxkxk+P0F6iPqTOLdhKribPO0o0iLoZcXr3AcKxU7jgrwmbC
         rQY2F56AN6mdf1nzx8Ogzrl5Sei3vf1y6B1CZxEzii2trMntGwZA2AeIxh4civ4a6/Mj
         G0dma9928Vj3X5ZKpIv7wELLTem8WrTmcna4kVuH9onRsMd477n41Ka4ZQlAkVNyP2S/
         Q3ZvUL9Pbpla7E5umUgBJ7VDarFIVKYTg2YKsek/tT8E5t/gaARjkRYGj3GsuLgQf3Hl
         d7Tw==
X-Gm-Message-State: AOAM530gTuxemYwujjkszIHO8K7PcqOZkQnq5vrt+o75u8f+7+rIGZM/
        92fTKJcujvUbwnNQDtMHZkmdkEqdKxWgDq4AzK/psWHZZ7HEb0I9WmGsPyyLH8XZ6WNaQ5VM7U/
        Vpf+2nDsOz2cpTVeCE1RQlk1pFMhe
X-Received: by 2002:a05:6402:2049:: with SMTP id bc9mr4318049edb.298.1622449446310;
        Mon, 31 May 2021 01:24:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztB5YugpLYrPo+8XwU5l1yxIN1gCVwYv3J4LZ7tC4K4dCN3aQqIUfMb1VZwhYkit4bfwvalA==
X-Received: by 2002:a05:6402:2049:: with SMTP id bc9mr4318039edb.298.1622449446163;
        Mon, 31 May 2021 01:24:06 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d24sm2369056ejr.51.2021.05.31.01.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 01:24:05 -0700 (PDT)
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
 <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
 <YFEEas6kH3FUoKJe@kernel.org>
 <8b592417-dc1d-a7f8-0e17-09b6bb1df33a@redhat.com>
 <YJlsdgxPIm5I6Jk8@kernel.org>
 <4f525bca-3836-7f5c-7913-e54d620473aa@redhat.com>
 <81aa6340-f854-8f26-f599-03b116cc3c29@redhat.com>
 <20210527140025.vl3ply6wnn7rsygg@kernel.org>
 <27d71b81-1e89-1b5d-ddaf-a8928bac90fd@redhat.com>
 <20210531043616.u3v25qzkkrik5apq@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <df7bcbfa-1706-1b8f-f32e-01c2d5e4ac7c@redhat.com>
Date:   Mon, 31 May 2021 10:24:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531043616.u3v25qzkkrik5apq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 5/31/21 6:36 AM, Jarkko Sakkinen wrote:
> On Thu, May 27, 2021 at 05:27:49PM +0200, Hans de Goede wrote:
>> This is from:
>> https://retrace.fedoraproject.org/faf/reports/74723/  (public)
> 
> I wonder if this occurs only with O_NONBLOCK.
> 
> Any chances to get the output of
> 
>   sudo tools/testing/selftests/tpm2/test_smoke.sh
> 
> ?
> 
> It's obvious that there is some sort of bug, but it's not yet obvious that
> this bug is connected to the locality issue yet, as in this case locality
> is successfully reserved by tpm_try_get_ops() in tpm_dev_async_work()
> (driver/chars/tpm/tpm-dev-common.c).

As mentioned I've asked the user to try with tpm_tis.interrupts=0 and see
if that makes a difference. I got a reply that the user only hit this
once and that this is not (easily) reproducible :|

"looks like a spurious problem that may already be solved."

I did get permission to open up the bug (make it public) so if you want
more info it is probably easiest if you interact directly with the
reporter here:

https://bugzilla.redhat.com/show_bug.cgi?id=1964974

If you don't already have a bugzilla.redhat.com account, creating one
is super easy, you only need to enter your email address and pick a
password.


>> The second backtrace is from:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1964735  (private)
>> https://retrace.fedoraproject.org/faf/reports/38209/ (public)
> 
> This must have a successful tpm_try_get_ops() for ima_tpm_chip
> (map_tpm_chip == tpm_default_chip()).
> 
> Would also be interesting to see the status code, i.e. TPM_STS_0
> register value, but these are completely lacking the warning
> message, and the warning message apparently does not have the
> information printed.
> 
> I'll send a patch that updates the warning, and also retract
> of using WARN() given panic-on-warn is commonly set [*]. It's
> not right thing to do to torn down the machine because of invalid
> status code.
> 
> So, I'll fix that by instead:
> 
>   dev_err_once(&chip->dev, "invalid status: 0x%02x\n", status);
>   dump_stack();
> 
> Should be visible enough to get notified, and provides the important
> stack dump to quickly find possible impairment of tpm_try_get_ops(),
> and also contains the missing status code printout.

Sounds good, thanks.

>> Note there is public bugzilla, with dmesg with the same backtrace
>> (on the same laptop), but then with 5.12.5 here:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1963712
>>
>> There are also 2 interesting comments on the public bugzilla:
>>
>> "updated to linux kernel 5.12.5 performed 
>> sudo shutdown -r now"
>>
>> "I installed Fedora 34 UEFI from USB on a Dell XPS 13 Developer Edition"
>>
>> So it seems this is happening on the "Dell XPS 13 Developer
>> Edition".
>>
>> I've also checked the BIOS versions involved in the 2 different
>> bugs and 1964735 has "BIOS 1.2.5 12/10/2020" where as
>> 1963712 has "BIOS 2.2.0 04/06/2021" so this seems to be
>> independent of the BIOS version.
>>
>> ###
>>
>> Interestingly enough the first backtrace is also happening on a:
>> "Dell Inc. XPS 13 9310/0MRT12, BIOS 2.2.0 04/06/2021"
>>
>> So it seems that at least with 5.12.6 (which has the last 2 fixes)
>> all reports are about the XPS 13 9310. I wonder if there is an
>> issue with the TPM interrupt line on the XPS 13 9310; I've asked the
>> reporters to try adding tpm_tis.interrupts=0 to their kernel commandline.
> 
> This is helpful for sure that these all are happening on matching hardware.

Ack, I'm still waiting to hear back from reporters of the second
backtrace, wrt tpm_tis.interrupts=0.

I've marked a couple of reports of the second backtrace as duplicates of:
https://bugzilla.redhat.com/show_bug.cgi?id=1963712

So all reporters of this are now following this public bug, so if you want
to reach out to them with questions that is probably the easiest way.

Regards,

Hans

