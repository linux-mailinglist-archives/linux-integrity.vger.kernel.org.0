Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3116911C6D7
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 09:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfLLIMz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 03:12:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40009 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfLLIMz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 03:12:55 -0500
Received: by mail-pj1-f68.google.com with SMTP id s35so697008pjb.7
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ieuNU3BxQNBlr5wacK6RSBM8UAY3+jZD+rGJxQ2r+2w=;
        b=idUCuBklPDpVcwuCAeYiQS7bb3n6PjK0uWRYClqzf76Z98GfJCybphCzT2opcGL6S/
         3JgT9GfUZDfXUgvywaVFvgrCImPzLLV1iixkkK3wMHT+afWyPgdJVnKlnZa24DaSL5y9
         SusB4/xv7MuZxtlaOJvMflaiNZot3T7jIBcwO+iLQ9D8riIER895g7AO90MD1w6T6c2S
         Gg1z2I7DxqL+DgmEkSFityz6NE7+B7sYuB0hVhJ5AuzMqK8VVkxc86qFqUpWFPOuiS+y
         MwTa/cgfn7w32DnkWYaJxjxsy9KoSUslhLrJNy7w+pxFuGLQSIoRA6uEG1xkvy5S0Y0l
         izaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ieuNU3BxQNBlr5wacK6RSBM8UAY3+jZD+rGJxQ2r+2w=;
        b=m+evSAymi9YTI7yH3bHXMwNJ05/N5aYHuvS+8auBo/0gxaiOm4kz3BbdXR/xkbdScq
         LuDUXC2PWHlSeWwIsKsvkDu8xSqIx1p06kVY/MkEFM5+ePY6J8RfJDXpnPn8bRvkiNiP
         z+YRpr6KaCypOWFIGEoA4p3iKXC2kt/DgJNRYtfWGh/WxY+PGjpKOfdSZeSog8poTj3e
         nXfFiSOu0tWzT3qVHf9YD5AlaWpU/cJ53bgBcq+p2OyUkA0Bgc4XZEbcJlLZpz7wmQd3
         46dsO6wB51cVNIF9qIp/YnXQJ9nvC/oddHZs5TcBeW0GYEm5yb9ERfht8Hv2PGSv8+Fl
         MymQ==
X-Gm-Message-State: APjAAAUtrooafdKuLzZWdJI6L76U/8e6w0ipXODibX3I73ajW8/X3DPT
        oDnq87pp4RjWhMJKj4uj0NhCyg==
X-Google-Smtp-Source: APXvYqxb7RLa7bbmoiInTQAaQl62w7+UdiUrGstBnfUBKncodbLw2Y6ukkROPOm97s7y7P4lV0LIGQ==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr7556492plp.120.1576138374309;
        Thu, 12 Dec 2019 00:12:54 -0800 (PST)
Received: from debian ([122.174.90.102])
        by smtp.gmail.com with ESMTPSA id r66sm6260219pfc.74.2019.12.12.00.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 00:12:53 -0800 (PST)
Date:   Thu, 12 Dec 2019 13:42:42 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Will Deacon <will@kernel.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PROBLEM]: WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191212081242.GB2657@debian>
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
 <20191209202552.GK19243@linux.intel.com>
 <34e5340f-de75-f20e-7898-6142eac45c13@intel.com>
 <20191211151701.GA3643@debian>
 <00804293-7f60-0ac1-fe01-0143eb508a2b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00804293-7f60-0ac1-fe01-0143eb508a2b@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 11, 2019 at 10:36:15AM -0800, Tadeusz Struk wrote:
> On 12/11/19 7:17 AM, Jeffrin Jose wrote:
> > above patch shows errors when i try to apply it.
> > --------------------x------------------------x------------------
> > error: git diff header lacks filename information when removing 1 leading pathname component (line 2)
> > when i did  related to this "diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c"
> > i get another error
> > error: corrupt patch at line 27
> > ----------------------x------------------------x-----------------
> > 
> > i use "git apply"
> 
> Hi,
> This was just a copy and paste that wasn't meant to be applied.
> If you want to try it please use the patch that I sent later:
> https://patchwork.kernel.org/patch/11283317/
>

i applied the patch and problem seem to be fixed.

Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

