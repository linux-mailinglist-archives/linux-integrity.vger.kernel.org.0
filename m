Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8823CEFB3
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Oct 2019 01:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfJGXnb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Oct 2019 19:43:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41941 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfJGXna (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Oct 2019 19:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570491808;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KfdB8ibDs6rNq8kMkSKmIsENyVmHkVqr3DazxzG7Po=;
        b=CPd+YTtchJJcPBOrOni/ZL7t1wgua8AAXtfkQ0nZezTD6lZZJlfOwXiUFOSdHnE/E/WaVp
        A05ndm1wV75WnmAJN+6E4hjwm6JNQGEjfdf+eWvfEGLgt8Bn17bux8jDj6pwujlgIM2gto
        iQse0dIFzbAiAFGOXVrsqA8vM6geLUo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-b3VcXfB3NPypOy3cR-huiQ-1; Mon, 07 Oct 2019 19:43:26 -0400
Received: by mail-io1-f72.google.com with SMTP id r13so29313517ioj.22
        for <linux-integrity@vger.kernel.org>; Mon, 07 Oct 2019 16:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/KfdB8ibDs6rNq8kMkSKmIsENyVmHkVqr3DazxzG7Po=;
        b=kOs9q5qIIW0zBG0ROD6k9PkfE3Tta3XDE5TSbsJHDdnvIthh6vMNegCAAcMv1Ji/N3
         krC4XMQpeqKS4DUvHRQgtdXwa8WSULLz3yEgK3gNZwRH/iCK1S3QvneTDzp1JPxBP3ki
         rj17qUdaQZK5BJyfBHyzPN2Mvf1qxhZG07NHcQ+qAxwAxDOOS8t0DJBtY+8wEhFhS3Mr
         uuA7pwybaaHU3wGpcZJAPjdV//uA6GweGzcBu20bJ26u6PCKU2/nHgYTrRrkhitnEz41
         MAvIPWVHOhzzGyVkHWGIeAeepb/qRWGslYNaH4+U+ZlNQ2UudYDafxgP2+ZdrGM9Y3wb
         SjwQ==
X-Gm-Message-State: APjAAAUrwAZ65K0ogKMg2Fpv1OEJTAZsqM6tl0bIISFPjeouARgAlbZP
        1uRDW1uvBtE6fZ174Qxmwj3x++/5z/4TgE6vmVyDzY1xkuiD+t5KxMADvkOrwpsQz0scZ/QNzQY
        n50oyvI/nx2ffJDvXOO+DUgsSUOlr
X-Received: by 2002:a92:bb05:: with SMTP id w5mr31955912ili.303.1570491806350;
        Mon, 07 Oct 2019 16:43:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy6Zp5FZMi5yxzuc/xTznB+fkg/9WS8bWFCEBHlaPE1Pn9L5J3AawFt79dXD9lIFRMLG+45/g==
X-Received: by 2002:a92:bb05:: with SMTP id w5mr31955887ili.303.1570491806053;
        Mon, 07 Oct 2019 16:43:26 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id s5sm5479794iol.71.2019.10.07.16.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 16:43:25 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:43:23 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] tpm: Use GFP_KERNEL for allocating struct tpm_buf
Message-ID: <20191007234323.bzeov5mpc4xregcy@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
 <20191003185103.26347-2-jarkko.sakkinen@linux.intel.com>
 <1570148716.10818.19.camel@linux.ibm.com>
 <20191006095005.GA7660@linux.intel.com>
 <1570475528.4242.2.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1570475528.4242.2.camel@linux.ibm.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: b3VcXfB3NPypOy3cR-huiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Oct 07 19, James Bottomley wrote:
>From: James Bottomley <James.Bottomley@HansenPartnership.com>
>Subject: [PATCH] tpm: use GFP kernel for tpm_buf allocations
>
>The current code uses GFP_HIGHMEM, which is wrong because GFP_HIGHMEM
>(on 32 bit systems) is memory ordinarily inaccessible to the kernel
>and should only be used for allocations affecting userspace.  In order
>to make highmem visible to the kernel on 32 bit it has to be kmapped,
>which consumes valuable entries in the kmap region.  Since the tpm_buf
>is only ever used in the kernel, switch to using a GFP_KERNEL
>allocation so as not to waste kmap space on 32 bits.
>
>Fixes: a74f8b36352e (tpm: introduce tpm_buf)
>Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

