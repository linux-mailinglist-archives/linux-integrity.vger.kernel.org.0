Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817B7690F29
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Feb 2023 18:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBIR1b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Feb 2023 12:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBIR1a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Feb 2023 12:27:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9492636690;
        Thu,  9 Feb 2023 09:27:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 038E8CE2559;
        Thu,  9 Feb 2023 17:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C75C433EF;
        Thu,  9 Feb 2023 17:27:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ND8YGvIF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1675963627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A05rqra2JzOwWHXPK1fgbDy2s18snUltZCCp/mNa3do=;
        b=ND8YGvIFU670lfq1GjFjVygyVFCsmM9pEEWH+bITYh9IUdFJB0cASiFzBCL3S7mtU2XGt3
        vuyw16PPNtCtoAcunAvuJ8LI1PIAAJ/kIDkHEaYU2hCsP/PbqDls9PIgZgEMoTrTNIdWYN
        J0As9PIpHpD/MeeLc5FuB0INWSOMqrI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 61c5b343 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 9 Feb 2023 17:27:07 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id a1so3194821ybj.9;
        Thu, 09 Feb 2023 09:27:07 -0800 (PST)
X-Gm-Message-State: AO0yUKV7e9qiYdiQMRa1m4Rwz3u2XZQfA+KaBYG2T3ZQlX2P1jHoYPxi
        eJQn+BzJbt6L8jId+YH0QVjIJXKeOBSxYG3bscM=
X-Google-Smtp-Source: AK7set8fojPXvRFNN7tEs8bI/1kxDlzSKYWZ/s2YuWziA2+UuCrN1ST3NnhlZ2Vohu6/3+7HefI1GivoSVeOXkyFJ4U=
X-Received: by 2002:a5b:6c5:0:b0:88f:946:bd98 with SMTP id r5-20020a5b06c5000000b0088f0946bd98mr1458600ybq.24.1675963626234;
 Thu, 09 Feb 2023 09:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20230209153120.261904-1-Jason@zx2c4.com> <543c2e9b-6d82-7ee0-9a1f-e3176aba16e2@amd.com>
In-Reply-To: <543c2e9b-6d82-7ee0-9a1f-e3176aba16e2@amd.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 9 Feb 2023 14:26:55 -0300
X-Gmail-Original-Message-ID: <CAHmME9rNMPwA0D8gqsm-OzR9GgHm31TKGvOWeMAauF-Y083q4g@mail.gmail.com>
Message-ID: <CAHmME9rNMPwA0D8gqsm-OzR9GgHm31TKGvOWeMAauF-Y083q4g@mail.gmail.com>
Subject: Re: [PATCH RFC] tpm: disable hwrng for known-defective AMD RNGs
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     regressions@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 9, 2023 at 12:41 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 2/9/2023 09:31, Jason A. Donenfeld wrote:
> > Do not register a hwrng for certain AMD TPMs that are running an old
> > known-buggy revision. Do this by probing the TPM2_PT_MANUFACTURER,
> > TPM2_PT_FIRMWARE_VERSION_1, and TPM2_PT_FIRMWARE_VERSION_2 properties,
> > and failing when an "AMD"-manufactured TPM2 chip is below a threshold.
> >
> > BROKEN BROKEN BROKEN - I just made the version numbers up and haven't
> > tested this because I don't actually have hardware for it. I'm posting
> > this so that Mario can take over its development and submit a v2 himself
> > once he has confirmed the versioning info from inside AMD.
>
> Thanks, happy to do that.  As I'll take over some comments are inline
> mostly for my future self when this is resubmitted.
>
> Perhaps one of the people who can reproduce this right now can confirm
> this works?  The version number string should at least trigger one of
> the reported systems to avoid doing this.
>
> >
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> > Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> At least as a note for myself this needs:
> 1. 'Link' tag to the public advisory for this fTPM issue
> 2. A 'Fixes' tag to the commit that enabled fTPM as a hwrng source by
> default and exposed the issue.
> 3. A 'Link' tag to the bugzilla.
>
> > ---
> >   drivers/char/tpm/tpm-chip.c | 34 ++++++++++++++++-
> >   drivers/char/tpm/tpm.h      | 73 +++++++++++++++++++++++++++++++++++++
> >   2 files changed, 106 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 741d8f3e8fb3..e0f8134d31a3 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -512,6 +512,37 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
> >       return 0;
> >   }
> >
> > +static bool tpm_is_rng_defective(struct tpm_chip *chip)
> > +{
> > +     int ret;
> > +     u32 val1, val2;
> > +     u64 version;
> > +
> > +     /* No known-broken TPM1 chips. */
> > +     if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
> > +             return false;
> > +
> > +     /* Only known-broken are AMD. */
> > +     ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val1, NULL);
> > +     if (ret < 0 || val1 != 0x414D4400U /* AMD */)
> > +             return false;
> > +
> > +     /* Grab and concat the version values. */
> > +     ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_1, &val1, NULL);
> > +     if (ret < 0)
> > +             return false;
> > +     ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_2, &val2, NULL);
> > +     if (ret < 0)
> > +             return false;
> > +     version = ((u64)val1 << 32) | val2;
> > +
> > +     /* Versions below 3.4e.2.9 are broken. */
> > +     if (version < 0x0003004E0002009ULL)
> > +             return true;
>
> We probably want to also do a 'dev_info_once' or 'dev_warn_once' here to
> let people know that they're not getting a fTPM RNG so it's not a surprise.

