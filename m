Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F288C15F85F
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2020 22:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgBNVCP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Feb 2020 16:02:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48058 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBNVCO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Feb 2020 16:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581714133;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=lKWveUCBRJQQDJHy/LqEzWg+XCVRMTZjzGNC5maciso=;
        b=fpGANzG/1g00YwrtgW/UUuCuoWg7d9sm1yIEVKNnoq+VrpcL/bl7hRM5eLnPlkk+OXNNzd
        RpvoKR6N1WM6KMWSfnAaqPBbAQ8d+wsq3bb0gJR1ZGGNW+nXtywNBmewKqm9maJ1IfcsT/
        +sD4zFNysEW4zyUl91TSUXj2aMUU/Ck=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-EDp1-ZpyOtW_h1LVKopJsw-1; Fri, 14 Feb 2020 16:02:07 -0500
X-MC-Unique: EDp1-ZpyOtW_h1LVKopJsw-1
Received: by mail-qv1-f71.google.com with SMTP id n11so6527244qvp.15
        for <linux-integrity@vger.kernel.org>; Fri, 14 Feb 2020 13:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=lKWveUCBRJQQDJHy/LqEzWg+XCVRMTZjzGNC5maciso=;
        b=ZaclUdy8Sv1Jejeff/R6VJyexPPZ60Vg2kPPCQzgHRhLc3hLiMh0cFq3v+WkgAM8ci
         QoiQEByL7ch9aV0HVn9Ewklx2awaFIg2q14tXhWF/h3NOFoBVtC8Co5nmyIbjpktBwKy
         7nbvih0bfXN4xFHhv7p/pdoD6nIx74WoKXGrw0hXF+rTZlayVdKqfSWnBlAf2bDng5Xr
         ljeh2bio93gNYEExbj27T9kv70X0tV3/soDpSvwMxI8iAOdZxgHyG9/g/EK/1KzQ+dsn
         DZy27DkavkX7Z4QEJD3eA9PyI90/hHVczEAiER4+Zkl2/mLURCA7Hnc7/lZPAudM3SCp
         rALg==
X-Gm-Message-State: APjAAAUUqQfvp6ZiGCGEl6eSG51c49x5U2QClIT/iSSUtqM25UuWprOl
        wcs61YUeyUw4hSCwoqt7a2L9q97OWnQVBGHsjNYevpsZD+WGHeaThBrqLHk2GT48TeX7zY271qz
        ubLeqles+m951x5QYqQTTaKUJ3Ett
X-Received: by 2002:ac8:1184:: with SMTP id d4mr4245069qtj.104.1581714126334;
        Fri, 14 Feb 2020 13:02:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzoFUR9kN8JGLUJZKtUX5Xr9kobJMMu/pCttPv7ZVlKN8usGg6J4Dk6xLoUjDrdCn9ouLGZdg==
X-Received: by 2002:ac8:1184:: with SMTP id d4mr4245039qtj.104.1581714125968;
        Fri, 14 Feb 2020 13:02:05 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id r6sm3890369qtm.63.2020.02.14.13.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:02:05 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:02:03 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Alex Guzman <alex@guzman.io>, linux-integrity@vger.kernel.org
Subject: Re: Debugging errors with Dell XPS 9560 TPM
Message-ID: <20200214210203.dgzhkrvagiozezfi@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <CAJ7-PMaLw_H8Fc1tyoT95f5EWpS3nvJt1Wx9=xpuiSotJ2h9VA@mail.gmail.com>
 <CAJ7-PMbJ5fiQAj-5QAzAcFW0eMNkxpQSs=r_wUEfED33XZAPDg@mail.gmail.com>
 <1581712162.16860.8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1581712162.16860.8.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Feb 14 20, James Bottomley wrote:
>On Fri, 2020-02-14 at 10:32 -0800, Alex Guzman wrote:
>> Looks like someone had a look on the bug tracker
>> (https://bugzilla.kernel.org/show_bug.cgi?id=206275#c6)
>> and they figure it's definitely a regression in the kernel and should
>> be reverted or rectified. They advised me to come ping here once
>> more.
>
>Reading the bugzilla, I don't get *what* needs to be reverted.  The
>commit 4d6ebc4c4950595414722dfadd0b361f5a05d37e isn't present in
>upstream, so what kernel is it present in, or what is the full commit
>message so we can find the upstream commit?
>
>James
>
>
>> - Alex
>>
>> On Sat, Feb 1, 2020 at 4:19 PM Alex Guzman <alex@guzman.io> wrote:
>> >
>> > Hey there! I reported a bug on the bug tracker a bit ago but
>> > haven't
>> > seen any movement, so I figured I'd drop in here. My XPS 9560 has
>> > been
>> > having issues with its TPM, and all commands will fail with error 1
>> > when operating on the TPM device. I managed to bisect it back to
>> > commit 4d6ebc4c4950595414722dfadd0b361f5a05d37e (tpm: fix invalid
>> > locking in NONBLOCKING mode) though it began failing with error 14
>> > (bad address) at that point.
>> >
>> > I reported the bug at
>> > https://bugzilla.kernel.org/show_bug.cgi?id=206275 and attached
>> > some
>> > dmesg logs from boot there. Does anyone have any suggestions for
>> > additional debugging or such to figure out what's happening here?
>> >
>> > - Alex
>>
>>
>

d23d12484307 | 2019-12-17 | tpm: fix invalid locking in NONBLOCKING mode (Tadeusz Struk)

There is a commit that is a fix to this commit:

a430e67d9a2c | 2020-01-08 | tpm: Handle negative priv->response_len in tpm_common_read() (Tadeusz Struk)

