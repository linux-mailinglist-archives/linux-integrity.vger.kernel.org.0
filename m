Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87E1276EF
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 09:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfLTIDn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 03:03:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35051 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTIDn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 03:03:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id 15so6334323lfr.2
        for <linux-integrity@vger.kernel.org>; Fri, 20 Dec 2019 00:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFswb2Ta89/de/X82QZLAzfIFVel8IoogFK++vd44ho=;
        b=MARHNKCmIGo7NwhsHKL6UJJRTFRYR6af2kgDCOkjCQx48C01IeIJ3ZHDSLQuB5l5kb
         6n8x34DEwaXKTxtdDh8fg8izbpohe0Mr2sutPjheiKwMCx8vE/co50MZhAfL1r82nhx/
         XCkI8H2//XlcoWozv0g8mgs6Mczy9v2hibqB3fnIIHgpINTXQWiuYKIilcQEPR3cBOt1
         xpsDsN9BBGb+10M27JH9pUzEapWS3WFPhAe/4wJco7z0SdzSGHrCoj31bx+TQiJDCV8L
         38o//lNB96dnlhgXgHAyaOMRX2ZbH/cyb0KF+qZ81e54+LpprZMwzAcsU9UWQSYu1XP7
         S6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFswb2Ta89/de/X82QZLAzfIFVel8IoogFK++vd44ho=;
        b=SqSRnwsvSvdDJ1NiGy1sJBbNKPhE8AubxzNAD1BsYZxfT099jKFL2alA/kG+W60tMy
         Br8NPh0hZwg098bUtTHjLOUNUQ5YnYjXcnmNBK+q6RVnpCm3WnwA+r1XtyWf9lwRr2UH
         FOkKmui4L/CNnTGGa1+RmcnM5tN/8fkEx/2ExkNWaccUTouMYRQVUSVHz8zndjh6lWzQ
         bKUzK/UoxZF01tnpdLuOQVM5RkS/UJfAUTDiYFluC7vLtAo33SyTvPLZNuTAvs7zhiuD
         71xMJqtqGUGyxb/+0tf7vjzI21HDuf6w/rWr29U1SWFqK7K/FLyUwDlY5U7XHtQtoPdT
         cGXg==
X-Gm-Message-State: APjAAAVesw9NVvbymifamrAX/RIsROVTjQ0LgXDaNs6/Wwht5Fgz3Gsa
        g+Z0wkhvbuvLTc3lp0MOZwvmKmtvARzmSQXvQYQPlA==
X-Google-Smtp-Source: APXvYqxzCSvdMhk4LNYb9i/4/M3OQbMKATjq9nbj0U9O1QilShD8NpD9MKR7CuGKL5Q80YwXw7c6gIp0ehgjFbgh3Ds=
X-Received: by 2002:ac2:5635:: with SMTP id b21mr7997658lff.127.1576829021066;
 Fri, 20 Dec 2019 00:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20191220074929.8191-1-janne.karhunen@gmail.com>
In-Reply-To: <20191220074929.8191-1-janne.karhunen@gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Fri, 20 Dec 2019 10:03:29 +0200
Message-ID: <CAE=NcraJnZyP8hB-jRLwTLUcD-bY+CPCZhUXPtHbL5HVHatA=g@mail.gmail.com>
Subject: Re: [PATCH v1 - RFC] ima: export the measurement list when needed
To:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        monty.wiseman@ge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 20, 2019 at 9:49 AM Janne Karhunen <janne.karhunen@gmail.com> wrote:

> Some systems can end up carrying lots of entries in the ima
> measurement list. Since every entry is using a bit of kernel
> memory, add a new Kconfig variable to allow the sysadmin to
> define the maximum measurement list size and the location
> of the exported list.

This patch now passes some basic test runs and looks to me it's doing
things correctly, if others are willing to give it a spin. My basic
test case for this is a simple bash for loop, creating thousands of
files and using this trigger to free the list.

Once we have the workqueue, the list free job should probably be
triggered from the ima_store_measurement() when the htable length says
so. This way the list will always stay truncated to the right size and
no-one has to poll.

When it comes to the oddity that kernel is creating files, the facts are:
1) the data cannot be kept in the memory forever,
2) the data cannot be thrown away.
So, what are the options. I didn't see any other obvious way. Luckily
there was a ready API for the job.


--
Janne