AFAICT, this runs once per TPM device. So maybe a simple dev_warn()
without the _once part will be good, so you actually see in dmesg each
buggy device.

>
> > +
> > +     return false;
> > +}
> > +
> >   static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> >   {
> >       struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
> > @@ -521,7 +552,8 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> >
> >   static int tpm_add_hwrng(struct tpm_chip *chip)
> >   {
> > -     if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip))
> > +     if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
> > +         tpm_is_rng_defective(chip))
> >               return 0;
> >
> >       snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 24ee4e1cc452..830014a26609 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -150,6 +150,79 @@ enum tpm_sub_capabilities {
> >       TPM_CAP_PROP_TIS_DURATION = 0x120,
> >   };
> >
> > +enum tpm2_pt_props {
> > +     TPM2_PT_NONE = 0x00000000,
> > +     TPM2_PT_GROUP = 0x00000100,
> > +     TPM2_PT_FIXED = TPM2_PT_GROUP * 1,
> > +     TPM2_PT_FAMILY_INDICATOR = TPM2_PT_FIXED + 0,
> > +     TPM2_PT_LEVEL = TPM2_PT_FIXED + 1,
> > +     TPM2_PT_REVISION = TPM2_PT_FIXED + 2,
> > +     TPM2_PT_DAY_OF_YEAR = TPM2_PT_FIXED + 3,
> > +     TPM2_PT_YEAR = TPM2_PT_FIXED + 4,
> > +     TPM2_PT_MANUFACTURER = TPM2_PT_FIXED + 5,
> > +     TPM2_PT_VENDOR_STRING_1 = TPM2_PT_FIXED + 6,
> > +     TPM2_PT_VENDOR_STRING_2 = TPM2_PT_FIXED + 7,
> > +     TPM2_PT_VENDOR_STRING_3 = TPM2_PT_FIXED + 8,
> > +     TPM2_PT_VENDOR_STRING_4 = TPM2_PT_FIXED + 9,
> > +     TPM2_PT_VENDOR_TPM_TYPE = TPM2_PT_FIXED + 10,
> > +     TPM2_PT_FIRMWARE_VERSION_1 = TPM2_PT_FIXED + 11,
> > +     TPM2_PT_FIRMWARE_VERSION_2 = TPM2_PT_FIXED + 12,
> > +     TPM2_PT_INPUT_BUFFER = TPM2_PT_FIXED + 13,
> > +     TPM2_PT_HR_TRANSIENT_MIN = TPM2_PT_FIXED + 14,
> > +     TPM2_PT_HR_PERSISTENT_MIN = TPM2_PT_FIXED + 15,
> > +     TPM2_PT_HR_LOADED_MIN = TPM2_PT_FIXED + 16,
> > +     TPM2_PT_ACTIVE_SESSIONS_MAX = TPM2_PT_FIXED + 17,
> > +     TPM2_PT_PCR_COUNT = TPM2_PT_FIXED + 18,
> > +     TPM2_PT_PCR_SELECT_MIN = TPM2_PT_FIXED + 19,
> > +     TPM2_PT_CONTEXT_GAP_MAX = TPM2_PT_FIXED + 20,
> > +     TPM2_PT_NV_COUNTERS_MAX = TPM2_PT_FIXED + 22,
> > +     TPM2_PT_NV_INDEX_MAX = TPM2_PT_FIXED + 23,
> > +     TPM2_PT_MEMORY = TPM2_PT_FIXED + 24,
> > +     TPM2_PT_CLOCK_UPDATE = TPM2_PT_FIXED + 25,
> > +     TPM2_PT_CONTEXT_HASH = TPM2_PT_FIXED + 26,
> > +     TPM2_PT_CONTEXT_SYM = TPM2_PT_FIXED + 27,
> > +     TPM2_PT_CONTEXT_SYM_SIZE = TPM2_PT_FIXED + 28,
> > +     TPM2_PT_ORDERLY_COUNT = TPM2_PT_FIXED + 29,
> > +     TPM2_PT_MAX_COMMAND_SIZE = TPM2_PT_FIXED + 30,
> > +     TPM2_PT_MAX_RESPONSE_SIZE = TPM2_PT_FIXED + 31,
> > +     TPM2_PT_MAX_DIGEST = TPM2_PT_FIXED + 32,
> > +     TPM2_PT_MAX_OBJECT_CONTEXT = TPM2_PT_FIXED + 33,
> > +     TPM2_PT_MAX_SESSION_CONTEXT = TPM2_PT_FIXED + 34,
> > +     TPM2_PT_PS_FAMILY_INDICATOR = TPM2_PT_FIXED + 35,
> > +     TPM2_PT_PS_LEVEL = TPM2_PT_FIXED + 36,
> > +     TPM2_PT_PS_REVISION = TPM2_PT_FIXED + 37,
> > +     TPM2_PT_PS_DAY_OF_YEAR = TPM2_PT_FIXED + 38,
> > +     TPM2_PT_PS_YEAR = TPM2_PT_FIXED + 39,
> > +     TPM2_PT_SPLIT_MAX = TPM2_PT_FIXED + 40,
> > +     TPM2_PT_TOTAL_COMMANDS = TPM2_PT_FIXED + 41,
> > +     TPM2_PT_LIBRARY_COMMANDS = TPM2_PT_FIXED + 42,
> > +     TPM2_PT_VENDOR_COMMANDS = TPM2_PT_FIXED + 43,
> > +     TPM2_PT_NV_BUFFER_MAX = TPM2_PT_FIXED + 44,
> > +     TPM2_PT_MODES = TPM2_PT_FIXED + 45,
> > +     TPM2_PT_MAX_CAP_BUFFER = TPM2_PT_FIXED + 46,
> > +     TPM2_PT_VAR = TPM2_PT_GROUP * 2,
> > +     TPM2_PT_PERMANENT = TPM2_PT_VAR + 0,
> > +     TPM2_PT_STARTUP_CLEAR = TPM2_PT_VAR + 1,
> > +     TPM2_PT_HR_NV_INDEX = TPM2_PT_VAR + 2,
> > +     TPM2_PT_HR_LOADED = TPM2_PT_VAR + 3,
> > +     TPM2_PT_HR_LOADED_AVAIL = TPM2_PT_VAR + 4,
> > +     TPM2_PT_HR_ACTIVE = TPM2_PT_VAR + 5,
> > +     TPM2_PT_HR_ACTIVE_AVAIL = TPM2_PT_VAR + 6,
> > +     TPM2_PT_HR_TRANSIENT_AVAIL = TPM2_PT_VAR + 7,
> > +     TPM2_PT_HR_PERSISTENT = TPM2_PT_VAR + 8,
> > +     TPM2_PT_HR_PERSISTENT_AVAIL = TPM2_PT_VAR + 9,
> > +     TPM2_PT_NV_COUNTERS = TPM2_PT_VAR + 10,
> > +     TPM2_PT_NV_COUNTERS_AVAIL = TPM2_PT_VAR + 11,
> > +     TPM2_PT_ALGORITHM_SET = TPM2_PT_VAR + 12,
> > +     TPM2_PT_LOADED_CURVES = TPM2_PT_VAR + 13,
> > +     TPM2_PT_LOCKOUT_COUNTER = TPM2_PT_VAR + 14,
> > +     TPM2_PT_MAX_AUTH_FAIL = TPM2_PT_VAR + 15,
> > +     TPM2_PT_LOCKOUT_INTERVAL = TPM2_PT_VAR + 16,
> > +     TPM2_PT_LOCKOUT_RECOVERY = TPM2_PT_VAR + 17,
> > +     TPM2_PT_NV_WRITE_RECOVERY = TPM2_PT_VAR + 18,
> > +     TPM2_PT_AUDIT_COUNTER_0 = TPM2_PT_VAR + 19,
> > +     TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
> > +};
> >
>
> I guess these properties should be split out to a separate patch in a
> series.

That will make backporting this more annoying. Up to Jarkko,
obviously, but personally I wouldn't bother.
