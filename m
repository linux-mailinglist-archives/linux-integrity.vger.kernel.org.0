Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FD11BB88
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 19:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfLKSSc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 13:18:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35984 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbfLKSSc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 13:18:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so10496050pgc.3
        for <linux-integrity@vger.kernel.org>; Wed, 11 Dec 2019 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tPPeeVDeYDqJ3/BkDOHHqJmeQk2RFS5XEnjcxyWStHk=;
        b=JtcCZOdbZR8PvoN5+zpqDevpmQX8mn/wjqVymTZNjvRG2R3gH+KMAmI1tsgUoaEn0d
         +Fmhha5vnwjhxmMZiyf1HWMUpB0kuoJFNNyL28RRSlL2Zxpm0Tl6AEtvGIHT3XSIGKPv
         8xbbRb7kPcjao4YeZtCkalMoIxz/SqZFBwNzXBn3AO4pfEywAdYsHgw9onPkuNAneu2w
         29BqS33e7MkozfghztMFnkQi7Am04h4ZcXqYMFLKYaXd7FJEYYfqS1ZtIjkU3IyxMEEh
         ZIx+Fo+7ODJnLjnSVVsD1VrKB99YPuflcS5JXuFnGakwnDxDmAMB0BojWo7FxAJlHid9
         jiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tPPeeVDeYDqJ3/BkDOHHqJmeQk2RFS5XEnjcxyWStHk=;
        b=B+vWjNryVm+Mk7TypxA6z6BrgJzGSEpZhojp3gGNvxFa9hcgZheHR+QAeJ4yCFs8ak
         ef23P0PKQWED4CrbcQQvd7QMU3EdhaNM1Qx1X+/gJYAvexyQ1Py789IfHLhO1QgOSrkt
         xzY8bx5u5IqTK0YLBFzNcRYMzikCVuFptqC2DMTo0hXXybTGz2upIDVbHQyEGA9aLeyf
         SL8LIxcqQbFTg54yIQ+WGPv8UudIqi6X+fb8+lj18NktIlfFblxPSLhLawWkD9OZfHvQ
         J2piYokRP3eKvtdqQdM1emXyayBCTSx2lWDa6B0tNyTV5ooRLBKlh5ON6h0783LNef9c
         b40g==
X-Gm-Message-State: APjAAAVbThjnUw4aptq9M5Fzw/r4wYVLOxcjJ032+xoVA63801FVI49s
        f5cQZty4bqw69zgZWlFCXJDmpvjRvKiXUw==
X-Google-Smtp-Source: APXvYqybTyPeIsHQTSfJ39+zPwF7Awi2StSmIK5YsDEej2sjXZRE90XZupRWhjMpYCh+OuD4UJC6uw==
X-Received: by 2002:a63:2355:: with SMTP id u21mr5522479pgm.179.1576088311800;
        Wed, 11 Dec 2019 10:18:31 -0800 (PST)
Received: from debian ([122.164.82.31])
        by smtp.gmail.com with ESMTPSA id t8sm4136330pfq.92.2019.12.11.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 10:18:30 -0800 (PST)
Date:   Wed, 11 Dec 2019 23:48:24 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Will Deacon <will@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PROBLEM]:  WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191211181824.GA13799@debian>
References: <20191207173420.GA5280@debian>
 <20191209103432.GC3306@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209103432.GC3306@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 09, 2019 at 10:34:32AM +0000, Will Deacon wrote: 
> Can you reproduce this failure on v5.5-rc1?

i compiled and tested v5.5-rc1 . Yes the failure was there

--
software engineer
rajagiri school of engineering and technology
