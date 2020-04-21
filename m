Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888511B3126
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 22:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDUUZy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Apr 2020 16:25:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45180 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUUZx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Apr 2020 16:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587500751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BNhmHt4RMHenaofqoWMv475WdAp14sVTXvWnABShIgI=;
        b=OT518kKH/0Gbym1/jMa2SC1w+lcH8Mjg0nfZG7UFCAnGI1RqMG3cCvsYXkxr/F2Jl5KKD9
        +6iljwAJBfRB7xVz2DhlH/m9jqlKxVjYzU+JKN8zt6L0yOCdgQBN8ysZln54s4fJCoYg/t
        OP88Xio04EFNXhVMXSTvsCVG4+e5HUI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-38uTTPYANmWpQi9plW7ffQ-1; Tue, 21 Apr 2020 16:25:45 -0400
X-MC-Unique: 38uTTPYANmWpQi9plW7ffQ-1
Received: by mail-wm1-f72.google.com with SMTP id h184so1973071wmf.5
        for <linux-integrity@vger.kernel.org>; Tue, 21 Apr 2020 13:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BNhmHt4RMHenaofqoWMv475WdAp14sVTXvWnABShIgI=;
        b=extsb87VNRkaHFST/BBigOvRKz+05PcS5sNrUNtRE8YiCjbH37GiV+XZjA4LHz/xBE
         D9Vx13hq9w5luFxSAzxdfp1X2D1yyC0gkd0to4o1RF/bStVWwdEcoDZpERsi/MRDnf7A
         cLlQgdfzceH1i27oDOYWYQRYDaqDq6n4Gn9GqbUxtuytm6qUMv2Ii0skAlaMqfisTxqU
         DbgsfTY+yBclNWRuXB2isY6pPBG+i94D53XlCbly6Aui/dtkJhRRzKkaXu3LYQUkye16
         8JAnGEpiazdvH8yStvh6V0wvWxjxrXMMXlTBLmZk2qb0r0sHHnNQbjQCjdBdB7roo0CI
         SL9g==
X-Gm-Message-State: AGi0Pua2WDsj9zflJt6pcmTuvZLoduzP3SJddsmJ0YkmeqqhLjXIxiRt
        A39lmnCQ02wA5GJY1LT4+Am7SIXGZ/w3d/KDEWQtIcy4NqEevD7bkMLbIhGOX7zg5ie2ZYc47Wc
        sBC5CFbcuCSJUQK3WXSWCAJGxWtJN
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr7105636wmc.121.1587500744439;
        Tue, 21 Apr 2020 13:25:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypKEl1/LaKqe5TKbNDkzBHlY5TT0KgVkGRX8P7aeJwKLOlLKLxxk/V4PeDMiOLVOh9I8f0byQQ==
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr7105610wmc.121.1587500744175;
        Tue, 21 Apr 2020 13:25:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id 17sm4730210wmo.2.2020.04.21.13.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 13:25:43 -0700 (PDT)
Subject: Re: [PATCH v2] tpm/tpm_tis: Free IRQ if probing fails
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200416160751.180791-1-jarkko.sakkinen@linux.intel.com>
 <fa25cd78-2535-d26d-dd66-d64111af857a@redhat.com>
 <20200421195403.GA46589@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2692261d-5395-b03c-2a6f-1694212cd2d4@redhat.com>
Date:   Tue, 21 Apr 2020 22:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421195403.GA46589@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 4/21/20 9:54 PM, Jarkko Sakkinen wrote:
> On Tue, Apr 21, 2020 at 03:23:19PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 4/16/20 6:07 PM, Jarkko Sakkinen wrote:
>>> Call disable_interrupts() if we have to revert to polling in order not to
>>> unnecessarily reserve the IRQ for the life-cycle of the driver.
>>>
>>> Cc: stable@vger.kernel.org # 4.5.x
>>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>>> Fixes: e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
>>> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>
>> I can confirm that this fixes the "irq 31 nobody cared" oops for me:
>>
>> Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> Hi, thanks a lot! Unfortunately I already put this out given the
> criticality of the issue:
> 
> https://lkml.org/lkml/2020/4/20/1544
> 
> Sincere apologies that I couldn't include your tested-by

No problem.

> but the most
> important thing is to know that it works now.

Agreed.

Regards,

Hans

