Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCF31CA562
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2020 09:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHHpJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 May 2020 03:45:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35278 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbgEHHpJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 May 2020 03:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588923907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCtLxG67mUZWCTWzvOeSx7soa6kbGPfHfXV0+mkhsHs=;
        b=C+GbVHO1c62y26DnWPD5ZFSFNbeXU2bheTP+LCIZZrcpDsiONlKa0vVZtkluY6Es+fcMYh
        djG4B8l4x2wdI97tN6uOXz0sBmbrHI3IR0e8VqR93QRpD9WrTNXmqTrXDgoDVWQZNVGY2W
        zipoS6FHM6nN8t48eFLYkW10eJBMbv4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-zELFPsEiOWipwdMvXONlkg-1; Fri, 08 May 2020 03:45:06 -0400
X-MC-Unique: zELFPsEiOWipwdMvXONlkg-1
Received: by mail-wr1-f71.google.com with SMTP id p8so495058wrj.5
        for <linux-integrity@vger.kernel.org>; Fri, 08 May 2020 00:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JCtLxG67mUZWCTWzvOeSx7soa6kbGPfHfXV0+mkhsHs=;
        b=rI0u7QFLvEGfNjt5abYr0/cpzxxtKaY38h5iJZJ75yqTn5ywtjFMvmnK4zLK3RhlBA
         aGSBWS8XOqOiP4hRt0LjAAS91abYQwLJhRESvYhQF8arpyGZT9IpAP+3V1GW2BjrZQfD
         dpw5j1wb0JVGlCUQxe7n3TwA4XLRVMqNedVRLY3cxRZ4W9WmSSZkwTKt4U+Z4oioFaUb
         arsmPWBR4NJQHk5307B64p7LQsuN/gQ6Yzl3F959+xMg8FP4IeMOPrslaOTL389DKXTa
         7VGsBWl5ozV/aXIRB3OhhFNOKHQDygpZRO6fPS3969h6/p7F53SgaQf6n8qduCSbTVWj
         sduw==
X-Gm-Message-State: AGi0PuZy3rqbKy0nKJ6wVLN1LdH+91sEOLT4pj8OtlU4JPOFiQA8WjxE
        6u3AKLBMcqkhLb5yskHXQG+jBh+i6OG4zZqekJWpOl/bnEbs5vt6TmBizbnTqb48YZhTMOPxWCx
        50O9YCr+t05/BN8KPQeYlfjDYtmDl
X-Received: by 2002:a5d:460d:: with SMTP id t13mr1438802wrq.280.1588923904762;
        Fri, 08 May 2020 00:45:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypI6clO3N/57wEu8V/ifyIdYk/MQ6WoB2HVVGpNyeRiUvxmDDuOG6OZrpAqSuU6XB6KhiaaXNQ==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr1438778wrq.280.1588923904566;
        Fri, 08 May 2020 00:45:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r20sm11223257wmh.26.2020.05.08.00.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 00:45:03 -0700 (PDT)
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
To:     Dan Williams <dan.j.williams@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410210652.GA16905@linux.intel.com>
 <b8865c10-3733-7179-c524-afa4c4386de6@redhat.com>
 <20200507141707.pltaa6dxkqkopjoa@cantor>
 <CAPcyv4j4-GRkwdSHNVUGLzehBVC6hUR4pNeez_=E6FKjS_DmNQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3f9a75c7-332a-3ad6-e69f-3ee1115d63af@redhat.com>
Date:   Fri, 8 May 2020 09:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4j4-GRkwdSHNVUGLzehBVC6hUR4pNeez_=E6FKjS_DmNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 5/7/20 11:51 PM, Dan Williams wrote:
<snip>

> My concern with a blacklist is that the existing tpm_tis module
> parameter to disable interrupts, IIRC, did not help mitigate this
> problem. So I would think that if there is a blackilst it should at
> least be amenable by module parameter for new platforms, or that
> specifying "interrupts=0" to tpm_tis.ko behaves identically to the
> device being placed on the list.

Are you sure that disabling the interrupt through the kernel commandline
did not help on the T490? The reverted patches all have to do with
the irq-probing / irq-handling and if tpm_tis_core_init gets passed
an irq of -1 then all of that should be skipped?

Regards,

Hans

