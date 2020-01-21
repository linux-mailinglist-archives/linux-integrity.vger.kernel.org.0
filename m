Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C92414456A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2020 20:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAUTwe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jan 2020 14:52:34 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34568 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbgAUTwe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 14:52:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DB1108EE180;
        Tue, 21 Jan 2020 11:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579636353;
        bh=M85fHEK3EDsUo/Rv6a9VBeWoJ6p5EGcRxfPwIERa8tw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LfmAYBdFolmGBonfM4Y/tZQqZMPvpmHmwAV5x0Mi6HiiAvkPVchq2Q7z5MG9n9xTJ
         aPKt99MjtpYkN1/MS1prvVVDV52uFM18rPOU/XYKRn/mIhxhwPgn9w2mjpNQzV7fqm
         Q1g1YWtTqKxivuM7ZCosEmzHeNGcI55OD9O/hdxo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nlBuNbZXxagS; Tue, 21 Jan 2020 11:52:33 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 072468EE0C9;
        Tue, 21 Jan 2020 11:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579636353;
        bh=M85fHEK3EDsUo/Rv6a9VBeWoJ6p5EGcRxfPwIERa8tw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LfmAYBdFolmGBonfM4Y/tZQqZMPvpmHmwAV5x0Mi6HiiAvkPVchq2Q7z5MG9n9xTJ
         aPKt99MjtpYkN1/MS1prvVVDV52uFM18rPOU/XYKRn/mIhxhwPgn9w2mjpNQzV7fqm
         Q1g1YWtTqKxivuM7ZCosEmzHeNGcI55OD9O/hdxo=
Message-ID: <1579636351.3390.35.camel@HansenPartnership.com>
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jan 2020 11:52:31 -0800
In-Reply-To: <1579634035.5125.311.camel@linux.ibm.com>
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
         <1579628090.3390.28.camel@HansenPartnership.com>
         <1579634035.5125.311.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-01-21 at 14:13 -0500, Mimi Zohar wrote:
> On Tue, 2020-01-21 at 09:34 -0800, James Bottomley wrote:
> > On Tue, 2020-01-21 at 09:13 -0800, Lakshmi Ramasubramanian wrote:
> > > Enabling IMA and ASYMMETRIC_PUBLIC_KEY_SUBTYPE configs will
> > > automatically enable the IMA hook to measure asymmetric keys.
> > > Keys created or updated early in the boot process are queued up
> > > whether or not a custom IMA policy is provided. Although the
> > > queued keys will be freed if a custom IMA policy is not loaded
> > > within 5 minutes, it could still cause significant performance
> > > impact on smaller systems.
> > 
> > What exactly do you expect distributions to do with this?  I can
> > tell you that most of them will take the default option, so this
> > gets set to N and you may as well not have got the patches upstream
> > because you won't be able to use them in any distro with this
> > setting.
> > 
> > > This patch turns the config IMA_MEASURE_ASYMMETRIC_KEYS off by
> > > default.  Since a custom IMA policy that defines key measurement
> > > is required to measure keys, systems that require key measurement
> > > can enable this config option in addition to providing a custom
> > > IMA policy.
> > 
> > Well, no they can't ... it's rather rare nowadays for people to
> > build their own kernels.  The vast majority of Linux consumers take
> > what the distros give them.  Think carefully before you decide a
> > config option is the solution to this problem.
> 
> James, up until now IMA could be configured, but there wouldn't be
> any performance penalty for enabling IMA until a policy was loaded.
>  With IMA and asymmetric keys enabled, whether or not an IMA policy
> is loaded, certificates will be queued.
> 
> My concern is:
> - changing the expected behavior

In general config options for this are a really bad idea because if the
tools only cope with one setting, no-one should ever use the other and
if they work with everything there's no need for the option.

> - really small devices/sensors being able to queue certificates

seems like the answer to this one would be don't queue.  I realise it's
after the submit design, but what about measuring when the key is added
if there's a policy otherwise measure the keyring when the policy is
added ... that way no queueing.

> This change permits disabling queueing certificates.  Whether the
> default should be "disabled" is a separate question.  I'm open to
> comments/suggestions.

I'm just giving the general rule of thumb for boolean config options. 
If it's default Y there likely shouldn't be a config option and if it's
default N the feature should likely not be in the kernel at all.


