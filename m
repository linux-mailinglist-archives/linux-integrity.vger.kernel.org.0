Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2C141A71
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jan 2020 00:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgARXUK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 18 Jan 2020 18:20:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26950 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727008AbgARXUK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 18 Jan 2020 18:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579389608;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=m3iDO3zfSoIkyAAMFkXVyU5OqJ8aBeRykhz9uDEJzf0=;
        b=hzsaqzq71BeJ+2inDk0ULlQNcTI4AtP+koRYXhYpXj4KdeGBDEQ003btzH2nRIAqGPCCH+
        xgEl3LGZEyPus78cX/3W+YLRvQ0DkuSGyodscmrn9Eh7TMCRh7A+qYrUMNvy/3W38OecZB
        sRutMmIFtOjMxhYpqoXQX88/i9vcnMw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-__oOwfSjMN2MUT36yszygQ-1; Sat, 18 Jan 2020 18:20:07 -0500
X-MC-Unique: __oOwfSjMN2MUT36yszygQ-1
Received: by mail-qv1-f72.google.com with SMTP id v3so18223886qvm.2
        for <linux-integrity@vger.kernel.org>; Sat, 18 Jan 2020 15:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=m3iDO3zfSoIkyAAMFkXVyU5OqJ8aBeRykhz9uDEJzf0=;
        b=XtMy/IjATfOhmXormz80bfjv/wxp82bmNXSQm92QpxbfsdPM2k/Q7lazKrGy1/ppLU
         FEDRq1VPA0JY/g1n4O+pM1TbilCzXUBuHFjM83MxL1qbENAggHChni8phjw6xwNsal+q
         E6jIgwr4cvQ/oyweWBeBb7oR3jlOwAdUNrIMWHnbTTC94U4Y2MisbfX9hz4WyYGnThPc
         oeH3UQ7J7xqbIZ86z84TbNR8AbmtvUOb5qPcZsYc/GgjHonQo13Gk6rEmRGau6NV6thx
         7rLsb00IUFAn+w4A/aHnwqQ7y91QOzXsXDRtp79arITrdNirnhiOFdoxwUXtr8GRvaoi
         oXLw==
X-Gm-Message-State: APjAAAXF/C/LVi6bibsrpO+vjr4SNYQEfRrJI8iB7rtjbfOA28hQJAqb
        Rx4uyQZVHupmjjqSew/X/SIPjUWS54DJuCREPYm/970pEcmhatXGASf+PDe2kr51YW1NN9oSeVz
        DZfeGHLntpeKfug3AhyID+7JHkT+t
X-Received: by 2002:a37:bcc7:: with SMTP id m190mr40652833qkf.103.1579389606869;
        Sat, 18 Jan 2020 15:20:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzP2jPeM0EnIMYwmCF8dkGaHKOVJpxNcw7jzC5gMDUDcLQKdemP/Rd0w7pdFAk2glLn/ctY1w==
X-Received: by 2002:a37:bcc7:: with SMTP id m190mr40652820qkf.103.1579389606596;
        Sat, 18 Jan 2020 15:20:06 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l49sm15460929qtk.7.2020.01.18.15.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 15:20:05 -0800 (PST)
Date:   Sat, 18 Jan 2020 16:20:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: ima pcr question
Message-ID: <20200118232004.lt2u2u6ryitrkaa2@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200114000602.h5k5rr2k6zl3dlts@cantor>
 <1578964659.5796.7.camel@linux.ibm.com>
 <20200117222920.2d42m3ahxznl64em@cantor>
 <1579302011.13499.9.camel@HansenPartnership.com>
 <20200118191414.m4gqggwfavkjlef4@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200118191414.m4gqggwfavkjlef4@cantor>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat Jan 18 20, Jerry Snitselaar wrote:
>On Fri Jan 17 20, James Bottomley wrote:
>>On Fri, 2020-01-17 at 15:29 -0700, Jerry Snitselaar wrote:
>>>On Mon Jan 13 20, Mimi Zohar wrote:
>>>> On Mon, 2020-01-13 at 17:06 -0700, Jerry Snitselaar wrote:
>>>> > We had a report of messages from ima saying "Error communicating
>>>> > with
>>>> > TPM".  Looking into it a bit, it looks like with some Dell
>>>> > systems
>>>> > (possibly others as well) in the bios they can set the hash
>>>> > algorithm
>>>> > being used. In this case with that set to sha256 the messages
>>>> > appear. Flipping the system to using sha1 makes them disappear.
>>>> > Looking at the ima code, ima_calc_boot_aggregate_tfm hard codes
>>>> > using
>>>> > sha1. Should that be changed to use whatever the default is in
>>>> > the
>>>> > config, or possibly find out from the tpm what algorithm is being
>>>> > used?
>>>>
>>>> The ima-ng template contains two digests.  The first digest is the
>>>> value being extended into the TPM, while the second digest is
>>>> either
>>>> the boot aggregate or file data hash.  It sounds like the problem
>>>> is
>>>> with the first digest.  Changing the boot-aggregate to use sha256
>>>> might be a good idea, but probably won't fix the problem.
>>>>
>>>> Mimi
>>>>
>>>
>>>The error message is coming from ima_pcrread, and the tpm_digest that
>>>gets passed
>>>by ima_calc_boot_aggregate_tfm to ima_pcrread is declared:
>>>
>>>	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0}
>>>};
>>>
>>>According to Dell their default BIOS setting is to use sha256. What
>>>they see with that
>>>setting is:
>>>
>>>[ 5.475036] ima: Error Communicating to TPM chip
>>>[ 5.475083] tsc: Refined TSC clocksource calibration: 3311.999 MHz
>>>[ 5.475092] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
>>>0x2fbd936b72f, max_idle_ns: 440795283163 ns
>>>[ 5.475118] ima: Error Communicating to TPM chip
>>>[ 5.475165] ima: Error Communicating to TPM chip
>>>[ 5.475235] clocksource: Switched to clocksource tsc
>>>[ 5.475266] ima: Error Communicating to TPM chip
>>>[ 5.475311] ima: Error Communicating to TPM chip
>>>[ 5.475341] ima: Error Communicating to TPM chip
>>>[ 5.475371] ima: Error Communicating to TPM chip
>>>[ 5.475402] ima: Error Communicating to TPM chip
>>>[ 5.489049] ima: No architecture policies found
>>
>>The implication seems to be that on a DELL setting the bios default to
>>sha256 turns off the TPM's sha1 pcr banks ... is that the case?
>>
>>tssgetcapability -cap 5
>>
>>should confirm or deny this.
>>
>>James
>>
>
>I believe so, I'm waiting to get access to the system here to double check.
>Before with the intel stack, tpm2_pcrlist -s would return both sha1 and sha256,
>but the plain tpm2_pcrlist command would show only banks for one or the other
>depending on which setting was in the bios. For the other it would just print
>out the algorithm and nothing else.
>
>I should be able to run the tss2 command later today.
>
>Regards,
>Jerry

with sha1 selected:

[root@dell-per830-01 ~]# tssgetcapability -cap 5
2 PCR selections
     hash TPM_ALG_SHA1
     TPMS_PCR_SELECTION length 3
     ff ff ff 
     hash TPM_ALG_SHA256
     TPMS_PCR_SELECTION length 3
     00 00 00 

with sha256 selected:

[root@dell-per830-01 ~]# tssgetcapability -cap 5
2 PCR selections
     hash TPM_ALG_SHA1
     TPMS_PCR_SELECTION length 3
     00 00 00 
     hash TPM_ALG_SHA256
     TPMS_PCR_SELECTION length 3
     ff ff ff 

