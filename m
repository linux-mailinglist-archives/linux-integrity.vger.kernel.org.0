Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274317D5DC
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 08:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfHAGuq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 02:50:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50019 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAGuq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 02:50:46 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost.localdomain)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1ht4ux-0006ob-9h; Thu, 01 Aug 2019 08:50:27 +0200
Message-ID: <19d9be198619e951750dedeb4d0a7f372083b42c.camel@pengutronix.de>
Subject: Re: [Tee-dev] [RFC v2 0/6] Introduce TEE based Trusted Keys support
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, jejb@linux.ibm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        keyrings@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Date:   Thu, 01 Aug 2019 08:50:22 +0200
In-Reply-To: <CAE=NcrYz8bT9zDhS_ZcvY84fpeTDxZ-KhJKeQGGyf=o4pG2J-Q@mail.gmail.com>
References: <1564489420-677-1-git-send-email-sumit.garg@linaro.org>
         <CAE=Ncrb63dQLe-nDQyO9OPv7XjwM_9mzL9SrcLiUi2Dr10cD4A@mail.gmail.com>
         <CAFA6WYPJAzbPdcpBqioxjY=T8RLw-73B_hpzX4cGnwVvm5zpJw@mail.gmail.com>
         <CAE=Ncrb23q++z8R8UMbjDE2epEq4YVcNGzrRD31eH3JAooYejg@mail.gmail.com>
         <CAFA6WYOKcOzSwakHhgshZcebD8ZBMSi7xQdjWYFS79=Xc+odOg@mail.gmail.com>
         <CAE=NcrYz8bT9zDhS_ZcvY84fpeTDxZ-KhJKeQGGyf=o4pG2J-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-08-01 at 09:36 +0300, Janne Karhunen wrote:
> On Wed, Jul 31, 2019 at 5:23 PM Sumit Garg <sumit.garg@linaro.org>
> wrote:
> 
> > > I guess my wording was wrong, tried to say that physical TEEs in
> > > the
> > > wild vary massively hardware wise. Generalizing these things is
> > > rough.
> > > 
> > 
> > There are already well defined GlobalPlatform Standards to
> > generalize
> > the TEE interface. One of them is GlobalPlatform TEE Client API [1]
> > which provides the basis for this TEE interface.
> 
> I'm aware of it - I have implemented a large part of the GP TEE APIs
> earlier (primarily the crypto functions). Does the TEE you work with
> actually support GP properly? Can I take a look at the code?

AFAIK Sumit is working with the OP-TEE implementation, which can be
found on github: https://github.com/op-tee/optee_os

Regards,
Rouven

