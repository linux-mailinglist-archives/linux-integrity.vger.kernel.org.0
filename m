Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB76EAE050
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 23:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfIIVjm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 17:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfIIVjm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 17:39:42 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272BD21924;
        Mon,  9 Sep 2019 21:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568065181;
        bh=+nUsbZO4jDJQKcj0U8bhaPUEL9Ppt9f9/QlIFDNBlZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twaohtH3xoKch2HMq/i9HVENozwbITC9sJ5WAC3reHThd59txrZjOMIerExBu/7lH
         /HgH1sJXxuUEdsP07RzvjWwjSJETSWH2zvTKHSYF0vpC6JlCf9IULO11R0YtGM6IDg
         AoFd4c7VbvrhRjQ7ONfdhd7hLZEIgVn9KCXA+JbA=
Date:   Mon, 9 Sep 2019 14:39:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: Re: [PATCH 1/3] ima: keep the integrity state of open files up to
 date
Message-ID: <20190909213938.GA105935@gmail.com>
Mail-Followup-To: Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        Konsta Karsisto <konsta.karsisto@gmail.com>
References: <20190902094540.12786-1-janne.karhunen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902094540.12786-1-janne.karhunen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 02, 2019 at 12:45:38PM +0300, Janne Karhunen wrote:
> When a file is open for writing, kernel crash or power outage
> is guaranteed to corrupt the inode integrity state leading to
> file appraisal failure on the subsequent boot. Add some basic
> infrastructure to keep the integrity measurements up to date
> as the files are written to.
> 
> Core file operations (open, close, sync, msync, truncate) are
> now allowed to update the measurement immediately. In order
> to maintain sufficient write performance for writes, add a
> latency tunable delayed work workqueue for computing the
> measurements.
> 

This still doesn't make it crash-safe.  So why is it okay?

- Eric
