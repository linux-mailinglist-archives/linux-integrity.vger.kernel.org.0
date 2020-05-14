Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D171D306A
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgENM4L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 08:56:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45888 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENM4L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 08:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589460969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TAmoezoC05P96DOudxLb1/r1uRT/iFGquaiotKnIECE=;
        b=YXN9DYoc3Tyssm7IzBSAu5+/3hALfBwPOV2Zat+tKe6cRmpWK/jwrGdGi5J+49G/yCWc3P
        Dr9XA4ppz7JyKbAdUuz8HMx/GBcW3RLoplv0YE4lX/TqLymEQH9mt9abt4OaItPvcXP9NJ
        bb27VpNfsbVxdbcM7gLBKNNmqfky6Jw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-3N0pAP-zPmyNNDKOXKhB9Q-1; Thu, 14 May 2020 08:56:07 -0400
X-MC-Unique: 3N0pAP-zPmyNNDKOXKhB9Q-1
Received: by mail-wr1-f72.google.com with SMTP id p2so1545573wrm.6
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 05:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TAmoezoC05P96DOudxLb1/r1uRT/iFGquaiotKnIECE=;
        b=ob9yn5XaT3lFBbrQQGuWa1HoT+Tvhh5ZqlztN9S6W6Wr4dkeeJ0ap5Kz5dTMxP1XFO
         f9mjpQST5h423f+//X7BrdlE3tro1pb6NOx/0ClJUcAP22aNcl0J9E0SMs7sduL8iwRq
         EzFXTlaI262/Zm9ewV82BFBgAdfa+OuocQr1mbR5H9AiMd0pq/NOZGW0MGPLfxzyqw+j
         Zz40P8GK5mvV2+ofFoZPOp2jexxUeQETjY5lregGO8MZ0SPuXqu/9Qy99JI1vy0QicQy
         1d1ka6CSNNbxMsogmPwNmW5zdaG6gNuPS3HnAmq6CPyoll41PNKs0LPwCa/17yWdQWdm
         k1Rg==
X-Gm-Message-State: AOAM530DyxLLUdi/VQPcQhnsVbN75u0XE1va9ffhXAUaVrmJIAiEalwk
        hrPVzSQCJWnOjksUkB7IT1x/LpRvu+/gm6JDd9xoUFEp6/O6y8AUKpqL3Eb5bB5O/2Fl9u6X3yH
        c/tcD9TRrqg9fIj9YRpsC78iOwmGb
X-Received: by 2002:a1c:46c1:: with SMTP id t184mr5712294wma.185.1589460965733;
        Thu, 14 May 2020 05:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjXbUyLQuuOWL+JOQUmn3G1AdsfCYpSP0KN4LxvpraQzEbKZ4xumuN9+gobLqXch7Q2O3gmg==
X-Received: by 2002:a1c:46c1:: with SMTP id t184mr5712279wma.185.1589460965512;
        Thu, 14 May 2020 05:56:05 -0700 (PDT)
Received: from ?IPv6:2a01:c50f:ab80:6700:527f:85b3:5615:ff0b? ([2a01:c50f:ab80:6700:527f:85b3:5615:ff0b])
        by smtp.gmail.com with ESMTPSA id x17sm3812412wrp.71.2020.05.14.05.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 05:56:04 -0700 (PDT)
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?UTF-8?Q?Lo=c3=afc_Yhuel?= <loic.yhuel@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
 <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
 <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
 <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
 <29fb28c4-9642-0265-a926-455377066b75@redhat.com>
 <CAMj1kXHFKajuvd5KkrQTozebKzaO1LaMQdd37unLs_dGR0UwVg@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <789b40ad-3017-b2cc-df15-d2739787d05e@redhat.com>
Date:   Thu, 14 May 2020 14:56:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHFKajuvd5KkrQTozebKzaO1LaMQdd37unLs_dGR0UwVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Ard,

On 5/14/20 2:28 PM, Ard Biesheuvel wrote:
> On Thu, 14 May 2020 at 13:33, Javier Martinez Canillas

[snip]

>>
>> The Final Events Table contains the logs for any events that are triggered
>> by ExitBootServices().
> 
> This is inaccurate afaik. The final events table contains all events
> that were logged since the first call to Tcg2::GetEventLog()
> 

Yes, you are correct. After the first call to GetEventLog(), all events
are logged in both the event log and the Final Events Table IIUC.

But what I tried to say is that only the Final Events Table can be used to
obtain the logs for the events triggered by ExitBootServices(). I'll try
to make it more clear if I post this as a proper patch.

I still don't know if something like that would be acceptable or if we
should just consider a bug if a firmware doesn't conform with the spec.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

