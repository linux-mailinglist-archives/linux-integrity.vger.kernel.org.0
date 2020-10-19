Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01059292B5B
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgJSQXr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbgJSQXp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 12:23:45 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED84C0613CE
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 09:23:44 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id w25so2924538oos.10
        for <linux-integrity@vger.kernel.org>; Mon, 19 Oct 2020 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6oL50ponfPLtWw8/JVnwt+LyqzYqL1wUurn0YqWTSto=;
        b=AFAbKip/t5N2DVC4zGjBWZnIFzy9UY1hEZ8Kx3V9DBtqIGCJAdSbHHwGyu5V/ji/DB
         kYSOz7F/QUfKGieDmhH+RovL118oNOdVhduEyNCDV1yGRl7VLZklDpkVWSRkSBIgLzwK
         759iyOUKnhKAwxx/Ywar+8GFYj1nNUOhNdsHT+GUIZuH+zgclnoE4PgHYyOv0N4q/wWe
         szEW9ZG/LFMRLeeKL+VM25YeqEIbK0M79HgPxhIYowPoTnt8OD9un3KelT/rFyZxFPR4
         my2gapMI1Et9Fd6EdFId4QZnnzbRoMkZwfrzaK1KAPPwZTg0uX12dQjfIk3u+gR5Kl51
         9h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6oL50ponfPLtWw8/JVnwt+LyqzYqL1wUurn0YqWTSto=;
        b=ZlUorlvubp+n/EvyDmllJiEzj34uAGHFANx+8O8dMvPEpQ2vA9nvqFbE591dqjVKTw
         455+Iaz0OEwZHOf0bzgSF8L7HXpDiLwtqhzF9YjoT5RAm8xbkFpIuGVWfYTd7DXXc0KK
         NRkRRhnwDd2kP2hsnk6V3XF2CPVFhVfoj0l/m9WPnuqJvyc1an7DDQXw2f/1o1uJL8uW
         Cw+Z/ewsF6HJ7ReY6HnMZrWwgaSuxQQCTUc9e6OIuLsefPJQKx4duNcj1MviPgBFIiz6
         EZddMnrn7+WUSPRI8cIuUeIQCGMmxCUzineIsZMbWeLxj63azZ1zk1ool3B4ayMaWZrb
         uaXQ==
X-Gm-Message-State: AOAM531SSKdTsE9L0HN4Jvzxqw/HeGvihYP7vdv4KGJKFAO03bjarYRp
        zeAps7VoXTf8dRxXLIAHmCAmG13C5TtbWNLLxwvu8Eis
X-Google-Smtp-Source: ABdhPJzjyyepAQNbsaEV/H8/WUIWOVxWhGSDGS+gAdRzo/RPBKT+HA72tzHXwmbpoZUl47+VEa35KxUQUzErsaCxNTc=
X-Received: by 2002:a4a:1d03:: with SMTP id 3mr529880oog.19.1603124623801;
 Mon, 19 Oct 2020 09:23:43 -0700 (PDT)
MIME-Version: 1.0
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 19 Oct 2020 12:23:33 -0400
Message-ID: <CAEjxPJ6Uw+wJYHW6ZWvWgxDXUW8wvv4-y8Sgy+SVeiH91XxiDg@mail.gmail.com>
Subject: Measuring kernel modules with IMA
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Why is it that IMA only supports measuring kernel modules if they are
loaded via finit_module(2)?  Why can't init_module(2) pass a buffer
with the module content after copying from userspace to IMA and let
IMA measure that buffer?  Is that an intentional design choice or just
no one has asked for it?

At present, it appears that kmod will fall back to using
init_module(2) when kernel modules are compressed on disk, and that
such compression is common in Linux distributions.  Hence, if one has
a func=MODULE_CHECK rule, kernel module loading fails unless one
enables module.sig_enforce and even then the modules aren't actually
measured, just signature checked.

Potential userspace-only solutions are to decompress the kernel
modules (but this deviates from distribution packaging/practice plus
obviously impacts storage) or change kmod to decompress to a tmpfs
file and use finit_module() on that.

But I'm not sure why we can't just measure the buffer with the
kernel's copy of the module during init_module(2) and get a
measurement that way.
