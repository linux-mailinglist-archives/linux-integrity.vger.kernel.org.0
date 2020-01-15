Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C36913CC6E
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jan 2020 19:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAOSpv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jan 2020 13:45:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53384 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAOSpv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jan 2020 13:45:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so1076755wmc.3
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jan 2020 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XhG7oKm+eUCDXzWAmBj1ApEpGRAwwk7JTkSRtwr4uDc=;
        b=SKYJhUZLU3m5uB+IwXigYsHxvV5o1M+7PQOjuaa8htp7C1d128jxoaBhSeOwMbUuZ5
         asWpNenhoM1ou5bOufNnZam1MHduqFELyxinQh1KeJSyJE8ICbIB47RiLkeBZdpguPWq
         NeayeqR6/qGB194gVdes9ah3JpJsuW5dMNdh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XhG7oKm+eUCDXzWAmBj1ApEpGRAwwk7JTkSRtwr4uDc=;
        b=ptFQhwC+VGtYVeyzj5EsjeUEbJFazlxbJmFvHpTpagh00FgJc9eek+IKuDiKdnkA3m
         YqxnXT5US/0Rsi57KOHInYuWJc0q9/GvPEV9hBO7Vchr5ZD99Za92nryms0Ccxh2sGg/
         Dzw7mrMYfcXxbv3Us6bb685EgsLATqZBpiJ3CWEven1O7WyvgNf6IF0N5gowM6ayh5O1
         b8NUEwSuQa3WhEMnTwc2pibRGE2I/zBX3gqjqXtz7pyL/GDRIRBCONFr+GBJnUxRMXW6
         DW8/IUySjrVQ6l6RF64zdbscixzwM3g+ZdCY9lJG4zXOvuodMeC/sMJYupyD0xpWyAHa
         /5HQ==
X-Gm-Message-State: APjAAAVkaP8kQWZpgSwwf39C8FC+ruGqxNKQTfzL8/PnAASm+sLY9jfi
        VZrCr7yHTrrTnhU0Gv3tuP4b6jdJPF7DjA==
X-Google-Smtp-Source: APXvYqxJUJuymcgl6BW34ydWB72BE5+YHoGJoQlEbVg0nk9JyqjTNyO7XAGrpWf/djrH7Rdzmj5LAA==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr1380457wmc.126.1579113948983;
        Wed, 15 Jan 2020 10:45:48 -0800 (PST)
Received: from revest ([37.165.158.17])
        by smtp.gmail.com with ESMTPSA id h17sm26445192wrs.18.2020.01.15.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:45:48 -0800 (PST)
Message-ID: <b88cbb1fb39175611e4b31e12a47df240a46dd48.camel@chromium.org>
Subject: Re: [PATCH v2] ima: add the ability to query the hash of a given
 file.
From:   Florent Revest <revest@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, KP Singh <kpsingh@chromium.org>
Cc:     linux-integrity@vger.kernel.org, mjg59@google.com,
        nramas@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Wed, 15 Jan 2020 19:45:43 +0100
In-Reply-To: <1579113367.5032.19.camel@linux.ibm.com>
References: <20200106162524.164650-1-revest@chromium.org>
         <20200113104830.GA28588@google.com>
         <1579113367.5032.19.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-01-15 at 13:36 -0500, Mimi Zohar wrote:
> On Mon, 2020-01-13 at 11:48 +0100, KP Singh wrote:
> > On 06-Jan 17:25, Florent Revest wrote:
> > > From: Florent Revest <revest@google.com>
> > > 
> > > This allows other parts of the kernel (perhaps a stacked LSM
> > > allowing
> > > system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the
> > > hash
> > > of a given file from IMA if it's present in the iint cache.
> > > 
> > > It's true that the existence of the hash means that it's also in
> > > the
> > > audit logs or in
> > > /sys/kernel/security/ima/ascii_runtime_measurements,
> > > but it can be difficult to pull that information out for every
> > > subsequent exec.  This is especially true if a given host has
> > > been up
> > > for a long time and the file was first measured a long time ago.
> > > 
> > > This is based on Peter Moody's patch:
> > >  https://sourceforge.net/p/linux-ima/mailman/message/33036180/
> > > 
> > > [1] https://lkml.org/lkml/2019/9/10/393
> > > 
> > > Signed-off-by: Florent Revest <revest@google.com>
> > 
> > Thanks for adding this Florent!
> > 
> > Reviewed-by: KP Singh <kpsingh@chromium.org>
> 
> Thanks, this patch is now queued in next-integrity-testing.

Good to hear Mimi! Thank you.

I would just like to make sure that you queued the v3 of this patch
though...? (this thread is for the v2 :) ) The v3 includes a couple of
comments you asked for.

