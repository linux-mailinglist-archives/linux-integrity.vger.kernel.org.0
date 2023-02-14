Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0AF69701D
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Feb 2023 22:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjBNVxD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Feb 2023 16:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjBNVxC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Feb 2023 16:53:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC4252A1
        for <linux-integrity@vger.kernel.org>; Tue, 14 Feb 2023 13:52:59 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id w11so25265253lfu.11
        for <linux-integrity@vger.kernel.org>; Tue, 14 Feb 2023 13:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bearmetal.eu; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9UHxk8UzZeze330gbOzHUNQekVJY4fD70twyY3whmc=;
        b=AvskxVxI7SW3r67o2Ae+zvenc/qpIuAt1bxctunXqFIcxSgTHqCK0i/BSIWK4cORVJ
         lgp8JoURU5e3OlR4x+ioax6QPhvfFVtNVPgzQcxUFYdW0iBEMfJU3RuABXGQfDakaEtC
         hXvEX9hGynZodXnt3F3Q9TXu8T4Psc2vm03vXLY8hXj1ZrSfoHHHPP3+8qTiCSKJPG1P
         f6V5dt13iFU9M7Icq46511r2TRsx/9jRF1qg3fBpI8i6uDe4eqryxZ1C5qMXVqJ1Mprh
         KMlnRVcYCIeNjkfsKXvIHmneEJ6CCo2Aq7inPDG6WMYdkvLF/8axvprxxal3lBsN0V6Q
         qMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9UHxk8UzZeze330gbOzHUNQekVJY4fD70twyY3whmc=;
        b=nwBfOYFwL4nz+fcnGXbuskP69+KEl7J15cZfwjR7Prx/GHkOGiR0D0bHR63DoJGLUC
         Z64NuIYusr+a7EKAo54DFiptiMiFf0cklQJhN0b6vWolQIn9b+lAniN1ZyUJ73DMZAQ7
         JoGLNJIN94ETxg29vUfNKGtcv0UkbezY5Hb8ePiE9xeIntcHejkwG4ybqYa4Jskcr9/0
         /glsJhEeM5EtOi+acLuxHmctt41a4EPCKm/3Uhil+bGPaXKI9wjt3/88whIl3poubVoH
         EzCMJ8VKBuQqu+gX629tanK21WM8GIcKLY6ShRW/SJuuCOEWpKafk/Ylp73ut9jRgFYG
         sn7g==
X-Gm-Message-State: AO0yUKW4Pjmz7ZgXM0b6jN6kuPaJjDuQ5LfVIBKOk0qE7BP0bPtLl5MH
        pkklqA8NkywgUleqkohom/76AGkj5lvYFiIAI7I=
X-Google-Smtp-Source: AK7set+TEXCHcEOvel6DuIWlKsLxpD/nHlSX0FH9lgnZy9z1UKK5pFRT24KWhbJd2LY3eMFvtevWHQ==
X-Received: by 2002:a05:6512:390a:b0:4d8:8ad1:a057 with SMTP id a10-20020a056512390a00b004d88ad1a057mr1450963lfu.51.1676411577872;
        Tue, 14 Feb 2023 13:52:57 -0800 (PST)
Received: from erkki-carbon-x1.. (75-161-250-195.sta.estpak.ee. [195.250.161.75])
        by smtp.gmail.com with ESMTPSA id y17-20020a2e7d11000000b002935d75761dsm213644ljc.4.2023.02.14.13.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:52:57 -0800 (PST)
From:   Erkki Eilonen <erkki@bearmetal.eu>
To:     jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, morten@linderud.pw,
        peterhuewe@gmx.de, Erkki Eilonen <erkki@bearmetal.eu>
Subject: Re: [PATCH v2] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI address
Date:   Tue, 14 Feb 2023 23:52:20 +0200
Message-Id: <20230214215220.1190357-1-erkki@bearmetal.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YzyyZ6AFAgTRG5G5@kernel.org>
References: <YzyyZ6AFAgTRG5G5@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Does the bug fix work for you? If you can give tested-by for it, then that
> ofc changes everything.

Apologies for the delayed response.

Previously we had a similar but not quite the same patch being used, now I've tested this specific patch.

Tested-By: Erkki Eilonen <erkki@bearmetal.eu>
  kernel: 5.10.121
  Device: QuantaGrid D53X-1U
  BIOS:
    Vendor: INSYDE Corp.
    Version: 3A16.Q402
    Release_Date: 11/10/2021

Cheers,
Erkki Eilonen
