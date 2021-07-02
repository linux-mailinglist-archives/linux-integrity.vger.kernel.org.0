Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62F3B9DA7
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 10:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhGBIpP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 04:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhGBIpO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 04:45:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B30AA613BC;
        Fri,  2 Jul 2021 08:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625215362;
        bh=k3WihHrSAaTf0ckco42mY1dCF2aiAaq6XQaeNMPRDbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHWwryh+JeCobPM4bLXvFcoZkqMT04y0lsUJoJaaiRvAgFhHsHYD1Qla0zRXDEv69
         R5UnAOwO9bqYAQscEe8OeBJB6PugZT2ra7x7rh3ZoW9LuzCrg1zPHkSWDCBN2IYHWp
         QUgoPgY8Y5vjZ/2JhE6ClRgqBrPu0H5poAJkItuoiqP0xCaQKRnM8kCM/F93xT5wmn
         YsDj7tKSAO79NXegczQ2fChstdDcaR/vdlha/vV3gIju3Z7/nqCISv780uCs7+H2Fx
         kmpipTkttAzIKkkwh6ggyg8Dqn0aX9IKZXL0VmcBRlVC2PwBUctwzTrtY36gC8qppZ
         IN2FCB6+B9bNg==
Date:   Fri, 2 Jul 2021 11:42:39 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
Message-ID: <20210702084239.svkmfw7r3y5auus3@kernel.org>
References: <20210624053321.861-1-hao.wu@rubrik.com>
 <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210702063555.q2phirfv7wxc6axu@kernel.org>
 <939BC11F-0905-4777-9DD7-630FC28ED205@rubrik.com>
 <20210702074518.64gyockmqrphbkqx@kernel.org>
 <559CEFEB-EE60-464B-A847-9E1C3B5F5BC4@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <559CEFEB-EE60-464B-A847-9E1C3B5F5BC4@rubrik.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 02, 2021 at 12:59:18AM -0700, Hao Wu wrote:
> > On Jul 2, 2021, at 12:45 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > On Fri, Jul 02, 2021 at 12:33:15AM -0700, Hao Wu wrote:
> >> 
> >> 
> >>> On Jul 1, 2021, at 11:35 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >>> 
> >>> On Tue, Jun 29, 2021 at 09:22:05PM -0700, Hao Wu wrote:
> >>>> This is a fix for the ATMEL TPM crash bug reported in
> >>>> https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
> >>>> 
> >>>> According to the discussions in the original thread,
> >>>> we don't want to revert the timeout of wait_for_tpm_stat
> >>>> for non-ATMEL chips, which brings back the performance cost.
> >>>> For investigation and analysis of why wait_for_tpm_stat
> >>>> caused the issue, and how the regression was introduced,
> >>>> please read the original thread above.
> >>>> 
> >>>> Thus the proposed fix here is to only revert the timeout
> >>>> for ATMEL chips by checking the vendor ID.
> >>>> 
> >>>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> >>>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
> >>> 
> >>> Fixes tag should be before SOB.
> >>> 
> >>>> ---
> >>>> Test Plan:
> >>>> - Run fixed kernel with ATMEL TPM chips and see crash
> >>>> has been fixed.
> >>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
> >>>> the timeout has not been changed.
> >>>> 
> >>>> drivers/char/tpm/tpm.h          |  9 ++++++++-
> >>>> drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++--
> >>>> include/linux/tpm.h             |  2 ++
> >>>> 3 files changed, 27 insertions(+), 3 deletions(-)
> >>>> 
> >>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> >>>> index 283f78211c3a..bc6aa7f9e119 100644
> >>>> --- a/drivers/char/tpm/tpm.h
> >>>> +++ b/drivers/char/tpm/tpm.h
> >>>> @@ -42,7 +42,9 @@ enum tpm_timeout {
> >>>> 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
> >>>> 	TPM_TIMEOUT_POLL = 1,	/* msecs */
> >>>> 	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
> >>>> -	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
> >>>> +	TPM_TIMEOUT_USECS_MAX = 500,	/* usecs */
> >>> 
> >>> What is this change?
> >> Need to add the tailing comma
> >> 
> >>> 
> >>>> +	TPM_TIMEOUT_WAIT_STAT = 500,	/* usecs */
> >>>> +	TPM_ATML_TIMEOUT_WAIT_STAT = 15000	/* usecs */
> >>>> };
> >>>> 
> >>>> /* TPM addresses */
> >>>> @@ -189,6 +191,11 @@ static inline void tpm_msleep(unsigned int delay_msec)
> >>>> 		     delay_msec * 1000);
> >>>> };
> >>>> 
> >>>> +static inline void tpm_usleep(unsigned int delay_usec)
> >>>> +{
> >>>> +	usleep_range(delay_usec - TPM_TIMEOUT_RANGE_US, delay_usec);
> >>>> +};
> >>> 
> >>> Please remove this, and open code.
> >> Ok, will do
> >> 
> >>>> +
> >>>> int tpm_chip_start(struct tpm_chip *chip);
> >>>> void tpm_chip_stop(struct tpm_chip *chip);
> >>>> struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
> >>>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> >>>> index 55b9d3965ae1..9ddd4edfe1c2 100644
> >>>> --- a/drivers/char/tpm/tpm_tis_core.c
> >>>> +++ b/drivers/char/tpm/tpm_tis_core.c
> >>>> @@ -80,8 +80,12 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> >>>> 		}
> >>>> 	} else {
> >>>> 		do {
> >>>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
> >>>> -				     TPM_TIMEOUT_USECS_MAX);
> >>>> +			if (chip->timeout_wait_stat && 
> >>>> +				chip->timeout_wait_stat >= TPM_TIMEOUT_WAIT_STAT) {
> >>>> +				tpm_usleep((unsigned int)(chip->timeout_wait_stat));
> >>>> +			} else {
> >>>> +				tpm_usleep((unsigned int)(TPM_TIMEOUT_WAIT_STAT));
> >>>> +			}
> >>> 
> >>> Invalid use of braces. Please read
> >>> 
> >>> https://www.kernel.org/doc/html/v5.13/process/coding-style.html
> >>> 
> >>> Why do you have to use this field conditionally anyway? Why doesn't
> >>> it always contain a legit value?
> >> The field is legit now, but doesn’t hurt to do addition check for robustness 
> >> to ensure no crash ? Just in case the value is updated below TPM_TIMEOUT_WAIT_STAT ? 
> >> 
> >> Can remove if we think it is not needed.
> > 
> > A simple question: why you use it conditionally? Can the field contain invalid value?
> > 
> There are two checks
> - chip->timeout_wait_stat >= TPM_TIMEOUT_WAIT_STAT
> It could be invalid when future developer set it to some value less than `TPM_TIMEOUT_USECS_MIN`,
> and crash the usleep 

I don't understand this. Why you don't set to appropriate value?

/Jarkko
