Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B822533D369
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 12:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhCPLym (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 07:54:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:59302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhCPLyK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 07:54:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DC8BAD74;
        Tue, 16 Mar 2021 11:54:09 +0000 (UTC)
Date:   Tue, 16 Mar 2021 12:54:07 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH] IMA: Add test for selinux measurement
Message-ID: <YFCcX8VM2KsMmuQ1@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210222023805.12846-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222023805.12846-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi, Mimi,

> New functionality has been added in IMA to measure data that is
> critical to the integrity of the system.  SELinux uses this feature
> to measure the hash of the SELinux policy loaded in kernel memory,
> and the current state of various SELinux configuration.  This new
> functionality needs test automation in LTP.

> Add test cases which verify that the IMA subsystem correctly
> measures the data provided by SELinux.

I finally merged this patchset, noted both kernel commits.
Thanks for this test!

Kind regards,
Petr

* fdd1ffe8a812 ("selinux: include a consumer of the new IMA critical data hook")
(v5.12-rc1-dontuse)
* 2554a48f4437 ("selinux: measure state and policy capabilities")
(to be in v5.13
