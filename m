Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD42C8CEE
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 17:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfJBPba (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 11:31:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725875AbfJBPba (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 11:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570030288;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z2WmFGxjjikT5Miosenuf0vEZuAWzLD/xn8HBAOrnNE=;
        b=d4W+nyUwKatBuyEC8IF0OIVlkgwE7lBylnDino4wqgF2ciC+YqeuHjOVsLcA2ZMTNMvgY+
        HtqpmE3kRgdUpZfxVF61eby2brBTfp1IokpLxT1IrIT3fKLje6jMbYJMap6aQAWfZY9pTo
        aSrB6LtGNN+z8M/wwj1mxNJ/H9UJOj0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-1Er7qObVM9mlNOPKNaeMZg-1; Wed, 02 Oct 2019 11:31:26 -0400
Received: by mail-io1-f70.google.com with SMTP id f5so45358841iob.17
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2019 08:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3qwXQsR3lou+ROCRc4yzFy/Jy2vjM/kmf8Di06ZjAII=;
        b=BTx8qJ1REGCpwvIvqf0Sl+6I27Fg7QmbGV5O3GimR1hFff29WG9gYSnL89p6lbVTH9
         TSGz9phhXHoELUxZtLk1Al4pckQyjgNQmJVhynZPTujrkh4D/gXSc1D+xJeQrM3Uo2QX
         gAketlbod8rIaqr9CJLgUlfty1ajUtx34bDdRPk8HTZyTaHU6RhD5vBb1b577CD/hdS9
         etFPGhsYgxp1E5nIwA9Eha6t063eM+VvB0SuTfRW3v/ziMt7wmFCM/Q2iZqtGd5+YUCw
         HOYWrtPl4Pa5YWgF9XEYE2mkd46fIe5kPXeRtU2JTLqwDwXI8SgSzdS7bMeDw59ySx53
         7ZvA==
X-Gm-Message-State: APjAAAVtLO0uUUDh8Z4gVzsQaPbUHHfOb8hwkpihVJ1uIo5QJT78x79t
        Atlxn+pmERT3vLeTjkfqkjMPKzp6CBHhpwC+fBpSMHSZcSa3/0b5VZowregJ1KecRKcNbI3hNT3
        i0PkPhghQdNarzN+FBggxd+JU5kna
X-Received: by 2002:a92:6507:: with SMTP id z7mr4198223ilb.191.1570030285582;
        Wed, 02 Oct 2019 08:31:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+A+4yeVQjgeYT4HlzAe6H/s5Sv36JwzxxIHXFwEfqwmULlLMujGvlChw2Hgybdyt37xLQvA==
X-Received: by 2002:a92:6507:: with SMTP id z7mr4198180ilb.191.1570030285293;
        Wed, 02 Oct 2019 08:31:25 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l82sm11873096ilh.23.2019.10.02.08.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:31:24 -0700 (PDT)
Date:   Wed, 2 Oct 2019 08:31:23 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20191002153123.wcguist4okoxckis@cantor>
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
MIME-Version: 1.0
In-Reply-To: <20191002151751.GP17454@sasha-vm>
User-Agent: NeoMutt/20180716
X-MC-Unique: 1Er7qObVM9mlNOPKNaeMZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Oct 02 19, Sasha Levin wrote:
>On Wed, Oct 02, 2019 at 03:57:58PM +0200, Greg KH wrote:
>>On Wed, Oct 02, 2019 at 04:14:44PM +0300, Jarkko Sakkinen wrote:
>>>From: Vadim Sukhomlinov <sukhomlinov@google.com>
>>>
>>>commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream
>>>
>>>TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
>>>future TPM operations. TPM 1.2 behavior was different, future TPM
>>>operations weren't disabled, causing rare issues. This patch ensures
>>>that future TPM operations are disabled.
>>>
>>>Fixes: d1bd4a792d39 ("tpm: Issue a TPM2_Shutdown for TPM2 devices.")
>>>Cc: stable@vger.kernel.org
>>>Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
>>>[dianders: resolved merge conflicts with mainline]
>>>Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>---
>>> drivers/char/tpm/tpm-chip.c | 5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>>What kernel version(s) is this for?
>
>It would go to 4.19, we've recently reverted an incorrect backport of
>this patch.
>
>Jarkko, why is this patch 3/3? We haven't seen the first two on the
>mailing list, do we need anything besides this patch?
>
>--
>Thanks,
>Sasha

It looks like there was a problem mailing the earlier patchset, and patches=
 1 and 2
weren't cc'd to stable, but patch 3 was.

