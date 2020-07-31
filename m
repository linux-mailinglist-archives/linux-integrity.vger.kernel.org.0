Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9C234C1C
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 22:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGaUTQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 16:19:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:46148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgGaUTP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 16:19:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 246C9ACA9;
        Fri, 31 Jul 2020 20:19:28 +0000 (UTC)
Date:   Fri, 31 Jul 2020 22:19:13 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 0/5] initial travis support
Message-ID: <20200731201913.GB27841@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731182408.696931-1-zohar@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Support for multiple TSS and crypto libraries resulted in needing to
> test different software package combinations.  Although this is a
> first attempt at using travis matrix, I've been asked to include the
> travis.yml file in the git repo.  Before doing so, I'd appreciate
> some sort of review.

Thanks for implementing it!
LGTM.
Tested-by: Petr Vorel <pvorel@suse.cz>

I'll try to find time soon to convert it to Docker based Travis CI.

Kind regards,
Petr
