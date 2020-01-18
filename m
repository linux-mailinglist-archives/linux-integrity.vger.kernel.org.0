Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A25141911
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2020 20:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgARTOW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 18 Jan 2020 14:14:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726658AbgARTOW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 18 Jan 2020 14:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579374861;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Y7e06Snt4Pk3YriskPs3p2nlk9RIrcN4IKw1nlL+RLw=;
        b=PjXtPhbDU6XkUsgroiAVl3BIXBLWJnPBZdonNSVPeBiIGorzWo5J7mF0bPHQkKibQP/0AA
        RAtD7RhQ8Pkhpw2hr1jovaoX3z1QTLkNE11WdCSsFb+tph5Z9HgB1PaXT5LwXTn1nFY2Xl
        bDuS9CPS6RFBscapcy0rWEtskxDBmtI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-opQhT2U8OOK-C47RrU__bA-1; Sat, 18 Jan 2020 14:14:18 -0500
X-MC-Unique: opQhT2U8OOK-C47RrU__bA-1
Received: by mail-qv1-f70.google.com with SMTP id g15so17921741qvk.11
        for <linux-integrity@vger.kernel.org>; Sat, 18 Jan 2020 11:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=Y7e06Snt4Pk3YriskPs3p2nlk9RIrcN4IKw1nlL+RLw=;
        b=JwSb3H517UrkAyc6KjrhVc9so4MZ99IYX2OltILirzMF7B0EriKgShU/kL/+a9NLCX
         6/zLHTBW9IjVGs0RoPGoV6Hqegwh6s+qvKa053WZ4OWcTxvISgvWBWZM+QMEsRqUkmli
         mW0cqNUv3vLqiL9wpKxOIQYC1nG5ACpuD8mN8RpCmTqxrh7HC4zXWBlDxERrRk+7rCAu
         iJ0cPZBVcNRFiQUmPMam5G9CjUuFbm16ys1z/kIosidcXlhheL3N1xhqJ5y7nFC57nfE
         YUWxWuKrwifaBefzg7UGIrQ8aquI/yUI+mBHS/s7nx85/t33MdEynNhg/uaD9jP7iTH5
         HDIA==
X-Gm-Message-State: APjAAAVGrkoXoJW8zAw4Cp46DTNpSIThcEXgPzyL62jszWwNQztRWYl4
        bg7tfY56S3ymVOpr8YKed2et3+rtaZOPJZgI4segOnv48zhmwNKqe1btxl8cml7w9hYRS2G4rKb
        0MUF2AaNHWEYgsbD8oXYBVcmmaZpp
X-Received: by 2002:ad4:5525:: with SMTP id ba5mr9508784qvb.117.1579374857354;
        Sat, 18 Jan 2020 11:14:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEqDJ6C2pDEQep3X37p9hEUDZLTwH9ys2w+CuYGQyWf9fCM1VuMRetcqCzptvZymkp/AvL+Q==
X-Received: by 2002:ad4:5525:: with SMTP id ba5mr9508772qvb.117.1579374857074;
        Sat, 18 Jan 2020 11:14:17 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id j15sm13530760qki.47.2020.01.18.11.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 11:14:16 -0800 (PST)
Date:   Sat, 18 Jan 2020 12:14:14 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: ima pcr question
Message-ID: <20200118191414.m4gqggwfavkjlef4@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200114000602.h5k5rr2k6zl3dlts@cantor>
 <1578964659.5796.7.camel@linux.ibm.com>
 <20200117222920.2d42m3ahxznl64em@cantor>
 <1579302011.13499.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1579302011.13499.9.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jan 17 20, James Bottomley wrote:
>On Fri, 2020-01-17 at 15:29 -0700, Jerry Snitselaar wrote:
>> On Mon Jan 13 20, Mimi Zohar wrote:
>> > On Mon, 2020-01-13 at 17:06 -0700, Jerry Snitselaar wrote:
>> > > We had a report of messages from ima saying "Error communicating
>> > > with
>> > > TPM".  Looking into it a bit, it looks like with some Dell
>> > > systems
>> > > (possibly others as well) in the bios they can set the hash
>> > > algorithm
>> > > being used. In this case with that set to sha256 the messages
>> > > appear. Flipping the system to using sha1 makes them disappear.
>> > > Looking at the ima code, ima_calc_boot_aggregate_tfm hard codes
>> > > using
>> > > sha1. Should that be changed to use whatever the default is in
>> > > the
>> > > config, or possibly find out from the tpm what algorithm is being
>> > > used?
>> >
>> > The ima-ng template contains two digests.  The first digest is the
>> > value being extended into the TPM, while the second digest is
>> > either
>> > the boot aggregate or file data hash.  It sounds like the problem
>> > is
>> > with the first digest.  Changing the boot-aggregate to use sha256
>> > might be a good idea, but probably won't fix the problem.
>> >
>> > Mimi
>> >
>>
>> The error message is coming from ima_pcrread, and the tpm_digest that
>> gets passed
>> by ima_calc_boot_aggregate_tfm to ima_pcrread is declared:
>>
>> 	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0}
>> };
>>
>> According to Dell their default BIOS setting is to use sha256. What
>> they see with that
>> setting is:
>>
>> [ 5.475036] ima: Error Communicating to TPM chip
>> [ 5.475083] tsc: Refined TSC clocksource calibration: 3311.999 MHz
>> [ 5.475092] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
>> 0x2fbd936b72f, max_idle_ns: 440795283163 ns
>> [ 5.475118] ima: Error Communicating to TPM chip
>> [ 5.475165] ima: Error Communicating to TPM chip
>> [ 5.475235] clocksource: Switched to clocksource tsc
>> [ 5.475266] ima: Error Communicating to TPM chip
>> [ 5.475311] ima: Error Communicating to TPM chip
>> [ 5.475341] ima: Error Communicating to TPM chip
>> [ 5.475371] ima: Error Communicating to TPM chip
>> [ 5.475402] ima: Error Communicating to TPM chip
>> [ 5.489049] ima: No architecture policies found
>
>The implication seems to be that on a DELL setting the bios default to
>sha256 turns off the TPM's sha1 pcr banks ... is that the case?
>
>tssgetcapability -cap 5
>
>should confirm or deny this.
>
>James
>

I believe so, I'm waiting to get access to the system here to double check.
Before with the intel stack, tpm2_pcrlist -s would return both sha1 and sha256,
but the plain tpm2_pcrlist command would show only banks for one or the other
depending on which setting was in the bios. For the other it would just print
out the algorithm and nothing else.

I should be able to run the tss2 command later today.

Regards,
Jerry

