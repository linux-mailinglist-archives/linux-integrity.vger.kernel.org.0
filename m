Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66B20773B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403982AbgFXPVM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 11:21:12 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51730 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403781AbgFXPVM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 11:21:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C06958EE16A;
        Wed, 24 Jun 2020 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593012070;
        bh=DOfXn7+KwCf/KpOq0sgZgebZBq+AocK/Mz+BMpU//pw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jnpRf2uO2k/DXOOIyuh7s7drZDKCrsxIQ5uRzBjEtPAVaoVdvmXcbKggYo1Rh65vS
         VfJkjwHplAQLF/lGQPdl5jUDMKDhZc/FIpzMMIXZ94UN26BGDD98CPfXMCzFqC5H0J
         0vTwpXwEgOkLBHllHmNZ8p2QKY+LswhDsnzeujJI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qYj7yQLOuoXC; Wed, 24 Jun 2020 08:21:10 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1BBFB8EE0E9;
        Wed, 24 Jun 2020 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593012070;
        bh=DOfXn7+KwCf/KpOq0sgZgebZBq+AocK/Mz+BMpU//pw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jnpRf2uO2k/DXOOIyuh7s7drZDKCrsxIQ5uRzBjEtPAVaoVdvmXcbKggYo1Rh65vS
         VfJkjwHplAQLF/lGQPdl5jUDMKDhZc/FIpzMMIXZ94UN26BGDD98CPfXMCzFqC5H0J
         0vTwpXwEgOkLBHllHmNZ8p2QKY+LswhDsnzeujJI=
Message-ID: <1593012069.28403.11.camel@HansenPartnership.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Date:   Wed, 24 Jun 2020 08:21:09 -0700
In-Reply-To: <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
         <20200604175851.758-2-maxim.uvarov@linaro.org>
         <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
         <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
         <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
         <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
         <1592507935.15159.5.camel@HansenPartnership.com>
         <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
         <1592578844.4369.5.camel@HansenPartnership.com>
         <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> Apologies for delay in my reply as I was busy with some other stuff.
> 
> On Fri, 19 Jun 2020 at 20:30, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > it's about consistency with what the kernel types mean.  When some
> > checker detects your using little endian operations on a big endian
> > structure (like in the prink for instance) they're going to keep
> > emailing you about it.
> 
> As mentioned above, using different terminology is meant to cause
> more confusion than just difference in endianness which is manageable
> inside TEE.
> 
> And I think it's safe to say that the kernel implements UUID in big
> endian format and thus uses %pUb whereas OP-TEE implements UUID in
> little endian format and thus uses %pUl.

So what I think you're saying is that if we still had uuid_be and
uuid_le you'd use uuid_le, because that's exactly the structure
described in the docs.  But because we renamed

uuid_be -> uuid_t
uuid_le -> guid_t

You can't use guid_t as a kernel type because it has the wrong name?

James

