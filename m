Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF555E8859
	for <lists+linux-integrity@lfdr.de>; Sat, 24 Sep 2022 06:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiIXEcA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 24 Sep 2022 00:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiIXEb7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 24 Sep 2022 00:31:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5AD120BC2
        for <linux-integrity@vger.kernel.org>; Fri, 23 Sep 2022 21:31:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q9so1939250pgq.8
        for <linux-integrity@vger.kernel.org>; Fri, 23 Sep 2022 21:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GnuhqFcO+fe0wjKJOsEuT4koguWc3h3nlcYn9yXR1Zw=;
        b=ilf0THC+aUYPZwJdPDqccBQqqkMoBov963Qzs4Dr2+tuAPSs/AcMmzfsh15hy6+fH7
         YTnwBOSMof5NP3YfRHg6bn185tlwhU0tn7acrCMKbYVD+djexbMzul59+Q5oft9TjqHj
         mg9uLJXPb8EqhgT1u1YSKzol9b6AhlL1VCSIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GnuhqFcO+fe0wjKJOsEuT4koguWc3h3nlcYn9yXR1Zw=;
        b=NrVwhT4GMZSsk2dNQZwj3QBJXoVHftiRkYvbN/6r1yViJ8X52zpnO1nb2y6gJaaV3G
         85mYCR1CFjm666XXAa6n+M5Td1Hsdc31fc4wY8stY2uHCD2oIJqvP2azyvqYLUC1C06Q
         bzRvxHSS9HhxKvAo12NFEDT+9SN53DWaidPi3G9l2YH+LMD2ZJ1yPkSKYzuLmHm1fd+v
         5sECy56uIAQEFO58xtUnBqok3oZELuBrx2FcVDr37p5y1BVVAeVDdFlvztZJupfQQQor
         0/HSS1FsQI9n0zx6rAcCAYDW13oL/vPaUVl4aYIy8+T+nms6tSUr0g5TKKzAIARWa07W
         8btA==
X-Gm-Message-State: ACrzQf2513OkLD6zBDNprgYkITVyH2l7wWo2xQFOb6ZLxLnvrQGlV1eo
        1w7a/a6ceav93wUHGg6S8DM/Rw==
X-Google-Smtp-Source: AMsMyM5aWgHQQgsKm67s9bNvFG2Josu1kMqGEZ4X0ajZCrpuwU5ilSO8WEOZTkJiSG0xeUURu/VHNQ==
X-Received: by 2002:a63:91c7:0:b0:438:36c9:9022 with SMTP id l190-20020a6391c7000000b0043836c99022mr10756123pge.573.1663993917905;
        Fri, 23 Sep 2022 21:31:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902d18200b001728ac8af94sm6677144plb.248.2022.09.23.21.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 21:31:56 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:31:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 07/10] PM: hibernate: Use TPM-backed keys to encrypt
 image
Message-ID: <202209232130.ED110D8F7D@keescook>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.7.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
 <202209201610.C06F8CA@keescook>
 <CAE=gft4twDMw8zpp1o0hv+SFFQtGNxkAivBg0VC2Pax1ez7qzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft4twDMw8zpp1o0hv+SFFQtGNxkAivBg0VC2Pax1ez7qzg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 23, 2022 at 03:23:43PM -0700, Evan Green wrote:
> On Tue, Sep 20, 2022 at 4:16 PM Kees Cook <keescook@chromium.org> wrote:
> > On Tue, Aug 23, 2022 at 03:25:23PM -0700, Evan Green wrote:
> > > [...]
> > > +     ret = key_instantiate_and_link(key, keyinfo, strlen(keyinfo) + 1, NULL,
> > > +                                    NULL);
> >
> > You want to keep the trailing NUL byte here so it's easier to read back
> > later? Reading it back will need to verify the trailing NUL regardless.
> > (Does this get read back?)
> 
> Are you referring to the trailing nul on keyinfo? The keyinfo string
> is only used within this function, as key_instantiate_and_link()
> receives it as a parameter string. I can see that
> trusted_instantiate() also null-terminates the buffer defensively for
> itself, but it still seemed prudent to hand in a terminated string. I
> can remove the + 1 if you think it's better.

No, I like having the trailing NUL byte -- it seems more robust that
way. I just wanted to understand who the consumer was going to be. I'm
clear now; thank you! :)

-- 
Kees Cook
