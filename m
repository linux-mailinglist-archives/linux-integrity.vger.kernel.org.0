Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23ED1E52AC
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 03:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgE1BKO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 21:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1BKN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 21:10:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2042C05BD1E
        for <linux-integrity@vger.kernel.org>; Wed, 27 May 2020 18:10:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so5540762plb.3
        for <linux-integrity@vger.kernel.org>; Wed, 27 May 2020 18:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guzman.io; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DBs8nK+3s3ZXcg9Ljp1jtKfqTEx7YoSz4n4Jq8JZ6LE=;
        b=GBR3d4gVwtMu2V4J/0vvbpx9014Z3kFK1DNo0ef35iWXKi0ifDDTfqG4EhPUulDy6Y
         acbA39mmqRen12kFONUViYA4c8SJm9UYLh5WWlxATd6J3bfC17VZw8zZuIMIZvbXFMs4
         99Fn9/WyMutywMSkjxmJA69oifXYriMx4ycIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DBs8nK+3s3ZXcg9Ljp1jtKfqTEx7YoSz4n4Jq8JZ6LE=;
        b=uG+ogrgg5wWa3qdUuht0WAErAynJdbVQ9YOhfaKmRCguFtbp267jV3wZlvTz4y7kWS
         zCxDbMqIJsvoRFtQ4Aoxqd2W61en1SPg+32MZhFUN6Af4rwmIUlCG9xvOL+IImJo2pox
         7septPCdDM2VU3yoJaqDbKPIm/XHvJzoCMLO9t1cHIOvlGrFKdJK3YkkiVshJeDEW446
         towCYLjWmoHQVmblx128/t+tWpkI49j2B/w+7KgTvvxwc0LyQcjyhlYziqkg8ZEm+HM7
         ZnXC1jVyjMzD/La7lb3OfzEZeKL211az1gJcVb1SiNgvgp44sSbAnf6/OWVraylOXG2i
         rIRQ==
X-Gm-Message-State: AOAM533RrmOwBSKtdk+ZkhBB5zehKxniawuSCCpfMpu6NPIPMwgRp1Jp
        ZMpZxniynamNsDLiSZKDk5Cd0g==
X-Google-Smtp-Source: ABdhPJxx+ItwDgk8haTKTqBGn6S7buU1BJTEN+9WqMGDf+M4vzUCZpnZQnsDTHrXc8XYSOj48dHuSA==
X-Received: by 2002:a17:90b:1008:: with SMTP id gm8mr1129632pjb.137.1590628211150;
        Wed, 27 May 2020 18:10:11 -0700 (PDT)
Received: from ?IPv6:2601:645:4000:ba:30d8:f462:8a0e:6cae? ([2601:645:4000:ba:30d8:f462:8a0e:6cae])
        by smtp.gmail.com with ESMTPSA id b16sm298136pfd.111.2020.05.27.18.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:10:10 -0700 (PDT)
Message-ID: <a5e2a176faa272a0edc8737c1ef1bf5b3c278f63.camel@guzman.io>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   Alex Guzman <alex@guzman.io>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mario.Limonciello@dell.com, James.Bottomley@HansenPartnership.com,
        peterhuewe@gmx.de, jgg@ziepe.ca
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-integrity@vger.kernel.org, jeffrin@rajagiritech.edu.in
Date:   Wed, 27 May 2020 18:10:02 -0700
In-Reply-To: <d6b4591c49f01f24b0dbfd25c8792a3f506d6cae.camel@linux.intel.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
         <d6b4591c49f01f24b0dbfd25c8792a3f506d6cae.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-05-27 at 23:15 +0300, Jarkko Sakkinen wrote:
> On Tue, 2020-05-26 at 19:23 +0000, Mario.Limonciello@dell.com wrote:
> > Thanks, I don't pretend to understand the nuances of this
> > particular code,
> > but I was hoping that the request to revert got some attention
> > since Alex's
> > kernel Bugzilla and message a few months ago to linux integrity
> > weren't.
> 
> Removing linux-kernel from CC since this subsystem internal
> discussion.
> 
> Seeing the whole thing first time today.
> 
> Bugzilla is the first thing to ignore when busy. It is good as place
> holder for bugs, but all discussions should happen only in LKML.
> There's
> no official requirement to proactively use Bugzilla for anything.
> 
> That said I'm happy that people put stuff there so that it gets
> logged.
> 
> For follow-up's use only LKML if it is important to you. Those will
> get
> processed.
> 
> As far as this goes, if nothing is heard from me, check that you put
> me
> as CC to the original email. Otherwise, I might have missed it (by
> mistake,
> not by purpose).
> 
> Honestly, I'm not sure what point was this patch when there was time
> to
> wait for months without response. Why the passivity for all this
> time?
> 
> /Jarkko
> 

It largely went quiet because I didn't raise the issue in the mailing
list again. I pinged back in February (
https://lore.kernel.org/linux-integrity/CAJ7-PMbujee92N1f9xVF8vtXgS49qpe7qHkeWh1Z0R-Rk-Jkaw@mail.gmail.com/
) but the conversation died out and I was content to simply use the
last working kernel version and see if the bug was resolved on its own.
I raised the issue again on the bugtracker a few days ago, leading to
this follow up here. :)

- Alex

