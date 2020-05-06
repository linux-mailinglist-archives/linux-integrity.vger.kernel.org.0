Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40091C7421
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2020 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgEFPUk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 May 2020 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbgEFPUj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 May 2020 11:20:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E0BC061A0F;
        Wed,  6 May 2020 08:20:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x17so2674915wrt.5;
        Wed, 06 May 2020 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QhrpUsD5ZNq874T4rNnffIMvqkskOMzNbsR1E6VBIeA=;
        b=cFfehZzGS3n7CWK8O1uNboha7loFK3c0+QdMWe7LPnCpVeLb0ZxGlU9/U3+A+RJKlC
         TnaJXouxBMFC8vy4ntN+TEIh+KnP2zVf9O2rNerZkBIXPz9Y0CYB1mQ2pdfnqIiFdVhr
         NP4TBekv+HV2gPSJ2YIzxb0+IH6QFT8bK3BT/bD9e5/eEGuq0iDz6YVjl7O/Awy38vkT
         MA/F6DWIAvtrs5fe/JIBcMZWvtBNxfEMn2vSxvRTPNJmOs3GpYk5TUGZwO5+pXRKREr9
         9CDnmdV9KPsj+Z2IOUK0azD4h/uhkCiUAfI+kh7LIPTqODdphNcJLxuUwlw9flMq9UOK
         E1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QhrpUsD5ZNq874T4rNnffIMvqkskOMzNbsR1E6VBIeA=;
        b=uYsINYA+GGBvThUWX3f5knnfKBJKrsRa65gd8jtI3a6mhsZD1HariKnCjQbRAurbnz
         jHXT6bMiWvUq8GrhQ6gkux4wSftdtXPxP6Zohui8ONO9W8ktZJujpWxFM++8jyMYdVeG
         lQef740FxUgJtLecynRj0xuv6fEOyEMyC9bOFwli/huIU0rMFJbiEaGqhm6jWwo+p1yR
         XR1Tyt9QBcFuF0wxhWz+2QE1F8dUiCWpVbXX0S7ZFwrL38WjBoI2NLU866R1nUqMDcgg
         00rjyM3pXYXWb7e3fpTGMA19MzcKJnbaSNtrrGIL6i7PDhuFXGuKUDJloRFVH8X6KHpF
         mALw==
X-Gm-Message-State: AGi0PuajUXB+Jb9dWtzKNA2ly+7qv+oNEu78BUjtFBZp43QPJ/cj5IUM
        P8mplASJ3ims0axBNTaA2TFrBasWiLs=
X-Google-Smtp-Source: APiQypLrNaNadDSaNH9ff3ofEIzCjPgAJ6OsG2lKZiftpy/CeNAuRBpSK2nKGRnQgqHle1SqjsvOJg==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr9930466wrt.163.1588778438140;
        Wed, 06 May 2020 08:20:38 -0700 (PDT)
Received: from [192.168.43.138] ([185.32.177.92])
        by smtp.gmail.com with ESMTPSA id i6sm3224360wrw.97.2020.05.06.08.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 08:20:37 -0700 (PDT)
Subject: Re: [PATCH v7 6/7] tpm: Add YAML schema for TPM TIS I2C options
To:     Rob Herring <robh@kernel.org>
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        oshri.alkoby@nuvoton.com, tmaimon77@gmail.com, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com
References: <20200427124931.115697-1-amirmizi6@gmail.com>
 <20200427124931.115697-7-amirmizi6@gmail.com> <20200505161226.GA555@bogus>
From:   Amir Mizinski <amirmizi6@gmail.com>
Message-ID: <c2760659-ec14-237e-e060-5d9a2d7c7e4a@gmail.com>
Date:   Wed, 6 May 2020 15:20:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505161226.GA555@bogus>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2020-05-05 16:12, Rob Herring wrote:
> On Mon, Apr 27, 2020 at 03:49:30PM +0300, amirmizi6@gmail.com wrote:
>> From: Amir Mizinski <amirmizi6@gmail.com>
>>
>> Added a YAML schema to support tpm tis i2c related dt-bindings for the I2c
>> PTP based physical layer.
>>
>> This patch adds the documentation for corresponding device tree bindings of
>> I2C based Physical TPM.
>> Refer to the 'I2C Interface Definition' section in
>> 'TCG PC Client PlatformTPMProfile(PTP) Specification' publication
>> for specification.
>
> Again, DT bindings describe h/w devices, not just a protocol. A device
> is more than just a protocol interface. There's clocks, power rails,
> resets, interrupts, firmware, etc.
>
> Unless there's something special about TPM chips that makes none of this
> applicable and no chip will ever have any quirks (or extensions) in
> their protocol to work-around, then you need compatible string(s) that
> are specific to the TPM chip. You can have tcg,tpm-tis-i2c as a
> fallback, but you need specific compatible to handle any quirks.
>
> Rob

Hello Rob, currently yes. All TPM chip are implemented according to the TGC specs and should use the same properties for this I2C driver.
I can't say for sure that it will be the case in the future. Shouldn't we use the standard "tcg,tpm-tis-i2c" compatible, and if a specific TPM chip will deviate from the specs, the vendor should add an additional compatible string for it?
Thank you,
Amir

