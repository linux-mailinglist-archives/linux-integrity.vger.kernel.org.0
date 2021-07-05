Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6913BB6B9
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 07:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGEFWd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 01:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhGEFWd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 01:22:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1274613E7;
        Mon,  5 Jul 2021 05:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625462397;
        bh=Az/D0IhuWMZAA5FollvuSsryLMhuWbsJ+/drNfuS0Qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a43gBB3/rdhVs3OAaur8XMDOcoBH6Xa8pfaUdF06QuGgcmpawh2+mAaRS2mr2DFu+
         ajqbJorG+TqEfgfVuUg+fPHcIxfnAGiHwlWXqmZrY732F3yJOcKAvUCb1WdSKfVSB2
         59I33UDrTk6oMrh3cVpnoTQ1oObizbEkiMgber79WE2pLj4vUbkrpYxp8SqfSRmZZH
         8oCIyn3s1F3f5Dnl+konD+CGr//sZuBUOvxCBz4YOnocEEInQFq2djsC+omjy+ReR5
         qN3imF8PjnJS6Val8HlXzi+KpcIr8c/q9J/Mf+u+72Jv04H1WcTN2rfakxGpFDavvC
         KGlcPtoYZ9ZUQ==
Date:   Mon, 5 Jul 2021 08:19:55 +0300
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
Message-ID: <20210705051955.53zoge4rkeocmfyr@kernel.org>
References: <20210624053321.861-1-hao.wu@rubrik.com>
 <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210702063555.q2phirfv7wxc6axu@kernel.org>
 <939BC11F-0905-4777-9DD7-630FC28ED205@rubrik.com>
 <20210702074518.64gyockmqrphbkqx@kernel.org>
 <559CEFEB-EE60-464B-A847-9E1C3B5F5BC4@rubrik.com>
 <20210702084239.svkmfw7r3y5auus3@kernel.org>
 <20210702115715.gyqfdk6ksgqzeenm@kernel.org>
 <AB80469F-821A-45D0-878C-7ED97C8B44BF@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AB80469F-821A-45D0-878C-7ED97C8B44BF@rubrik.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 02, 2021 at 12:16:12PM -0700, Hao Wu wrote:
