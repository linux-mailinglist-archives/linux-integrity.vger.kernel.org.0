Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC974F1AC2
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Apr 2022 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379212AbiDDVS5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380033AbiDDSl7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 14:41:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371895FB0
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 11:40:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h19so9811258pfv.1
        for <linux-integrity@vger.kernel.org>; Mon, 04 Apr 2022 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dVG8SdKJh3lNF5aMlMn0lGtL8TsUuGiy0ylcJGnwrLQ=;
        b=mX37UAkizZPJSLK5nuleOQGUHlnzGzVIX7n8Ey1L438YuOI2RXx1GF5cjewpiTeFfb
         NEZ5/iVMlRh6ZJghqjttF4FVrgeWQQRSBDnKhGJlGSusXLPVP9/IzJTcC6cJyGhipMEZ
         NN5pT8S0RD/wR/TL2mC3KHhfGSWO55u10Bk6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dVG8SdKJh3lNF5aMlMn0lGtL8TsUuGiy0ylcJGnwrLQ=;
        b=yGa/WoWa3GgSxKT6PbnyZaRMU1DBqcZTeRhm81P8ppyJTrigMyYQAAQa0mFsUY9lL4
         aDIyFBaf35FusWC+o45+inytVjKTy8muI2uAedGnbb2CsD54mEwYwuAmvaugTyYljmPD
         MXhe8b5yDZwvbadMvO78bch45PspVEBnLycs4Nl5zQSSU+kxvBXA3oFs15kCsbFNdlUR
         ClW92dE62ScE/u+9ykHWaiYnLx704jrmmSdrxqu2k3XbYqFcnBg3uOWDaoVyBnJjdKSh
         NbT4zZgWxgj6W+qCkiwrMF6XMxB1LR4IVAUGy1peXyEYnZquV5mr9eGhEAAPbeE7q0FY
         a7/w==
X-Gm-Message-State: AOAM530V2DA1Sx7VRo6rwWD2cmgixLBSIXthhniOfd09ZjRMrq9CrYGE
        +mMSEpsbwWhCys508oJyVI74ng==
X-Google-Smtp-Source: ABdhPJx3WYIgYP8Ex9on1q2aw9dCFrPaAv+SqDaCN+xEoGXLlI1AISWPm+KJ14/yd+3EV0nxg5JGCg==
X-Received: by 2002:a05:6a00:1252:b0:4fa:afcc:7d24 with SMTP id u18-20020a056a00125200b004faafcc7d24mr911536pfi.85.1649097601437;
        Mon, 04 Apr 2022 11:40:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056a00300900b004fae1346aa1sm12196740pfb.122.2022.04.04.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:40:01 -0700 (PDT)
Date:   Mon, 4 Apr 2022 11:40:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <202204041130.F649632@keescook>
References: <20220321161557.495388-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220321161557.495388-1-mic@digikod.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 21, 2022 at 05:15:57PM +0100, Micka�l Sala�n wrote:
> [...]
> For further details, please see the latest cover letter:
> https://lore.kernel.org/r/20220104155024.48023-1-mic@digikod.net
> 
> Commit dae71698b6c5 ("printk: Move back proc_dointvec_minmax_sysadmin()
> to sysctl.c") was recently added due to the sysctl refactoring.
> 
> Commit e674341a90b9 ("selftests/interpreter: fix separate directory
> build") will fix some test build cases as explained here:
> https://lore.kernel.org/r/20220119101531.2850400-1-usama.anjum@collabora.com
> Merging this commit without the new KHDR_INCLUDES is not an issue.
> The upcoming kselftest pull request is ready:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
> 
> This patch series has been open for review for more than three years and
> got a lot of feedbacks (and bikeshedding) which were all considered.
> Since I heard no objection, please consider to pull this code for
> v5.18-rc1 .  These five patches have been successfully tested in the
> latest linux-next releases for several weeks.

Hi Linus,

It looks like this didn't get pulled for -rc1 even though it was sent
during the merge window and has been in -next for a while. It would be
really nice to get this landed since userspace can't make any forward
progress without the kernel support.

Was there some issue blocking this from being merged? All the feedback I
can find on prior versions was addressed.

-Kees

-- 
Kees Cook
