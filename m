Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341EB2DDA87
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 22:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgLQVFp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 16:05:45 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:55542 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727098AbgLQVFp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 16:05:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1943F1280A41;
        Thu, 17 Dec 2020 13:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1608239105;
        bh=2z1gqUvnD7Nsw83lQWThTJ7MGgErgFbJ7JmEcoACSXc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=hc+IYruwsde7x1Nf08Vb246H6OmkNH/9UfbMo9iSWp0A4CDkBsM1eu9q0CblU0k7L
         PkAau/W2hSVeaTfiwj76ihpW/HB9LujIajOcehSpxkwbegsZwW0TsWvXf9Fl8dNiCu
         BHQ/baMym62CxHwcVTIgrenqEyj+zD8og0Dp0tDU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FHPVzP9c2lh4; Thu, 17 Dec 2020 13:05:05 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 883191280A18;
        Thu, 17 Dec 2020 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1608239104;
        bh=2z1gqUvnD7Nsw83lQWThTJ7MGgErgFbJ7JmEcoACSXc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=s47I7kW8tnFJUNd1UvU/ZTFz/XMj8iPdn8h//DzBicTfFwkja9s8QfRi9UdTXNx4W
         D226YjrDR8fHWX/U071sHn95jsK0cM/YWGhI/HCRSPjf56uKX4FCQ9pK1VhsgiItqE
         JWnXcXkXRhu/4wvfELuPseS6xOel0EeI9SrwWZdo=
Message-ID: <0bf3eb18d7f2cf941814926cdd4f4ff61079387b.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: Rework open/close/shutdown to avoid races
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Dec 2020 13:05:03 -0800
In-Reply-To: <e7566e1e48f5be9dca034b4bfb67683b5d3cb88f.camel@HansenPartnership.com>
References: <20201215133801.546207-1-s.temerkhanov@gmail.com>
         <e7566e1e48f5be9dca034b4bfb67683b5d3cb88f.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-12-15 at 10:51 -0800, James Bottomley wrote:
> On Tue, 2020-12-15 at 16:38 +0300, Sergey Temerkhanov wrote:
> > Avoid race condition at shutdown by shutting downn the TPM 2.0
> > devices synchronously. This eliminates the condition when the
> > shutdown sequence sets chip->ops to NULL leading to the following:
> > 
> > [ 1586.593561][ T8669] tpm2_del_space+0x28/0x73
> > [ 1586.598718][ T8669] tpmrm_release+0x27/0x33wq
> > [ 1586.603774][ T8669] __fput+0x109/0x1d
> > [ 1586.608380][ T8669] task_work_run+0x7c/0x90
> > [ 1586.613414][ T8669] prepare_exit_to_usermode+0xb8/0x128
> > [ 1586.619522][ T8669] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [ 1586.626068][ T8669] RIP: 0033:0x4cb4bb
> 
> An actual bug report would have been helpful.  However, from this
> trace it's easy to deduce that tpm2_del_space() didn't get converted
> to the get/put of the chip ops ... it's still trying to do its own
> half arsed thing with tpm_chip_start() and the mutex.  So isn't a
> much simpler fix simply to convert it as below?  compile tested only,
> but if you can test it out I'll send a proper patch.

I got this booted and running here, so I know it works.  What I still
need to know is does it fix your problem?

James


