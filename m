Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F7C8D17
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfJBPmN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 11:42:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50696 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727451AbfJBPmM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 11:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570030930;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xrk/iom6SacGfDF1/MM+LslI1lE/sTa+RHmkn0pm1oc=;
        b=azTJwomv9/VoNcjy9Ik5K5aNeL7f45TW9cTOZ33dkbTg0mwDozxFS9Cvnyx0zdpu2v21eZ
        KrtVlPgG9snCFLQwzJnlhys1Giwsbh2omvcmt0QkZji9qJE09KWrRsz6kH64gRR69CnfVc
        xCE8DGcypsFoGmh/n22DJR4EV/jrNcQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-_h_tSoizMN--yd7aSGNU_Q-1; Wed, 02 Oct 2019 11:42:08 -0400
Received: by mail-io1-f69.google.com with SMTP id a22so45191402ioq.23
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2019 08:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GNjCC8zynseCVOGAnnSac3El4WfDC7ObgvHi4C+tII0=;
        b=GbgUkR5yp13ymXSiPxE8oINYszMU2AOgV14MLfS092OTZmW+8MGxn0K3BkBBQu9Vt+
         T2XNxQrB16C2sknNcLfnMJphJtBtiM1+cbHcJrlNu7P2vAILKEJV0CCR7PjMbI1RCyiF
         9O0jqIi59S2iIEBqDN2oM21HH0089w+rdspOvl0CzfkXksgoUT6DI2TTrreBTdzd56Jh
         eGKeQmAlTIK9YBbjaiOH7PmSR6i5i+W0nGhWZ/G8d7vOEbhOn/WZqN3+BbJg9ePQXfY8
         7BeRgvDu5waJxTKj+e1/7Hf9PSxa/AU98Fsy8EyHItpIvvFuorJ3+ui6PvQlhHBOpPzD
         YiJA==
X-Gm-Message-State: APjAAAWEfuKARrla5fUVlCCpvWnSFyO8/o8DwX1Q273wBqMqFk1ehES6
        6IEFfFKqLY+YdYObxFOwkJo0ObfI9gpD3lQJrlTdSNcIOEBWPHKc10LtSKvakRkhallB9Arezia
        U/fAv4119gEzgLHLlWxn9Zb27HfU4
X-Received: by 2002:a92:8f19:: with SMTP id j25mr4502273ild.302.1570030928150;
        Wed, 02 Oct 2019 08:42:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoz3ZFieRh9HyOfrL85tv/y22VKUjqn3g4HP+t/mcTWx0Pl3pyfxzaeghuDo6XoQJjRpPgDQ==
X-Received: by 2002:a92:8f19:: with SMTP id j25mr4502246ild.302.1570030927921;
        Wed, 02 Oct 2019 08:42:07 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q3sm8208287ioi.68.2019.10.02.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:42:07 -0700 (PDT)
Date:   Wed, 2 Oct 2019 08:42:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-stabley@vger.kernel.org,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent future
 TPM operations
Message-ID: <20191002154204.me4lzgx2l4r6zkpy@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-stabley@vger.kernel.org,
        Vadim Sukhomlinov <sukhomlinov@google.com>, stable@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191002131445.7793-1-jarkko.sakkinen@linux.intel.com>
 <20191002131445.7793-4-jarkko.sakkinen@linux.intel.com>
 <20191002135758.GA1738718@kroah.com>
 <20191002151751.GP17454@sasha-vm>
 <20191002153123.wcguist4okoxckis@cantor>
MIME-Version: 1.0
In-Reply-To: <20191002153123.wcguist4okoxckis@cantor>
User-Agent: NeoMutt/20180716
X-MC-Unique: _h_tSoizMN--yd7aSGNU_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Oct 02 19, Jerry Snitselaar wrote:
>On Wed Oct 02 19, Sasha Levin wrote:
>>On Wed, Oct 02, 2019 at 03:57:58PM +0200, Greg KH wrote:
>>>On Wed, Oct 02, 2019 at 04:14:44PM +0300, Jarkko Sakkinen wrote:
>>>>From: Vadim Sukhomlinov <sukhomlinov@google.com>
>>>>
>>>>commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream
>>>>
>>>>TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disablin=
g
>>>>future TPM operations. TPM 1.2 behavior was different, future TPM
>>>>operations weren't disabled, causing rare issues. This patch ensures
>>>>that future TPM operations are disabled.
>>>>
>>>>Fixes: d1bd4a792d39 ("tpm: Issue a TPM2_Shutdown for TPM2 devices.")
>>>>Cc: stable@vger.kernel.org
>>>>Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
>>>>[dianders: resolved merge conflicts with mainline]
>>>>Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>>Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>>---
>>>>drivers/char/tpm/tpm-chip.c | 5 +++--
>>>>1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>>What kernel version(s) is this for?
>>
>>It would go to 4.19, we've recently reverted an incorrect backport of
>>this patch.
>>
>>Jarkko, why is this patch 3/3? We haven't seen the first two on the
>>mailing list, do we need anything besides this patch?
>>
>>--
>>Thanks,
>>Sasha
>
>It looks like there was a problem mailing the earlier patchset, and patche=
s 1 and 2
>weren't cc'd to stable, but patch 3 was.

Is linux-stabley@vger.kernel.org a valid address?

