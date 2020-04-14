Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242531A87D6
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502330AbgDNRor (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 13:44:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20281 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502269AbgDNRol (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 13:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586886278;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=eFpvihWvp4gtK9CNYDR6vOir4WNetUr/OAKV/hebSIc=;
        b=E5TdohfumrqXGObb4HOtYZ8waBd3MnhpYkYij7wvxzYazKtM3up4pf9FTPBkRwV8armrXv
        sYTBCihYS+F6o3XptbyubNUSU2swCO60YzIw+Zv5RpHqTx4mgZKAlTo4EWJNaVj+b3P5IA
        1NrMIvgh+xo/5j0eCPqGAzi6C2B1AnA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-uHIINsbqPNGHkqWF6b1ZEw-1; Tue, 14 Apr 2020 13:44:36 -0400
X-MC-Unique: uHIINsbqPNGHkqWF6b1ZEw-1
Received: by mail-qv1-f70.google.com with SMTP id y18so535604qvx.1
        for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2020 10:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=eFpvihWvp4gtK9CNYDR6vOir4WNetUr/OAKV/hebSIc=;
        b=MAnXyQ27/SudrK36MT8Qdav940qRzPvPz3N3beU7WrWHVJpdSHwZCQAv+HTEno9qgM
         utNceJIWsVV6Ul6f7RcsbedPD5LlM/bmA8PM/+uSuIMemklfOXaHWci0AerEb47mBuYs
         hpGdQUWhFYqi+BigDWrH0jaHmFLp6p258BFIUYW/7RMMxYBA8DvHwn496aFCWWAIrYZU
         b/cTczoD1MFkJ6bKc8eZch1X5E8mH+fIjOb7tf8e9NR7+Y/5BDxa+b6Cy9PbblSsleCo
         CCz0rSPLm04lCaBo/FGBg3WZKZYddRtyVlLIar6wYjo/YiIXPNDwLORehGEsEqlu63XH
         7DuQ==
X-Gm-Message-State: AGi0PuYxeqS+mOJk17/IqsF1f0IYNjdelbg92VLOqprl+acSavq1YtCa
        xkk+BuxyAY3HO27ZFLk1gkvftp2yuJ92Ybx3+KG0G32EwW/CPFAj0Afyk0GXAzuSigaifSSXCXo
        ppTMHTmEQA+sdDSPBweSGf/KE8drj
X-Received: by 2002:a37:ad0b:: with SMTP id f11mr21940882qkm.125.1586886275973;
        Tue, 14 Apr 2020 10:44:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypJYfBk2h0H8kc8exxOZkFIy1sLPsElXTf4qLvH7T7gLHtQ4/wiS4m/ec27gQD++W2BOzcWXBg==
X-Received: by 2002:a37:ad0b:: with SMTP id f11mr21940859qkm.125.1586886275728;
        Tue, 14 Apr 2020 10:44:35 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id m11sm10633233qkg.130.2020.04.14.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:44:34 -0700 (PDT)
Date:   Tue, 14 Apr 2020 10:44:33 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_core: Disable broken IRQ handling code
Message-ID: <20200414174433.r54hawtqxlgo3d7y@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20200409211044.21625-1-hdegoede@redhat.com>
 <20200410163826.GM11886@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200410163826.GM11886@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Apr 10 20, Jason Gunthorpe wrote:
>On Thu, Apr 09, 2020 at 11:10:44PM +0200, Hans de Goede wrote:
>> Since commit dda8b2af395b ("tpm: Revert "tpm_tis_core: Set
>> TPM_CHIP_FLAG_IRQ before probing for interrupts"") we no longer set
>> the TPM_CHIP_FLAG_IRQ ever.
>
>This all used to work..

IIRC this goes all the way back to 570a36097f30 ("tpm: drop 'irq' from struct tpm_vendor_specific")
when the flag was added. There was never anything initially setting it in the tpm_tis code.
There were checks added, but the only place it got set was where it did the interrupt test in
tpm_tis_send, and it can only get down to that code if the flag is set. Stefan's patch was enabling
the flag, but with the flag enabled some systems were seeing interrupt storms. I believe it has
been seen with both the t490 and an internal system that Dan Williams was working on at Intel.
Without access to hw seeing the problem the decision was to revert Stefan's patches while
we try to figure out the issues.

>
>> So the whole IRQ probing code is not useful, worse we rely on the
>> IRQ-test path of tpm_tis_send() to call disable_interrupts() if
>> interrupts do not work, but that path never gets entered because we
>> never set the TPM_CHIP_FLAG_IRQ.
>
>The IRQ probing code should be deleted.
>
>> On some systems, e.g. the Lenovo X1 8th gen,  the interrupt we try
>> to use and never free creates an interrupt storm followed by
>> an "irq XX: nobody cared" oops.
>
>Is this related to probing?
>
>Jason
>

