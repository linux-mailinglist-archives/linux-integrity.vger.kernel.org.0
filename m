Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3BA309A2E
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 05:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhAaETo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 23:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhAaETL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 23:19:11 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D2CC061573;
        Sat, 30 Jan 2021 20:18:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 155151280586;
        Sat, 30 Jan 2021 20:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612066709;
        bh=Nbgoi+95+AcZmsgbWasTlZCJci+H2dmaEkCTxqsJ2Kg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=igFPavvWYr/Boa3vIm6E0r6fC7fYamxgAigWmrGEy2OVTaX4iA0ZD/jV0ur1+ZWkX
         RxksMXHzc2aMJNb+bFVbNYUm/Hjxe9TTWjHSNgHFmo03o7LoNXPCxNfWyNCvirjkft
         E/8RwS+YWdUNlWqmaLpVEdz3xIf4oItfag1OvFno=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DkaenQoIzObO; Sat, 30 Jan 2021 20:18:29 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 544911280582;
        Sat, 30 Jan 2021 20:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612066708;
        bh=Nbgoi+95+AcZmsgbWasTlZCJci+H2dmaEkCTxqsJ2Kg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=jjevaDCcS1E8tDTXk5F85vfVii8uzIpqjdnrEEcMDeM7htuJaFBBMdgg3+Hgqq5BV
         lNeTI5HAE0rcC3b5EkXmy2AQvitL0XmpVRUgU0dGcLImsX4Ap2/uS536OduJsXjmsO
         KEwPx6y1Mt91zkB4aqOQC+4tql6WbjrEeALOzDLQ=
Message-ID: <486ef072bf19eaf70c5417282f499a7c48e09a07.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Date:   Sat, 30 Jan 2021 20:18:27 -0800
In-Reply-To: <57e79e19-fe5c-7d41-ff30-40afbaa7a96d@roeck-us.net>
References: <20210123014247.989368-1-lma@semihalf.com>
         <20210125171846.GA31929@roeck-us.net>
         <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
         <YBSTOrlgTPpzoblY@kernel.org>
         <7a702108-ec9e-b2e2-be89-3590437c0eb5@roeck-us.net>
         <bf4564a2f4f761a4c0a00857c7dc346fc43bcd92.camel@HansenPartnership.com>
         <57e79e19-fe5c-7d41-ff30-40afbaa7a96d@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-01-30 at 19:36 -0800, Guenter Roeck wrote:
> On 1/30/21 4:41 PM, James Bottomley wrote:
> > On Sat, 2021-01-30 at 15:49 -0800, Guenter Roeck wrote:
> > > On 1/29/21 2:59 PM, Jarkko Sakkinen wrote:
> > > > On Tue, Jan 26, 2021 at 04:46:07PM +0100, Łukasz Majczak wrote:
> > > > > Hi Jarkko, Guenter
> > > > > 
> > > > > Yes, here are the logs when failure occurs -
> > > > > https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
> > > > > Look for a phrase "TPM returned invalid status"
> > > > > 
> > > > > Guenter - good suggestion - I will try to keep it as tight as
> > > > > possible.
> > > > > 
> > > > > Best regards,
> > > > > Lukasz
> > > > 
> > > > Is it possible for you try out with linux-next? Thanks. It's a
> > > > known issue, which ought to be fixed by now.
> > > > 
> > > > The log message is harmless, it'a warning not panic, and does
> > > > not endanger system stability. WARN()'s always dump stack
> > > > trace. No oops is happening.
> > > > 
> > > 
> > > There is a note in the kernel documentation which states:
> > > 
> > > Note that the WARN()-family should only be used for "expected to
> > > be unreachable" situations. If you want to warn about "reachable
> > > but undesirable" situations, please use the pr_warn()-family of
> > > functions.
> > 
> > It fits the definition.  The warning only triggers if the access is
> > in the wrong locality, which should be impossible, so the warning
> > should be unreachable.
> > 
> Thanks a lot for the clarification. So a warning traceback in the
> kernel doesn't necessarily suggest that there is a serious problem
> that should be fixed; it only means that some code is executed which
> should not be reachable (but is otherwise harmless).
> 
> That makes me wonder, though, if it would make sense to mark such
> harmless tracebacks differently. The terms "warning" and "harmless"
> sound like a bit of a contradiction to me (especially for systems
> where panic_on_warn is set).

Well, it's not harmless; because it occurs at start of day, it means we
clear the ineffective command and use default values and those happen
to work fine for the TPM in question, so the problem is pretty much
covered up.  If it had occurred anywhere else it would result in a loss
of the command data with unknown ramifications to user space, possibly
leading to a TPM failure.

Hopefully this means this is the only place we screwed up, but you can
see why a scary warning and stack trace is appropriate: if it triggers,
something in the kernel violated the TPM command model.

James