> 
> > On Jul 2, 2021, at 4:57 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > On Fri, Jul 02, 2021 at 11:42:39AM +0300, Jarkko Sakkinen wrote:
> >> On Fri, Jul 02, 2021 at 12:59:18AM -0700, Hao Wu wrote:
> >>>> On Jul 2, 2021, at 12:45 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >>>> 
> >>>> On Fri, Jul 02, 2021 at 12:33:15AM -0700, Hao Wu wrote:
> >>>>> 
> >>>>> 
> >>>>>> On Jul 1, 2021, at 11:35 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >>>>>> 
> >>>>>> On Tue, Jun 29, 2021 at 09:22:05PM -0700, Hao Wu wrote:
> >>>>>>> This is a fix for the ATMEL TPM crash bug reported in
> >>>>>>> https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
> >>>>>>> 
> >>>>>>> According to the discussions in the original thread,
> >>>>>>> we don't want to revert the timeout of wait_for_tpm_stat
> >>>>>>> for non-ATMEL chips, which brings back the performance cost.
> >>>>>>> For investigation and analysis of why wait_for_tpm_stat
> >>>>>>> caused the issue, and how the regression was introduced,
> >>>>>>> please read the original thread above.
> >>>>>>> 
> >>>>>>> Thus the proposed fix here is to only revert the timeout
> >>>>>>> for ATMEL chips by checking the vendor ID.
> >>>>>>> 
> >>>>>>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> >>>>>>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.2/2.0 generic drivers")
> >>>>>> 
> >>>>>> Fixes tag should be before SOB.
> >>>>>> 
> >>>>>>> ---
> >>>>>>> Test Plan:
> >>>>>>> - Run fixed kernel with ATMEL TPM chips and see crash
> >>>>>>> has been fixed.
> >>>>>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
> >>>>>>> the timeout has not been changed.
> >>>>>>> 
> >>>>>>> drivers/char/tpm/tpm.h          |  9 ++++++++-
> >>>>>>> drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++--
> >>>>>>> include/linux/tpm.h             |  2 ++
> >>>>>>> 3 files changed, 27 insertions(+), 3 deletions(-)
> >>>>>>> 
> >>>>>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> >>>>>>> index 283f78211c3a..bc6aa7f9e119 100644
> >>>>>>> --- a/drivers/char/tpm/tpm.h
> >>>>>>> +++ b/drivers/char/tpm/tpm.h
> >>>>>>> @@ -42,7 +42,9 @@ enum tpm_timeout {
> >>>>>>> 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
> >>>>>>> 	TPM_TIMEOUT_POLL = 1,	/* msecs */
> >>>>>>> 	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
> >>>>>>> -	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
> >>>>>>> +	TPM_TIMEOUT_USECS_MAX = 500,	/* usecs */
> >>>>>> 
> >>>>>> What is this change?
> >>>>> Need to add the tailing comma
> >>>>> 
> >>>>>> 
> >>>>>>> +	TPM_TIMEOUT_WAIT_STAT = 500,	/* usecs */
> >>>>>>> +	TPM_ATML_TIMEOUT_WAIT_STAT = 15000	/* usecs */
> >>>>>>> };
> >>>>>>> 
> >>>>>>> /* TPM addresses */
> >>>>>>> @@ -189,6 +191,11 @@ static inline void tpm_msleep(unsigned int delay_msec)
> >>>>>>> 		     delay_msec * 1000);
> >>>>>>> };
> >>>>>>> 
> >>>>>>> +static inline void tpm_usleep(unsigned int delay_usec)
> >>>>>>> +{
> >>>>>>> +	usleep_range(delay_usec - TPM_TIMEOUT_RANGE_US, delay_usec);
> >>>>>>> +};
> >>>>>> 
> >>>>>> Please remove this, and open code.
> >>>>> Ok, will do
> >>>>> 
> >>>>>>> +
> >>>>>>> int tpm_chip_start(struct tpm_chip *chip);
> >>>>>>> void tpm_chip_stop(struct tpm_chip *chip);
> >>>>>>> struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
> >>>>>>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> >>>>>>> index 55b9d3965ae1..9ddd4edfe1c2 100644
> >>>>>>> --- a/drivers/char/tpm/tpm_tis_core.c
> >>>>>>> +++ b/drivers/char/tpm/tpm_tis_core.c
> >>>>>>> @@ -80,8 +80,12 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> >>>>>>> 		}
> >>>>>>> 	} else {
> >>>>>>> 		do {
> >>>>>>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
> >>>>>>> -				     TPM_TIMEOUT_USECS_MAX);
> >>>>>>> +			if (chip->timeout_wait_stat && 
> >>>>>>> +				chip->timeout_wait_stat >= TPM_TIMEOUT_WAIT_STAT) {
> >>>>>>> +				tpm_usleep((unsigned int)(chip->timeout_wait_stat));
> >>>>>>> +			} else {
> >>>>>>> +				tpm_usleep((unsigned int)(TPM_TIMEOUT_WAIT_STAT));
> >>>>>>> +			}
> >>>>>> 
> >>>>>> Invalid use of braces. Please read
> >>>>>> 
> >>>>>> https://www.kernel.org/doc/html/v5.13/process/coding-style.html
> >>>>>> 
> >>>>>> Why do you have to use this field conditionally anyway? Why doesn't
> >>>>>> it always contain a legit value?
> >>>>> The field is legit now, but doesn’t hurt to do addition check for robustness 
> >>>>> to ensure no crash ? Just in case the value is updated below TPM_TIMEOUT_WAIT_STAT ? 
> >>>>> 
> >>>>> Can remove if we think it is not needed.
> >>>> 
> >>>> A simple question: why you use it conditionally? Can the field contain invalid value?
> >>>> 
> >>> There are two checks
> >>> - chip->timeout_wait_stat >= TPM_TIMEOUT_WAIT_STAT
> >>> It could be invalid when future developer set it to some value less than `TPM_TIMEOUT_USECS_MIN`,
> >>> and crash the usleep 
> >> 
> >> I don't understand this. Why you don't set to appropriate value?
> Ok, fair enough, I assume developers will test it anyway to ensure no crash. Will remove this check.
> 
> > What you should do, is to define two fields:
> > 
> > - tpm_timeout_min
> > - tpm_timeout_max
> > 
> > And initialize these to TPM_TIMEOUT_USECS_MIN and TPM_TIMEOUT_USECS_MAX.
> > 
> > Then fixup those for Atmel (with a simple if-statement, switch-case is
> > overkill).
> Switch was more for extensibility when other vendor has similar issue,
> but we can refactor when needed in the future. I can use if-statement for now.

Make things more fancy *only* when you actually need more fancy.

> > The way you work out things right now is broken:
> > 
> > 1. Before for non-Atmel: usleep_range(100, 500)
> > 2. After for non-Atmel: usleep_range(200, 500)
> I realized this in day-1, I think this range change does not matter much.

By saying that you are actually saying that *undocumented* semantic changes
to the kernel code are fine as long as they don't change things "too much"

Are you serious about this?

> `TPM_TIMEOUT_RANGE_US=300` is already used in the codebase, I assume people define
> such if for general use cases for usleep_range in TPM
> But we can add two fields if that makes us more comfortable to strictly follow the current code
> semantically.

This has absolutely nothing to do with "comfortable". It's black and white
wrong.

/Jarkko
