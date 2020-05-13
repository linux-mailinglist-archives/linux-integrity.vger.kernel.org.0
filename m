Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7BB1D1CBD
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2020 19:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbgEMR7i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 13:59:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42517 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733070AbgEMR7h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 13:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589392777;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=e6FA0WrIsTcMll1rrS/V4eDTsjXkqs5JYsxdv6Dzgts=;
        b=TiZrHTdO9McdQxViI4NUu2eaeLPtgxRbUPzNegGN2uV/a5UK/Zs4jDwZXbNR6ucsylDz8k
        4AKXBVvgUbUh313+jMLChAqxzAqfGBwEHfUKcGGVKL/wPJr8DVZdmqkuyxrtzkp1UBL8ei
        s9z9sB7rUzz4zjjOumCAkC5MN6EbO1U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-XOetYAlTMdmhF-xSngsZng-1; Wed, 13 May 2020 13:59:34 -0400
X-MC-Unique: XOetYAlTMdmhF-xSngsZng-1
Received: by mail-qt1-f199.google.com with SMTP id d35so431078qtc.20
        for <linux-integrity@vger.kernel.org>; Wed, 13 May 2020 10:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=e6FA0WrIsTcMll1rrS/V4eDTsjXkqs5JYsxdv6Dzgts=;
        b=DAv2fXBpG07y2GQIJ2gBQTixGX1dWcs3lTo7B4nbWIwTeComobWYl0GBgE/TgFzX5u
         dnt47VyT8y7Xd1VXO2Xk3nBIceQyYktLpTvBqQjxpiqYFVDjP0EnDcRMzJLRky+o7viR
         jEsfcRZlTKicodEulLmqHrKkHI9B9jqIPrzpiE53m1Tib0zazkymmsu62O4tibU8MBiK
         LWZZVs/f5MRsz936lWuRyXA0O6p83oOBOuYb9ezWjtcvy9zoRb3E1mMb01wUY1v46Po0
         nRxVhOmczPtmPzG/GGZaLpHZLQ4vc/MwZ0qwDNaOIco4Z7oIlbFcFuOTUZIj/EiScLPm
         f2pw==
X-Gm-Message-State: AOAM5314ybDLt8vD21e6QA+TpYkMu8YOnrYm6bAIIQWVijfxQ98uIR85
        Gd+NC2wvBcQE2B2gxq8/ns/or+99bo6xTPQcvzsoratl77NlGd/NR4e/frciemV6mcfKNcHQFiR
        ta35R0LQulaqaRzYoFx8g9+02aBmy
X-Received: by 2002:a37:d85:: with SMTP id 127mr911545qkn.205.1589392774103;
        Wed, 13 May 2020 10:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvav37qbGcKf4apGEaWgFyLHRpmxNwQi8Slj32UOEimK2Qii5IbMjk3HEyRYNcSP1IpxMceQ==
X-Received: by 2002:a37:d85:: with SMTP id 127mr911526qkn.205.1589392773879;
        Wed, 13 May 2020 10:59:33 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id a194sm472778qkb.21.2020.05.13.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 10:59:33 -0700 (PDT)
Date:   Wed, 13 May 2020 10:59:31 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Subject: Re: Disparity in tpm pcr5 value
Message-ID: <20200513175931.xte33asq5nskjflh@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200505222731.whnkisag7tlrbcie@cantor>
 <20200513171052.GD25598@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200513171052.GD25598@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 13 20, Jarkko Sakkinen wrote:
>On Tue, May 05, 2020 at 03:27:31PM -0700, Jerry Snitselaar wrote:
>> On some systems we've had reports of the value of pcr5 doesn't match the digests in the tpm event log.
>> It looks like I'm able to reproduce here with 5.7-rc4 on a dell system using this parser:
>>
>> https://github.com/ValdikSS/binary_bios_measurements_parser
>>
>> Any thoughts on where to start digging? Is there another tool I should use to parse this?
>
>ExitBootServices() extends PCR5. My 1st intuition would be to look at
>final event table handling, which I documented here:
>
>https://www.kernel.org/doc/Documentation/security/tpm/tpm_event_log.rst
>
>It is somewhat quirky how it nees to be managed (had to read that
>myself to recall how it went).
>
>/Jarkko
>

Yes, my guess is the problem is that when the bios is set to use sha1 it
does not present a final events log to the os.

